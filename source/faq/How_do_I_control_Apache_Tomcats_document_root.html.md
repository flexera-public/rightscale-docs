---
title: How do I control Apache Tomcat's document root?
category: general
description: Tomcat will render the app based on its appbase, which is set to /home/webapps/application/releases/working/ where 'application' is the name of your application.
---

## Background Information

I have a warfile named portal.war and when the RightScale ServerTemplates install it, Tomcat renders the files at www.mysite.com/portal instead of at www.mysite.com/. So the document root is in /portal instead of /. How can I modify this setting?

* * *

## Answer

Tomcat will render the app based on its appbase, which is set to /home/webapps/application/releases/working/ where 'application' is the name of your application.

In order to get Tomcat to serve the files based on another context, you need to add the following directive to the web.xml file:

  `<Context path="/" docBase="/home/webapps/application/releases/working/portal" />`

So you should add the following to the **server.xml template** file, which is attached to the RightScript, **WEB TomCat5 configure v5**.

  `<Context path="/" docBase="/home/webapps/@@APPLICATION@@/releases/working/portal" />`

Note that "portal" in the above context assumes your warfile is named portal.war. You would replace the word "portal" with your actual warfile name (without the .war extension).
