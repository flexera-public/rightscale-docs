---
title: Deregister or Delete a Private Cloud from RightScale
layout: cm_layout
description: Steps for deleting/deregistering a private cloud from RightScale so that the private cloud's resources will no longer be accessible to any RightScale account.
---
## Objective

To delete/deregister a private cloud from RightScale so that the private cloud's resources will no longer be accessible to any RightScale account. (i.e. Nobody will have the ability to access your private cloud's resources through the RightScale Dashboard or API.)

## Prerequisites

* A private cloud (Cloud.com, etc.) that has been registered with RightScale by this particular RightScale account.
* 'admin' user role privileges in the RightScale account that was used to originally add the private cloud with RightScale. For example, if you originally added private cloud 'X' with a RightScale account called "SomeCompany," only an admin user of that account can delete the cloud.

## Overview

When you permanently delete/deregister a private cloud from RightScale, you are not deleting the cloud itself. When you go into the Dashboard and delete a private cloud you are simply removing the ability to access the private cloud and its resources from the RightScale management platform (for all users). The private cloud and its resources will still exist and be unaffected, however they will need to be managed using a different tool. Each private cloud has a separate user/admin console that can be used to manage its resources.

If you do not want to permanently delete a private cloud, but only want to remove access to it for a RightScale account(s), see [Delete a Cloud Account from RightScale](/cm/dashboard/settings/account/delete_a_cloud_account_from_a_rightscale_account.html).

Only the "owner" of the private cloud should delete or approve the deletion of a private cloud from RightScale. The cloud owner/administrator can be identified (by email) as the person who originally registered the private cloud with RightScale. If you are not the cloud owner/administrator, but have 'admin' privileges, be sure to contact the person who is referenced under the cloud's Info tab before attempting to delete it. Go to Settings -> Account -> Clouds tab -> click the private cloud name (text link). (e.g. Created by: [admin@site.com](mailto:admin@site.com))

### What are the implications of deleting a private cloud?

The private cloud will no longer appear under the Clouds menu (Clouds -> *SomePrivateCloud*) in the RightScale Dashboard in any RightScale account. If you've previously given other RightScale accounts access to your private cloud, your cloud will no longer appear in their account as well. So, if other users have instances that are currently running in your private cloud that they may have initially launched using the RightScale Dashboard, they will need to use another tool to manage or terminate those instances. (i.e. private cloud's console interface)

## Steps

1. Before you delete a cloud, make sure that you fully understand the implications and ramifications of deleting a cloud. Make sure that you can still access your private cloud using a different tool and that you have warned any users of your private cloud that they will no longer be able to manage your private cloud's resources using RightScale.
2. Log into the RightScale account that you initially used to register the private cloud with RightScale.
3. Go to **Settings** > **Account** > **Clouds tab**.
4. Go to the private cloud's show page by clicking on its nickname link.
![cm-private-cloud-account.png](/img/cm-private-cloud-account.png)
5. Click the **Delete** action button.
6. Since this is a significant action, you will be asked to confirm the deletion by entering your user password. Please carefully read the text in the dialog box before proceeding. Click **Confirm Delete**.

![cm-all-cloud-accounts-removal.png](/img/cm-all-cloud-accounts-removal.png)

## Post Tutorial Steps

* You may want to inform any users of your private cloud that the cloud is no longer accessible via RightScale.
