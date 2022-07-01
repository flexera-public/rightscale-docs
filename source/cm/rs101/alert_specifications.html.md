---
title: Alert Specifications
layout: cm_layout
description: A RightScale alert specification defines the conditions under which an alert is triggered and an Alert Escalation is called or a Voting Tag is set.
---

## Overview

An alert (specification) defines the conditions under which an alert is triggered and an Alert Escalation is called or a Voting Tag is set. Several of the most common alerts have already been predefined for your convenience and are already included in many of RightScale's ServerTemplates. You can either create a **new** alert from scratch (see [Create a New Alert Specification](/cm/rs101/create_a_new_alert_specification.html)) or **copy** an alert (see [Copy an Alert Specification](/cm/rs101/import_an_alert_specification.html)). To create your own custom alerts, see [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html).

An alert must be defined at either the ServerTemplate, Server, or Server Array levels.

The ability to add an Alert Specification (new / copy alert) is only supported under the following conditions.

* Current/Next Server ("Alerts" tab)
* Enabled Server Array ("Next Alerts" tab only)
* Disabled Server Array ("Alerts" tab)
* HEAD ServerTemplate ("Alerts" tab)

When you create an Alert Specification you can associate it with either an Alert Escalation or Voting Tag. You can only assign one Alert Escalation or Voting Tag to an Alert Specification. However, you can create multiple alerts that monitor the same metric and then call for a different Alert Escalation. Similarly, you can have multiple alerts that call the same alert escalation. For example, you might have several alerts that point to the 'default' Alert Escalation.

A Server inherits its Alert Specifications from the ServerTemplate and Server Array (if applicable). Alerts can also be added at the Server level. Once a Server is launched, the instance that's configured in the cloud will contain all Alert Specifications and its Voter Tag will be set (if applicable).

In the following diagram, the Server inherits 3 Alert Specifications from the ServerTemplate and Server Array levels. An additional Alert Specification is also defined at the Server level. So when the Server is launched and an instance in the cloud is created, all of the Server's Alert Specifications will be monitored. In this example, the monitored Server is part of a scalable alert-based Server Array. Therefore, it will be allowed to vote for scaling actions based on a 'cpu' metric, so a related Voter Tag will be assigned (rs\_vote:MyArray=none).

Alert Specifications can still be added to a Server (Instance) once it's operational under the Current Server's Alerts tab.

![cm-assign-alerts-v2.png](/img/cm-assign-alerts-v2.png)

* [Create a New Alert Specification](/cm/rs101/create_a_new_alert_specification.html)
* [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
* [Import an Alert Specification](/cm/rs101/import_an_alert_specification.html)
* [Inheritance of Alert Specifications](/cm/rs101/inheritance_of_alert_specifications.html)
* [Managing Alert Specifications on Running Servers](/cm/rs101/managing_alert_specifications_on_running_servers.html)
