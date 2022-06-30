// Taken and adapted from https://golang.org/misc/linkcheck/linkcheck.go
// Plz run the following after you modify this script:
// GOOS=darwin GOARCH=amd64 go build -o util/linkcheck/check_mac util/linkcheck/check.go
// GOOS=windows GOARCH=386 go build -o util/linkcheck/check_windows.exe util/linkcheck/check.go
// GOOS=linux GOARCH=amd64 go build -o util/linkcheck/check_linux util/linkcheck/check.go

package main

import (
  "errors"
  "flag"
  "fmt"
  "io/ioutil"
  "log"
  "net/http"
  "os"
  "regexp"
  "strings"
  "sync"
  "time"
  "net"
)

var client = http.Client {
  Timeout: time.Duration(10 * time.Second),
}

var (
  root      = flag.String("root", "http://localhost:4567", "Root URL to crawl")
  fragments = flag.Bool("fragments", false, "Check link fragments")
  ext_links = flag.Bool("ext_links", false, "Check external links")
  verbose   = flag.Bool("verbose", false, "Verbose logging")
)

var internalLinksWG, externalLinksWG sync.WaitGroup // outstanding fetches

// urlFrag is a URL and its optional #fragment (without the #)
type urlFrag struct {
  url, frag string
}

// Owned by crawlLoop goroutine:
var (
  linkSources = make(map[string][]string) // url no fragment -> sources
  fragExists  = make(map[urlFrag]bool)
  problems    []string
)

// Used for checking internal links
var (
  urlq = make(chan string) // Internal URLs to crawl
  aRx         = regexp.MustCompile(`<a href=['"]?(/[^\s'">]+)`)
  mu          sync.Mutex
  crawled     = make(map[string]bool)      // URL without fragment -> true
  neededFrags = make(map[urlFrag][]string) // URL#frag -> who needs it
)

// Used for checking external links
var (
  externalRx    = regexp.MustCompile(`<a href=['"]?(http[^\s'">]+)`)
  externalLinks = make(map[string]bool)
  externalLinkChannel = make(chan string, 500)
  externalRSLinks     = regexp.MustCompile(`\/\/(www|blog)\.rightscale\.com\/`)
)

func localLinks(body string) (links []string) {
  seen := map[string]bool{}
  mv := aRx.FindAllStringSubmatch(body, -1)
  for _, m := range mv {
    if !seen[m[1]] {
      seen[m[1]] = true
      links = append(links, m[1])
    }
  }
  return
}

func scrapeExternalLinks(url string, body string) {
  mv := externalRx.FindAllStringSubmatch(body, -1)
  for _, m := range mv {
    if !externalLinks[m[1]] && !externalRSLinks.MatchString(m[1]){
      externalLinks[m[1]] = true
      externalLinkChannel <- m[1]
      externalLinksWG.Add(1)
      dest := sanitizeURL(m[1])
      linkSources[dest] = append(linkSources[dest], url)
    }
  }
}

// url may contain a #fragment, and the fragment is then noted as needing to exist.
func crawl(url string, sourceURL string) {
  mu.Lock()
  defer mu.Unlock()
  var frag string
  if i := strings.Index(url, "#"); i >= 0 {
    frag = url[i+1:]
    url = url[:i]
    if frag != "" {
      uf := urlFrag{url, frag}
      neededFrags[uf] = append(neededFrags[uf], sourceURL)
    }
  }
  if crawled[url] {
    return
  }
  crawled[url] = true

  internalLinksWG.Add(1)
  go func() {
    urlq <- url
  }()
}

func addProblem(url, errmsg string) {
  msg := fmt.Sprintf("Error on %s: %s (from %s)", url, errmsg, linkSources[sanitizeURL(url)])
  if *verbose {
    log.Print(msg)
  }
  problems = append(problems, msg)
}

func crawlLoop() {
  for url := range urlq {
    if err := doCrawl(url); err != nil {
      addProblem(url, err.Error())
    }
  }
}

func sanitizeURL(url string) (sanitizedUrl string){
  // Removes the anchor link
  sanitizedUrl = strings.SplitN(url, "#", 2)[0]
  return
}

func doCrawl(url string) error {
  defer internalLinksWG.Done()

  res, err := client.Get(url)
  if err != nil {
    return err
  }
  if res.StatusCode != 200 {
    return errors.New(res.Status)
  }
  slurp, err := ioutil.ReadAll(res.Body)
  res.Body.Close()
  if err != nil {
    log.Fatalf("Error reading %s body: %v", url, err)
  }
  if *verbose {
    log.Printf("Len of %s: %d", url, len(slurp))
  }
  body := string(slurp)
  for _, ref := range localLinks(body) {
    if *verbose {
      log.Printf("  links to %s", ref)
    }
    dest := sanitizeURL(*root + ref)
    linkSources[dest] = append(linkSources[dest], url)
    crawl(dest, url)
  }

  if *ext_links {
    scrapeExternalLinks(url, body)
  }

  return nil
}

func doExternalCrawl(url string) error {
  defer externalLinksWG.Done()

  res, err := client.Get(url)
  if err != nil {
    switch errType := err.(type) {
    case net.Error:
      if !errType.Timeout() { // Ignore timeouts
        return err
      }
    }
  } else if !(res.StatusCode == 200 || res.StatusCode / 100 == 3 || res.StatusCode == 401 || res.StatusCode == 503) {
    return errors.New(res.Status)
  }

  return nil
}

func checkExternalLinks() {
  for url := range externalLinkChannel {
    if *verbose {
      log.Printf("Checking %s", url)
    }
    if err := doExternalCrawl(url); err != nil {
      addProblem(url, err.Error())
    }
  }
}

func main() {
  flag.Parse()

  if *ext_links {
    for i := 0; i <= 100; i++ {
      go checkExternalLinks()
    }
  }

  go crawlLoop()
  crawl(*root, "")
  internalLinksWG.Wait()
  close(urlq)

  if *ext_links {
    externalLinksWG.Wait()
    close(externalLinkChannel)
  }

  if *fragments {
    for uf, needers := range neededFrags {
      if !fragExists[uf] {
        problems = append(problems, fmt.Sprintf("Missing fragment for %+v from %v", uf, needers))
      }
    }
  }

  for _, s := range problems {
    fmt.Println(s)
  }
  fmt.Println("----------")
  fmt.Println(len(problems), "issues found. You can use 'nocheck' in links to skip them, e.g. <a nocheck href='http://mylink.com'>MyLink</a>")

  if len(problems) > 0 {
    os.Exit(1)
  }
}