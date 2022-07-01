require 'net/http'
require 'uri'
require 'json'

desc 'Serve the docs site locally'
task :serve do
  puts 'Serving docs site locally...'
  puts 'Goto http://localhost:4567 to see the site; press Ctrl+C to kill this.'
  Rake::Task["download_policy_list"].execute
  system('bundle exec middleman server')
end

desc 'Build the docs site from source'
task :build do
  puts 'Building docs site...'
  Rake::Task["download_policy_list"].execute
  status = system('bundle exec middleman build --clean')
  puts status ? 'Done :)' : "Failed to build site :("
end

desc 'Upload a draft of the docs to surge.sh'
task :surge => :build do
  if which('surge')
    status = Dir.chdir('build') do |_|
      File.unlink('CNAME')
      system('surge')
    end
    puts status ? 'Done :)' : 'Failed to upload to surge.sh :('
  else
    puts 'Could not upload to surge.sh; please install surge from https://surge.sh/help/getting-started-with-surge'
  end
end

namespace :img do
  desc 'Copies the latest screenshot, renaming and resizing it. Works on OSX'
  task :screenshot do
    require 'fileutils'
    location = `defaults read com.apple.screencapture location 2> /dev/null`
    location = '~/Desktop' unless location.length > 0
    latest = Dir[File.expand_path(location + '/Screen Shot *.png')].max
    is_retina = `system_profiler -xml -detailLevel mini SPDisplaysDataType | xmllint --xpath "//key[text() = 'spdisplays_retina']/following-sibling::string[1]/text()" -` == 'spdisplays_yes'
    puts "Copying #{latest}" + (is_retina ? " and assuming Retina" : '')
    puts "What product does this relate to? (CM,CA,SS,...)"
    print '>> '
    product = STDIN.gets
    puts "Describe your image in a few words:"
    print '>> '
    description = STDIN.gets
    filename_base = product.strip.downcase + '-' + description.downcase.strip.gsub(/[\s\-_\/\\]+/, '-')
    if is_retina
      FileUtils.cp latest, './source/img/' + filename_base + '@2x.png'
      `convert '#{latest}' -resize 50% '#{'./source/img/' + filename_base + '.png'}'`
    else
      FileUtils.cp latest, './source/img/' + filename_base + '.png'
    end
    `echo "![#{description.strip}](/img/#{filename_base}.png)" | pbcopy`
    puts "The following has been copied into your clipboard:"
    puts ""
    puts "![#{description.strip}](/img/#{filename_base}.png)"
  end
end

desc 'Crawl the docs site and check for broken links'
task :check_links do
  require 'open3'
  root = 'http://localhost:4567'
  puts "Checking #{root} for broken links..."
  # download the latest version of polices to check_links on
  Rake::Task["download_policy_list"].execute
  begin
    tuple       = ::Open3.popen3({}, "bundle exec middleman server")
    wait_thread = tuple[3]
    pid         = wait_thread.pid

    # Wait until the server is up
    next until server_ready? 'http://localhost:4567/index.html'

    if OS.windows?
      cmd = 'check_windows.exe'
    elsif OS.mac?
      cmd = 'check_mac'
    else
      cmd = 'check_linux'
    end
    links_ok = system("util/linkcheck/#{cmd} -root #{root} -ext_links")
    abort("Found broken links, please fix them and retry.") unless links_ok
    puts "All links are fine."
  ensure
    # Ensure we kill the server
    ::Process.kill('INT', pid)
    wait_thread.join
  end
end

desc 'download policy list into data folder'
task :download_policy_list do
  puts "Downloading Policy List"
  uri = URI('https://s3.amazonaws.com/rs-policysync-tool/active-policy-list.json')
  # Must be somedomain.net instead of somedomain.net/, otherwise, it will throw exception.
  Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') do |http|
      resp = http.get uri
      policy_hash = JSON.parse(resp.body)
      categorized_data = policy_hash["policies"].group_by{ |x| x['category'].gsub(" ","_").downcase }
      categorized_data.each_key do |c|
        categorized_data[c].sort_by! {|p| p['name']}
      end
      open("data/policies.json", "wb") do |file|
          file.write(JSON.pretty_generate(categorized_data))
          file.write("\n")
      end
  end
  puts "Done."
end

# Wait until the server responds with a 200
def self.server_ready?(url)
  begin
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    res.code == '200'
  rescue Errno::ECONNREFUSED
    false
  rescue Errno::EADDRNOTAVAIL
    false
  end
end

# Cross-platform way of finding an executable in the $PATH.
#
#   which('ruby') #=> /usr/bin/ruby
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each do |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    end
  end
  nil
end

module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end
