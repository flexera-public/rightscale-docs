---
title: Remove users from RightScale
description: Steps to safely remove or delete users from a RightScale organization or account
tags: remove delete user users
---
## Overview

You can remove or delete a user, including all the roles, from a RightScale account and/or an organization via [Governance](https://governance.rightscale.com).

!!info*Note:* Resources owned by the deleted user will continue to remain in RightScale. 

## Delete a user from a RightScale organization 

Deleting a user from a RightScale organization permanently removes the user from the organization. You must have `enterprise_manager` role to perform this action.

* Go to the [Governance](https://governance.rightscale.com) module and search the *user*.

* Select the user that needs to be deleted. Click on `Remove`

	![gov_select_user_for_removal](/img/gov_select_user_for_removal.png)

* Confirm the action and you are done.

	![gov_delete_user_confirmation](/img/gov_delete_user_confirmation.png)

* Optional: Verify audit entry for the deleted user.

    ![gov_delete_auditentries.png](/img/gov_delete_auditentries.png)

## Delete a user from a RightScale account 

To delete a user from a specific RightScale account, instead of the entire organization, simply remove all roles from the user via [Governance](https://governance.rightscale.com). This user will no longer have access to the account but will still belong to the organization so you can easily re-invite the user. You must have `enterprise_manager` or `admin` role to perform this action.

* Go to the "Accounts" page in the left navigation bar of [Governance](https://governance.rightscale.com) module and find the *account*.

* Search the user and and uncheck all roles from this user. Make sure there are no *inherited roles*.

    ![gov_remove_user_account.png](/img/gov_remove_user_account.png)

* Hit *Save* and you are done.

* Optional: Verify audit entry for the deleted user.

    ![gov_delete_auditentries.png](/img/gov_delete_auditentries.png)