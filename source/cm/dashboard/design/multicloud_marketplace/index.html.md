---
title: MultiCloud Marketplace
layout: cm_layout
alias: cm/dashboard/design/multicloud_marketplace/multicloud_marketplace.html
description: The MultiCloud Marketplace is where RightScale maintains a library of ServerTemplates, RightScripts, MultiCloud Images and Macros for you.
---

## Overview

The MultiCloud Marketplace is where we maintain a library of ServerTemplates, RightScripts, MultiCloud Images and Macros for you. The MultiCloud Marketplace contains a wide range of components including ServerTemplates to create a MySQL EBS Master/Slave setup, PHP Application servers, or a grid application macro for instantly creating a complete setup for performing batch processing tasks. Feel free to browse through the MultiCloud Marketplace to see what components are available. Be sure to visit the MultiCloud Marketplace often to check for new or updated components.

The MultiCloud Marketplace is simple to use, and contains the following functional areas. First, on the left hand side:

* **Browse** - Select the RightScale component you wish to browse for in the MultiCloud Marketplace. Note that once selected, this dynamically reflects the remaining sections of the left hand side of the screen.
* **Search** - Searches for the text pattern you enter in. *Both* the Nickname and Description fields are included in the Search.
* **Categories** - Each RightScale component is split into categories. For example, ServerTemplates that are Load Balancing related, Application Servers, etc. Each category also includes an exhaustive listing "All" and "Shared". Shared displays all of the RightScale components that have been shared with you from other RightScale users via Sharing Groups. (*Note*: The ability to create Sharing Groups and share RightScale components is reserved for users of our Premium and Enterprise editions.) When you accept an invitation to a Sharing Group, you gain access to all of that group's shared RightScale components (ServerTemplates, RightScripts, Macros, and MCIs). The primary part of the display (right hand side) differs depending on what RightScale component you are browsing for. ServerTemplates are handled a bit differently, with additional functionality.

**ServerTemplates** - When browsing for ServerTemplates the screen is split into the following two sections:
* **Featured ServerTemplate** - Highlights ServerTemplates that are either new, popular or have recently changed. The Featured ServerTemplate changes pretty often, about every two weeks, so keep your eyes open for ServerTemplates of interest!
* **List of ServerTemplates** - Note that in addition to the categories, there are three helpful tabs to help you locate ServerTemplates of interest: Highest Rated; Recently Added; Featured

Selecting an individual ServerTemplate also includes the following helpful capabilities:

* **My Rating** - 4 Star rating system. 1 (lowest) to 4 (highest) rating.
* **Discussion** - Post discussion comments for the ServerTemplate. Try to be as constructive as possible.
* **Supported Clouds** - Lists the clouds that are supported by the selected ServerTemplate.

!!info*Note:* In order to import a RightScale component (ServerTemplate, RightScript, etc.) from the MultiCloud Marketplace into the current RightScale account, you will need 'library' user role privileges. To check your user role privileges, go to Settings -> User. If you do not have this privilege, an 'admin' user of the RightScale account (Settings -> Account) must grant you this privilege.

## Accessing the MultiCloud Marketplace

You can view the MultiCloud Marketplace two different ways but each supports slightly different functionality.

