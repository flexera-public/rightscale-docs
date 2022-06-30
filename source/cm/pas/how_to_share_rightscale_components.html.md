---
title: How to Share RightScale Components
layout: cm_layout
description: Guidelines and steps for sharing RightScale components (ServerTemplates, RightScripts, etc.) either publicly or privately.
---
## Objective

To publicly or privately share RightScale components (ServerTemplates, RightScripts, etc.).

## Prerequisites

The ability to privately share RightScale components with other RightScale accounts is only supported for accounts with an enterprise structure. To upgrade your plan type, please contact [sales@rightscale.com](mailto:sales@rightscale.com). In order to create Account Groups and share RightScale components you will also need 'publisher' user role privileges.

!!warning*Warning!* If you attempt to publish a MCI or ServerTemplate (either publically or privately), where the MCI itself or one of the MCIs in the ServerTemplate has at least one machine image that is private, you must go to the AWS console to set that image as public. Otherwise, you will not be able to successfully publish your RightScale component.

## Overview

The ability to share RightScale components with other users can help increase productivity and efficiency within an organization or the RightScale community. To learn more about the different types of sharing within the RightScale platform, see [Sharing RightScale Components](/cm/pas/sharing_rightscale_components.html).

## Steps

RightScale's Publishing Assistant wizard will walk you through the process of publishing your component(s).

### Publish to MultiCloud Marketplace

