---
title: Load Balancer with HAProxy for Chef Server (RightLink 10)
alias: st/rl10/lb/overview.html
description: This RigthLink 10 ServerTemplate contains scripts and inputs that allow it to connect to application servers private/public IP address. It is one of the core ServerTemplates in a typical a three-tier website architecture.
---

## Overview

Configures a dedicated HAProxy load balancer. The ServerTemplate contains scripts and inputs that allow it to connect to application servers private/public IP address. The ServerTemplate is one of the core ServerTemplates in a typical a three-tier website architecture.

!!info*Note:* This ServerTemplate requires a Chef Server with the required cookbooks (see below under Requirements) uploaded to the Chef Server to work.

**Note:** For a complete list of the ServerTemplate's features and support, view the detailed description under its **Info** tab.

## Requirements
* Chef Server or Hosted Chef
* [rs-haproxy](https://github.com/rightscale-cookbooks/rs-haproxy) ([2.0.1](https://github.com/rightscale-cookbooks/rs-haproxy/releases/tag/v2.0.1))

## Technical Overview

HAProxy (High Availability Proxy) is a software load balancer. It is generally used to direct client web traffic to an array of application servers. The scripts associated with the ServerTemplate installs the HAProxy. The following are the scripts in the Boot Sequence and Operational section:

**Boot Sequence:**
See [RightLink 10 Linux Base ](/st/rl10/base_linux/index.html) for details on the default scripts.
* **Chef Client Install** - This script installs and configures the chef client.
* **HAProxy Install - chef** - Installs HAProxy by downloading the source package and compiling it. This recipe simply sets up the HAProxy configuration file using the haproxy LWRP, enables, and starts the HAProxy service. If the ‘HAProxy SSL Certificate’ input is set then this recipe will configure HTTPS support on the HAProxy server. All HTTP requests will be redirected to HTTPS in this scenario.
* **HAProxy Frontend - chef** - This script can be used in two different contexts.
  1. To attach all existing application servers in the deployment to the corresponding pools served by the HAProxy server. This recipe finds application servers in the deployment by querying for the application tags on the application server. Only the application servers whose application name matches one of the pool names in HAProxy are identified and attached to the HAProxy server.
  2. To be run as a remote recipe for attaching/detaching a single application server to/from the HAProxy servers. To attach a single application server, the server invoking the remote recipe call should set the action attribute to attach and pass its application name, bind IP address and port, server UUID, and the virtual host name to the HAProxy server. To detach a single application server, this attribute should be set to detach and the invoking server should pass its application name and the server UUID to the HAProxy server. Refer to rs_run_recipe utility for making remote recipe calls and passing information to the remote recipe.
* **HAProxy Schedule - chef** -   Creates a crontab entry to run the `HAProxy Frontend - chef` script to attach all active application servers.

**Operational Scripts:**

* **HAProxy Frontend - chef** - This script can be used in two different contexts.
  1. To attach all existing application servers in the deployment to the corresponding pools served by the HAProxy server. This recipe finds application servers in the deployment by querying for the application tags on the application server. Only the application servers whose application name matches one of the pool names in HAProxy are identified and attached to the HAProxy server.
  2. To be run as a remote recipe for attaching/detaching a single application server to/from the HAProxy servers. To attach a single application server, the server invoking the remote recipe call should set the action attribute to attach and pass its application name, bind IP address and port, server UUID, and the virtual host name to the HAProxy server. To detach a single application server, this attribute should be set to detach and the invoking server should pass its application name and the server UUID to the HAProxy server. Refer to rs_run_recipe utility for making remote recipe calls and passing information to the remote recipe.
* **HAProxy Schedule - chef** -   Creates a crontab entry to run the `HAProxy Frontend - chef` script to attach all active application servers.  

### General Best Practices

1. Select an instance type that best meets your application's performance requirements. If possible, select an instance type that offers more memory or guaranteed interface/bandwidth I/O, which is ideal for a load balancer server.
2. Launch load balancer servers in different availability zones or datacenters (if supported by the cloud) for additional protection against outages in a single zone affecting your entire web application. Typically, application servers and HAProxy load balancer servers will be in the same cloud.

### Support for Multiple Load Balancing Pools

Although the ServerTemplate is commonly used to launch a set of load balancer servers that round-robin incoming web requests for a single application across an array of dedicated applications servers, it can also be configured to load balance across multiple applications using multiple vhosts. For example, if you have two different applications (e.g. free and pay versions) where both applications connect to the same database, you could create a single deployment where the same load balancer servers send traffic to the appropriate application tier.

![st-3tier-array.png](/img/st-3tier-array.png)

**Example: 1 Load Balancing Pool**

![st-3tier-mult-vhosts.png](/img/st-3tier-mult-vhosts.png)

**Example: 2 Load Balancing Pools**

### Session Stickiness

If you want a user's session to be maintained, set the **Use Session Stickiness** input to **True** to configure the load balancers to send a user's subsequent requests to the same application server. However, it's important to remember that session stickiness will only work if an end user's browser allows and stores the session cookie from the load balancer. Set to **False** to disable session stickiness and configure the load balancers to distribute incoming requests in a round-robin fashion across all serviceable application servers.

### Load Balancing Algorithm

By default, the load balancers will distribute incoming requests to the application servers in its load balancing pool in a round-robin fashion. (e.g. 1,2,3,1,2,3,1...) However, the ServerTemplate also has built-in supports for a few other configurations. Use the **Load Balancing Algorithm** input to select the load balancing logic that's best suited for your application.

* **roundrobin** (default) - Incoming requests are distributed in a round-robin fashion. (a-b-c-a-b-...)
* **leastconn** - Incoming requests are sent to the server with the fewest number of active connections.
* **source** - Incoming requests from the same client IP address will be sent to the same application server.

To learn more, see the [HAProxy Configuration Manual](http://haproxy.1wt.eu/download/1.6/doc/configuration.txt).

### HAProxy Status Report (Health Check Page)

HAProxy includes a built-in health-checking feature that allows it to monitor registered application servers to determine if they are running and accepting connections (up). To enable this feature, each application server must have an identically named health check page that will return an HTTP 200 OK status back to the HAProxy server each time a load balancer issues an HTTP GET request. The health-check page helps distinguish your application servers from other servers running outside of your deployment.

Go to the HAProxy Status page to verify that all of the application servers are properly connected to the load balancer servers. The default location of the status page is defined by the **Statistics URI** input. By default, it's set to the value ‘**/haproxy-status**’. (e.g. http://www.example.com/haproxy-status) You may optionally set the **Statistics Page Username** and **Statistics Page Password** inputs in order to require a user name and password to log in and view the page.

![st-HAProxy-status.png](/img/st-HAProxy-status.png)

