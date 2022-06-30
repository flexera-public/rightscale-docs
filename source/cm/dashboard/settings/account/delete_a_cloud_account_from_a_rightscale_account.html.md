---
title: Delete a Cloud Account from a RightScale Account
layout: cm_layout
description: Steps for deleting a public or private cloud account from RightScale so that the cloud resources are no longer accessible via the RightScale Cloud Management Dashboard.
---

## Objective

To delete a public or private cloud account from RightScale so that the cloud resources are no longer accessible via the Dashboard (for that account).

!!warning*Warning!* Before you delete a cloud account from RightScale, be sure you fully understand its ramifications. See [What happens when I delete a cloud account from RightScale?](/faq/What_happens_when_I_delete_a_cloud_from_my_RightScale_account.html)

## Overview

All cloud account types including AWS can be removed. If you have any issues, please contact [support@rightscale.com](mailto:support@rightscale.com).  

* For changing AWS credentails, see [FAQ 69 - Can I change my AWS Credentials in the Dashboard?](http://support.rightscale.com/09-Clouds/AWS/FAQs/FAQ_0069_-_Can_I_change_my_AWS_Credentials_in_the_Dashboard%3F/index.html)  

## Prerequisites

You must have 'admin' role privileges in the RightScale account you wish to delete the cloud account from.

## Steps

### Delete a Cloud Account

1. Go to **Settings** > **Account Settings** > **Clouds** tab.
2. Locate the cloud credentials that you want to remove from the RightScale account and click the delete icon in the Actions column (red "x").
3. As a a safety precaution, you will need to enter the password that you use to log in to the dashboard. Enter your password and click **Submit**.  
  ![cm-authenticate.png](/img/cm-authenticate.png)
4. Once you've successfully authenticated yourself, click **Confirm Delete**.  
  ![cm-confirm-delete.png](/img/cm-confirm-delete.png)
5. After the cloud's credentials have been successfully removed from the RightScale account, the cloud will no longer be listed as an available public/private pool of resources under the Clouds menu.

## See also

* [Add a Cloud Account to a RightScale Account](/cm/dashboard/settings/account/add_a_cloud_account_to_a_rightscale_account.html)
