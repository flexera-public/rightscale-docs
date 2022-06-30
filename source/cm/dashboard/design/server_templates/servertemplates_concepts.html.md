---
title: ServerTemplate Concepts
layout: cm_layout
description: The RightScale ServerTemplates allow you to pre-configure servers by starting from a base image and adding scripts that run during the boot, operational, and shutdown phases of a server instance.
---

## Introduction

ServerTemplates<sup>TM</sup> allow you to pre-configure servers by starting from a base image and adding scripts that run during the boot, operational, and shutdown phases of a server instance.

**ServerTemplates** are one of the key concepts of the RightScale Dashboard. To help you get up and running faster, RightScale regularly publishes ServerTemplates for commonly used web applications (Design > MultiCloud Marketplace) that are already configured with the appropriate RightScripts. You can also import or subscribe to ServerTemplates that have been published by ISV Partners or others in the RightScale community. Although you can use a ServerTemplate as-is to launch a server, you must clone it in order to create a private, editable copy that you can customize for your own application. ServerTemplates that you've created yourself or cloned will appear under the 'Local' view.

!!info*Note:* RightScale only supports our own published ServerTemplates. It is the responsibility of the publisher to provide the necessary support for their published components.

## RightScale ServerTemplates on YouTube

<div class="media media-video-wide">
  <iframe class="media-video-item" src="https://www.youtube.com/embed/ri407EbonvE"></iframe>
  <div class="media-caption">
    <small>Introduction to ServerTemplates</small>
  </div>
</div>

