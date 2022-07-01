---
title: Users
---

The user management tabs in Cloud Management are moved to the new Governance application located in the RightScale product dropdown. See the image below. If you have the role `admin` or `enterprise_manager`, you will see the option to seamlessly navigate to the Governance application for all your identity access management.

![governance_redirect](/img/governance_redirect.png)

!!info*Note:* Groups view is only shown to the users with `enterprise_manager` role.

##What's different?
  * **Scoping:** Instead of being scoped to a RightScale account, the user management interface is scoped at the organization level. The interface provides you with a top down view of the active organization and its child accounts.

  * **Role Inheritance:** Roles granted to a user at the organization level will automatically cascade down to all the child accounts with the exception of 2 special roles. <code>enterprise_manager</code> can be granted only at the organization level but it's inherited to all the child accounts. <code>admin</code> role, on the other hand, can only be granted at the account level.

##Inherited Roles
Roles set directly on the user and those inherited from groups form a **union** of roles for the user. The User Roles view includes a visualization of roles inherited by the user from groups the user is a member of. By default the view will show the inheritance sorted by group. You can also sort the inheritance view by roles.

![Inheritance Image](/img/governance_inheritance.png)
