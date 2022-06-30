---
title: Alert Escalations
layout: cm_layout
description: A RightScale alert escalation defines the action or set of actions to be taken when specified alert conditions are met.
---

## Overview

An **alert escalation** defines the action or set of actions to be taken when specified alert conditions are met and when alert conditions are resolved. Each alert escalation can have a series of actions that are executed in sequential order until the alert condition no longer exists, at which time a resolution action can be defined. By default, you must associate an alert escalation when you create an alert. Because of this requirement, you must create an alert escalation before you create an alert (unless you use one of our predefined alert escalations). See [Create an Alert Escalation](/cm/dashboard/design/alert_escalations/alert_escalations_actions.html#create-a-new-alert-escalation).

Alert Escalations are either assigned to a specific deployment or they are made available to all deployments. Once an Alert Escalation is assigned to a deployment, all servers within that deployment can use that alert escalation when creating an alert specification.

## Actions

Each alert escalation is comprised of a series of one or more actions. An alert escalation defines which actions are performed in response to a triggered alert condition. Actions are executed in sequence as long as the alert exists. If the alert goes away and then returns again, the actions are processed again in sequence from the beginning of the list.

The following actions are supported:

* Send Email
* Reboot Server
* Relaunch Server
* Run RightScript
* Run Cloud Workflow (Labs)
* Vote to Grow the Server Array (scale-up)\*
* Vote to Shrink the Server Array (scale-down)\*

!!info*Note* `*` The vote to grow/shrink actions will soon be deprecated. Please use [Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags) instead for configuring a scalable Server Array.

For detailed descriptions about each action, see [Valid Actions for Alert Escalations](/cm/dashboard/design/alert_escalations/#valid-actions-for-alert-escalations).

## Resolution Action (Labs)

When an alert condition is resolved, a resolution action can optionally be executed to notify users/systems that the alert is resolved. Only one resolution action per Alert Escalation is allowed. 

The following resolution actions are supported:

* Send Email
* Run Cloud Workflow

!!info*Note*The resolution action capability is currently in Labs.