To see more videos, go to our RightScale channel on YouTube, [https://www.youtube.com/RightScale](https://www.youtube.com/RightScale).

## What are the benefits of using ServerTemplates?

The key advantage of using ServerTemplates is that they help you create a more modular and easily reproducible server setup. Remember, in the cloud, you are no longer tied to a physical piece of hardware. Instead of creating new images for every type of server, you can now write simple scripts (RightScripts or Chef Recipes) that install and configure the necessary software components each time a server is launched with a particular ServerTemplate. Use the same RightScripts for multiple servers across several Deployments (Production, Staging, QA). ServerTemplates also make it easy to make changes across multiple servers. You no longer have to "re-image" each server individually when it comes time to upgrade or patch the base image. Simply update the appropriate scripts that are used across multiple ServerTemplates.

## How do I use ServerTemplates?

Create your own ServerTemplate or import or subscribe to one of the existing published ServerTemplates from the MultiCloud Marketplace. Although you can use one of the published ServerTemplates from the MultiCloud Marketplace "as-is" to launch servers, you must clone it in order to create an editable, private copy of your own. When you import or clone a ServerTemplate, it will appear under the 'Local' view (**Design** > **ServerTemplates** > **View Local**). You can only edit private ServerTemplates.

## What's inside of a ServerTemplate?

A ServerTemplate consists of a Base Machine image (or AMI), some Cloud-Specific configurations depending on cloud infrastructure, and a list of [RightScripts](/cm/dashboard/design/rightscripts/index.html).

* **Base Image**
    * Start with base operating system such as CentOS, Ubuntu, etc.
* **Cloud Configurations**
    * **Standard Networking Tools**
    * **IP Address (or Elastic IP)** must be assigned to the server
    * **Security Group** defines support-level access to the server
    * **Unique SSH Key** is required to provide root-level access to your machine
* **RightScripts** can be executed at the following times and can be written in a variety of script languages including Shell, Bash, Perl, Ruby, or Python:
    * **Boot Scripts** - executed at boot time when the server is launched
    * **Operational Scripts** - executed during normal operational runtime
    * **Decommission Scripts** - executed during the shutdown phase when the instance is terminated
		
A key component of ServerTemplates is a MultiCloud Image (MCI).

### Related FAQs 
* [What is a MultiCloud Image (MCI)?](/cm/rs101/multicloud_image_(mci).html)
 
 
## Leveraging Chef, Puppet, etc with ServerTemplates
 
Any configuration management system can be used with ServerTemplates by bootstrapping the ServerTemplate with a script that initiates the configuration engine of choice. RightScale provides examples for Chef and Puppet, as well as a ServerTemplate that can be used to run a Chef Server. See the [full list of ServerTemplates](/st/rl10/).
 

## Revision History Timeline for ServerTemplates

The Revision timeline for ServerTemplates shows the most recently committed revisions of the template. Similar functionality exists for RightScripts.

![cm-revision-timeline-default.png](/img/cm-revision-timeline-default.png)

By default, the timeline will only show the two most recent revisions along with the HEAD revision.

You can either select a different revision to view or click the **Revision** button, which will take you to the template's **Revisions** tab.

If you select a revision that's older than the two most recent revisions, it will be displayed and the Revision timeline will display [...] to denote a larger gap in the revision history.

![cm-revision-timeline-old-revision.png](/img/cm-revision-timeline-old-revision.png)

## ServerTemplate Versioning

This section provides information on RightScale's version control system with regards to ServerTemplates including ServerTemplate libraries, ServerTemplate versioning, and the difference between Versions and Revisions.

### ServerTemplate Libraries

In the RightScale Dashboard you have access to a variety of ServerTemplates in the MultiCloud Marketplace. There are generally three different types of publishers.

* **RightScale** - ServerTemplates that are published from RightScale. RightScale thoroughly tests each ServerTemplate before it is published.
* **Partners** - ServerTemplates that are published by certified RightScale Partners The use of these ServerTemplates are at the discretion of each partner. Most are free for public usage although paid subscriptions may be required. Partners are responsible for providing documentation and support for their published ServerTemplates.
* **Shared** - ServerTemplates that have been shared with your account. When you accept an invitation to a sharing group, you will find all of its shared components (ServerTemplates and Macros) under the "Shared" category. Similar to Partners, 'Sharers' are responsible for providing documentation and support for their published ServerTemplates.

![cm-st-versioning-libraries.png](/img/cm-st-versioning-libraries.png)

### Understanding ServerTemplate Versioning

Instead of creating a ServerTemplate from scratch, we recommend finding an existing ServerTemplate that already accomplishes a majority of what you're trying to accomplish (e.g. PHP FrontEnd, Rails App Server, etc.). Although you can use a ServerTemplate as-is to launch servers, you will not be able to make any modifications to the ServerTemplate. The first step is to import any relevant ServerTemplates from the MultiCloud Marketplace into your 'Local' view. In order to make changes to an imported, published ServerTemplate you will need to clone it to create an editable copy in your 'Local' view. When you clone a ServerTemplate you are essentially creating a private, editable copy of that ServerTemplate for your own purposes. The cloned ServerTemplate will be treated as a completely new ServerTemplate.

!!info*Note:* When you clone a ServerTemplate or RightScript that contains a version number in its namespace (e.g. PHP FrontEnd v7), the name of the clone will automatically increment one version number (e.g. PHP FrontEnd v8). As a best practice, you should rename it so that the name is consistent with the version that it was cloned from in order to avoid confusion when RightScale releases an updated version several months later called PHP FrontEnd v8.

![cm-st-versioniong-clone.png](/img/cm-st-versioniong-clone.png)

Once you have an editable copy of the ServerTemplate, you can make changes to the ServerTemplate and create static revisions for version control purposes by committing your changes at any time. You can only make changes to [HEAD] versions.

![cm-st-versioning-add-script.png](/img/cm-st-versioning-add-script.png)

Notice in the diagram above that we added a [HEAD] RightScript. If you add a [HEAD] version of a RightScript into a ServerTemplate, you will be prompted to commit any [HEAD] RightScripts the next time that you try to commit the ServerTemplate. When you commit HEAD RightScripts in your ServerTemplate, new revisions of those RightScripts will automatically be created. Commit ServerTemplates that you do not want change. Once you commit a ServerTemplate, it is locked and you will never be able to change the referenced versions of those RightScripts (HEAD/revision). Therefore, if you commit a ServerTemplate that references a [HEAD] RightScript, that RightScript could be changed and break functionality of your ServerTemplate. The purpose of committing a ServerTemplate is to create a static revision whose functionality cannot change over time. See [Committing a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html).

But, in this case, we are not ready to create a static revision of the ServerTemplate because we're still making modifications to its underlying RightScripts.

Later on, RightScale releases a newer version of the 'PHPFrontEnd v7 [rev 2]" ServerTemplate that you originally cloned your ServerTemplate from several months ago.

If you import the newest revision to your 'Local' view, you will see yellow sphere notifications next to RightScripts that have newer revisions available. Remember, each ServerTemplate will have its own lineage. However, they may be referencing the same RightScripts. However, update RightScript notifications will only detect newer RightScript revisions that are in your 'Local' view. It cannot detect newer revisions that exist in the ServerTemplate section of the MultiCloud Marketplace. Therefore, you should periodically check the MultiCloud Marketplace for newer revisions of your ServerTemplate so that you can import them into your 'Local' view and see what new RightScripts have been published in the ServerTemplate. You can use the "Diff" or "Update to latest RightScripts" buttons to view differences and upgrade selected RightScripts.

![cm-st-versioning-lineage.png](/img/cm-st-versioning-lineage.png)

In the example diagram above, the newest published revision of the ServerTemplate [rev 2] contains a revised 'Script-A'. The yellow sphere that appears in your [HEAD] version denotes that a newer revision of that RightScript is available. You can click the yellow sphere to perform a "diff" between your current revision and the latest revision that's available. To upgrade the revision of a single RightScript, you should edit the referenced revision of that RightScript. (You can only change a RightScript's revision in a [HEAD] version.)

