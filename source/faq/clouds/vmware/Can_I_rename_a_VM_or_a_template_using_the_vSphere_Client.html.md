---
title: Can I rename a VM or a template (image) using the vSphere Client?
category: vmware
description: When I use the vSphere Client to rename a VM or a template, the Dashboard does not appear to update the corresponding Instance or Image name.
---

## Question:

When I use the vSphere Client to rename a VM or a template, the Dashboard does not appear to update the corresponding Instance or Image name.

Is this a known behavior with a fix or should I just get the name right first time and not rename things?

## Resolution

As of this time, renaming Template (images) from the vSphere Client does not update the image in RightScale.

If you want to rename an existing template, here's a way to do it:

1. Find the Template (image) that you want to rename using the vSphere Client
2. Right click and choose, "Convert to Virtual Machine"
3. Go to **RightScale dashboard > Clouds > Images**
4. At the bottom of the page that says "..you can manually query if something positively looks out of date", click the query link.
5. Wait for a while and refresh the page until the image disappear from the list
6. Now back to vSphere Client, select the VM, right-click and select **Template > Convert to Template**
6. Once the VM has been converted into a Template again, go back to the RightScale dashboard cloud image and do the re-query again
7. It should take a few seconds to a couple minutes to discover the new image

In summary, to rename the image, convert first to VM, do a RightScale force query, make sure the image was remove from the list, convert the image to template and do a force re-query again. Doing a re-query is not required since there is a scheduled process to discover the resources in the cloud including templates (images) but it will make the discovery faster. But doing so, you may need to re-associate the image to any MCI if you manually added it.

As for VMs, instance that was provisioned using RightScale dashboard (or API), we do not recommend renaming the instance name and this is not supported operation. If you want to rename the instance name, you can rename the server name instead and relaunch the server. The new instance will be provision using the new server name.
