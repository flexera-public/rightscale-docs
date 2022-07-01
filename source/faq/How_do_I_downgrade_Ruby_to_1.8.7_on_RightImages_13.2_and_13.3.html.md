---
title: How do I downgrade Ruby to 1.8.7 on RightImages 13.2 and 13.3?
category: general
description: With the v13.2 ServerTemplate release, all images were upgraded to version 1.9.3. However, users may require an older version.
---

## Background

With the v13.2 ServerTemplate release, all images were upgraded to version 1.9.3. However, users may require an older version. The user must downgrade ruby to version 1.8.7 manually.

## Answer

Execute the following on the command line of a v13.2 Linux RightImage instance logged in as 'root':

For CentOS and RedHat:

~~~
yum erase ruby ruby-libs
yum install ruby-1.8.*
yum install rubygems
~~~

For Ubuntu:

~~~
apt-get install ruby1.8 rubygems (may already be installed)
update-alternatives --set ruby "/usr/bin/ruby1.8"
update-alternatives --set gem "/usr/bin/gem1.8"
~~~
