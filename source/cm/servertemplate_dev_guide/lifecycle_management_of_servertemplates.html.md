---
title: Lifecycle Management of ServerTemplates
description: This document highlights some of the common procedures that may be required to keep your RightScale ServerTemplate up-to-date throughout its lifecycle.
---

## Overview

Once you have completed the initial development of a custom ServerTemplate and either release it for use in production environments within your own RightScale account or publish a revision of it to the MultiCloud Marketplace (MCM), you may need to regularly maintain the ServerTemplate over time. This document highlights some of the common procedures that may be required to keep your ServerTemplate up-to-date.

## Prerequisites

* 'designer' user role privileges

## Best Practices

* Only use committed ServerTemplates in a production environment.
* Commit a ServerTemplate if you want to preserve a change that was made to the HEAD version of the ServerTemplate.
* Only commit successful changes that have been tested.
* The most recently committed revision of a ServerTemplate should match the HEAD version unless it's currently being modified.
* When committing a HEAD version of a ServerTemplate, be sure to include a detailed commit message that clearly summarizes the changes.
* Committed revisions of ServerTemplates should not include HEAD versions of other RightScale components (e.g. RightScripts or MultiCloud Images).

## Things to Consider

### Will the updated ServerTemplate be a newer revision or a completely different template?

* **Yes** - Do not clone the ServerTemplate so that you can keep the same lineage.
* **No** - Clone the ServerTemplate to create a new ServerTemplate with its own lineage.

![cm-update-servertemplates.png](/img/cm-update-servertemplates.png)

In the diagram above, several ServerTemplate revisions were published. In this example, Rev 3 is a newer revision of a previously published ServerTemplate (Rev 1). Both revisions are of the same ServerTemplate. However, when you clone a component, it creates a completely new object with a different lineage. Therefore, the published Rev 2 version of the cloned ServerTemplate is technically a revision of a completely different ServerTemplate. Yellow/orange ball updates are only displayed when newer revisions of the same ServerTemplate are published and made available.

### Is a newer version available in the MultiCloud Marketplace?

If your custom ServerTemplate is based on another ServerTemplate that you previously imported from the MultiCloud Marketplace you may want to import the newer version (if available) and incorporate some of those updates into your own custom ServerTemplate.

For example, if you started your development with an application ServerTemplate published by RightScale and several months later RightScale releases an updated version of that ServerTemplate that includes a few bug fixes and security enhancements, you may want to incorporate those changes into your custom version of that ServerTemplate. In such cases, you may want to import the newest revision that was published to the MCM, perform a differential (diff) to identify the changes and perhaps merge those changes into the HEAD version of your cloned ServerTemplate. Of course, it's always recommended that you test the ServerTemplate after you've made changes to it, especially if you're merging changes that might not be compatible.

![cm-merge-servertemplates.png](/img/cm-merge-servertemplates.png)

### Will you publish the updated version to the MultiCloud Marketplace?

* **Yes** - If you are publishing a newer revision of a previously published ServerTemplate, you may want to deprecate previous revisions if you want to prevent new users from being able to import older revisions of the ServerTemplate. If multiple revisions of a ServerTemplate are available for importing from the MCM, they will be listed under the name of the most recently published revision. For example, if a ServerTemplate was first published with the ServerTemplate name "My App (Beta)" [rev 1] and later published with the name "My App" [rev 3] the first revision will be listed under the "My App" ServerTemplate as a previous revision, but the original name ("My App (Beta)") will not be displayed. Consequently, a user might have a difficult time finding an earlier published revision of ServerTemplate by name.
* **No**  - If you want to update servers within your RightScale account to use the new revision, you will need to create an upgrade strategy.

### Should a previously published revision still be available in the MultiCloud Marketplace?

If you previously published a ServerTemplate and now want to replace it with a newer version in the MultiCloud Marketplace, you may want to deprecate any previously published revisions before you publish the new version.

* **Yes** - No actions are required.
* **No**  - Deprecate any older revisions of the ServerTemplate that were previously published that you do not want new users to be able to see in the MCM and/or import into their own RightScale account. Note: A deprecated revision of a ServerTemplate will not affect RightScale accounts that previously imported that revision. Once a ServerTemplate has been imported from the MCM, it cannot be removed from that account even if that particular revision is later deprecated by the publisher.

