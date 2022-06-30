---
title: Failed to inject user-data because there is no Floppy drive defined
category: vmware
description: If you are still using an older version of the appliance, you should plan to upgrade both vscale and vscale-admin as soon as possible.
---

## Question:

When launching an instance from an image I created with RightLink 6.x installed for my vSphere, I am receiving the following error:

~~~
CloudExceptions::CloudException - Vscale::GenericError: Failed to inject user-data because there is no Floppy drive defined in the template
~~~

How do I address this error?

## Resolution

With the older version of the cloud appliance, the vscale appliance used to mount the floppy drive as a way to share user-data with the virtual machine. If there is no floppy drive to the VM before you converted it into a template, this will surely fail.

To resolve the issue,

1. Convert the template back to VM
2. Add the floppy drive and convert back to template.  Do not rename the VM name before converting.
3. Once the image has been rediscovered, try to launch a server again

Also, if you are still using an older version of the appliance, you should plan to upgrade both vscale and vscale-admin as soon as possible. The latest version of the cloud appliance, a new feature was introduced which should make the floppy drive based config optional.
