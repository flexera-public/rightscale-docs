---
title: Deprecating or Deleting Shared Components
layout: cm_layout
description: Steps for deprecating or deleting Shared Components that are being actively shared in the RightScale Cloud Management Platform.
---
## Objective

To deprecate or delete/remove a shared component that's actively being shared in the MultiCloud Marketplace.

## Prerequisites

* 'publisher' User Role Privileges
* To delete/remove a shared component from an Account Group, you must have private sharing enabled on the RightScale account.

## Overview

Before you deprecate or delete a shared component from the MultiCloud Marketplace, it's important that you understand the difference between the two actions.

If you've shared/published a RightScale component and you later decide that you no longer want to share it, you can either deprecate it or remove it from the Account Group. In both cases, the component will no longer be visible in the MultiCloud Marketplace. (i.e. Users will no longer be able to view it in the MultiCloud Marketplace or import it to their local collection.) However, if you deprecate a component instead of deleting it from an Account Group, it will still be hidden, but the component will remain usable by accounts who previously imported it.

Once you've shared/published a RightScale component, it will always remain in the MultiCloud Marketplace. Users who were able to import it from the MultiCloud Marketplace before you were able to deprecate it or remove it from the account group will still have access to it in their account's local view. It's important to understand that once a component is imported from the MultiCloud Marketplace to a user's local collection, it cannot be removed from his/her account, even if the component is later deprecated or removed from the sharing group. Therefore, the publishing status of a component will continue to say "published" even though it is no longer being actively shared via any account groups.

**Note for RightScale Partners**

It's also important to understand the differences between deleting and deprecating a RightScale component with regards to maintaining accurate reporting information. As a best practice, you should always try and deprecate a component instead of deleting it from the account group in order to preserve its cross-reference and usage information, which is especially useful for Partners who have customers that may be subscribing to their ServerTemplates. If you delete a component from an account group, you will lose valuable reporting information for that component that would otherwise be reflected in the ServerTemplate Usage report (Partners only).

## Steps

### Deprecate a RightScale Component

A published component can be deprecated in two locations in the Dashboard.

1. Your Publications
  * Go to **Design** > **Account Library** > **Your Publications**
  * Select the actively shared component you wish to deprecate
  * Under the Info tab, click the **Deprecate** text link in the "Deprecation Status" row.
2. Component's Info tab
  * Go to **Design** > **<Component>** > **<YourComponent>**
  * Under the Info tab, click the **Deprecate** text link in the "Deprecation Status" row.

!!info*Note:* If you publish a newer revision of the same lineage of a ServerTemplate (rev 3), only the most recently published ServerTemplate will be visible in the MultiCloud Marketplace. However, if you deprecate a published ServerTemplate (e.g. rev 3) and an earlier revision (e.g. rev 2) was previously published (and not deprecated) prior to the publishing of rev 3, rev 2 will automatically become visible in the MultiCloud Marketplace. If you do not want any revisions of a ServerTemplate to be visible in the MultiCloud Marketplace, you will need to deprecate any previously published revisions (that have not been deprecated).

### Delete a RightScale Component

If your account is enabled for private sharing you can remove a shared component from an Account Group.

1. Go to **Design** > **MultiCloud Marketplace** > **Your Publications**
2. Select the component you wish to remove from an Account Group.
3. Under the component's **Account Groups** tab, click the **Edit** button.
4. Click the **remove** text link next to each listed Account Group from which you want to remove the component.

!!info*Note:* Once you've published a component to the MultiCloud Marketplace, you will never be able to delete it from your RightScale account.