### Do you want servers in your RightScale account to use the updated version of the ServerTemplate?

* **Yes** - Create a migration strategy for upgrading those servers.
* **No** - No actions are required.

## Updating RightScale Components in a ServerTemplate

### RightScripts

If a newer revision of a RightScript (of the same lineage) is available, you will see an orange ball icon next to the script name. Notifications are only displayed for RightScripts, not Chef recipes. An orange icon will be displayed for one of two reasons:

* a newer revision of the RightScript is available within the RightScale account
* a newer revision of the RightScript is available in the MultiCloud Marketplace (MCM)

!!info*Note:* Yellow/orange icons will only be displayed if you're viewing an editable HEAD version since you cannot update RightScripts on a committed, static revision of a ServerTemplate.

* Click the orange icon to perform a differential between the two revisions of the script and view the changes. If the newer revision is available in the MCM and is currently not available in the RightScale account, you will have the option to import it from the MCM. (The **Import** button will only be displayed if you have 'library' user role privileges in the RightScale account.)
* If you wish to change a RightScript's revision, click the **Edit** icon next to the script name.

![cm-update-rightscript-revision.png](/img/cm-update-rightscript-revision.png)

You can also update a RightScript revision across multiple ServerTemplates within a RightScale account to perform a global upgrade of a particular RightScript.

* [Update to latest RightScripts in a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#update-to-latest-rightscripts-in-a-servertemplate)
* [Detect Changes in HEAD ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#detect-changes-in-head-servertemplate)
* [Update RightScripts across Multiple ServerTemplates](/cm/dashboard/design/rightscripts/rightscripts_actions.html#update-rightscripts-across-multiple-servertemplates)

### MultiCloud Images (MCIs)

If you are updating a ServerTemplate's MCIs, it's recommended that you test each MCI by launching test servers into each of the supported clouds. If you modify the list of MCIs by either updating the revision of an existing MCI or adding new MCIs to the list, you are responsible for testing and maintaining the ServerTemplate. The publisher of the ServerTemplate is no longer responsible because you are introducing new functionality that was not originally supported when it was published.

If you are developing new ServerTemplates, it's strongly recommended that you use the most recent revisions of MCIs that are available. If you are following best practices and using MCIs published by RightScale, it's recommended that you keep the revisions of the existing MCIs up-to-date if they are of the same compatibility release (e.g. 12H1). For example, if RightScale releases newer revisions of MCIs that your ServerTemplate is currently using, it's recommended that you update your ServerTemplate's MCI list to use the latest revisions, which often include bug fixes, security improvements, and updated cloud support.

* [Update the revision of a MultiCloud Image in a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#update-the-revision-of-a-multicloud-image-in-a-servertemplate)
* [Add a MultiCloud Image to a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#add-a-multicloud-image-to-a-servertemplate)

### Servers

Although it is possible to change the ServerTemplate of a server, it's recommended that you only perform this action in a development or test environment and not in a live production environment.

* [Change the ServerTemplate of a Server](/cm/dashboard/design/server_templates/servertemplates_actions.html#change-the-servertemplate-of-a-server)

### Alerts

As a best practice, alert specifications that are associated with monitored server metrics should be defined at the ServerTemplate level. An alert specification either uses an Alert Escalation or sets a voter tag (for autoscaling purposes).

You can either update existing alert specifications, create new ones, or import them from another source (RightScale's default alerts, ServerTemplate, or server). Any changes to a ServerTemplate's Alerts tab can be identified by performing a ServerTemplate differential. Be sure to review the best practices for adding alert specifications to a ServerTemplate.

* [Create Custom ServerTemplates](/cm/servertemplate_dev_guide/create_custom_servertemplates.html)
* [Differentiate Two ServerTemplates](/cm/dashboard/design/server_templates/servertemplates_actions.html#differentiate-two-servertemplates)
* [Alert Specifications](/cm/rs101/alert_specifications.html)
