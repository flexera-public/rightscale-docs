---
title: Sharing RightScale Components
layout: cm_layout
description: Understand the Sharing features within the RightScale Dashboard and how you can best use them for collaborative development and testing purposes.
---
## Objective

To gain a proper understanding of the Sharing features within the RightScale Dashboard and how you can best use them for collaborative development and testing purposes. You can use Account Groups (previously called Sharing Groups) to share the following RightScale components: ServerTemplates, RightScripts, and MultiCloud Images.

For AWS, you can also share Images and EBS Snapshots, but those are cloud resources and are shared in a different manner. See [Sharing Cloud Resources](/cm/pas/sharing_cloud_resources.html).

This document focuses on sharing RightScale components via Account Groups.

## Overview

One of the best ways to facilitate collaborative work across multiple teams or departments is to use RightScale's sharing features. Account Groups provide a means of sharing commonly used Rightscale components such as ServerTemplates and RightScripts between different RightScale accounts. Any RightScale user (with 'publisher' role privileges) has the ability to create Account Groups and share RightScale components. You can either publicly or privately share your RightScale components.

| Detail | Public Sharing | Private Sharing |
| ------ | -------------- | --------------- |
| Who can share? | All Accounts | Select RightScale Editions (Accounts with enterprise structure) |
| Who can view it in the MultiCloud Marketplace? | All Accounts | All Accounts or Select Accounts |
| Who can import it from the MultiCloud Marketplace? | All Accounts | Select RightScale Editions (Accounts with enterprise structure) |

### Public Sharing

Public sharing allows you to share your custom RightScale components with all other RightScale accounts. Everyone will have access to view and import your components from the RightScale Component MultiCloud Marketplace. Public sharing is supported in any RightScale account, regardless of the plan type. Community publishing helps facilitate development within the RightScale community by providing a way for RightScale users to share their custom ServerTemplates, RightScripts, etc. with each other. To enforce best practices, you can only publish committed revisions of components to the public.

### Private Sharing

Private sharing is performed discretely between RightScale accounts via Account Groups. Only Premium plans and above support private sharing. Whereas public sharing makes a component viewable and importable by all users, private sharing provides a way for you to control who can view and import your shared components. You can privately share both committed revisions and HEAD versions of a component.

!!info*Note:* The ability to share a HEAD version of a component is only supported in Private Sharing using private account groups; HEAD versions cannot be published and shared with the public.

For example, your development team could share their latest ServerTemplates with the quality assurance team for testing purposes. Privately shared components will not be visible to all RightScale users. Remember, RightScale components are not user-specific; they are RightScale account-specific. Therefore, it's important to understand that sharing is performed between RightScale accounts and not individual users. Users will be able to view and use those RightScale components as long as they have the appropriate user role privileges ('designer') in that account. See [User Role Privileges](/cm/ref/user_role_privs.html).

