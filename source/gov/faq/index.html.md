---
title: FAQ
---

## What is an organization?

Organization is an evolution of RightScale enterprises. Governance is scoped to a single organization, which may contain one or more accounts. Roles assigned at the organization level are inherited by all child accounts. 

## Who can access to Governance?

Governance is only accessible to users with `enterprise_manager` or `admin` roles. Each role gives the user specific set of access. For instance, users with `enterprise_manager` role can see all 3 pages on the left navigration bar: Users, Groups and Accounts. Whereas, users with `admin` can only see Accounts.

## How does this affect Cloud Management?

**Users** tab in Cloud Management, which used to manage a user permission, is moved to the Governance. Product selector dropdown will show you Governance if you have `admin` or `enterprise_manager` role in the current account, you are looking at.

## How does this affect Optima?

Product selector dropdown will show you Governance if you have `admin` or `enterprise_manager` role in the any of the accounts.

## How does this affect Self-Service?

We have introduced new dedicated Self-Service roles to give you more flexibilitu. You no longer have to grant Cloud Management roles like `actor` to give a user Self-Service access. Learn more on [Inviting Self Service Users](/ss/getting_started/ss_user_types.html#inviting-self-service-users). Product selector dropdown will show you Governance if you have `admin` or `enterprise_manager` role in the current account, you are looking at.

## Can I invite a new user from Governance?

At the moment, you can invite new users to your organization from the existing Invite flow in Cloud Management. We will bring this functionality directly in Governance soon. Learn more about the detailed [invitation process](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html).

## What is a Role? 

Role (e.g.: actor, ss_end_user etc) is nothing but a collection of "privileges" (e.g.: Access to SS designer, Cloud Management deployment etc). Learn more on [Roles](/cm/ref/user_roles.html). In addition, we are introducing the concept of [Role Inheritance](/gov/#capabilities-role-inheritance) to make permissions management seamless.

## How do I remove or delete a user from RightScale?

Follow the instructions to [Remove users from RightScale](/gov/getting_started/gov_remove_all_roles.html)

## Can Enterprise Managers or Admins manage other Enterprise Managers or Admins?

Yes, however every organization must have at least 1 Enterprise Manager.

## What are the changes in the API?

We have added support for granting new Self-Service roles via existing API 1.5. Learn more at [Inviting Self Service Users via API ](/ss/getting_started/ss_user_types.html#inviting-self-service-users).

## Where are the Audit Entries?

All Audit Entries are located under the **Reports** section of Cloud Management. 

## How do I change my Organization name?

Follow the instructions to [Update Organization name](/cm/dashboard/settings/enterprise/#actions-and-procedures-update-organization-name)

## Can I download a detailed user role report for security audit?

Yes, just click the **Export CSV** button on the Users page for organization wide report or Accounts page for account level report. Check out the [Reporting](/gov/#capabilities-reporting) capabilities of Governance. 

## Can I synchronize groups from my directory service?

Yes. Currently support for synchronizing groups from a directory service is provided via the [LDAP Group Sync](/gov/reference/gov_ldap_group_sync.html) tool.