---
title: Cookbooks
layout: cm_layout
alias: cm/dashboard/design/cookbooks/cookbooks.html
description: The Cookbooks section of the RightScale Cloud Management Dashboard allows you to see the available cookbooks in your account.
---
## Overview

The Cookbooks section, viewable under **Design** in the RightScale Dashboard, allows you to see the cookbooks in your account. These cookbooks can be imported from ServerTemplates in the Marketplace or directly from Repositories you've configured in your account. In this section, you can import cookbooks, which will take you to the Repositories section, or you can select a cookbook. When you select a cookbook, you see all the version numbers of that cookbook and from where the cookbook originated.  

Visit the [Cookbooks Actions and Procedures](/cm/dashboard/design/cookbooks/cookbooks_actions.html) page for instructions on common Cookbook-related tasks,

## Cookbook States

Once imported to RightScale, cookbooks have a state. A cookbook's state does not govern how the cookbook functions; state determines how and when the cookbook can be updated and in which UI contexts the cookbook can be selected.

Below is a table that displays the various states a cookbook can have.

| State | Effect | Namespace |
| ----- | ------ | --------- |
| normal | This is the default status of a cookbook. When a cookbook is imported into your account, this is the status it will have.  | Primary and Alternate |
| Frozen | This means the cookbook cannot be re-imported or modified. This only applies to cookbooks in the primary namespace. | Primary |
| Followed | This means that RightScale will periodically scrape the source repository and update the cookbook content when it changes in the repository. If a new version of the cookbook appears in the source repository (as defined in the Chef metadata), the new version will be automatically imported into the alternate namespace as well. Only cookbooks in the alternate namespace can be followed. | Alternate |
| Obsolete | A cookbook marked as obsolete means that a cookbook will only appear in the cookbooks section of RightScale. Obsolete cookbooks will not appear when adding cookbooks to a ServerTemplate or in other indexes or listings.<br>**Note** : If a the cookbook has already been added to a ServerTemplate, this does not remove it. | Primary and Alternate |

You can use action buttons after selecting a cookbook to transition between various states:  

![cm-chef-cookbook-state-machine.png](/img/cm-chef-cookbook-state-machine.png)

## Primary and Alternate Namespaces

To improve the sharing of ServerTemplates, RightScale has introduced the primary and alternate namespaces. The primary namespace is similar to Chef Server in that you can only have one instance of a given cookbook version in the primary namespace (e.g. only one instance of "php 1.0.0"). The alternate namespace is primarily used for importing cookbooks from ServerTemplates and allows multiple instances of a given cookbook version (e.g. a "php 1.0.0" cookbook from RightScale and a "php 1.0.0" cookbook from Zend).

There are multiple differences in behavior between cookbooks in each namespace; use of the primary namespace is generally recommended for cookbooks that are being used in ServerTemplate design. When building ServerTemplates, RightScale reads cookbook dependency data from the cookbook metadata and will automatically resolve dependencies using cookbooks in the primary namespace only.

You can perform the following actions depending on which namespace your cookbook belongs to:

* **Normal** - This is the default status of a cookbook. When a cookbook is imported into your account, this is the status it will have.
* **Freeze** - (primary namespace only) - This stops a cookbook from being able to be re-imported or modified. This only applies to cookbooks in the primary namespace.
* **Follow** - (alternate namespace only) - RightScale periodically scrapes the source repository and updates the cookbook content when it changes in the repository. If a new version of the cookbook appears in the source repository (as defined in the Chef metadata), the new version will be automatically imported into the alternate namespace as well.
* **Make Obsolete** - Obsolete cookbooks will only appear in the cookbooks section of RightScale. They will not appear when adding cookbooks to a ServerTemplate or in other indexes and listings.
* **Unfreeze** - This stops a cookbook from being frozen and marks the cookbook as "normal." Normal means no action has been performed on the cookbook.
* **Unfollow** - This stops a cookbook from being followed and marks the cookbook as "normal." Normal means no action has been performed on the cookbook.
* **Undo Obsolete** - This stops a cookbooks from being marked as obsolete and marks the cookbook as "normal." Normal means no action has been performed on the cookbook.

![cm-primary-and-alternate-namespaces-diagram.png](/img/cm-primary-and-alternate-namespaces-diagram.png)

### Primary Namespaces

If you are using your own cookbooks to build ServerTemplates -- that is, you are pulling in cookbooks from an external repository -- you should be using the primary namespace. The primary namespace is similar to Chef Server in that you can only have one instance of a given cookbook version in the primary namespace (e.g. only one instance of "php 1.0.0").

Cookbooks in the primary namespace:

* **Can be replaced or edited**. A cookbook is replaced by importing a new cookbook version to overwrite the old version, which replaces its entire contents. When you select a cookbook, you are able to use any version of a cookbook imported into your account.
* **Can be frozen, preventing them from being replaced or edited**. Note that frozen cookbooks can be unfrozen, so they are not entirely immutable on Head ServerTemplates.
* **Cannot be followed**. The reason that cookbooks in the primary namespace cannot be followed is due to the limitation of having a single instance of a given cookbook-version. If following was permitted, the case could exist where the same cookbook-version was "flip-flopping" content due to being followed from multiple source repositories.

### Alternate Namespaces

Cookbooks that have been brought into your account by importing a ServerTemplate from the Marketplace are placed in the alternate namespace to ensure that conflict with other existing cookbooks is avoided.

Cookbooks in the alternate namespace:

* **Can be followed**. Changes made to the cookbook are automatically tracked in the corresponding repository whenever it is scraped.
* **Cannot be changed unless the cookbook is being followed**. - A subsequent import of the cookbook into the alternate namespace will create a new cookbook in your account with the new content.
* **Cannot be frozen**. - A subsequent import of the cookbook into the alternate namespace will create a new cookbook in your account with the new content.

#### When Else to Use the Alternate Namespace

There are use cases in which the alternate namespace can be extremely useful. You may find that the development workflows in your organization require multiple developers to modify cookbooks without affecting others. For example, if you use Cookbook A and Cookbook B in your ServerTemplates, a developer may need to modify Cookbook A without affecting others. In this case, the developer could import Cookbook A into the alternate namespace, modify his/her ServerTemplate to use this cookbook, and then make any modifications and perform testing without impacting the "production" cookbook in the primary namespace. Once the changes are complete, the developer can bump the version if needed and then re-import the cookbook into the primary namespace making it available to all other users.

## Further Reading

* [Repositories](/cm/dashboard/design/repositories/repositories.html)
* [ServerTemplate Developer Guide](/cm/servertemplate_dev_guide/)

## Related FAQs

* [How do I prevent my chef recipes from running during a reboot?](/faq/How_do_I_prevent_my_chef_recipes_from_running_during_a_reboot.html)
* [Why am I getting a warning that cookbooks could not be found?](/faq/Why_am_I_getting_a_warning_that_cookbooks_could_not_be_found.html)
