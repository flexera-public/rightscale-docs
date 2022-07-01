---
title: Enable Mandatory Server Login Control
layout: cm_layout
description: Steps for enabling a RightScale account to have its users manage their own SSH key pairs.
---
## Objective

To enable an account to have its users manage their own key pairs.

## Prerequisites

* 'server_login' and 'server_superuser' if you are running RightImage 5.7 and lower (both roles will need to be enabled to be able to SSH into a server). If you are running 5.8 or newer, like with 5.7 and lower, you can have both roles enabled or you can have either 'server_login' (which allows you to login as the user of the account without root access) and 'server_superuser' (which allows you to login as root to the server). For more information, see [RightScale Account and User Management](/cm/rs101/rightScale_account_and_user_role_management.html).
* An understanding of [Server Login Control](/cm/rs101/server_login_control.html).

## Overview

The Server Login Control feature allows you to use a private SSH Key Pair instead of using your cloud SSH keys for shell access. SSH Key Pairs are unique for each user and are used across all RightScale accounts. By default, RightScale manages a user's public and private keys. But if you would like all users in an account to manage their own key pair for security reasons, it is possible to make this a requirement before a user can SSH into a server. To enable this feature, follow the steps below.

## Steps

* Go to **Settings** > **Account**  **Settings** > **SSH**.
* Next to **Mandatory Server Login Control** , click 'enable'

![cm-ssh-access-management.png](/img/cm-ssh-access-management.png)

!!info*Note:* This only applies to Linux servers managed with RightLink.

## Next Steps

Once an account has mandated that every user manages their own SSH Key Pair, the user will need to set up their account with their own public and private key. For instructions on how to do this, see [Manage Your Own SSH Key Pair](/cm/dashboard/settings/user/user.html).

## See also

* [Server Login Control](/cm/rs101/server_login_control.html)
* [What is Server Login Control](/cm/rs101/server_login_control.html#what-is-server-login-control-)
* [Manage Your Own SSH Key Pair](/cm/dashboard/settings/user/user.html)
