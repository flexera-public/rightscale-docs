---
title: Legacy vs New Permissions in Self-Service
description: Identifies the differences between and reasoning behind the Legacy and New permissions models in RightScale Self-Service. 
---

## Introduction

As of June 24, 2015, a new permission model has been put in place for Self-Service. For a detailed discussion of the changes and benefits, see [CloudApp Permissions](../guides/ss_permissions.html).

In short, existing CloudApps will continue to work as-is with no changes required. In order to get the benefits of the new delegated permissions model, CloudApps will have to be updated.

## Updating Legacy CloudApps

Any CloudApp uploaded to Self-Service and published to the Catalog prior to June 24 will not contain "delegation" capabilities. For your convenience, you can locate these CloudApps by navigating to the Catalog and selecting "card view". The cards will show a "Legacy permissions" indicator to Designers and Admins only so that you can re-upload and re-publish the CloudApp.

  ![Legacy Permissions Indicator](/img/ss-legacy-permissions-indicator.png)

In order to get the benefit of delegated permissions, CATs must be **re-uploaded to Self-Service** and **re-published to the Catalog**. Note that if the CAT contains RCL code that interacts with other resources, you may also need to add [permissions declarations](../reference/ss_CAT_file_language.html#permissions) in order to capture all of the required permissions.  
