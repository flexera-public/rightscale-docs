---
title: Import an Alert Specification
layout: cm_layout
description: Procedure for importing an existing Alert Specification from either a Server or ServerTemplate in the RightScale Cloud Management Dashboard.
---

## Objective

To import an existing Alert Specification from either a Server or ServerTemplate.

## Prerequisites

* 'designer' user role privileges

## Overview

An Alert Specification defines the conditions under which an alert is triggered and an automated action or set of actions take effect. Alert Specifications can either be tied to an Alert Escalation or a Voting Tag (for autoscaling purposes). To learn more about how Alert Specifications can be used, see the [RightScale Alert System](/cm/rs101/rightscale_alert_system.html).

## Steps

Alert Specifications can be added at either the ServerTemplate, Server Array, or Server levels. You can add an Alert Specification to a Current or Next Server, HEAD ServerTemplate, or Server Array.  It's important to understand where a Server can inherit its Alert Specifications from so that you can define them in the proper location and launch that server with the correct Alert Specifications. See [Alert Specifications](/cm/rs101/alert_specifications.html) for details.

An Alert Specification is defined the same way regardless of where it's defined.

Go to the component where you want to add an Alert Specification and go to its **Alerts** tab. At this point you have two options:

* **New** - Create a new Alert Specification from scratch. See [Create a New Alert Specification](/cm/rs101/create_a_new_alert_specification.html).
* **import** - import an existing Alert Specification from somewhere else. (This tutorial will focus on how to import an alert.)

**Note** : An Alerts tab also exists at the Dashboard level (Manage -> View Dashboard) or at the Deployment level (Manage > Deployments > *YourDeployment*), but those tabs show an overview status page for all active and triggered alerts across all Deployments or a single Deployment, respectively.

When you click the import **alert** button, you'll see a pop-up selector window where you can select an alert specification that's already been defined somewhere else. You can import an alert specification from one of the following locations:

* **Default** (RightScale Alerts) - A list of commonly used Alert Specifications preconfigured by RightScale
* **Server** - An Alert Specification that's defined at the Server level
* **Private/Imported ServerTemplate** - An Alert Specification that's defined at the ServerTemplate level. You cannot import an alert specification from a ServerTemplate in the MultiCloud Marketplace. It must first be imported/subscribed.

Once you've selected the source type and specify where you're going to import an alert from, click **Next**.

![cm-copy-alert-selector.png](/img/cm-copy-alert-selector.png)

When you import an alert, you're essentially cloning the alert and adding an editable import to your Server/ServerTemplate. No link to the original alert specification is maintained, so any changes to the original alert specification do not affect the copied alert specification. The ability to import an alert is useful for leveraging existing alert specifications that are defined elsewhere in your account. It can also save you time because instead of creating an alert specification from scratch you can simply import a similar alert from another component and customize it accordingly.

Once you find an Alert Specification that you want to import, click the **Add** button to add it to your Server/ServerTemplate.

Once the Alert Specification has been successfully added (cloned) you can click the **Done** button to return to the Alerts tab.

![cm-add-alert-confirmation.png](/img/cm-add-alert-confirmation.png)

You can now edit the added Alert Specification's settings accordingly.

## See also

- [Create a New Alert Specification](/cm/rs101/create_a_new_alert_specification.html)
- [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
- [Alert Escalations](/cm/dashboard/design/alert_escalations/index.html)
