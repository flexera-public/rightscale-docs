---
title: Cookbooks - Actions and Procedures
layout: cm_layout
description: Common procedures for working with Cookbooks in the RightScale Cloud Management Dashboard.
---

## Download a Cookbook

Downloading a cookbook allows you to get the contents of a cookbook that had been imported into your account. You can make changes to this on your machine locally and, if you want to bring it into RightScale and use it with a ServerTemplate, you can do so by adding it as a repository.

### Steps

1. Go to **Design** > **Cookbooks**.
2. Select the Cookbook you would like to download.
3. Choose the version.
4. Select **Download**.
  ![cm-download-a-cookbook.png](/img/cm-download-a-cookbook.png)  
5. A .tar file of the cookbook will download. You can unzip this file to view the contents of the cookbook. A cookbook can contain the following folders and files:
  * **attributes** - Attributes are displayed as user-configurable inputs in the RightScale dashboard. Attributes are most commonly used in Chef recipes. In order for attributes to be displayed in the dashboard, they must be properly documented in the Chef metadata (metadata.rb).
  * **definitions** - Definitions allow you to create new Resources by stringing together existing resources.
  * **providers** - A provider consists of the platform-specific code that will be executed on a server based on its underlying system architecture. Whereas a Chef resource describes the desired task (e.g. install a package), it's the related Chef provider that actually provides the underlying code that's executed to accomplish the task. Instead of creating a single bash script that contains each supported option through a long list of If/Else statements, you can create a single Chef recipe that leverages existing Chef resources and providers that accomplish the same task in a more efficient and scalable manner.
  * **recipes** - Recipes are located inside of a Chef cookbook. A recipe is a script written in Chef's domain-specific language (DSL) that will be executed on a running instance. A ServerTemplate consists of scripts that are either RightScripts or Chef recipes. Similar to RightScripts, Chef recipes support variable substitution where inputs (called Chef attributes) allow a user to define values that will be used when the script is executed. A recipe can also contain Chef resources that are located in another cookbook of a referenced repository.
  * **templates** - A template is a file written in a markup language that allows one to dynamically generate a file's final content based on variables or more complex logic. Templates are commonly used to manage configuration files with Chef.
  * MANIFEST
  * **metadata.rb** - Contains a Ruby DSL that's used to build the metadata.json file. The metadata.rb file is a human readable version of the metadata.json file. When you create a new cookbook using knife, a metadata.rb will automatically be created for you.
  * **metadata.json** - The actual meta-data file that's used by RightScale (which acts as the Chef Server) to understand the contents of the cookbook and how its components can be used.

For more information about using Chef in RightScale, see the [Chef Cookbooks Developer Guide](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/index.html).

!!info*Note:* If you made changes to the file on your machine locally, you can upload that file to RightScale so you can add your cookbooks to ServerTemplates.

## View a Cookbook

When you view a cookbook in RightScale, you are seeing the information of a cookbook that has been imported into your account from the Repositories section of RightScale.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook you want to view.
2. Click on the version of the cookbook.
3. Drop-downs will display that contain various information about the cookbook: **Info**, **Recipes**, and **Attributes**.

### Info

The Info section shows information of the cookbook that was defined when the cookbook was fetched from a repository and imported into RightScale.  
![cm-cookbook-info.png](/img/cm-cookbook-info.png)

* **Version** - The cookbook name and version.
* **Namespace** - Cookbooks in your account belongs to either a primary or alternate namespace. In the primary namespace, there can be only one cookbook with the same name and version. In the alternate namespace, cookbooks can share the same name and version if they come from a different source.
* **Summary** - The summary provides a brief overview of the cookbook.
* **Long Description** - This is a more detailed description of the cookbook. If the cookbook contains a README markdown (.md) file, this is where that information will display. If not, this field will be blank.
* **Last Updated** - The date and time at which the cookbook was last updated. This information is based on the last time that RightScale fetched data from the repository.
* **Source** - Indicates the location from which the cookbook was imported.
* **Status** - The status can be one of the following:
  * **Normal** - This is the default status of a cookbook. When a cookbook is imported into your account, this is the status it will have.
  * **Follow** (alternate namespace only) - RightScale periodically scrapes the source repository and updates the cookbook content when it changes in the repository. If a new version of the cookbook appears in the source repository (as defined in the Chef metadata), the new version will be automatically imported into the alternate namespace as well.
  * **Frozen** (primary namespace only) - A frozen cookbook cannot be be re-imported or modified.
  * **Obsolete** - Obsolete cookbooks will only appear in the cookbooks section of RightScale. They will not appear when adding cookbooks to a ServerTemplate or in other indexes or listings.

### Recipes

The Recipes section list all the recipes that are located inside the cookbook. A recipe is a script written in Chef's domain-specific language (DSL) that can be used to run in a ServerTemplate. A ServerTemplate consists of scripts that are either RightScripts or recipes. Similar to RightScripts, recipes support variable substitution where inputs (or attributes) allow a user to define values that will be used when the script is executed. A recipe can also contain resources that are located in other cookbooks.

In this section, you can see the list of recipe names and a summary of the recipes in the cookbook.

![cm-cookbook-recipes.png](/img/cm-cookbook-recipes.png)

### Attributes

The Attributes section lists all the attributes that are located in the cookbook. Attributes display as user-configurable inputs in the RightScale dashboard. Attributes are most commonly used in recipes. In order for attributes to be displayed in the dashboard, they must be properly documented in the Chef metadata (metadata.rb).

In this section, you see the attribute, if it's optional or required when the script runs in the dashboard, what values are set by default, what recipes use the attribute, and a description of the attribute.

![cm-cookbook-attributes.png](/img/cm-cookbook-attributes.png)

## Follow a Cookbook

