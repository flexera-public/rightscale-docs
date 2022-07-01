---
title: Managing Alert Specifications on Running Servers
layout: cm_layout
description: Once a RightScale Server/Instance has been launched and it has inherited its Alert Specifications from the various levels, you can manage the status of those Alert Specifications.
---

Once a Server/Instance has been launched and it has inherited its Alert Specifications from the various levels, you can manage the status of those Alert Specifications.

For example, you can change an Alert Specification's status:

* **Enable/Disable** - Permanently disable or re-enable the Alert Specification. Only enabled Alert Specifications will be evaluated by the RightScale Alert Daemon and be allowed to create an Alert condition that either calls the associated Alert Escalation or changes a Server's voting tag for autoscaling purposes.
* **Quench (1hr off / 24hr off)** - If an Alert CTo quench an Alert Specification is to temporarily disable it so that it is no longer monitored by the RightScale Alert Daemon and can no longer trigger an Alert condition. You can quench an Alert Specification regardless of whether or not an Alert condition (highlighted by a red ball) exists.

## See also

* [Inheritance of Alerts Specifications](/cm/rs101/inheritance_of_alert_specifications.html)
