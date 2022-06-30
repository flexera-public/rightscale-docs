---
title: What is the HEALTH_CHECK_URI?
category: general
description: The HEALTH_CHECK_URI is used by HAProxy to verify whether each application server in its load-balancer pool is running ("up").
---

## Background Information

While launching load-balancer (HAProxy) servers, a HEALTH_CHECK_URI input is required. What is this?

* * *

## Answer

The HEALTH_CHECK_URI is used by HAProxy to verify whether each application server in its load-balancer pool is running ("up").

You can set this input to "Ignore" if you do not want HAProxy to do health checks. However, you should eventually enable health checks, because it is the only way to ensure that HAProxy will not direct client connections to a server that is unavailable. Remember the following when specifying a HEALTH_CHECK_URI:

* It should reference a static web page that is always present and whose file name never changes.
* The actual contents of the page are not important. They can be as simple&nbsp;as the text:&nbsp;"OK."
* To prevent HAProxy from reading pages from servers that do not belong to your configuration, use a random number in the health-check file name (e.g. health1235293874.html). For example, do not use `index.html` as your health-check page, because most web servers include this file.
* The page should return a 200 OK message when accessed in a web browser.
* The page needs to be accessible to any user.&nbsp; For example, do not password protect it using .htaccess.
* Test the page using `www.yoursite.com/health1235293874.html` (where `www.yoursite.com` is your fully qualified host name) and ensure that you can see its contents.
* Assuming that the script input OPT_LB_STATS_URI is set to *haproxy-status* and HEALTH_CHECK_URI is correctly set (and that your site's permissions allow it), you can add `/haproxy-status` to your load-balancer hostname URL to check the status of HAProxy: `www.yoursite.com/haproxy-status`. This displays an HAProxy status report in a tabular HTML format.
* If an application server is unavailable or its health-check page is inaccessible, it is considered "down," and that server will not participate in the load-balancer pool.
* If you set HEALTH_CHECK_URI to "Ignore" for an application server, the HTML-formatted HAProxy status report (`www.yoursite.com/haproxy-status`) displays a "no check" status for that server, and HAProxy includes it in the load balancer pool even if it is not accessible or running.
* When entering the HEALTH_CHECK_URI input, specify the path to the URI from www root, prefixed by a forward slash. For example, if the file is named `/health1235293874.html` and located in www root, enter: `/health1235293874.html`. If it is in a subdirectory, enter a HEALTH_CHECK_URI value like `/MySubdirectory/health1235293874.html`.
