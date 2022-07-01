---
title: Inheritance of Alert Specifications
layout: cm_layout
description: Similar to inputs, alerts (or alert specifications) in RightScale also conform to an inheritance hierarchy where the alert specification that is actually applied to a server depends on where it is defined.
---

## Introduction

Similar to inputs, alerts (or alert specifications) also conform to an inheritance hierarchy where the alert specification that is actually applied to a server depends on where it's defined. The following diagrams and explanations will help you understand where you should define your alerts.

You can add/remove alerts at the following levels.

* ServerTemplate
* Server Array
* Server (Instance)

The actual alerts that are applied to a running server will depend on where they're defined.

## Servers

A **Server** (in a Deployment) first inherits its Alert Specifications from its ServerTemplate. However, at the Server level you can make further modifications to the Alert Specifications. If there is a running (active) server, you can also add/remove Alert Specifications under the "Current" Server's Alerts tab. If you make changes to the "Next" Server, those Alert Specifications will be applied the next time the server is launched or relaunched (if there's already a "Current" Server running).

![cm-alerts-inheritance-servers.png](/img/cm-alerts-inheritance-servers.png)

## Server Arrays

A **Server Array** will also first inherit its Alert Specifications from its ServerTemplate. However, at the Server Array level you can make further modifications to the Alert Specifications to affect which Alert Specifications will actually be inherited by new Instances that are launched into the array. Once an Instance has been launched and is running, you can also make modifications to its Alert Specifications, however those changes will only be applied to the current running instance. (Unlike a Server in a Deployment, you cannot Relaunch an Instance in a Server Array.)

![cm-alerts-inheritance-arrays.png](/img/cm-alerts-inheritance-arrays.png)

## Best Practices

Typically, you want to define your Alert Specifications at the ServerTemplate level. Unlike Inputs, you cannot define Alert Specifications at the Deployment level. Because the type of Alert Specification that you define typically depends on the functionality of the Server, you should define them at the ServerTemplate level. For example, you'll probably have a different set of Alert Specifications for an HAProxy Load Balancer than you would for a MySQL Database Server. However, if you want the same Alert Specification to be inherited by all Servers in a Deployment, you'll need to manually add them to each ServerTemplate or Server. Although you have the flexibility to add Alert Specifications at the Server level, it's best to do so for development and testing purposes only.

## See also

* [Import an Alert Specification](/cm/rs101/import_an_alert_specification.html)
