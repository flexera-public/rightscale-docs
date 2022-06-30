---
title: About Governance
alias: gov/about.html
description: Enhanced Identity and Access Management (IAM) via RightScale Governance.
---

## Overview

The RightScale Governance module enables you to manage users, user groups, and roles across RightScale accounts. Roles and accounts are scoped to an **Organization**, allowing greater control across multiple RightScale accounts for performing management actions (like granting user roles).

An Organization is a container for settings, users, and accounts. The name of the organization is shown in Governance in the organization selector, on the top right of the page, including other places in the product, some of which are under development. For existing customers, we have automatically created an organization based on your Organization **master account**.

## Capabilities

### Single pane of glass to IAM

Governance allows you to manage all of the users, accounts, user groups, and access controls across all of your RightScale account in one place. You will no longer see the old permissions page in Cloud Management.

![governance_users_list.png](/img/governance_users_list.png)

### Create and manage User Groups 

Organize users into Groups based on your organizational needs or other criteria and assign specific roles to the Groups, simplifying the management of roles across your accounts.

!!info*Note:* Ensure Group names are unique and do not start with initial spaces.  All printable UTF-8 non-whitespace characters allowed.

![governance_groups_users.png](/img/governance_groups_users.png)

### Role Inheritance

Inheritance is a powerful feature for granting roles to a user across all accounts in a RightScale Organization. Simply grant the necessary role at the Organization level and it will be inherited down to all accounts within it. 

!!info*Note:* All inherited roles are shown explicitly and can only be modified at the level they were assigned. <code>enterprise_manager</code> can only be granted at the organization level whereas role <code>admin</code> can only be granted at the account level.

![governance_inheritance.png](/img/governance_inheritance.png)


### Full Auditability 

All changes to the organization like adding a new user, updating roles, creating new groups, etc are recorded in the master account's *Audit Entries* page (Reports Section of Cloud Management). The audit trail shows what change was made and who made the change.

![governance_audit_entry.png](/img/governance_audit_entry.png) 

### Simplified User Roles

Out of the box roles can be given to Users as well as Groups at the account and organization level, providing detailed controls for which users can do what across your accounts. 

![governance_new_userroles.png](/img/governance_new_userroles.png)

### Reporting

Download a detailed user role report (CSV), broken down by accounts, for better visibility and auditing. Depending on your role, the report will list all users and their roles either at the organization level (`enterprise_manager`) or at the account level (`admin` role). 

**Enterprise Manager's View**

![governance-exportcsv.gif](/img/governance-exportcsv.gif)

**Admin's View**

![governance-exportcsv-accounts.gif](/img/governance-exportcsv-accounts.gif)

## Who can access Governance?

Governance is only accessible to users with `enterprise_managers` and `admin` roles. Each role gives the user specific set of access.

### Enterprise Managers View

Enterprise Managers get the complete view of the organization and can manage users, groups and roles at the organization as well as accounts level.

![governance_managers_view.png](/img/governance_managers_view.png)

### Admin View

Admins only get a view of their account and can manage users, groups and roles at the account level only. 

![governance_admin_view.png](/img/governance_admin_view.png)

## Known Limitations

* [API 1.5](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html) does not support all Governance operations yet, like Groups. This API only allows management of roles granted directly at the Account level, to a User.

* **Affilation:** There may exist some users in your organization user list that do not currently have access to any account in your organization. They exist in this list because at some point in the past they were granted a role or invited to an account. You can remove such users from your organization by just deleting them. 

* There is no change in the invite flow for new users. You can continue to use Cloud Management to invite new permanent as well as temporary users, including the new Self-Service roles (`ss_end_user`,`ss_designer`,`ss_observer`).


<!-- [[Governance Resources

* [Blog: RightScale Governance](http://www.rightscale.com/blog/governance/governance) **UPDATE LINK WHEN PUBLISHED**
* [White Paper: The Ins and Outs of Multicloud IAM](http://www.rightscale.com/iam_whitepaper_uri_goes_here) **UPDATE LINK WHEN PUBLISHED**
]] -->
