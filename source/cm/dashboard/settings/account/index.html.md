---
title: Account Settings
layout: cm_layout
alias: cm/dashboard/settings/account/account.html
description: The RightScale Dashboard will display a summary of your individual RightScale account information including the type of plan, your AWS Credentials, sharing group memberships, users, and user permission rights.
---

## About RightScale Accounts

The RightScale Dashboard will display a summary of your individual RightScale account information including the type of plan, your AWS Credentials, sharing group memberships, users, and user permission rights. Each user (e.g. [johndoe@rightscale.com](mailto:johndoe@rightscale.com)) can have access to multiple accounts (e.g. johndoe, johndoe2). To switch between your accounts use the drop-down menu at the top-right of the Dashboard. Account credentials are used by RightScale to access Amazon Web Services on your behalf. These credentials are also required in order to store data in your Amazon S3 buckets.

A number of tabs are available from the main Account Settings screen as described below.

* **Info** – shows general information about the RightScale account you're currently viewing, including your account type (direct, sub-account, etc.) and the owner (based on the email address that was used to initially create the RightScale account).
* **Plan** – lists your current RightScale plan type and the name of the Master account, if applicable. If you wish to upgrade your plan, please [contact us](mailto:support@rightscale.com).
* **Account Groups** - shows a list of (Account Group) memberships. When an 'admin' user in the current RightScale account accepts an invitation to an Account Group, the account becomes a member of that group and instantly gains access to all of the shared RightScripts, ServerTemplates, MCIs, and Macros within that collection. Shared components are published by other RightScale accounts. Access to the shared components can be changed at any time at the discretion of the publisher. However, once a shared component is imported/subscribed to, it will remain in the RightScale account's local collection even though a publisher may later deprecate it from the Account Group. Components that have been shared with this RightScale account can be found in the appropriate collection of the Library by clicking the "Shared" text link.
* **Preferences** \* – lists the preferences of the RightScale account you are currently viewing. This tab is only visible to users with 'admin' role privileges in the account.
* **Users** \* - lists all of the users that have access to the RightScale account, as well as their associated permissions (roles). Each user will be able to select the account from the dropdown menu in the upper right. A change to a user's roles will take effect immediately. You can either delete a user or edit their permissions. Be sure to choose your users and their permissions wisely since any cloud related activity will use the account's cloud (AWS) credentials. See the Invitations tab to invite additional users to your account.
* **SSH** \* - lets manage the Server Login Control feature which allows you to use a private SSH Key Pair instead of using your cloud SSH keys for shell access. SSH Key Pairs are unique for each user and are used across all RightScale accounts. By default, RightScale manages a user's public and private keys. But if you would like all users in an account to manage their own key pair for security reasons, it is possible to make this a requirement before a user can SSH into a server. This would essentially disable RightScale from managing an SSH Key Pair for users of an account.
* **Invitations** \* – shows any pending Invitations you have sent out. If you have 'admin' role privileges of the RightScale account, you can send account invitations to other users. When you send an email invitation, you must use the same email address that is associated with a user's RightScale account.
* **Clouds** – lists the cloud infrastructures that are currently enabled on the selected RightScale account. You can also enable other public clouds or add a private cloud. You must have 'admin' role privileges in order to create/delete a cloud account. Before you delete a cloud account from RightScale, be sure you understand its ramifications.
* **Administered Clouds** \* - lists the private clouds that have been registered with this RightScale account.
* **Server Defaults** - lists the cloud components that are available for configuring as default settings for servers in your account. These defaults can also be set at the deployment level. When setting defaults at the deployment level, you can inherit account defaults.
* **Access Controls** - lets you specify the range of IP addresses that can login to RightScale or from which users or programs can access RightScale API endpoints. This feature can be used by account administrators to enable access to RightScale through a company's IP address.
* **API Credentials** - displays your OAuth API information and allows you to enable or disable this feature to generate a token or revoke a token.

\* Denotes tabs that are only visible to the account owner.

To learn more about our plans and pricing, please go to [www.rightscale.com](https://www.rightscale.com/products-and-services/products/).

## Common Actions and Procedures

[[ Working with Users in a RightScale Account
* [Invite Users to a RightScale Account](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html)
* [Accept a RightScale Account Invitation](/cm/dashboard/settings/account/accept_a_rightscale_account_invitation.html)
* [Accept an invitation to an Account Group](/cm/pas/accept_an_invitation_to_an_account_group.html)
* [Change the Owner of a RightScale Account](/cm/dashboard/settings/account/change_the_owner_of_a_rightscale_account.html)
* [Remove Users from RightScale](/gov/getting_started/gov_remove_all_roles.html)
]]

[[ Working with Cloud Accounts in RightScale
* [Add a Cloud Account to a RightScale Account](/cm/dashboard/settings/account/add_a_cloud_account_to_a_rightscale_account.html)
* [Delete a Cloud Account from a RightScale Account](/cm/dashboard/settings/account/delete_a_cloud_account_from_a_rightscale_account.html)
* [Delete a Private Cloud Account from RightScale](/cm/dashboard/settings/account/delete_a_private_cloud_account_from_rightscale.html)
* [Register a Private Cloud with RightScale](/cm/dashboard/settings/account/register_a_private_cloud_with_rightscale.html)
* [Deregister a Private Cloud from RightScale](/cm/dashboard/settings/account/deregister_a_private_cloud_from_rightscale.html)
* [Deregister or Delete a Private Cloud from RightScale](/cm/dashboard/settings/account/deregister_or_delete_a_private_cloud_from_rightscale.html)
]]

[[ Miscellaneous
* [Add an IP Whitelist Range](/cm/dashboard/settings/account/add_an_ip_whitelist_range.html)
* [Add QuickMonitoring Graphs](/cm/dashboard/settings/account/add_quickmonitoring_graphs.html)s
* [Enable Mandatory Server Login Control](/cm/dashboard/settings/account/enable_mandatory_server_login_control.html)
* [Enable OAuth](/cm/dashboard/settings/account/enable_oauth.html)
* [Send All Alert Escalations to SNS](/cm/dashboard/settings/account/send_all_alert_escalations_to_sns.html)
* [Upgrade a Free RightScale Account](/cm/dashboard/settings/account/upgrade_a_free_rightscale_account.html)
* [Server Defaults](/cm/rs101/server_defaults.html)
* [Change the RightScale Logo to Your Own Logo](/cm/dashboard/settings/account/set_a_custom_dashboard_logo.html)
]]
