---
title: Version Control (Diff and Merge)
layout: cm_layout
description: RightScale supports the ability to perform a common "diff" or differential between two different revisions of the same object, as well as the ability to merge those differences together.
---

## Overview

RightScale supports the ability to perform a common "diff" or differential between two different revisions of the same object, as well as the ability to merge those differences together. The Diff/Merge feature functions in a similar way for all objects that support this feature. Currently, the Diff/Merge functionality is supported for the following RightScale objects:

* ServerTemplates
* RightScripts
* MultiCloud Images

## Performing a Diff

The best way to review all of the changes to an object is to simply perform a diff between two different revisions of that object. Typically, you perform a diff between two different revisions (or HEAD versions) of the same object. However, you can also perform a diff between two separate objects. Colored highlights help you visually decipher what has been added/modified/deleted.

## Performing a Merge

You can perform both basic and advanced merges in the RightScale Dashboard. As a best practice, you should always perform a diff before attempting a merge. You should also commit the latest HEAD version before attempting any merge so that you can always revert back to an object's configuration prior to the merge. Remember, you cannot undo a merge. When you perform a merge, the resulting object must be a HEAD version. Also, you cannot select which parts of a merge you would like to accept and which parts you want to exclude. The merging feature is an "all-or-nothing" change.

![cm-diffmerge-basic.png](/img/cm-diffmerge-basic.png)

![cm-diffmerge-adv.png](/img/cm-diffmerge-adv.png)

### Resolving Conflicts

Sometimes when you perform a merge you will be asked to resolve some conflicts. For example, if you're merging two MultiCloud Images, one revision might specify a 64-bit image for launching 'm1.large' EC2 instance types whereas the other revision uses a 32-bit image for launching 'm1.small' instance types. In such cases, you must select which preference to keep in the merged version.

## See also

- [Diff and Merging RightScripts](/cm/dashboard/design/rightscripts/rightscripts_actions.html#diff-rightscripts)
- [Differentiate Two ServerTemplates](/cm/dashboard/design/server_templates/servertemplates_actions.html#differentiate-two-servertemplates)
