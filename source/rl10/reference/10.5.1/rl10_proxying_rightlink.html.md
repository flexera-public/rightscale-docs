---
title: RightLink Through a Proxy
description: RightLink 10 is capable of routing all its traffic through an external proxy for both all workflows ("enable running", "install at boot", "custom image").
version_number: 10.5.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_proxying_rightlink.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_proxying_rightlink.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_proxying_rightlink.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_proxying_rightlink.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_proxying_rightlink.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_proxying_rightlink.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_proxying_rightlink.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_proxying_rightlink.html
---

## Overview

Starting with version 10.1 for Linux and 10.2 for Windows, RightLink is capable of routing all its traffic through an
external proxy for both all workflows ("enable running", "install at boot", "custom image").

The proxy server must support the HTTPS CONNECT protocol. SOCKS is currently not
supported, and no HTTP requests are made by the RightLink client. Basic authentication
is also supported by passing the username and password in the url itself. Digest and
more advanced authentication schemes such as NTLM or Kerberos are not currently supported.

## Execution environment

http_proxy, https_proxy, HTTP_PROXY, and HTTPS_PROXY will also be set in the execution
environment of your scripts/recipes if RightLink is proxied. no_proxy and NO_PROXY will
also be set if the no_proxy parameter is passed. Many unix programs (apt-get, yum, curl,
rsc) will honor these parameters if set.

## Configuring your proxy

RightLink communicates back with the RightScale platform in 4 ways:
1. HTTPS requests to the RightScale API servers, such as us-3.rightscale.com
2. HTTPS requests to the island load balancers (such as island1.rightscale.com) to download attachments and cookbooks.
3. Websocket requests to the RightScale routers.
4. HTTPS requests to the RightScale TSS servers, such as tss-3.rightscale.com.