When a cookbook is being followed, the new or updated versions of that cookbook that appear in the repositories section will automatically get imported. This only applies to cookbooks that have been imported into the alternate namespace from a repository.

!!info*Note:* Repositories are automatically re-scraped roughly once a day.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook follow. Following a cookbook can only apply to cookbooks in the alternate namespace.
2. Select the cookbook version or versions you would like to follow.
3. From the **Actions** drop-down, select Follow.  
  ![cm-follow-cookbooks.png](/img/cm-follow-cookbooks.png)  
4. A confirmation will ask if you want to follow the selected cookbook version or versions. You can only follow cookbooks from an alternate namespace and you can't follow an alternate namespace that is already being followed. Additionally, you can only apply one status at a time to a cookbook. For example, if a cookbook is marked as obsolete, this will change the status to followed.  
  ![cm-convirmation-follow-cookbook.png](/img/cm-convirmation-follow-cookbook.png)
5. Select **OK**.

## Unfollow a Cookbook

When you unfollow a cookbook, you will no longer get new or updated versions of the cookbook automatically imported into your account when a change has been fetched by your repository. Following or unfollowing cookbooks only apply to cookbooks in an alternate namespace.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook you would like to no longer follow. Following a cookbook can only apply to cookbooks in the alternate namespace.
2. Select the cookbook version or versions you would like to follow.
3. From the **Actions** drop-down, select Unfollow.  
  ![cm-unfollow-cookbooks.png](/img/cm-unfollow-cookbooks.png)  
4. A confirmation will ask if you want to unfollow the selected cookbook version or versions. You can only follow cookbooks from an alternate namespace and you can only unfollow an alternate namespace that is being followed.
5. Click **Ok**.

## Freeze a Cookbook

When you freeze a cookbook, the cookbook can't be modified. Any changes to the cookbook must be imported as a new version. You can only freeze a cookbook in the primary namespace. Primary namespace cookbooks are generally brought over from your own repositories.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook you want to freeze. You can only freeze a cookbook in the primary namespace.
2. Select the cookbook version or versions you would like to freeze.
3. From the **Actions** drop-down, select Freeze.  
  ![cm-freeze-a-cookbook.png](/img/cm-freeze-a-cookbook.png)  
4. A confirmation will ask if you want to freeze the selected cookbook or cookbooks. You can only freeze cookbooks in a primary namespace. Additionally, you can only apply one status at a time to a cookbook. For example, if a cookbook is marked as obsolete, this will change the status to frozen.  
  ![cm-confirm-cookbook-freeze.png](/img/cm-confirm-cookbook-freeze.png)  
5. Select **Ok**.

## Unfreeze a Cookbook

When you unfreeze a cookbook, the cookbook can be modified. Any changes changes to the cookbook that gets imported as the same version will replace the cookbook. You can only freeze or unfreeze a cookbook in the primary namespace. Primary namespace cookbooks are generally brought over from your own repositories.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook you want to unfreeze. You can only freeze or unfreeze a cookbook in the primary namespace.
2. Select the cookbook version or versions you would like to unfreeze.
3. From the **Actions** drop-down, select Unfreeze.  
  ![cm-unfreeze-a-cookbook.png](/img/cm-unfreeze-a-cookbook.png)
4. A confirmation will ask if you want to unfreeze the selected cookbook version or versions. You can only unfreeze cookbooks from a primary namespace and you can only unfreeze an primary namespace that is frozen.
5. Click **Ok**.

## Make a Cookbook Obsolete

When a cookbook is marked as obsolete, the cookbook cannot be attached to a ServerTemplate. This does not detach a cookbook if it has already been attached.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook version or versions you want to mark as obsolete.
2. Select the cookbook version or versions you would like to make obsolete.
3. From the **Actions** drop-down, select Make Obsolete.
  ![cm-make-a-cookbook-obsolete.png](/img/cm-make-a-cookbook-obsolete.png)  
4. A confirmation will ask if you want to make the selected cookbook version or versions obsolete. You can only assign one state at a time to a cookbook. So if the cookbook is frozen, and you mark it as obsolte, it will change it to obsolete.
5. Select **OK**.

## Undo an Obsoleted Cookbook

When a cookbook is marked as obsolete, the cookbook cannot be attached to a ServerTemplate. If you would like to make a undo a cookbook that was made obsolete so you can use it in your ServerTemplates, it is possible.

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook version or versions you want to undo as obsolete.
2. Select the cookbook version or versions you would like to undo as obsolete.
3. From the **Actions** drop-down, select Undo Obsolete.
  ![cm-undo-cookbook-obsolete.png](/img/cm-undo-cookbook-obsolete.png)
4. A confirmation will ask if you want to make the selected cookbook version or versions obsolete.
5. Click **Ok**.

## Delete a Cookbook

You can remove any cookbooks that have been imported into your account from the repositories section. When you remove a cookbook, it is deleting it from RightScale, but will not remove it from the repository the cookbook came from. Cookbooks that are Frozen cannot be deleted. Also, cookbooks that are used by Head ServerTemplates cannot be deleted. If a cookbook is in use by a committed revision of a ServerTemplate, deleting the cookbook from your account does not affect the committed ServerTemplate(s).

### Steps

1. Go to **Design** > **Cookbooks** and select the cookbook you would like to remove.
2. Select the cookbook version or versions you would like to remove.
3. From the **Actions** drop-down, select Delete.  
  ![cm-delete-cookbooks.png](/img/cm-delete-cookbooks.png)
4. A confirmation will ask if you want to remove. If a recipe of that cookbook is in use by a ServerTemplate, then you will not be allowed to delete the cookbooks. You will need to remove the recipe attached to the ServerTemplate. Deleting a cookbook does not remove it from the repository it came from.
5. Click **OK** to confirm that you want to delete the cookbook version.
