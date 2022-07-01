---
title: Why am I getting a warning that cookbooks could not be found?
category: general
description: When using Chef cookbooks in your ServerTemplates, you may see a warning that cookbooks could not be found.
---

## Overview

When using Chef cookbooks in your ServerTemplates, you may see a warning that cookbooks could not be found, such as the following two messages highlighted in red in the screenshots below:

* Some cookbooks have missing dependencies
* These cookbooks are missing

**Error when modifying the head version of a cookbook**

![faq-MissingCookbookDependencies.png](/img/faq-MissingCookbookDependencies.png)

**Error when launching a server**

![faq-MissingDependenciesLaunchServer.png](/img/faq-MissingDependenciesLaunchServer.png)

RightScale will only show this warning when designing or launching ServerTemplates on the HEAD revision. We hide the warning on committed revisions. You will get additional warnings when launching, committing, or publishing a ServerTemplate with this condition, though RightScale won't prevent you from taking those actions.

Within the metadata of a Chef cookbook (found in the metadata.rb file), you can specify other cookbooks that this cookbook depends on to run (for more information see the Opscode documentation](https://docs.chef.io/config_rb_metadata.html)). When you attach a cookbook to a ServerTemplate, RightScale uses this metadata and tries to resolve all dependencies by looking for the dependent cookbooks in your account in the primary namespace. If RightScale can't find the dependent cookbooks in the primary namespace, this warning message is displayed.

**Note**: just because a cookbook "depends" on another cookbook doesn't necessarily mean that the dependent cookbook is required for your server to launch successfully. If the cookbook that has the dependency is never used, or its recipes never actually use resources in the dependent cookbook, your server may launch with no errors. RightScale can't parse all the code to make this determination, so we show the warning solely based on the metadata information.

**Note**: any RightScale-published Chef ServerTemplate prior to v13.5 will list some cookbooks as missing (packages, ruby\_enterprise, etc). This is due to RightScale's use of forks of Opscode cookbooks in those ServerTemplates -- all of the dependent cookbooks weren't included because they weren't actually needed even though they were called out (see the **Do nothing** resolution below). To remove the 'packages, ruby\_enterprise' dependency, modify the ServerTemplate and detach the following cookbooks: 'rails\_enterprise, passenger\_apache2'.&nbsp;As of v13.5, all of these cookbooks have been removed from the ServerTemplates.

## Resolution

If you are seeing this message, there are multiple resolution paths to consider:

* **Import the dependent cookbook into the primary namespace** - by importing the dependent cookbook into your primary namespace, RightScale will be able to automatically resolve the dependency. You may have to locate the origin of the cookbook if it is not a cookbook that you have created. To do this, add the repositoy to your account and then import the cookbook from your repository.
* **Select the dependent cookbook from the alternate namespace** - if the cookbook already exists in your account but is in the alternate namespace, you can locate it be clicking on the search icon and selecting the appropriate cookbook.
* **Remove the cookbook(s) that have the dependency** - if you are not actually using the cookbook(s) that call out the particular dependency, you can remove the cookbooks from the ServerTemplate by clicking the close icon next to the name of the cookbook. **Note** : we currently do not have a way of showing you which cookbooks are causing the dependency errors. If that's a feature that would be useful to you, please [let us know on our feedback forum](http://feedback.rightscale.com).
* **Do nothing** - if the dependency isn't really required by the specific resources/recipes that you're using in the ServerTemplate, you can do nothing and RightScale will not prevent you from launching or committing the ServerTemplate (though we will warn you again before completing the action).
