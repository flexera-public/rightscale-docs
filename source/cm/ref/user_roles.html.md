---
title: User Roles (RBAC)
layout: cm_layout
description: The following Role Based Access Control (RBAC) is a list of RightScale User Roles. Keep in mind that user roles are account-specific.
---

RightScale has an extensive Role Based Access Control (RBAC) to provide complete control over various parts of the platform. To view your own user roles across all of your accounts, go to **Settings** > **User** > **Info**. User Roles are account scoped but some roles can be granted at the Organization level from [Governance](https://governance.rightscale.com) application.

### admin

Administrative control of the RightScale Account. An account can have multiple users with 'admin' privileges. Only 'admins' can send and receive account invitations. Only an 'admin' can add/change public/private cloud infrastructures and credentials, modify user permissions, and accept account group invitations on behalf of a RightScale account. The RightScale account owner (the person who created the account) cannot have admin privileges revoked by another 'admin' user; the account owner will always have 'admin' user role privileges in the account he/she created. However, only an 'admin' user can revoke another user's 'admin' privileges. The 'admin' role is also needed to view and generate Infrastructure Audit Reports, view Customer Usage Reports (if the RightScale account is enabled for this feature), and to set account markups and markdowns in Optima.

!!info*Note:* Admins will also need <b>actor</b> permissions to add/change public/private cloud infrastructures and credentials.

### actor

Ability to manage all cloud related activity. You need 'actor' privileges in order to act on resources and services at the cloud infrastructure level such as launch/terminate servers, create volumes and snapshots, and run scripts on running servers. You will also need this permission to create and manage deployments and server arrays. *Note*: The ability to create security groups and related firewall rules requires the 'security_manager' user role.

### observer

Ability to view the RightScale account. If users do not have at least 'observer' role privileges, they will not be able to log into the Dashboard and view the account in Cloud Management.

### designer

Ability to create RightScale-specific components such as ServerTemplates, RightScripts, MultiCloud Images, Repositories, Credentials, and Alert Escalations. You will need this permission to essentially perform actions underneath the Design menu of the Dashboard. With this permission you can also browse the MultiCloud Marketplace (MCM) (from within the RightScale Dashboard) for ServerTemplates and RightScripts, but you will need the 'library' user role in order to import an object from the MCM. *Note*: You can also view publicly-viewable assets in the MCM using [http://www.rightscale.com/library](http://www.rightscale.com/library/server_templates).

### library

Ability to import objects from the MultiCloud Marketplace into a RightScale account. The ability to view the MultiCloud Marketplace (while logged into the RightScale dashboard) requires the 'designer' role.

### security_manager

Ability to manage network and firewall permissions that are used by instances in the cloud. You will need this permission in order to create security groups and define individual firewall rules within those security groups. You will also need this permission in order to create Virtual Private Clouds (VPCs) and subnets. Only trusted users should be granted this permission. You will also be able to view and generate Infrastructure Audit Reports.

### server_login

Ability to log into running servers. For Linux servers running RightLink10, you can SSH into the instance using your [default](/rl10/reference/rl10_managed_ssh_login.html#login-names-rightscale-generated-default-login-name) or [custom](/rl10/reference/rl10_managed_ssh_login.html#login-names-user-definable-custom-login-name) login name. For Linux servers running RightLink prior to Rightlink10, you are identified by the first part of the email address used to log into the RightScale Dashboard. For Windows servers you can create a Remote Desktop Connection using RDP. Your managed SSH Key is used for authentication purposes. In order to establish a remote connection you must also make sure that the running instance has the appropriate firewall permissions to allow SSH (TCP port 22) and RDP (TCP port 3389) connections. See [What is Server Login Control?](/cm/rs101/server_login_control.html#who-manages-server-login-control-)

### server_superuser

Ability to execute 'sudo' on running servers. (Applies to Linux-based (not Windows) servers only.) Similar to the 'security_manager' role, only trusted users should be granted this permission. _Note_: You will still need 'server_login' privileges in order to start an SSH/RDP session.

### publisher

Ability to create sharing groups and share RightScale objects (ServerTemplates, RightScripts, and Macros) with other users. If you have a RightScale partner account, you can publish RightScale objects so that they appear in the MultiCloud Marketplace.

### credential_viewer

Ability to view the value of a RightScale Credential object.

### enterprise_manager

(Enterprise only) Manages all accounts within a RightScale organization. Send account invitations and grant user role privileges across all accounts in the organization. The organization must have at least one 'enterprise_manager' user. An 'enterprise_manager' can also grant the same privileges to another user. See [Organization](/cm/dashboard/settings/enterprise/index.html).  

**Note** : To enable the 'enterprise_manager' role, someone that is already an 'enterprise_manager' needs to be enable the role from the [Governance](https://governance.rightscale.com) module of RightScale.

### ca_user

The `ca_user` role grants a user access to detailed billing information in the [RightScale Optima](https://analytics.rightscale.com) site. This type of information is especially useful for users who want to keep track of their estimated infrastructure costs in order to stay within the allotted budget. 

### billing_center_admin

The `billing_center_admin` role grants **read-write** access to Billing Centers and all accesses granted by **ca_user** within [RightScale Optima](https://analytics.rightscale.com) for that organization.

### billing_center_viewer

The `billing_center_viewer` role grants **read-only** access along with the ability to create reports and alerts for Billing Centers within [RightScale Optima](https://analytics.rightscale.com) for that organization.

### ss_end_user

The `ss_end_user` role grants a user [End User privileges](/ss/getting_started/ss_user_types.html) in Self-Service so they can view the Catalog along with managing CloudApps (e.g.: Launch, Terminate etc).

### ss_observer

The `ss_observer` role grants a user [Observer privileges](/ss/getting_started/ss_user_types.html) in Self-Service to view the Catalog and running CloudApps, but they can not take any action on them. 

### ss_designer

The `ss_designer` role grants a user [Designer privileges](/ss/getting_started/ss_user_types.html) in Self-Service to view the Design menu to upload and publish CATs, manage Schedules, and interact with the Cloud Workflow Console.

### policy_publisher

The `policy_publisher` role grants user access to the policy automation to publish or un-publish policy templates to the Catalog. Learn more about [Policy Automation Access Control](/policies/#access-control).

### policy_designer

The `policy_designer` role grants user access to the policy automation to design, upload, and test policy templates. Learn more about [Policy Automation Access Control](/policies/#access-control).

### policy_manager

The `policy_manager` role grants user access to the policy automation to apply policy templates and monitor them. Learn more about [Policy Automation Access Control](/policies/#access-control).

### policy_viewer

The `policy_manager` role grants user view-only access to the policy automation to view running policies and incidents. Learn more about [Policy Automation Access Control](/policies/#access-control).

## See also

- [Account Management/User Roles](/cm/rs101/rightScale_account_and_user_role_management.html)
- [User Role Privileges](/cm/ref/user_role_privs.html)
