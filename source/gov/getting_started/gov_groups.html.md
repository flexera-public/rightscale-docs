---
title: RightScale Groups
---
RightScale Groups are collections of users and roles associated with one or more RightScale accounts. With groups you can logically organize your users based on job function or other constructs which relate to your business. Only users with <code>enterprise_manager</code> permission can create, edit or delete groups. Users with <code>admin</code> role can only edit roles for the groups. Group name must be unique.

!!info*Note:* Groups view is only shown to the users with `enterprise_manager` role.

##What's new?
  * **Scoping:** Unlike Cloud Management, where the operations are performed within the scope of a RightScale account, Governance is scoped at the organization level. The interface provides you with a top down view of the active organization and its child accounts.

  * **Role Inheritance:** Inheritance is a powerful feature for assigning Roles at the top level, say organization, and then cascading it down to the Group/Account/User level. Roles granted at the organization level will automatically cascade down to all the child accounts with the exception of 2 special roles. <code>enterprise_manager</code> can be granted only at the organization level but it's inherited to all the child accounts. <code>admin</code> role, on the other hand, can only be granted at the account level.

##Users

You can manage users in your groups to map with your organizational hierarchy.

![Group Users Image](/img/gov-group-users.png)

##Roles

You can grant roles to your Groups, at the organization and/or account level, which will be inherited by all users accordingly.

![governance_inheritance.png](/img/governance_inheritance.png)