---
title: Deregister a Private Cloud from RightScale
layout: cm_layout
description: Steps to permanently delete a private cloud from RightScale. Note that you cannot permanently delete a public cloud because you do not control their infrastructure.
---
## Objective

To permanently delete a private cloud from RightScale. (_Note_: You cannot permanently delete a public cloud because you do not control their infrastructure.)

!!warning*Warning!* Before you permanently delete a cloud from RightScale, be sure you fully understand its ramifications. When you permanently deleted an administered private cloud, any RightScale account that previously had access to the cloud's resources will lose the ability to access those resources from the RightScale platform.

## Prerequisites

* You must be the administrator of the cloud. (Typically the person who installed the cloud and then registered it with RightScale.)
* The private cloud must have already been registered with RightScale.

## Steps

* Navigate to to **Settings** -> **Account Settings** -> **Clouds** tab
* Click the hyperlink for the private cloud you wish to delete.
* Click the **Delete** button. Be sure you fully understand its ramifications.

![cm-delete-cloud.png](/img/cm-delete-cloud.png)

As a safety precaution, you will be prompted to confirm the deletion of the cloud, along with a clear description of what action will take place if you proceed. (Please note the emphasis in bold below.)

This will **remove all RightScale users** from the Cloud '*CloudName*' and **delete the cloud.** You can re-register your cloud later, but you lose all meta-data, such as servers and cloud-specific settings for ServerTemplates. **This cannot be undone**.

## See also

- [Delete a Cloud Account from a RightScale Account](/cm/dashboard/settings/account/delete_a_cloud_account_from_a_rightscale_account.html)