![cm-change-script-revision.png](/img/cm-change-script-revision.png)

You also have the option of using the "Update to latest RightScripts" action button to update all of the RightScripts that have been flagged with yellow spheres to the latest revisions that are available. But be careful, because there is no undo button. Therefore, you might want to commit the ServerTemplate _before_ updating all of the RightScripts.

![cm-st-versioning-update-rightscripts.png](/img/cm-st-versioning-update-rightscripts.png)

The same version control rules apply to RightScripts. When you clone a RightScript so that you can make edits, it becomes a completely new RightScript with no notion of a previous revision. The cloned RightScript will start its own revision history lineage. Therefore, the flags for denoting when new revisions of a RightScript are available are only shown for newer revisions of the same RightScript. For example, if you cloned 'Script-A [rev 1]' so that you could make changes to the RightScript, it will become a completely new RightScript. Therefore, you will not see an yellow sphere next to the RightScript in the diagram below even though 'Script-A [rev 2]' is available, because it is no longer related to that RightScript (from which it was cloned).

![cm-st-versioning-no-flags.png](/img/cm-st-versioning-no-flags.png)

### Version vs. Revision

It's important to understand the distinction between a *version* and a *revision*. You might notice that RightScale publishes a ServerTemplate with the same title, except it has a different version in the name.

For example:

* PHP FrontEnd v6
* PHP FrontEnd v7

Published ServerTemplates from RightScale that contain different versions in the title should be treated as *completely different* and separate ServerTemplates that have different revision lineages. Each ServerTemplate is unique and will have its own lineage. Different versions of a ServerTemplate are treated the same way as a cloned version of a ServerTemplate. However, revisions are specific to the same ServerTemplate.

For example:

* PHP FrontEnd v7 [rev 3]
* PHP FrontEnd v7 [rev 4]

In the example above, [rev 4] is a direct descendent of [rev 3].  Even if you change the name of the ServerTemplate, it will belong to the same lineage. The name is really just metadata. If you change the name it does not affect the actual object itself, it only affects how you refer to it.

For example, let's say you change the name of the ServerTemplate before you commit it and create [rev5].

* PHP FrontEnd v7 [rev 3]
* PHP FrontEnd v7 [rev 4]
* My Production FE [rev 5]

You might think that it is a different ServerTemplate because the name is different, but all of those revisions apply to the same lineage of that ServerTemplate. But if you clone the ServerTemplate, it becomes a separate ServerTemplate and will start a new lineage of its own and will have no previous revision history.

When RightScale releases beta ServerTemplates for demo/testing purposes, we may change the name of the ServerTemplate as it transitions from Alpha to Beta to production. Once a ServerTemplate is solid and has been fully tested, we will remove the alpha/beta labels.

For example:

* PHP FrontEnd (Alpha) [rev 3]
* PHP FrontEnd (Beta) [rev 4]
* PHP FrontEnd [rev6] *--- production ready!*
