---
title: Why does Collectd require a missing dependency "libpython"?
category: general
description: At or around October 19, 2010, the folks at collectd changed some dependency requirements, and collectd x86 now requires libpython as a pre-requisite.
---

## Background Information

At or around October 19, 2010, the folks at collectd changed some dependency requirements, and collectd x86 now requires libpython as a pre-requisite.

Our 'SYS&nbsp;Monitoring Install' script that installs and configures collectd for RightScale monitoring will install the x86 (32 bit) version of collectd. When using this script on an x64 (64 bit) instance/Rightimage, you may notice the script fails with an error, indicating the missing dependency -
~~~
--> Processing Dependency: libpython2.4.so.1.0 for package: collectd
--> Finished Dependency Resolution
Error: Missing Dependency: libpython2.4.so.1.0 is needed by package collectd
~~~

* * *

## Answer

To resolve this issue, we recommend one of the following approaches:

1. **Freeze Repository Dates -** Since the problem started on or around 10/19/2010, we recommend freezing to that date or earlier. This will install a collectd (x86) package that does not require libpython x86.
2. **Clone SYS Monitoring Install script and edit -** Another option is to import our SYS Monitoring Install script, then edit and change the Package that it installs. By default we install the package **collectd** but you'll want to change this to **collectd.x86_64** This will install the 64 bit version of collectd, which requires libpython x64, which _is_ installed on our 64 bit Rightimages by default.

### See also

* [http://serverfault.com/questions/160251/yum-claims-python-isnt-installed](http://serverfault.com/questions/160251/yum-claims-python-isnt-installed)
