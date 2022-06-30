---
title: What happens when I delete a cloud account from RightScale?
category: general
description: Details of the ramifications of deleting a cloud account from RightScale.
---

## Background Information

You've previously registered a cloud account (e.g. AWS, Azure, GCE, VMware Private Cloud, etc.) with a RightScale account, but now you want to delete (remove) the ability to use those cloud resources from the RightScale Dashboard.   Perhaps you've canceled your cloud account or you have another set of cloud credentials that you wish to use instead. 

If you are an 'admin' user of a RightScale account, you have the ability to delete a cloud account (i.e. remove any association between RightScale and the cloud account). 

* * *

## Answer

### Understanding the Ramifications of Deleting a Cloud Account
Before you actually delete a previously registered cloud account from your RightScale account, it's important to first understand all the ramifications of performing such an action.   When you delete a cloud account (e.g. AWS, Azure, GCE, VMware Private Cloud, etc.), you will permanently lose all metadata that is associated with its cloud resources.  For example, if you've added a nickname, description, or tag to a cloud resource in the Dashboard, that information will be lost forever if the cloud account is deleted (removed) from your RightScale account.  However, the actual cloud resources themselves will not disappear because they exist independently from RightScale.  For example, any operational server instances will continue to run and be serviceable on that cloud infrastructure.  Deleting a cloud account from RightScale does not shutdown any active instances that are already operational.  You will still be responsible for the costs associated with any cloud-related activity.   However, once the cloud account is deleted from your RightScale account, you will no longer be able to revert back or restore any cloud-specific metadata even if you re-register the cloud again with the exact same cloud account credentials.

Similarly, any RightScale-specific objects (e.g. Servers and ServerTemplates) that have been configured to run on that cloud will no longer work properly because the controller object that was created to establish the link between your RightScale account and the cloud account (using your cloud account credentials) will be deleted.

Therefore, even if you re-register a cloud account (that you previously deleted), but use different cloud account credentials, you will not be able to launch those previously defined Servers or use those old ServerTemplates.  You will need to recreate them again.  However, RightScale will rediscover and display in the Dashboard any instances and images based on the new cloud account's credentials, but any previous associations will not exist. Therefore, as best practice, assign only admin role to a few trusted individuals to avoid accidental deletion of your Cloud Account from RightScale.
