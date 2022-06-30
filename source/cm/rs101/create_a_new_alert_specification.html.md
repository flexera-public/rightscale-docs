---
title: Create a New Alert Specification
layout: cm_layout
description: In the RightScale Cloud Management Platform, an Alert Specification defines the conditions under which an alert is triggered and an automated action or set of actions take effect.
---

## Objective

To create a new Alert Specification from scratch.

## Prerequisites

* 'designer' user role privileges

## Overview

An Alert Specification defines the conditions under which an alert is triggered and an automated action or set of actions take effect. Alert Specifications can either be tied to an Alert Escalation or a Voting Tag (for autoscaling purposes). To learn more about how Alert Specifications can be used, see [RightScale Alert System](/cm/rs101/rightscale_alert_system.html).

## Steps

Alert Specifications can be defined at either the ServerTemplate, Server Array, or Server levels. It's important to understand where a Server can inherit its Alert Specifications from so that you can define them in the proper location and manage them appropriately. See [Alert Specifications](/cm/rs101/alert_specifications.html) for details.

An Alert Specification is defined the same way, regardless of where it's defined.

Depending on where an Alert Specification is defined (ServerTemplate, Server Array, Server), go to its **Alerts** tab. At this point you have two options:

* **New** - Create a new Alert Specification from scratch.(This tutorial will focus on how to create new Alert Specification from scratch.)
* **Copy** - Copy an existing Alert Specification from somewhere else. See [Copy an Alert Specification](/cm/rs101/import_an_alert_specification.html).

**Note** : An Alerts tab also exists at the Dashboard level (Manage > View Dashboard) or at the Deployment level (Manage > Deployments > *YourDeployment*), but those tabs show an overview status page of all active and triggered alerts across all Deployments or a single Deployment, respectively.

![cm-define-alert.png](/img/cm-define-alert.png)

Click the **New** button, then provide the following information to create a new Alert Specification.  

**Note**: The "warning" Alert Escalation dictates which action(s) are taken once the alert is triggered. Example: If "cpu-0/cpu-idle" falls below 25% available (< 25) for 30 minutes, then execute the "warning" Alert Escalation.

* **Nickname** – A short nickname that helps you recognize the alert specification ( **Note** : multiple Alert Specifications can have the same name).
* **Description** – A short description of the alert specification (for internal use only).
* **Metric** - The file/variable that you are monitoring. For example, cpu, apache, disk, mysql, haproxy, memory, etc.
* **Variable** - The type of variable (condition), which depends on the selected metric. It could be a count, value, free/used, write/read, etc. For example, if you are monitoring "cpu-0 idle" you can set the condition and threshold to be < 25%.
* **Threshold & Duration** - An alert is triggered when the metric's variable meets or exceeds the specified threshold for longer than the specified duration. For example, if a Server's "cpu-0 idle" is < 25% available for longer than 30 minutes, trigger an alert. RightScale evaluates each alert specification once a minute.
* **Alert Escalation** - The name of the Alert Escalation that will be called when the alert is triggered. As long as the alert remains triggered, the Alert Escalation's action(s) will be executed in sequence. If you do not select an Alert Escalation from the dropdown menu, the "default" will be used. **Note**: If an Alert Escalation appears to be missing from the list, it's probably because the escalation is not available. An Alert Escalation is either configured to be available for use in a single Deployment or in all Deployments. Go to the missing Alert Escalation and modify its Deployment access settings under the Info tab.
* **Voter Tag** - If the triggered alert should be used for autoscaling purposes, set an appropriate voting tag.  The voting tag **must** match the voting tag that's defined in the associated Server Array (that will grow/shrink). See [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags).

### Human Readable Sizes

The **df** and **swap** alert specification metrics offer the ability to specify the following human readable options when defining the alert specification:

* Kilobytes (KB) - Defined as 1024 Bytes
* Megabytes (MB) - Defined as 1024<sup>2 </sup>Bytes
* Gigabytes (GB) - Defined as 1024<sup><span style="font-size:9px;">3 </span></sup>Bytes

An example screenshot showing these options shown here:

![cm-human-readable-alert-spec.png](/img/cm-human-readable-alert-spec.png)

**Note:** After saving an alert specification, the human readable specification will be convert and will *always* show its value in Bytes.

### Alert Behavior

After an alert is triggered (and the first email is sent), any changes made to the Alert Specification will be ignored. You must disable the alert, make any necessary changes, and then re-enable it in order for the new settings to take effect. For example, you set an alert stating that "if cpu-0/cpu-idle.value is > 10 for 10 minutes" in order to send an escalation. You receive the escalation email and decide the threshold is too low. You change it to "if cpu-0/cpu-idle.value is > 10 for 20 minutes" but you do not disable it. The threshold will remain at 10 minutes until you disable the alert and then re-enable it with the new threshold setting.

## See also

* [Copy an Alert Specification](/cm/rs101/import_an_alert_specification.html)
