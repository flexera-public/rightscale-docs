---
title: What is inside of a RightImage?
category: general
description: A RightImage is the basic building block for launching a RightScale-friendly instance in the cloud. RightScale publishes many publicly available Amazon Machine Images (AMIs) that any user can use free of charge.
---

## Background

RightScale publishes many publicly available Amazon Machine Images (AMIs) that any user can use free of charge. Although these images can be used as-is to successfully launch an instance in the cloud with a base operating system, the true power of the RightScale platform is realized when you combine one of these RightImages with a ServerTemplate that will further configure the instance with additional software such that the resulting instance will be a production-ready server that fulfills a particular role or function in the cloud for your web application, such as a MySQ LDatabase Server or PHP Application Server. 

## Answer

A RightImage is the basic building block for launching a RightScale-friendly instance in the cloud. Although RightScale can discover any running instance in the cloud(s) based upon your provided cloud credentials, it's recommended that you follow RightScale's ServerTemplate model for launching instances so that you can leverage the same image to launch multiple instances, but use several different ServerTemplates to configure each server's ultimate functionality.

In order to fully take advantage of the RightScale platform, you need to launch RightScale-friendly instances where RightScale can communicate with the instance in a specialized way. RightImages (v5 and above) contain a lightweight RightLink agent that allows the RightScale platform to more efficiently and securely manage your running instances. If you cannot use a RightImage, you must create a RightScale-friendly version of your custom image by installing RightLink. See [Creating RightScale-enabled Images with RightLink](http://support.rightscale.com/12-Guides/RightLink/04-Creating_RightScale-enabled_Images_with_RightLink).

Let's take a closer look at what's inside of a typical RightImage.

There are several RightScale-specific init scripts that are used by the instance to self-configure itself in such a way that RightScale can optimally manage it.

* **/etc/init.d/rightimage** is the first script that is run. It essentially determines the base OS, architecture version, and installs the correct RightLink package either from our RightScale mirrors or from an S3 bucket. Afterwards it kicks off the **/opt/rightscale/bin/post\_install.sh** script which uses the OS init control tools to register the startup scripts to be invoked on future boots of the OS, thereby ensuring that RightLink will always be started.  

* **/etc/init.d/rightscale** is the third script that is run. It initializes the RightScale-specific (but not RightLink-specific) system state. It's responsible for caching launch settings (i.e userdata) and metadata in /var/spool and then installs any available patches to the RightLink agent.  

* **/etc/init.d/rightlink** is the final script that is run. It configures and enrolls the RightLink agent idempotently, which ensures that RightLink will be properly installed and configured regardless of various configuration factors.  If configuration and enrollment succeed, rightlink starts the sandboxed monit which starts the persistent agent process. If you're not launching the AMI using the RightScale platform (via ServerTemplates) it will never properly enroll with the RightScale platform.  Although RightScale will still be able to discover the instance just like any other instance that's launched directly from an AMI, we will not be able to recognize and treat it as a typical RightScale server that's been launched through the Dashboard or API. Consequently, you'll have limited control over the instance. When you launch a server from the Dashboard or the API (using ServerTemplates) RightScale will create a server record and associate the resulting cloud instance to it when the ec2 daemon detects it or RightLink enrolls properly.

Although you could remove these scripts above from the image without harming the overall stability of the image, their presence in the image does not cause any problems from a security standpoint.