The first step in the sharing process is to determine which RightScale component you want to publish to the MultiCloud Marketplace. Users will need to have access to the MultiCloud Marketplace ('library' user role privileges) in order to view and import/subscribe to a shared component. You can only publish private components to the MultiCloud Marketplace. (i.e. You cannot import a premium ServerTemplate that's published by a different account and then re-publish it to the MultiCloud Marketplace.)

1. Go to the private component in your local collection that you want to share. (e.g. Design > ServerTemplates > View Local)
2. Be sure to select the correct revision of that component that you want to share. As a best practice, you should only share committed (static) revisions of a component. Also make sure that you haven't previously published it. The component should be listed as "unpublished" under the component's Info tab. You should only share a HEAD version under certain circumstances. The ability to publish a HEAD version is only supported for RightScale accounts that are enabled for private sharing. You cannot publicly share a HEAD version of a component. When you publish a component to the MultiCloud Marketplace, only the selected revision or HEAD version will be published. (i.e. Previous revisions of that component will not be published.)
3. Click the **Publish to MultiCloud Marketplace** action button. (*Note*: If this button is not displayed, you do not have the 'publisher' User Role Privilege in the RightScale account *or* if you are looking at a HEAD revision and your account does not support private sharing.)
  ![cm-publish-to-library.png](/img/cm-publish-to-library.png)
4. You must read and agree to RightScale's EULA before continuing the publishing process.
5. Next, you will need to specify the visibility of your component. This selection controls who can browse and find your component in the MultiCloud Marketplace. (In a later step you will specify which accounts have access to import the component.)  
  ![cm-publish-to-marketplace.png](/img/cm-publish-to-marketplace.png)
  * **Publish to the Public MultiCloud Marketplace Catalog** - Make this component publicly visible to everyone in the MultiCloud Marketplace. Unless your account is enabled for private publishing, only committed revisions can be publicly shared. (Note: Components will be indexed by search engines.)
  * **Share privately** - Make this component only visible in the MultiCloud Marketplace to specific RightScale accounts with whom you've granted access via Account Group Invitations. Users will be able to view the component in the MultiCloud Marketplace under **Categories -> Shared**. *Note*: You must have a Premium account (or better) for private sharing.

*  You must read and agree to [RightScale's Publishing Agreement](/cm/pas/rightscale_publisher_agreement.html) before continuing the publishing process.
*  Click the **Sharing** action button to proceed to the next step.

### Organization

If you are publishing for the first time, you must provide the following information about your publishing organization. Later, you can edit this information under Design -> Account Library -> Your Publishing Organization. The 'Organization' tab appears the first time a user publishes from your account.

* **Organization Name (required)** - In the MultiCloud Marketplace, the organization name will denote who published the component. Each account can only have one defined publishing organization. Several characters are not allowed in the namespace: ; \\ / > < & , .
* **Organization Email (required)** - When someone leaves a comment on one of your shared components, notifications will be sent to this email address (if enabled).
* **Logos** - Depending on the view in the MultiCloud Marketplace, large and small logos will appear next to the component.
* **Support Information** - Publishers are responsible for supporting their shared components. Be sure to provide helpful links and contact information that will be useful for your users. The provided support information will be displayed for each shared component regardless of the account group.
* **Welcome Message** - The welcome message will be shown when an Account Group Invitation is accepted.

### Sharing

![cm-pub-assist-st-sharing.png](/img/cm-pub-assist-st-sharing.png)

The "Sharing" section allows you to control who can import your component.

Specify your sharing preferences. Remember, when you publish a ServerTemplate, any (unpublished) private RightScripts, MultiCloud Images, and RepoPaths that are used by the ServerTemplate are implictly shared to guarantee the usability of the template itself. Click the **View ServerTemplate components** link to see what other components will be implicitly published.

* **All RightScale Accounts** - The component can be imported into any RightScale account. Note: Public publishing must be enabled in the publishing account. Contact your RightScale account manager to enable public publishing for your account.
* **Specific Accounts** - The component can only be imported into specified RightScale accounts. You can either select an existing Account Group(s) or create a New Account Group. Note: You must select at least one Account Group, however it can be empty. (i.e. Specific RightScale accounts have not been added to the Account Group.)
  * **Publishing Only for RightScale Paid Accounts** - If your account is enabled for private publishing, you can also select the "RightScale Paid Customers" Account Group which makes the component importable ONLY into paid RightScale accounts (Standard and above). Only users with credit cards on file are able to import ISV templates that require payment (contact your account manager or [sales@rightscale.com](mailto:sales@rightscale.com) for clarification).<br> **Note**: Select this option if you are an ISV publishing a pay-per-use RightScale ServerTemplate unless otherwise instructed by your RIghtScale account contact.

The "Comments" section allows you to control the comment feature in the MultiCloud Marketplace.

* **Allow users to leave comments on this ServerTemplate** - If checked, users will be able to leave comments about your component in the MultiCloud Marketplace. Only users who are logged into the Dashboard can leave comments.
* **Email me when a user comments on this ServerTemplate** - If checked, an email notification will be sent to the provided Organization Email address. (Design > Account Library > Your Publishing Organization)

Click the **Descriptions** action button to proceed to the next step.

### Descriptions

![cm-pub-assist-st-descriptions.png](/img/cm-pub-assist-st-descriptions.png)

Fill out the Short and Long Descriptions for the component. For your convenience, both description fields are pre-populated with the ServerTemplate's current description. If you have published an earlier revision, the fields are pre-populated with the previously entered short and long descriptions. However, since these description fields will be saved in the MultiCloud Marketplace's database, you can actually provide different descriptions. *Note*: The provided descriptions will appear in the MultiCloud Marketplace for all previously shared revisions of that component.

You can update the "New Revision Notes" as well, which are prepopulated with the component's Commit message for the selected revision.

Revision Notes are similar to commit messages in the Dashboard. They will be seen at the bottom of the shared component in the MultiCloud Marketplace. As a best practice, you should provide useful information about any changes, bug fixes, new features, especially if there's a previously published revision of that component in the MultiCloud Marketplace.

Categories allow users to more easily search for your publication in the MultiCloud Marketplace. The selected categories will be applied to all revisions of your publication. You can add multiple categories.

**Notes**:

* Markdown syntax is supported
* Hover over the blue information icon for additional help
* Character limitations are updated in real time as the fields are populated

Click the **EULAs** action button to proceed to the next step.

### EULAs

!!warning*Reminder!* EULAs currently apply to ServerTemplates only. This phase is not part of the Publishing Assistant when publishing other RightScale components (RightScripts or MCIs).

![cm-pub-assist-st-eulas.png](/img/cm-pub-assist-st-eulas.png)

* EULAs can be managed outside of the Publishing Assistant. Simply select which EULA(s) should be attached to the ServerTemplate you are going to publish.
* You can also create and add a new EULA directly from within the Publishing Assistant.
  * Click the **New EULA** action button
  * Fill out the EULA Name and Text. Markdown Syntax is supported.
  * Preview the EULA. Don't forget to select **Save & Attach** prior to continuing.

!!info*Note:* EULAs are not required when publishing RightImages or RightScripts indepdendently from a ServerTemplate._

Click the **Preview** action button to proceed to the next step.

### Preview

![cm-pub-assist-st-preview.png](/img/cm-pub-assist-st-preview.png)

If everything looks correct, click the **Publish** action button.

### Notes

* Shared RightScale components will appear in the MultiCloud Marketplace for accounts that have access to those components. In the MultiCloud Marketplace, click the "Shared" link under Categories.
* A shared component will continue to appear in the RightScale account's Local collection of the "publishing" account since you are the publisher.
* If you are sharing a HEAD version of a component, you can still make changes to the HEAD version in your local collection. When you want those changes to be propagated to the HEAD copy that's in the MultiCloud Marketplace and subsequently pass those changes to any RightScale accounts that are subscribing to that component, click the **Republish to MultiCloud Marketplace** button when viewing the published HEAD version. Currently, the accounts that are subscribing to the HEAD version and are using it in their local accounts do not have the ability to push their changes to the MultiCloud Marketplace to similarly update the HEAD version. If any changes are made to HEAD RightScripts, you need to republish them in order to be shared. These changes will be included in the HEAD ServerTemplate and affect any ServerTemplates using those RightScripts.
* Add Categories - You also have the option of categorizing your component so that it is easier to find in the MultiCloud Marketplace. Go to Design -> Account Library -> Your Publications. A component's categories can be managed under its Info tab. Simply select a category from the dropdown and click the Add button. Although, you can add your component to multiple categories, please make sure that they are relevant for each topic.

![cm-add-categories.png](/img/cm-add-categories.png)

## Invite Users to a Private Account Group

(For private sharing only)

To grant access to a private Account Group, you must send an Account Group Invitation (email) to an 'admin' user of the RightScale account you wish to share your components with. Remember, a user accepts an invitation on behalf of a RightScale account. Once an invitation has been accepted, users of that RightScale account will be able to import any shared components of that Account Group in the MultiCloud Marketplace. A user must accept an Account Group Invitation within 6 days. An invitation can only be accepted once. If a user has 'admin' role privileges on multiple accounts, he/she must be sure to accept the invitation while being logged into the desired RightScale account.

![cm-accept-invitation.png](/img/cm-accept-invitation.png)

To send an Account Group Invitation, you will need 'publisher' role privileges.

Go to **Design** > **Account Library** > **Your Account Groups** and click the **Invitations** tab. Click the **New** link.

Add user email addresses, select the appropriate Account Group(s) that you want to grant access to and click the Send Invitations link.

You may cancel a pending invitation at any time by clicking the **cancel invitation** action link. However, if an invitation has already been accepted, you can always revoke their access by changing their access under **Design** > **Account Library** > **Your Account Groups** > **Account Groups** tab.

Users must use the membership code in order to confirm their membership. See [How do I accept an Account Group Invitation?](/cm/pas/accept_an_invitation_to_an_account_group.html)
