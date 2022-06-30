---
title: Repositories
layout: cm_layout
alias: cm/dashboard/design/repositories/repositories.html
description: In the RightScale Cloud Management Dashboard, Repositories show you a list of git repositories, subversion repositories, and compressed files connected to RightScale.
---

## Overview

Repositories show you a list of git repositories, subversion repositories, and compressed files connected to RightScale. This section shows you the repository information from the last time RightScale performed a scrape of your repositories. It shows the repository names, the URL of the repository, the tag or branches of the repository, the number of cookbooks fetched by RightScale, and the last time the repository was fetched. You can perform a refresh on this page or **Add a Repository**. When you click on a repository, you are taken to additional detail of that repository and can perform he following actions:

* **Edit** - You can modify any of the fields that were available when creating the repository.
* **Refetch** - Initiate a new scrape of the repository to update the contents from the source.
* **Refetch and Import** - Initiate a new scrape where all content in the repository is automatically imported into RightScale in the primary namespace. For more information about namespaces, see the Primary and Alternate Namespaces section below.

Visit the [Repositories - Actions and Procedures](/cm/dashboard/design/repositories/repositories_actions.html) page for step-by-step instructions on common repository-related tasks.

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

![cm-primary-and-alternate-name-spaces-diagram.png](/img/cm-primary-and-alternate-name-spaces-diagram.png)

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
* **Cannot be changed unless the cookbook is being followed**. A subsequent import of the cookbook into the alternate namespace will create a new cookbook in your account with the new content.
* **Cannot be frozen**. A subsequent import of the cookbook into the alternate namespace will create a new cookbook in your account with the new content.

#### When Else to Use the Alternate Namespace

There are use cases in which the alternate namespace can be extremely useful. You may find that the development workflows in your organization require multiple developers to modify cookbooks without affecting others. For example, if you use Cookbook A and Cookbook B in your ServerTemplates, a developer may need to modify Cookbook A without affecting others. In this case, the developer could import Cookbook A into the alternate namespace, modify his/her ServerTemplate to use this cookbook, and then make any modifications and perform testing without impacting the "production" cookbook in the primary namespace. Once the changes are complete, the developer can bump the version if needed and then re-import the cookbook into the primary namespace making it available to all other users.

## Further Reading

* [Cookbooks](/cm/dashboard/design/cookbooks/cookbooks.html)
* [Chef Developer Workflows](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/04-Developer/04-Development_Workflows/02-Chef_Developer_Workflows/index.html)
* [Chef Developer Guide](https://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/index.html)
* [ServerTemplate Developer Guide](/cm/servertemplate_dev_guide/)
