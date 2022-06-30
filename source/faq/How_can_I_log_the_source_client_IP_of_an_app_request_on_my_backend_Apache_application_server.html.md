---
title: How can I log the source client IP of an app request on my backend Apache application server?
category: general
description: By default, the RightScale Load Balancer ServerTemplates will forward the 'X-Forwarded-For' HTTP header, which contains the source client IP address of the request, through to your backend application server.
---

## Background

By default, our Load Balancer servertemplates will forward the 'X-Forwarded-For' HTTP header, which contains the source client IP address of the request, through to your backend application server. This IP address isn't logged anywhere by default though, so this article explains how we can add this header to the Apache access logs on the backend (application) servers in order to see where the request originated from.

## Answer

In order to log the source IP from the X-Forwarded-For header on the app server, we will want to edit the Apache configuration file on your application server. This is normally located in:

**Ubuntu:** /etc/apache2/apache2.conf

**Centos:** /etc/httpd/conf/httpd.conf

Edit the file with a text editor and locate the 'LogFormat' lines, which defines how our access and error logs should output their content. By default, we will be looking at the 'combined' LogFormat line, but you can add this to any LogFormat line you wish. It will look similar to this:

~~~
LogFormat "%i %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
~~~

To add in the X-Forwarded-For, we will simply use the variable and integrate it into the LogFormat line, so you will want to change this line like so:

~~~
LogFormat "%i 'Forwarded for - %{X-Forwarded-For}i' %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
~~~

Save the change to the Apache config file, then restart/reload Apache. After a restart, view your access.log files, and you should notice that the source IP now being logged. Access logs are normally located in **/var/log/apache2/** or **/var/log/httpd/** (depending on distribution), though they may be elsewhere depending on templates used or app configuration.

**Have questions or problems?**

Call us at **(866) 787-2253** or open up a support request from the RightScale dashboard by going to the **Support -> Email** link from the top right corner of the dashboard.
