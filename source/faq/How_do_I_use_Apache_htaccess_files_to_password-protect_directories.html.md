---
title: How do I use Apache .htaccess files to password-protect directories?
category: general
description: This article describes how to enable .htaccess files for Apache on a server within a RightScale deployment.
---

## Background Information

How do you enable .htaccess files for Apache? When you create the files in directories, they do not work.

* * *

## Answer

You will need to modify the vhost configuration files found in `/etc/httpd/rightscale.d`

If the server is a load balancer and has HAProxy installed on it, you will need to modify: `http-8000-www.yoursite.com.vhost`.

If it is a standalone server (such as part of an auto-scaling array) you will need to modify: `http-80-www.yoursite.com.vhost`.

Change the line from `AllowOverride None` to `AllowOveride All` in order to password protect a directory that you can put the following into: `/home/webabbs/yourappdir/current/dirtoprotect/.htaccess`.

~~~
AuthType Basic
AuthName "Password Required"
AuthUserFile /www/passwords/password.file
AuthGroupFile /www/passwords/group.file
Require Group admins
~~~

You can automate this in a RightScript as follows. This script password protects the www root (you will need to modify the path if you need to protect a different directory):

~~~
#!/bin/bash

if [-f /etc/httpd/rightscale.d/http-8000-$WEBSITE_DNS.vhost]; then
  sed -i "s/AllowOverride None/AllowOverride All/g" /etc/httpd/rightscale.d/http-8000-$WEBSITE_DNS.vhost
fi
if [-f /etc/httpd/rightscale.d/http-80-$WEBSITE_DNS.vhost]; then
  sed -i "s/AllowOverride None/AllowOverride All/g" /etc/httpd/rightscale.d/http-80-$WEBSITE_DNS.vhost
fi
cat > /home/webapps/$APPLICATION/current/.htaccess << EOF
AuthType Basic
AuthName "Password Required"
AuthUserFile /www/passwords/password.file
AuthGroupFile /www/passwords/group.file
Require Group admins
EOF

service httpd restart
~~~
