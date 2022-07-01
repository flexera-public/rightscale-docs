---
title: How can I change the EC2 hostname?
category: aws
description: You can change the hostname on the instance using the Linux hostname command (you can do this as part of a boot script).
---

## Background Information

Currently the hostname is in the form: "DomU-12-31-38-00-AA-11"  
How can I change it?

* * *

## Answer

You can change the hostname on the instance using the Linux hostname command (you can do this as part of a boot script):

~~~
hostname myhostname
~~~

However, this does not effect DNS in any way.&nbsp; You need to also make changes to the hostname in DNS Made Easy if you want to be able to access that host from other computers. This can be done by modifying or creating A-Records for the server. The hostname command effects the "internal" hostname of that server only.
