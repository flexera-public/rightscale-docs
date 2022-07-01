---
title: How do I install Pecl/APC?
category: general
description: The PECL Demo ServerTemplate has Chef recipes which can be used to install PEAR and PECL packages.
---

## Background Information

Trying to install `php-pecl-apc` fails because of a dependency error.

* * *

## Answer

You need to use Pear to install this, which can be done through a simple RightScript or Chef Recipe.

The [PECL Demo](http://www.rightscale.com/library/server_templates/PECL-Demo/lineage/18473) ServerTemplate has Chef recipes which can be used to install PEAR and PECL packages.

Another option is creating a RightScript. Add the following to the 'Packages' line, to install the necessary resources for APC installation:&nbsp;

~~~
php-pear php-devel httpd-devel
~~~

And paste this as the body of the script. You can enter custom configuration options in the file apc.ini created by the script:

~~~
#!/bin/bash echo no | pear install pecl/apc echo extension=apc.so > /etc/php.d/apc.ini service httpd graceful
~~~
