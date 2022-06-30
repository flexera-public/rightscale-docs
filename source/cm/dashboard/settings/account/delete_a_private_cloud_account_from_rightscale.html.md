---
title: Delete a Private Cloud Account from RightScale
layout: cm_layout
description: Steps to delete a private cloud account from a RightScale account so that the cloud's resources are no longer accessible via the RightScale platform (Dashboard or API).
---
## Objective

To delete a private cloud account from a RightScale account so that the cloud's resources are no longer accessible via the RightScale platform (Dashboard or API).

## Prerequisites

* A private cloud to which you have access to in your RightScale account (Clouds -> *SomePrivateCloud*)
* 'admin' user role privileges in the RightScale account that you're going to delete the private cloud account

## Overview

Deleting a private cloud account is different than permanently deleting/deregistering a private cloud from RightScale ([Deregister or Delete a Private Cloud from RightScale](/cm/dashboard/settings/account/deregister_or_delete_a_private_cloud_from_rightscale.html)) because you are only removing access to that from a single RightScale account whereas the latter removes access to the private cloud from all RightScale accounts.

For example, perhaps you or another user with 'admin' privileges added private cloud 'X' to your RightScale account. Now, you no longer need to access that private cloud's resources. Furthermore, you no longer wish to see cloud 'X' appear under the Clouds menu of the RightScale Dashboard. Therefore, you want to remove all data associated with cloud 'X' from your RightScale account.

### What are the implications of deleting a private cloud account?

* The private cloud will no longer appear under the Clouds menu (Clouds -> *SomePrivateCloud*) in the RightScale Dashboard
* All RightScale meta-data will be lost (e.g. Servers, cloud-specific settings, Nicknames, etc.)
* To manage existing cloud resources, you will need to use another tool to manage or terminate those instances. (i.e. private cloud's console interface)

## Steps

1. Before you delete a cloud, make sure that you fully understand the implications and ramifications of deleting a cloud account. Make sure that you can still access the private cloud (if necessary) using a different tool and that you have warned users of your RightScale account that they will no longer be able to manage their resources of that private cloud using RightScale.
2. Log into the RightScale account that currently has access to the private cloud.
3. Go to **Settings** > **Account Settings** > **Clouds** tab.
4. Click the **Delete** action icon next to the private cloud you wish to remove from the current RightScale account.
  ![cm-delete-cloud-account.png](/img/cm-delete-cloud-account.png)
5. Since this is a significant action, you will be asked to confirm the deletion by entering your user password. Please read the text in the dialog window before proceeding. Click **Confirm Delete**.

![cm-your-cloud-account-removal.png](/img/cm-your-cloud-account-removal.png)

## Post Tutorial Steps

- You may want to inform any users of your private cloud that the cloud is no longer accessible via RightScale.

## See also

- [Deregister or Delete a Private Cloud from RightScale](/cm/dashboard/settings/account/deregister_a_private_cloud_from_rightscale.html)
