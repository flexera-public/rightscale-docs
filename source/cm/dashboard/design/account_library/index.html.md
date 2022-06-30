---
title: Account Library
layout: cm_layout
alias: cm/dashboard/design/account_library.html
description: The Account Library in the RightScale Cloud Management Dashboard stores your RightScale components that have been imported from the MultiCloud Marketplace.
---

## Overview

RightScale components that have been imported from the MultiCloud Marketplace are shown in the Your Imports page (Design > Account Library > Your Imports). For each component (ServerTemplate, RightScript, and MultiCloud Images) the *Total imports* and whether or not there are *Updates available* is displayed on the Overview tab. Select the component tab or associated hyperlink to see detailed information about previously imported components. In order to view this section you must have 'designer' user role privileges.

The following information is displayed for a selected component:

* **Name**
* **Publisher**
* **Imported At**
* **Revision**
* **Revision Notes**
* **Update Available**
* **Update Revision Notes** (not displayed by default)
* **Xref** - Shows the number of Servers and/or Server Arrays. If there are any, the entry is a hyperlink to the Design > ServerTemplates > Xref tab (which shows Server and Server Array information)
* **Actions** - If updates are available, you can click the **Import** or **Diff** action links to either import the newer version or get a full description of the differences between your current version and the upgraded version.

You can filter the results either by the Name or Publisher. Checking the 'show imports with updates' will display only the RightScale components that have updates available. Available updates are indicated with a yellow sphere. Hover over the yellow sphere for a summary of update information, including the Revision Notes.

Visit the [Account Library - Actions and Procedures](/cm/dashboard/design/account_library/account_library_actions.html) page for step-by-step instructions for common Account Library tasks.

## ServerTemplates, RightScripts, and MultiCloud Images

These three RightScale components are treated precisely the same. The same look, feel and functionality from the UI exists for each component. A typical page looks like the following. (*Note*: The Xref tab for ServerTemplates reveals Servers and Arrays. The Xref tab for RightScripts and MCIs lists ServerTemplates.)

 ![cm-your-imports-st-example.png](/img/cm-your-imports-st-example.png)

Notice the following salient points:

* A ServerTemplate is shown (but RightScripts and MCIs look and behave the same)
* There is ONE line item per local or imported component. Only the latest revision is displayed.
* Only components that have updates available are shown (because the "Show imports with updates" checkbox that is selected)
* Click the **Diff** action link to see the differences between your current version and the latest version you can upgrade to
* Click the **Import** action link to import the newer revision
* Hover over the yellow sphere to get additional upgrade notes. (Revision, Revision Notes and when it was published.)

### Other Scenarios

By far the most prevalent scenario is shown above. You have imported a component, and at some point that component was updated by the original publisher, and hence Your Imports reports on what components can be upgraded. There are a few scenarios or *edge cases* you should be familiar with however.

**Once published (not) always published** - It could be the case that an available upgrade, as indicated by a yellow sphere, disappears. What likely transpired were steps similar to the following:

* You import a component from the public MultiCloud Marketplace
* You use it for a day, a week, a month or some period of time
* A newer revision is published. You notice the yellow sphere.
* Prior to you importing the upgraded revision, the yellow sphere disappears.
* The publisher realizes they meant to publish privately (to an Account Group) instead of publicly. They effectively retracted the publication before you imported the newer revision. (This is likely a fairly rare scenario, but would explain the mystery of the disappearing yellow ball.)

!!info*Note:* Once you have imported something from the MultiCloud Marketplace, it cannot be taken back from you. In other words, even in this scenario, you could still use the originally published revision of the component.

## Additional Dashboard Locations for Upgrades

The upgrade functionality as indicated by the yellow sphere works elsewhere in the Dashboard as well. For example, consider the following:

* Navigate to a HEAD revision of a ServerTemplate (Design > ServerTemplates)
* Select the ServerTemplate
* Select either the Images or Scripts tab
  * If there is a newer revision of either the MCIs or RightScripts, you will see the yellow sphere indicating that upgrades are available. For example, a RightScript with upgrades will look like:

![cm-your-imports-scripts-tab-example.png](/img/cm-your-imports-scripts-tab-example.png)

* If you hover over the yellow sphere, you will see a message similar to the following:

`Revision 3 is now available in the MultiCloud Marketplace; click to display diff.`

One last subtle point: Published revisions in the MultiCloud Marketplace take precedence in the upgrade messaging. For example, consider the following scenario:

1. You import 'revision 1' of a RightScale component.
2. You clone, modify and publish a newer 'revision 2'. You share this privately with others in an Account Group.
3. Others use 'revision 2' for some time. In the mean time, you publish a newer 'revision 3' and share it privately as well.
4. Others will see the yellow sphere indicating upgrades are available. Hovering over the sphere will indicate the updates are local, *not* in the MultiCloud Marketplace.
5. Lastly, the original publisher of the component publishes a newer revision.
  * You will still have a yellow sphere indicator
  * Hovering over the sphere will comment that the *public marketplace* has upgrades available (not the local share). Both are tracked, and can even be edited, but the messaging gives precedence to upgrades in the public marketplace.

## Managing Your End User License Agreements (EULAs)

You can create, manage, and attach End User License Agreements (EULAs) to ServerTemplates when you publish them. There are three parts to End User License Agreements in the RightScale Dashboard that you should be familiar with:

1. **Managing EULAs** - Create new EULAs, new revisions, view, archive/unarchive, etc. (Design -> Account Library -> Your EULAs)
2. **Publications** - Attach EULAs to ServerTemplates \* as part of the publishing process, or view EULAs attached to published ServerTemplates (Design -> Account Library -> Your Publications)
3. **Accepting EULAs** - When end users import ServerTemplates that have EULAs attached to them, they must accept/reject the EULA

### EULA Rules Summary

There are several rules to be aware of when working with EULAs in the RightScale Dashboard. Such as:

* 0, 1 or more EULAs can be attached to a published component (ServerTemplate)
* EULAs are attached as part of the publishing process. You cannot attach EULAs to previously published ServerTemplates. (You can however publish a new revision of the ServerTemplate with the desired EULA.)
* Saved EULAS cannot be deleted, but they can be archived.
* EULAs *cannot* be attached to Head revisions (of ServerTemplates).
* EULAs themselves do not have a Head revision (the most current revision is effectively a Head revision)
* Archive/unarchive applies to *all revisions* of the EULA. (For example, if the latest revision is 3, then a archive/unarchive applies to Revision 3, 2 and 1, not just Revision 3.)
* New EULA revisions do *not* effect their corresponding older revisions that were previously attached to a published component (e.g. ServerTemplate)
* Currently, there is no way for an end-user to view what EULAs they have accepted in the past.

## Further Reading

* [Account Library - Actions and Procedures](/cm/dashboard/design/account_library/account_library_actions.html)
* [About the MultiCloud Marketplace](/cm/dashboard/design/multicloud_marketplace/multicloud_marketplace.html)
* [MultiCloud Marketplace](http://www.rightscale.com/library/server_templates)