* **Marketing Site** ( [http://www.rightscale.com/library/](http://www.rightscale.com/library/server_templates))
  * View all published RightScale components that are publicly available (Free, Paid)  
* **RightScale Dashboard** (Design > MultiCloud Marketplace)
  * View all published RightScale components that are publicly available (Free, Paid)
  * View all published RightScale components that are privately shared with your RightScale account via Sharing Groups
  * Import or Subscribe to components
  * Rate components (Note: You cannot rate a HEAD version because it's not static.)
  * Leave comments (Note: You cannot leave comments on a HEAD version because it's not static.)

## Using Components in the MultiCloud Marketplace

In order to use any components from the MultiCloud Marketplace you need to place a copy in your own local collection so that you can use it in your own account. Simply browse through the MultiCloud Marketplace to find all of the components that are relevant for your application. Once you find a component that is relevant for your application, you can either import a static copy or subscribe to a HEAD (non-static) version. A copy of that component will be added to your local collection. You can either use the preconfigured components as-is or clone them to create editable copies that you can customize accordingly. Remember, each component that is available in the MultiCloud Marketplace has been published by either RightScale, an ISV Partner, or by another RightScale account that has publishing privileges.

!!warning*Disclaimer* It is the responsibility of the publisher to test and support their published components. The MultiCloud Marketplace simply serves as a central location where publishers can distribute their components to users of the RightScale community. RightScale is not responsible for supporting components that are not officially published by RightScale.

![cm-object-libraries.png](/img/cm-object-libraries.png)

## Importing vs Subscribing

When you find a RightScale component that you want to use in your own RightScale account, you can either **import** it or **subscribe** to it. In both cases, a copy of the component is placed in your account's local collection for that component type.

The key difference between **importing** and **subscribing** is that you import committed (static) revisions of an component, whereas you can only subscribe to HEAD (non-committed) components. Most components that are available in the MultiCloud Marketplace are published, committed revisions. You can either use them as-is, or customize them. However, if you need to customize them in any way, you must clone them first, which creates private editable copies. You will only have access to the published revision or HEAD version for cloning. You will not have access to earlier revisions of that component, however you can import earlier revisions as separate actions as needed (if they are still available in the MultiCloud Marketplace). Once you import a component from the MultiCloud Marketplace, it will remain in your local collection even if the publisher later deprecates it and it is no longer browsable or importable in the MultiCloud Marketplace.

!!warning*Warning!* You must be extremely careful and understand the consequences of using a subscribed component. For example, if you subscribe to a HEAD version of a ServerTemplate, you can use it as-is, but the publisher reserves the right to make changes to it at any time. The ability to subscribe to a HEAD version can be a very useful tool, especially for collaborative development. When you subscribe to a RightScale component it will be listed as an "imported" component. So, if you add a server to a deployment, you'll find the subscribed ServerTemplate under the "imported" list.

In order to view components in the MultiCloud Marketplace, you will need the 'designer' user role privileges, but in order to import/subscribe to a component from the MultiCloud Marketplace, you will need the 'library' user role.

## Importing RightScale Components

### ServerTemplates

When you import a ServerTemplate, any of its underlying RightScripts, RepoPaths, and MultiCloud Images are also imported unless they already exist in their respective local collections.

!!info*Note:* Only the committed RightScript revision that's referenced in the ServerTemplate becomes visible (Design > RightScripts). i.e. You cannot see the complete history of all revisions of that RightScript. For example, if you import 'ServerTemplate A' that uses 'RightScript A [rev 4]' you will not see 'RightScript A [rev 3]' of that RightScript unless you previously imported a ServerTemplate that referenced 'RightScript A [rev 3]'.

### RightScripts and MultiCloud Images

You can also import RightScripts and MultiCloud Images individually.

## Local Collection

The Local Collection shows all of the RightScale account's private, imported, and subscribed components. A local collection will exist for each RightScale component that's in the MultiCloud Marketplace (ServerTemplates, RightScripts, etc.). The Local Collection is RightScale Account-specific, not user-specific.

Inside your Local Collection you'll find two types of RightScale components:

* **Private** - Editable components that were either created from scratch or cloned.
* **Imported** - Components that were either imported or subscribed. You can use them as-is, but they cannot be modified. Clone a component to create a private, editable copy.

## Further Reading

* [Design ServerTemplates](/cm/dashboard/design/server_templates/servertemplates.html)
* [Design RightScripts](/cm/dashboard/design/rightscripts/rightscripts.html)
* [Design MultiCloud Images](/cm/dashboard/design/multicloud_images/multicloud_images.html)
* [Lifecycle Management Guide](/cm/management_guide/)
* [View the MultiCloud Marketplace](http://www.rightscale.com/library/server_templates)

## Related FAQs

* [CVE-2014-0160: Updating OpenSSL library on RightImage](/faq/CVE-2014-0160_Updating_OpenSSL_library_on_RightImage.html)
