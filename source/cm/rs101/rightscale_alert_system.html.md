---
title: RightScale Alert System
layout: cm_layout
description: The RightScale Cloud Management Platform supports an alert system that can take appropriate actions automatically based on predefined conditions that you configure.
---

## Overview

The RightScale Management Platform supports an alert system that can take appropriate actions automatically based on predefined conditions that you configure.

There are two types of RightScale Alerts:

* Alerts based on Alert Escalations (Used to send email notifications or perform an action or series of actions on a Server)
* Alerts based on Voting Tags (Used specifically for horizontal autoscaling using Server Arrays)

Both types of alerts use [Alert Specifications](/cm/rs101/alert_specifications.html) to define the condition under which an alert is triggered and an action is taken.

The three main benefits of the RightScale alert system are:

1. You define conditions that you want to be monitored on your Servers
2. You specify what action (Alert Escalation or Voting Tag) should be taken when an alert is triggered
3. RightScale monitors the alert specifications for each Server and automatically takes action(s) on your behalf when alerts are triggered

- [Alerts based on Alert Escalations](/cm/rs101/alerts_based_on_alert_escalations.html)
  - [Alerts, Alert Escalations, and Server Arrays](/cm/rs101/alerts_alert_escalations_and_server_arrays.html)
  - [Alert Escalations](/cm/rs101/alert_escalations.html)
  - [Alert System Flowchart](/cm/rs101/alert_system_flowchart.html)
- [Alerts based on Voting Tags](/cm/rs101/alerts_based_on_voting_Tags.html)
  - [Scalable Architecture Diagrams](/cm/rs101/scalable_architecture_diagrams.html)
  - [Understanding the Voting Process](/cm/rs101/understanding_the_voting_process.html)
- [Alert Specifications](/cm/rs101/alert_specifications.html)
  - [Create a New Alert Specification](/cm/rs101/create_a_new_alert_specification.html)
  - [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
  - [Import an Alert Specification](/cm/rs101/import_an_alert_specification.html)
  - [Inheritance of Alert Specifications](/cm/rs101/inheritance_of_alert_specifications.html)
  - [Managing Alert Specifications on Running Servers](/cm/rs101/managing_alert_specifications_on_running_servers.html)
