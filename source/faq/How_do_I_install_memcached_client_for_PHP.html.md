---
title: How do I install memcached client for PHP?
category: general
description: Install the memcached client for PHP in Ubuntu by adding the php5-memcache package and reloading apache, in CentOS by installing the package via PECL, or by creating a RightScript to install it at launch time.
---

## Answer

For Ubuntu just add the php5-memcache package and reload apache.

For CentOS, &nbsp;install the package via PECL. This can be done using the Chef recipes included in the PECL Demo ServerTemplate.

Another option is to create a RightScript that will do this at launch time.&nbsp;The RightScript should contain the following:

~~~
#!/bin/bash -ex

#
# Test for a reboot, if this is a reboot just skip this script.
#
if test "$RS_REBOOT" = "true" ; then
  echo "Skip install of PECL::Memcache on reboot."
  logger -t InstallPHPMemcacheScript "Skip Example script on reboot."
  exit 0 # Leave with a smile ...
fi

echo "Installing PECL::Memcache"
echo "y" | pecl install -a -f memcache
if [$? -eq '0']; then
  echo "install completed successfully adding to php.conf"
  echo "extension=memcache.so" > /etc/php.d/memcache.ini
fi

exit 0
~~~

Add this RightScript to the boot scripts for your server template and ensure that Apache 2 is restarted after.

### See also:

* [How do I install memcached monitoring?](https://support.rightscale.com/06-FAQs/FAQ_0144_-_How_do_I_install_memcached_monitoring%3F/index.html)
* [How do I install Pecl/APC?](/faq/How_do_I_install_Pecl_APC.html)
