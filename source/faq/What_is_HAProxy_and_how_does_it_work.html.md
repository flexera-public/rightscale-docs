---
title: What is HAProxy and how does it work?
category: general
description: HAProxy, or High Availability Proxy is used by RightScale for load balancing in the cloud. HAProxy is installed with RightScale load balancer ServerTemplates.
---

## Background Information

HAProxy, or High Availability Proxy is used by RightScale for load balancing in the cloud.

HAProxy is installed with RightScale _load balancer_ ServerTemplates. Load-balancer servers are also known as _front-end servers_. Generally, their purpose is to direct users to available application servers. A load-balancer server may have _only_ the load balancer application (HAProxy) installed or, in rare cases, it may be an application server in addition to a load balancer, which is not a recommended configuration.

Each load-balancer server has its own public IP address (typically an _Elastic IP address_ in the case of Amazon EC2 clouds), but shares the same fully qualified domain name (e.g. host.domain.tld) as the other load-balancer servers in your configuration.

*Example:* Server A: loadbalancer.example.com (IP address: 174.11.45.13), Server B: loadbalancer.example.com (IP address: 174.11.68.201).

HAProxy can be used with HTTP and HTTPS traffic.

Get more details in our white paper: [Load Balancing in the Cloud: Tools, Tips, and Techniques](http://www.rightscale.com/lp/load-balancing-in-the-cloud-whitepaper.php).

* * *

## Answer

### HTTP Using Port 80


1. The user's web browser sends a request to the load balancer over port 80, using the fully qualified domain name/URI (e.g. `http://host.domain.tld:80`).
2. The Domain Name System (DNS) resolves the URI to one of the static IP addresses associated with that fully qualified domain name. (All load-balancer servers share the _same_ fully qualified domain name but have unique static IP addresses.) *Example:* There are two load balancers, _Server A_ and _Server B_. DNS directs the first client request to Server A, the second to Server B, the third to Server A, and so on.

3. If a load-balancer server is unavailable, the request to that server will time out. However, when this happens, most browsers resend the client request to DNS, and the request is directed to the second load balancer in this case. Thus, if one of your two load-balancer servers is unavailable, it will result in half of the traffic to your site having a slower initial load time.

4. Because each load-balancer server has the Apache HTTP Server configured to monitor port 80, Apache processes all incoming client requests to your load-balancer servers.

5. Apache's virtual host configuration has a rewrite rule that sends the request to `http://127.0.0.1:85` (that is, localhost on port 85).

6. HAProxy is configured to monitor `http://127.0.0.1:85`, and receives the request.

7. Referencing the load-balancer pool in its configuration file, HAProxy determines the application server to route the client request to, based on&nbsp;a round-robin system. This server receiving the request is generally part of an auto-scaling array consisting of dedicated application servers. HAProxy forwards the request to the server port referenced in its configuration file (generally port 80).

### HTTPS Using Port 443

When you configure a server to use HTTP Secure (HTTPS), the load-balancer server performs SSL termination for incoming client connections as described in the FAQ titled [How do I set up SSL?](http://support.rightscale.com/06-FAQs/FAQ_0007_-_How_do_I_set_up_SSL%3F).

### Required Boot Scripts

**LB HA proxy install.** Installs HAProxy. The following inputs are used with this RightScript.

**Note**: Inputs prefixed by "OPT\_" are typically optional, not mandatory.

**HEALTH\_CHECK\_URI**

Optional for testing, but required for production. This references a path from www root to a web page that should return an OK 200 response. The contents of the page are not important, but its name should be unique (preferably containing a random number). The same page is used for _all_ application servers to determine whether the server is running (_up_). The page contents can be as simple as the text, "OK." For example, if the page were http://www.mydomain.com:80/hlthchk378923.html and its content was just two letters, "OK," you would simply specify a HEALTH\_CHECK\_URI of: /hlthchk378923.html. While you can use index.html as the health-check page, this is not recommended. This is because most web sites have an index.html page which creates the risk that your load balancer will direct client traffic to a web site other than your own in the cloud.

*Example:* The Amazon EC2 cloud recycles IP addresses so if one server was terminated and another launched for a different site—with the same IP address and page name as your health-check page name—HAProxy could consider the server to be running even though it is someone else's, and direct traffic to it.

For this reason, you should always use a health-check URI with a unique file name. This value displays in the HAProxy configuration file as:

  ~~~
  # When internal servers support a status page
  option httpchk GET /hlthchk378923.html
  ~~~

**LB\_APPLISTENER\_NAME**  
Name of a pool of HAProxy load-balancer servers; for example, _www_. Load-balancer servers with the same LB\_LISTENER\_NAME become part of the same pool. The HAProxy configuration file includes this value in the configuration block:

  ~~~
  # Example: listen myapp 0.0.0.0:80
  listen www 127.0.0.1:85
  mode http
  balance roundrobin
  ~~~

**LB\_BIND\_ADDRESS**  
This is the IP address that HAProxy listens on, which is normally the localhost specified by IP address: 127.0.0.1.

**LB\_BIND\_PORT**  
This is the port that HAProxy listens on, which is normally 85.

**LB\_TEMPLATE\_NAME**  
This is the name of the base HAProxy configuration file that will be used.&nbsp; This file is modified according to the defined input values. The current values are:

  ~~~
  haproxy_fullssl
  haproxy_http
  haproxy_tcp
  ~~~

*Note:* Do _not_ use the haproxy\_fullssl option to enable SSL for your load-balancer server. This function is performed using a RightScript (`"WEB apache FrontEnd https vhost"`) as described in the FAQ titled [How do I set up SSL?](http://support.rightscale.com/06-FAQs/FAQ_0007_-_How_do_I_set_up_SSL%3F)

**OPT\_LB\_STATS\_PASSWORD**  
Used to set a password for the HAProxy status report ("stats") page.

**OPT\_LB\_STATS\_URI**  
Normally set to haproxy-status, this setting defines how to access the HAProxy status report web page, which provides information about which servers are running and listening as part of the load-balancer pool. For example, if you set this value to haproxy-status, you would use http://host.domain.tld/haproxy-status to access the status report page. You can change this URI. This value displays in the HAProxy configuration file as:

  ~~~
  # Haproxy status page
  stats uri /haproxy-status
  ~~~

**OPT\_LB\_STATS\_USER**  
This can be used to set a user name for the HAProxy status page.

**LB Apache reverse proxy configure.** Sets up the Apache web server as a reverse proxy, and includes the /etc/httpd/rightscale.d folder, which contains vhost files for Apache. There are no inputs.

## Required Application Server Scripts

The following scripts must run on the application servers in your configuration to enable interaction with your HAProxy load balancer servers.

**LB Application to HAProxy connect.** Connects the instance to the servers running HAProxy. This script must run on each application server that will join the load-balancer pool.

**LB\_HOSTNAME**  
The fully qualified hostname for all servers with HAProxy installed on them. For example, if loadbalancer.example.com has two associated load-balancer servers with static IP addresses, you would enter _loadbalancer.example.com_ as the LB\_HOSTNAME. These hosts must be registered with DNS so that the script can locate all HAProxy servers and update their configuration files.

**OPT\_SESSION\_STICKINESS**  
When set to "True" HAProxy will reconnect sessions to the last server they were connected to ("session stickiness"), via a cookie.

**LB Application to HAProxy disconnect.** Disconnects the instance from the servers running HAProxy (i.e. removes it from the load-balancer pool), typically on server shutdown. This is generally run as a decommission script on application servers.

## Configuration Files

The `/etc/haproxy/haproxy.cfg` file is the primary configuration file for HAProxy.

The last lines in this file list the application servers in the load-balancer pool. When "LB Application to HAProxy connect" runs on an application server, it adds that server to all the HAProxy configuration files on all load-balancer servers with the same LB\_HOSTNAME.

  `#server srv3.0 10.253.43.224:8888 cookie srv03.0 check inter 2000 rise 2 fall 3`

  `server i-b70793de 10.251.26.177:8888 cookie i-b70793de check inter 3000 rise 2 fall 3 maxconn 255`

The _/etc/httpd/rightscale.d_ directory contains the vhost files for the Apache web server. For example:

  `http-80-yoursite.vhost`<br>
  `http-8888-yoursite.vhost`<br>
  `https-443-yoursite.vhost`
