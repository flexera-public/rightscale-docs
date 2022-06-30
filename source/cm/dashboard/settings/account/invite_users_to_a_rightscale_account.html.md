---
title: Invite Users to a RightScale Account
layout: cm_layout
description: To add a user to a RightScale account by sending an account invitation, which either grants temporary or permanent access to the account, as well as defines the granted user role privileges within the account.
---

## Objective

To add a user to a RightScale account by sending an account invitation, which either grants temporary or permanent access to the account, as well as defines the granted user role privileges within the account.

## Prerequisites

* `admin` user role privileges in the RightScale account into which you're going to invite a new user.
* Paid RightScale account - Required to invite users to a RightScale account and grant them non-Admin privileges. Free RightScale accounts can invite other users, but they must be given `admin` user role privileges.

## Overview

Only users with `admin` user role privileges can send RightScale account invitations to other users. In order to invite a user to a RightScale account, you must send the invitation to the email address that the user will use to log into the RightScale Dashboard. Remember, RightScale users are identified by their email address, not by a name or username. If the invited user is new to RightScale and has never logged into the Dashboard before (with that email address), he/she will need to create a user profile inside RightScale.

## Steps

To send a RightScale account invitation, go to **Settings** > **Account Settings**. Under the **Invitations** tab, click the **Invite Users** button.

Notice that there are two types of invitations: permanent and temporary.

![cm_invite_flow_ca_user.png](/img/cm_invite_flow_ca_user.png)

When you invite users, you will need to select which user role privileges they will have within the RightScale account. See [User Roles](/cm/ref/user_roles.html).

!!info*Note:* If you have a free RightScale account, you must grant each invited user `admin` user role privileges.

Click the **Send Invitations** button to send an email invitation to each user. (A copy of the email invitation will also be sent to the owner of the RightScale account.)

The invitation link that users receive in email will expire in six days. If the user does not use the invitation to activate a RighScale account within that period, you must send a new invitation.

### Temporary Invitations

Temporary invitations allow account admins to invite users to their account, but the invited user will be removed after a specified number of days. If the invited user already exists on the account, any additional permissions will be added for the listed number of days. In **Settings** > **Account** > **Users**, there is a row of permanent permissions and a row under it for temporary permissions. If new temporary permissions are added to a user that already has temporary permissions, the new permissions and expiration period will supersede the previous one.

## See also

- [Accept a RightScale Account Invitation](/cm/dashboard/settings/account/accept_a_rightscale_account_invitation.html)
