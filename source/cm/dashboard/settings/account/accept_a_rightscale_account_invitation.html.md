---
title: Accept a RightScale Account Invitation
layout: cm_layout
description: Steps for accepting a RightScale Account Invitation. You can accept an invitation to a RightScale account regardless of whether or not you have your own RightScale account.
---
## Objective

To accept an invitation to access a RightScale account.

## Prerequisites

An invitation to a RightScale account that has not expired. (Invitations expire after six days.)

## Overview

You can only receive a RightScale account invitation from a user with 'admin' user role privileges within that account. However, you can accept an invitation to a RightScale account regardless of whether or not you have your own RightScale account.

## Steps

If you received an invitation to access a RightScale account, you will receive an email invitation from [support@rightscale.com](mailto:support@rightscale.com). If the email is not in your inbox, check your spam folder or perform a keyword search for 'rightscale' in your email.

To accept the account invitation, simply click on the validation link in your email. If you are new to RightScale and have never logged into the Dashboard before, you will be asked to create a user profile and password. You will not be asked to create a username as each RightScale user will be identified by their email address. This process is useful for creating a user account without having to also create a new RightScale account.

Once you are logged into the Dashboard, you are presented with three login options.

![cm-sso-happy-path-invite.png](/img/cm-sso-happy-path-invite.png)

* Choose **Single Sign-On** if you are an existing RightScale user and want to log in using your SAML single sign-on credentials.
* Choose **Password-Based Login** if you are an existing RightScale user and want to log in using the password for your RightScale user profile.
* Choose **Sign Up** if you are a new RightScale user and have not logged into the RightScale dashboard before.

Once you have logged in successfully, you are taken back to the Invitation page where you can click **Accept Invitation**.

![cm-accept-invitation.png](/img/cm-accept-invitation.png)

Once you've accepted the invitation, go to **Settings** > **User**. Under the **Info** tab you will see the user role privileges that you were granted for the current account. To learn more about what you can/cannot do within the RightScale account, go to [User Roles](/cm/ref/user_roles.html).

## See also

- [Invite Users to a RightScale Account](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html)
