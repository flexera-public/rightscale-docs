---
title: RightScale Account and User Role Management
layout: cm_layout
description: Detailed descriptions of Accounts, Users, and Roles as these terms pertain to the RightScale Cloud Management Platform.
---

The terms 'accounts', 'user', and 'roles' are used throughout the documentation and can cause some confusion. This page contains detailed descriptions of these terms and provides details about their appropriate usage/application.

## Accounts

An account provides a layer of tenancy for various features in the platform. An account contains integrations to clouds and can only contain 1 account from each public cloud provider but any number of private cloud accounts. Accounts can belong to one and only one RightScale organization.

Each user will likely have two types of accounts.

* **RightScale Account** - Create a RightScale Account to log in to the RightScale Dashboard. Registration requires an email and password. To view information about your RightScale Account in the Dashboard, go to **Settings** > **Account**. Click the **Plan** tab to view information about the type of RightScale Plan that is associated with a RightScale Account (Standard, Enterprise, etc.) **Note**: Unless otherwise specified, the word 'account' in the documentation refers to your RightScale Account.

* **Cloud Account** - Before you can use the RightScale Dashboard to manage your server instances in the Cloud, you must first create an account with your cloud provider. You need to enter valid cloud credentials into the Dashboard in order to launch and manage resources in your cloud through the RightScale Dashboard or API. For example, in order to launch EC2 instances, you must have valid AWS Credentials. Each RightScale account can only use a single set of cloud credentials per cloud infrastructure. For example, if you're managing two sets of AWS credentials, you need to create two RightScale accounts to manage both cloud infrastructure accounts.

In the following diagram, there are three separate users. John set up the 'Site1.com' RightScale account and invited Ben (who has his own RightScale account) to be a user of the 'Site1.com' RightScale account. Ben set up his own RightScale account, which he's enabled to manage resources across multiple cloud providers. Greg is new to RightScale and has never set up his own RightScale account, however Ben invited him to be a user of his 'Site2.com' RightScale account.

![cm-account-scenarios.png](/img/cm-account-scenarios.png)

Keep in mind that a RightScale Account is separate from a Cloud Account. You can register multiple cloud accounts with a single RightScale account. However, you will be responsible for paying for all cloud and cloud-related cloud usage costs. If you are a paying customer of RightScale, your cloud usage costs are separate charges from your RightScale Edition subscription fee.

![cm-billing-model.png](/img/cm-billing-model.png)

## User

RightScale users are identified by their email address. Each user can have access to multiple RightScale Accounts. Create your own RightScale Account or accept invitations to be a user of other RightScale Accounts. To view information about your User settings across all of the RightScale account to which you have access to use in the Dashboard, go to **Settings** > **User**. For an exhaustive list of each role and their associated permissions, see [User Role Privileges](/cm/ref/user_role_privs.html).

In the diagram below, John Doe is identified as ['john@mysite.com](mailto:'john@mysite.com)' in the RightScale platform. He currently has access to three RightScale Accounts and has different user role privileges in each of those accounts.

![common-user.png](/img/common-user.png)

Each user is identified and distinguished from other users by his/her email. In the RightScale system, your email address is used as your username or unique identifier. Email addresses are used in audit entries, changelogs, and histories to identify which user performed a particular action(s) within a RightScale Account. Therefore, it's important that login credentials (email/password) are never shared or used by multiple users, otherwise it will be impossible to determine who is responsible for tracking user actions within the Dashboard.

## Managing your RightScale Account

If you are an **Admin** user of a RightScale account, you can use the various user roles to control the permissions of all invited users in order to control their level of access and functionality. Only 'admin' users can send account invitations. If you are an 'admin' user, you must specify a user's roles before sending an account invitation. Later, you can change a user's roles under the **Settings** > **Account Settings** > **Users**.

**Note**: Only an 'admin' user can revoke another user's 'admin' privileges.

It's important that you never share the email/password that you use to log into the RightScale Dashboard. For example, if an account (e.g. 'Site1.com') has multiple users, each user should create their own RightScale account. Later, the 'admin' user of the 'Site1.com' account can invite additional users to that account. This is the only way that you can have user accountability within an account. If you share the same email/password with multiple users, there is no way to determine who launched or terminated a server. It's important that each action can be attributed to a single user.

![cm-user-roles-2.png](/img/cm-user-roles-2.png)

## (User) Roles

To view your own user role privileges across all of your accounts, go to **Settings** > **User** > **Info**. Remember, user roles are account-specific.

For a complete matrix of what you can/cannot do inside the Dashboard based with your user role privileges, see [User Role Privileges](/cm/ref/user_role_privs.html).

The available user roles include:
<br>
<br>
**Cloud Management**
* actor
* observer
* designer
* library
* security_manager
* server_login
* server_superuser
* publisher
* credential_viewer
<br>
<br>
**Optima**
* ca_user
* billing_center_viewer
* billing_center_admin
<br>
<br>
**Governance**
* admin
* enterprise_manager
* policy_publisher
* policy_designer
* policy_manager
* policy_viewer
<br>
<br>
**Self-Service**
* ss_end_user
* ss_observer
* ss_designer

For a detailed description of the permissions associated with each of the roles, see [User Roles](/cm/ref/user_roles.html).

## (Server) Roles

Sometimes the word 'role' refers to a server's role or configuration. For example, when you launch an instance on a cloud infrastructure like Amazon EC2 you are provisioning a "blank" piece of hardware that you can configure to fulfill a specific type of server role. Additionally, you can use different ServerTemplates to configure instances to fulfill certain roles such as dedicated load balancers, application servers, database servers, etc.

![cm-server-roles.png](/img/cm-server-roles.png)

## See also

* [User Role Privileges](/cm/ref/user_role_privs.html)
