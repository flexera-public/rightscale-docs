---
title: Test ServerTemplates in Staging
description: Guidelines for properly testing your RightScale ServerTemplate before using it in a production environment or publishing it to the MultiCloud Marketplace.
---

## Overview

It is important to properly test a ServerTemplate before using it in a production environment or publishing it to the MultiCloud Marketplace so that other RightScale accounts will have access to import and use it for their own purposes.

## ServerTemplate Testing Guidelines

### ALL ServerTemplates

Use the suggested guidelines below for properly testing all ServerTemplates.

* Test a ServerTemplate with each of its MCIs to ensure that it can be used in all of the clouds it is intended to support.
* Test the ServerTemplate in a sandbox environment. If possible, it is recommended that you commit the ServerTemplate and share the latest revision with another RightScale account that's used for quality assurance and testing purposes. A common mistake in ServerTemplate development is that account-specific resources are used during development.  Account-specific dependencies are often uncovered when the ServerTemplate is used in a separate RightScale account. For example, perhaps one of the MCIs references a custom image that's not "publicly available" and therefore it cannot be used in another RightScale account. Or perhaps one of the ServerTemplate's inputs is predefined to use a unique credential (Design > Credentials) that's specific to the RightScale account in which it was created. Or an alert specification is designed to call a unique alert escalation that's account-specific. As a result, a user will have problems launching the server because the system cannot find the appropriately named cloud resources or RightScale design objects in his/her account because they are account-specific.
* Test all operational scripts on a running server. Are there any script dependencies? If so, be sure to clearly describe them in a script's description.
* Freeze all OS software repositories to a specific date in order to ensure that new updates are not introduced, which might break current functionality.

### RightScripts

Use the suggested guidelines below to properly test any ServerTemplate that uses RightScripts.

* Test all of the ServerTemplate's boot scripts to make sure that they are reboot safe.
* All referenced RightScripts should be committed revision (not editable HEAD versions).
* Consolidate duplicate/redundant inputs. Are there multiple inputs that are used to pass the same value to a script? For example, you might have one script that has an input (PRIVATE_IP) for passing in the private IP address of the server while another script has a different input (IP_ADDRESS_PRIVATE) for passing the same value. In such cases, it often makes sense to consolidate the similarly named inputs and modify the script(s) so that a single input is used instead of multiple ones. Duplicate inputs often occur when you create a custom ServerTemplate that is designed to be used with other ServerTemplates. For example, perhaps you've created a custom application server that's compatible with the one of the "load balancer" ServerTemplates published by RightScale. In such cases, you should check to make sure that your ServerTemplate's custom scripts use the same input names as the RightScale ServerTemplate to prevent confusion and input redundancy. A good way to check for input redundancy is to create a new deployment that has a server for each ServerTemplate that will get used. Then check the deployment's Inputs tab (which displays a consolidated list of all inputs used by any of the ServerTemplates' scripts) to see if the same value is being used by more than one input.

### Chef Recipes

Use the suggested guidelines below to properly test any ServerTemplate that uses Chef recipes.

* If your ServerTemplate references any Chef recipes under its Scripts tab, you must make sure that the RepoPath object and all of its referenced cookbook repositories are locked down. Each referenced cookbook repository of the RepoPath should be tied to a specific SHA to make it immutable. Similary, the ServerTemplate should reference a committed RepoPath revision to make it immutable. This is the only way to ensure that the code referenced by the ServerTemplate remains unchanged.
* Can the ServerTemplate's cookbook repositories be successfully retrieved?  If the ServerTemplate uses a private software repository, you will need to provide authentication credentials to access the repository. For example, if you are using a private GitHub repository, you will need to specify a valid GitHub SSH key when you configure the ServerTemplate's RepoPath object. If you are sharing the ServerTemplate with a different RightScale account, you can either let them use the same SSH key or create a new one (on GitHub) to grant them a different authentication key.  When generating your SSH Key, please use the -m PEM option with ssh-keygen (for example:  ssh-keygen -m PEM -t rsa -b 4096 -C "your_email@example.com").
* Are the inputs properly displayed in the dashboard? If an expected input is not being displayed under an Inputs tab,  it is probably because the cookbook's metadata is incorrect. Perhaps the input is not properly declared in the cookbook's metadata.
* Make sure all cookbook dependencies are properly defined in a cookbook's metadata.