!!warning*Warning!* If you share a HEAD version of a RightScale component, you should understand its implications, namely that you can automatically inherit changes from the publisher. See [Subscribe to a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#subscribe-to-a-servertemplate).

The example below demonstrates private sharing between two different RightScale accounts.

### Key Terms

In order to properly understand the concept of sharing RightScale components, it's important to understand the following terms.

* **Account Group** - A collection of a RightScale account's private RightScale components that can be shared with other RightScale accounts so that users of those accounts can either use them as-is, or clone and edit them for their own purposes.
* **RightScale Component** - You can only share certain types of RightScale components (ServerTemplates, RightScripts, and MultiCloud Images.
* **Account Group Invitations** - An invitation to an Account Group. An invitation can only be used once. You can either accept an invitation directly from the email invitation or enter the membership code directly into the Dashboard. You must be an 'admin' user of a RightScale account in order to accept a sharing group invitation. Once a sharing group invitation is accepted, the RightScale account has access to the Account Group's RightScale components. Any users of the account will be able to import the shared RightScale components from the MultiCloud Marketplace. (Tip: Use the "Shared" link in the Categories section.)
* **RightScale MultiCloud Marketplace** - The MultiCloud Marketplace serves as the virtual store where users can browse through all the published RightScale components and import them into a RightScale account. Only users with 'MultiCloud Marketplace' user role privileges can import or subscribe to a component. You can never unpublish a component; a copy of it will always remain in the MultiCloud Marketplace. You can only change its visibility status (i.e. whether or not the component can be imported). If you've shared a component and later decide that you no longer want it to be visible to new users (so that they can import it) you can deprecate it.

![cm-accept-invitation.png](/img/cm-accept-invitation.png)

* Implicit Sharing - Sharing a ServerTemplate is slightly different than sharing other components because it's a component that references other components. Therefore, if you share a ServerTemplate, it's imperative that any of its referenced private components are also shared/published in order to ensure a ServerTemplate's functionality. As a convenience, when you share a ServerTemplate, any referenced private MultiCloud Image, RepoPaths, or RightScripts are implicitly shared automatically. Otherwise, it would be very difficult for a user to manually publish each private component that is required by the ServerTemplate.
* Explicit Sharing - Although MultiCloud Images and RightScripts are explicitly shared when a related ServerTemplate is published, you can also publish/share these components "explicitly" or by themselves. i.e. RightScripts do not have to be shared in the context of a ServerTemplate.

![cm-explicit-implicit-sharing.png](/img/cm-explicit-implicit-sharing.png)

## Differences between Sharing RightScale Components

### ServerTemplates

By default, when you publish a ServerTemplate to the MultiCloud Marketplace, you are also publishing/sharing all of the template's private RightScripts, MultiCloud Images, and RepoPaths (if available). In order to prevent against piracy, if you share a ServerTemplate that contains paid RightScripts that have been published by RightScale or some other Partner, you must make sure that the RightScale account(s) that you are sharing the template with has access to use those paid scripts, otherwise they will not be able to use the ServerTemplate as-is.

### RightScripts or MultiCloud Images

You can publish RightScripts and MultiCloud Images individually.

## Best Practices

### Use EULAs

To protect the use of your ServerTemplate, you can attach an End User License Agreement (EULA) to it. In order to use a ServerTemplate with an attached EULA, a user must accept the defined terms and conditions.

!!info*Note:* Currently, you can only attach EULAs to ServerTemplates. In the future, you will be able to attach EULAs to other RightScale components as well.

### Share Committed Revisions not HEAD versions

Unless you are working closely with another group that's using a different RightScale account, you should never publish and share a HEAD version of any component because it's not static. As a best practice, you should only publish committed revisions of a component. The ability to publish and share HEAD versions of a component is only supported for private sharing. You can only publicly share committed revisions.

### Better to Deprecate than Remove RightScale Components

Before you deprecate or delete a shared component from the MultiCloud Marketplace, it's important that you understand the difference between the two actions. See [Deprecating or Deleting Shared Components](/cm/pas/deprecating_or_deleting_shared_components.html)

## Tutorials

To learn more about how to share RightScale components via Account Groups, see the [How to Share RightScale Components](/cm/pas/sharing_rightscale_components.html) tutorial.

## Further Reading

- [RightScale Components vs. Cloud Resources](/cm/pas/rightscale_components_vs_cloud_resources.html)
- [Sharing Cloud Resources](/cm/pas/sharing_cloud_resources.html)
- [About the MultiCloud Marketplace](/cm/dashboard/design/multicloud_marketplace/multicloud_marketplace.html)
- [Create a New Account Group](/cm/dashboard/design/account_library/account_library_actions.html#Create_a_New_Account _Group)
- [Deprecating or Deleting Shared Components](/cm/pas/deprecating_or_deleting_shared_components.html)
- [Accept an Invitation to an Account Group](/cm/pas/accept_an_invitation_to_an_account_group.html)
- [How to Share RightScale Components](/cm/pas/how_to_share_rightscale_components.html)