The websockets protocol is built on top of HTTPS and from the perspective of the
proxy server it is an HTTPS connection that is kept open indefinitely. Requests are
periodically sent on the websocket (every 5 minutes). In order to accommodate the
websocket connection, make sure the inactivity timeout is at least 15 minutes and
[read timeouts](http://www.squid-cache.org/Doc/config/read_timeout/) are as high as possible.

#### SSL/TLS Intercept Proxy Notes:

SSL/TLS interception proxy works by negotiating two sessions: 
1. Acts as the client on the server side 
2. Acts as server on the client side
3. Generates new server key pair on client side

When properly configured the SSL/TLS intercept proxy should be somewhat transparent to RightLink and should not impact RightLink communication.  The details for properly implementing and configuring SSL/TLS intercept proxies vary by manufacturer and as such these details are beyond the scope of this brief document _-please refer to your manufacturer's specific documents on implementation and configuration._  In general, the best practice guidelines for implementing and configuring SSL/TLS intercept proxies are outlined below.   

  - **Transitive root/x.509 trusts** should be established without any certificate validation flaws
  - **Key pair caching and indexing** should be working correctly for both first visit and subsequent visits
  - **Websockets** should be supported 
  - **Failure modes** should be properly planned and accounted for such as passthrough in the case that the proxy goes down.  If not passthrough then the intercept proxy becomes the single point of failure.  Each failure mode: passthrough, fail close, friendly error has some trade offs.
  - **Updating/Patching** procedures should be planned and defined, and should include using a test ssl intercept proxy appliance when applying patches and updates vs. applying updates and patches to a live production proxy appliance. 
  - **All Testing passes** e.g. Qualys SSL/TLS security scanner or others

## Usage

### Enabling a Running Instance

To use a proxy when enabling a running instance, pass the `-x proxy_url` and
`-y no_proxy` options to the `rightlink.enable.sh` script on Linux or to the `rightlink.enable.ps1`
script on Windows as shown in the following example. For further details, see Enable Running Instances
for [Linux](rl10_enable_running_instances.html) or [Windows](rl10_enable_running_instances_windows.html).

  ~~~ bash
  curl -s https://rightlink.rightscale.com/rll/10.5.2/rightlink.enable.sh | sudo bash -s -- -l -k "e22f8d37...456"
  -t "RightLink 10.5.2 Linux Base" -n "Test Server" -d "RightLink Enabled Test" -c "amazon"
  -x "http://basicuser:basicpass@1.2.3.4:3126" -y "dontproxy.com"
  ~~~

  ~~~ powershell
  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile("https://rightlink.rightscale.com/rll/10.5.2/rightlink.enable.ps1", "$pwd\rightlink.enable.ps1")
  Powershell -ExecutionPolicy Unrestricted -File rightlink.enable.ps1 -refreshToken "e22f8d37...456"
  -serverTemplateName "RightLink 10.5.2 Windows Base" -serverName "Test Server" -deploymentName "RightLink Enabled Test"
  -cloudType "amazon" -Proxy "http://basicuser:basicpass@1.2.3.4:3126" -NoProxy "dontproxy.com"
  ~~~

### Installing at Boot and Custom Image

To use a proxy for a RightLink agent installed at boot via cloud-init for [Linux](rl10_install_at_boot.html), you may set tags on your RightScale Server of the form `rs_agent:http_proxy=url` and `rs_agent:http_no_proxy=url list`. For example, set these tags on your Server before launch:

  ~~~ bash
  rs_agent:http_proxy=http://basicuser:basicpass@1.2.3.4:3128
  rs_agent:http_no_proxy=example.com,myserver.com
  ~~~

Alternatively, user and password can be specified as separate tags which allows the use of [Credentials]:

* `rs_agent:http_proxy_user=<user>|cred:<CRED>` -- Allows setting the user to use along with the `rs_agent:http_proxy` and `rs_agent:http_proxy_password` tags. Its value can be either a plain text user or a reference to a [Credential]. It must be specified along with `rs_agent:http_proxy_password` and may only be specified when `rs_agent:http_proxy` is specified as well.
* `rs_agent:http_proxy_password=cred:<CRED>` -- Allows setting the password to use along with the `rs_agent:http_proxy` and `rs_agent:http_proxy_user` tags. Its value can be a reference to a [Credential] which allows hiding the sensitive password value when viewing server or server array tags. It must be specified along with `rs_agent:http_proxy_user` and may only specified when `rs_agent:http_proxy` is specified as well.

**Example**:

~~~
rs_agent:http_proxy=10.0.0.0:3128
rs_agent:http_proxy_user=basicuser
rs_agent:http_proxy_password=cred:BASIC_PASS
~~~

These tags will also work for images with Cloud-init and RightLink pre-installed for Linux or RightLink pre-installed for Windows.

[Credentials]: /cm/dashboard/design/credentials/
[Credential]: /cm/dashboard/design/credentials/

### In a VPC or Private Network

In a network with very limited outbound access, install-at-boot scenarios become a bit more complicated. Bootstrapping relies on cloud-init downloading and running an install script. This can be done two ways, one of which is proxy friendly and one of which isn't. 
* You can pass cloud-init an URL to download directly by setting the `rs_agent:mime_include_url` tag on your MCI. Since cloud-init [doesn't know about the proxy set](https://bugs.launchpad.net/cloud-init/+bug/1089405?comments=all) by the http_proxy tag, the `rs_agent:mime_include_url` tag which contains the script to download and install RightLink will fail. 
* The alternate way is to use `rs_agent:mime_shellscript` tag. This tag is set to an URL to download, exactly like `mime_include_url`. However, it generates a bash snippet to `curl` down and execute the shell script specified at the URL which is proxy-aware. 

In addition to the above solutions, there are a number of network level solutions to allow outbound access:
1. Create a rule to allow outbound access to `rightlink.rightscale.com` for your network.
2. Create a [custom image](rl10_install.html) with RightLink 10 pre-installed. The `x-mime-include-url` tag can be left off as RightLink will already be installed.
3. Create a proxy to `rightlink.rightscale.com` in your private network and have the `rs_agent:x-mime-include-url` reference that instead.

