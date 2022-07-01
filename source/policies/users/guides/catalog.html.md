---
title: Managing and using the Policy Catalog
---

## Catalog Overview

The policy Catalog is the container for all policies that policy managers can apply in your organization. The catalog contains all [Flexera pre-built policies](../policy_list.html) as well as any policies [published by your organization](). The Catalog is managed by the [policy publisher](/policies/users/getting_started/policy_roles.html) and is used by the [policy manager](/policies/users/getting_started/policy_roles.html) to apply policies to individual accounts or the organization as a whole.

![policy_catalog.png](/img/policy_catalog.png)

## Browsing the Catalog

After selecting `Catalog` from the left-hand navigation menu, by default you will see all the available policies grouped by type and displayed in "card" view, as shown above. The "Categories" dropdown in the upper-left of the view can be used to filter the policies to only show those from certain categories. To the right, there is a "Published" filter that is only available to policy publishers which allows them to see any policies which have been hidden from the Catalog. To the right of that is a general search box that can be used to filter the cards based on their category or title -- any string typed here has the effect of immediately filtering the view. On the right side you can switch between card view and list view. Card view provides more detail about the policies, while list view shows more policies per page.

### Policy Details

To get more information about a given policy, click the Details button if you are in card view, or click on the policy name if you are in list view.

The policy details panel will open and shows much more information about the selected policy, including publisher information, the full detailed description, and the actual policy template code that drives the behavior of the policy. In the policy code editor, you can use the Download button to download the policy template, the Copy button to copy its contents to your clipboard, and you can change the styling of the code viewer to a light or dark theme.

## Applying policies from the Catalog

To apply a policy from the catalog, you must be a [policy manager](/policies/users/getting_started/policy_roles.html) or [policy designer](/policies/users/getting_started/policy_roles.html). If you are in card view or in the policy detail view, click the "Apply: button. If you are in list view, click the three-dot menu on the right of any policy and select "Apply Policy".

This will open the apply policy dialog, which is described in detail on the [Applying a Policy](apply_policy.html) page.

## Publishing custom policies to the catalog

[Policy publishers](/policies/users/getting_started/policy_roles.html) are able to publish new policies to the Catalog from the Templates page. To do so, navigate to the Templates page and select the account that contains the template that you want to publish using the account selector at the top of the page. Find and select the template that you want to publish and press the `Publish` button in the lower-right hand side of the screen. 

If a custom policy already exists in the Catalog with the same name, you will get a warning asking you to confirm that you want to overwrite the existing policy. If the policy name is unique, it will be published immediately to the Catalog and will be available for policy managers to use.

!!warning*Note:*You are not able to publish a custom policy that has the same name as a [Flexera pre-built policy](/policies/user/policy_list.html), even if that policy has been unpublished. 

## Removing policies from the catalog

[Policy publishers](/policies/users/getting_started/policy_roles.html) can remove the policies available to users by unpublishing and/or deleting them from the Catalog. The process for custom policies and Flexera pre-built policies is slightly different.

### Custom policies

To unpublish a custom policy, first make sure that the published filter in the Catalog view is showing either "Published" items or "All" items. Find the policy that you wish to remove from the Catalog and click the `Unpublish` button. Change the published filter to show "Unpublished" or "All" to see the policy that you just unpublished. If you wish to remove the policy from the list altogether, click the "Delete" button to remove the policy from the Catalog (this can not be undone).

### Flexera pre-built policies

To unpublish a Flexera pre-built policy, first make sure that the published filter in the Catalog view is showing either "Published" items or "All" items. Find the policy that you wish to remove from the Catalog and click the `Unpublish` button. Change the published filter to show "Unpublished" or "All" to see the policy that you just unpublished. 

Note that Flexera pre-built policies can not be deleted, but will continue to show as "Unpublished". If you wish to make the policy available again, find the policy in the unpublished view and click the `Publish` button to make the policy available again.



