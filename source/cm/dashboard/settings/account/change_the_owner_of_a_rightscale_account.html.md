---
title: Change the Owner of a RightScale Account
layout: cm_layout
description: Steps for changing the owner of a RightScale account using the RightScale Cloud Management Dashboard.
---
## Objective

To change the owner of a RightScale account.

## Prerequisites

* 'admin' user role privileges
* The RightScale account must be a Paid Edition.

## Overview

The person (identified by their email address) who initially sets up a RightScale account automatically becomes the "owner" of the account. By default, email notifications are only sent to the owner's email address when an instance is launched from the RightScale account (Settings -> Account Settings -> Preferences tab).

Perhaps you want another user to receive those email notifications or maybe you want all members of your team to receive them. Currently, instance available notifications can only be sent to a single email address. So, if you want multiple people to receive those emails, you can use an email distribution to be the owner of the account.

## Steps

1. Set up an email distribution that will relay emails to the appropriate members of your team. (e.g. sysadmin.team@company.com)
2. You can only transfer ownership to another 'admin' user of the RightScale account. So the next step is to send an account invitation to the new email distribution that you just set up. Be sure to grant the user 'admin' user role privileges. See [Invite Users to a RightScale Account](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html).
3. A person with access to the inbox of the new email will need to accept the account invitation or you can click on the provided URL. _Note_: If you are creating a new user, you will be prompted to create a password for Dashboard login purposes.
4. Someone with 'admin' privileges in the RightScale account must log into the Dashboard. Go to **Settings** > **Account Settings** > **Info tab**. Click **Edit**.
5. Use the dropdown menu to select the user who will become the new owner of the account and click **Save**. The user must have 'admin' privileges.

## See also

- [Invite Users to a RightScale Account](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html)
