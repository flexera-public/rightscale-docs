---
title: Managing Windows Updates
description: Steps for managing Windows updates on Windows Servers running in the RightScale Cloud Management Platform.
---

## Overview

Managing Windows Servers as an Admin can be particularly troublesome when it comes to patching servers for a variety of reasons. Initially, the admin subscribes to the 'don't fix what isn't broken' mentality whereby he turns off 'Automatic Update' and leaves the machine unpatched for an indefinite period of time. Eventually, the administrator is forced to consider applying patches due to either some highly critical patch or because a certain fix is required for the operation of a new or upgraded application. Now, the administrator has to comb through countless KB articles, identify what patches will be applied, apply and test them, and then promote them to production within a defined outage period.

You can streamline the process of managing Windows updates by using RightScripts.

## Steps

Using RightScale, the following process will update your Windows Server in Production with minimal downtime to be protected with all critical updates:

* Import Windows Update RightScript (SYS Windows Updates installer) from the MultiCloud Marketplace. This RightScript will apply all critical updates to your server automatically, rebooting as necessary until complete.
* Add the Windows Update RightScript as an 'Any Script'.
* Configure and launch an instance of the ServerTemplate to run outside your production environment. When operational, run the 'SYS Windows Updates installer' RightScript to let all critical patches be applied automatically.
* When the server is operational, proceed with application and system testing to verify the patch.
* Once satisfied with patches, perform sysprep as necessary. Once clean, bundle the machine into a new image.
* Perform a sanity test on the new image and then after complete verification, begin changing the images used by production servers. You can either perform a rolling upgrade by bouncing individual production servers (ideal, if possible), or schedule downtime to restart all production servers on the new images.
* Alternatively, if the administrator has a list of updates he would like to apply to his system, instead of running the 'SYS Windows Updates installer' RightScript, run the UpdateList RightScript and provide the list of update titles to apply.
