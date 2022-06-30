---
title: How can I modify the message of the day?
category: general
description: The message of the day (/etc/motd) is used by RightScale to print a welcome message upon login and to indicate if the instance installation was successful or failed.
---

## Background Information

I am trying to modify the message of the day but overwriting `/etc/motd` in a boot script does not work?

* * *

## Answer

The message of the day (/etc/motd) is used by RightScale to print a welcome message upon login and to indicate if the instance installation was successful or failed. The file `/etc/motd` cannot be modified in a boot script because it is written after all the boot scripts have run. This is necessary because the message changes if all of the scripts have run successfully or not.

It is not possible to modify the init scripts because they are a part of the server image. However, you can change the source files that are written to `/etc/motd`. These files are:

~~~
/opt/rightscale/etc/motd-complete
/opt/rightscale/etc/motd-failed
~~~

You can use your own boot script to overwrite these two files. Attach your two replacement text files (motd-complete) and (motd-failed) to the script and use the following as the script body:

~~~
cp $RS_ATTACH_DIR/motd-complete /opt/rightscale/etc/motd-complete
cp $RS_ATTACH_DIR/motd-failed /opt/rightscale/etc/motd-failed
~~~
