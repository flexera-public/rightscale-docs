---
title: Policy Roles and Access Controls
---

## Policy Roles Overview

### User Roles

Flexera provides many different roles for access control to the features in policies that should align well to the users in your organization:
* **Policy Manager** (`policy_manager`) - This is one of the primary users of policy manager - a user who has control over which policies are applied to the scopes they have access to and how those policies behave. In many DevOps organization, many of the users in a team will be given this role in the accounts or projects that the team uses.
* **Policy Approver** (`policy_approver`) - This user has the authority to approve remediation actions for policy incidents, but doesn't actually configure the policies themselves. In some teams there may be fewer policy managers that are configuring the policies, but more policy approvers who confirm that the proposed actions are valid in the given scope.
* **Policy Designer** (`policy_designer`) - This user actually develops custom policies (or customizes pre-built policies) by writing [Policy Template code](/policies/developers). This user has the ability to design and develop their own templates and test them in the accounts they have access to. Once a template is deemed ready for the organization to use, this user works with the policy publisher to make the policy available in the Catalog.
* **Policy Publisher** (`policy_publisher`) - This user has the ability to modify which policies are available in the Catalog, either by publishing policies built by policy designers, or by hiding policies that are pre-built from Flexera. This user role is only available at the organization level since the Catalog exists at that level.
* **Policy Viewer** (`policy_viewer`) - This user is able to see all of the information about applied policies and related incidents, but has no ability to change anything in the system. This user can not apply, configure, or terminate policies, nor can they approve or deny incident actions.
* **Admin** (`admin`) - This user has the ability to administer cloud accounts and access to external APIs. This user can add and edit credentials for use by the policy manager and designer roles.

### Access Levels

For all policy roles except `policy_publisher`, the role can be granted to a user or group at either the organization or the account level. When a role is granted at the organization level, it effectively grants that role to every account that exists now and in the future in the organization. Another effect of organization-level roles is that those users will be able to use the `Organization Summary` view on many policy pages, which rolls up all information about policies and incidents into a single overview. For users with account-level access, they will only be able to see content on an account-by-account basis.

## Granting Policy Roles

Role based access control is centrally managed by our [Governance](https://governance.rightscale.com) module. You can grant any roles to the desired user or group from that page. You will need `enterprise_manager` or `admin` roles to access Governance.

![governance_policy_roles.png](/img/governance-policy-roles.png)

!!info*Note:* Users with `enterprise_manager` role can access all policy functions. Users with `admin` role have no implicit policy access.

## Detailed Feature to Role Mapping

RightScale policy management comes with granular access control to provide more flexibility based on the user type. You can grant users these roles using [Governance](https://governance.rightscale.com).

The following table describes which roles are needed to use the various features of policy manager.

Page | Features | Roles that can use the feature
-------- | -------- | -----------
Catalog | View Catalog | `policy_publisher`, `policy_designer`, `policy_manager`
 | Publish a Policy Template | `policy_publisher`
 | Un-publish a Policy Template | `policy_publisher`
 | Delete custom Policy Template | `policy_publisher`
 | Apply a Policy | `policy_manager`, `policy_designer`
Dashboard | View Dashboard | `policy_designer`, `policy_manager`, `policy_viewer`
 | Organizational Summary | Organization roles: `enterprise_manager`, `policy_designer`, `policy_manager`, `policy_viewer`
Applied Policies | View Applied Policies | `policy_designer`, `policy_manager`, `policy_viewer`
 | Update a policy | `policy_designer`, `policy_manager`
 | Terminate a policy | `policy_designer`, `policy_manager`
 | Apply a similar policy | `policy_designer`, `policy_manager`
Incidents | View Incidents | `policy_designer`, `policy_manager`, `policy_viewer`
 | Approve or Deny an Action | `policy_approver`
Templates | View Templates | `policy_publisher`, `policy_designer`
 | Upload a custom policy | `policy_designer`
 | Apply a policy | `policy_designer`
 | Delete a custom policy template | `policy_designer`
 | Publish a Policy Template | `policy_publisher`
Credentials | Create/Edit/Delete Credentials | `admin`
 | List/Use Credentials | `policy_designer`, `policy_manager`

## Policy-specific Permissions

The policy roles described above grant users access to the policy manager product and its features, but policies themselves have the ability to interact with any API which, in many cases, require permissions on that target API. The user that **applies** the policy must have the underlying privileges to access the resources needed by the policy. Each policy provided by Flexera documents its required permissions.
