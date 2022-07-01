---
title: ServerTemplates
layout: cm_layout
alias: cm/dashboard/design/server_templates/servertemplates.html
description: The RightScale ServerTemplate allows you to pre-configure servers by starting from a base image and adding scripts that run during the boot, operational, and shutdown phases.
---

## Overview

**What is a ServerTemplate?**  
ServerTemplates allow you to pre-configure servers by starting from a base image and adding scripts that run during the boot, operational, and shutdown phases. A ServerTemplate is a description of how a new instance will be configured when it is provisioned by your cloud provider.

**View MultiCloud Marketplace**  
In the Cloud Management Dashboard, go to **Design** > **MultiCloud Marketplace** to find a variety of different ServerTemplates that have already been published by RightScale, ISV Partners, and others. For example, you'll find ServerTemplates for building servers that satisfy common server roles such as a PHP FrontEnd, Rails AppServer, MySQL EBS server, etc. Simply find the ones that are relevant for your application and either import or subscribe to them to add copies of them to your 'Local' collection. Use them as-is or clone them to create editable copies that you can customize for your own purposes. Watch our <a nocheck href="https://www.youtube.com/watch?v=ri407EbonvE">ServerTemplates Video</a> for a better understanding of how ServerTemplates can be used to launch servers in the cloud.

**Getting Started with ServerTemplates**  
Download the [Base RightLink 10 ServerTemplate](https://www.rightscale.com/library/server_templates/RightLink-10-6-0-Linux-Base/228959) into your account to get started with ServerTemplates.

## Further Reading

* Visit the [ServerTemplate Concepts](/cm/dashboard/design/server_templates/servertemplates_concepts.html) page for additional information about using SeverTemplates in your cloud deployments.
* The [ServerTemplates Actions and Procedures](/cm/dashboard/design/server_templates/servertemplates_actions.html) page provides step-by-step instructions for common ServerTemplate tasks.
* Browse the [RightScale MultiCloud Marketplace](http://www.rightscale.com/library/server_templates) for currently available ServerTemplates.

## Related FAQs

- [What happened to Chef Cookbook Overrides?](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/02-End_User/04-RightScale_Support_of_Chef/What_happened_to_Chef_Cookbook_Overrides%3F/index.html)
- [How is a non-fingerprinted image associated with an MCI?](/faq/clouds/google/How_is_a_non-fingerprinted_image_associated_with_an_MCI.html)
- [Why isn't my instance type working with this ServerTemplate?](/faq/clouds/google/Why_isnt_my_instance_type_working_with_this_ServerTemplate.html)
