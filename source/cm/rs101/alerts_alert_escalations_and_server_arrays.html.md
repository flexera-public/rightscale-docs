---
title: Alerts, Alert Escalations, and Server Arrays
layout: cm_layout
description: Understanding the relationship between alerts, escalations, and server arrays in the RightScale Cloud Management Platform.
---

## Objective

The purpose of this document is to explain the relationship between alerts, alert escalations, and server arrays.

## Overview

In order to truly understand RightScale's alert and monitoring system and how you can use it to automatically perform various actions on your setup, it's important to understand each component in the context of the others. The alert and monitoring system is comprised of the following key components. Each component is discussed in more detail here as well.

* [Monitoring](/cm/rs101/monitoring_system.html)
* [Server Arrays](/cm/rs101/server_array.html)
* [Alert Escalations](/cm/rs101/alert_escalation.html)
* [Alerts](/cm/rs101/alerts.html)

Follow the [How do I set up Autoscaling?](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags) tutorial to learn how to configure a scalable alert-based array.

## Scalable Architecture Diagrams

First, we'll show you some common scalable alert-based architectures.

Architectures for front-end, client-facing sites. A common basic scalable setup is a four-server setup featuring front-end servers that act as both load balancers and application servers.

![cm-server-setup-website-array.png](/img/cm-server-setup-website-array.png)

For larger websites, you might have two front-end servers that are used strictly as load balancers, so you can expand the number of application servers underneath.

![cm-scalable-diagram.gif](/img/cm-scalable-diagram.gif)

## Monitoring

RightScale's Monitoring system serves as the backbone for Alerts and Alert Escalations. Before you can use any alerts, you must first enable each server for monitoring. If you are not using one of RightScale's ServerTemplates, you need to enable all of your servers for monitoring. See [Setting up collectd](/cm/rs101/setting_up_collectd.html)

**Important!** Alerts only work on servers that have monitoring enabled.

## Server Arrays

A **Server Array** is a group of mostly identical instances where the number of instances in the array varies (i.e., scales) over time in response to changing factors. RightScale offers both alert and queue-based arrays. Alert-based arrays are most commonly used for scaling a pool of application servers.

When you create an array, you need to associate it with a particular deployment. Multiple arrays can be associated with the same deployment. For example, you might have an alert-based array for scaling the number of application servers and a queue-based array for scaling worker instances for back-end batch processing.

![cm-site-grid-array-diagram.png](/img/cm-site-grid-array-diagram.png)

In some ways, you have the same level of control with server arrays as you do with deployments. For example, you can define common inputs and alerts that will be inherited by all servers in the array or run RightScripts on server instances.

When you create a server array you must define **how** you want that pool of server resources to scale-up and scale-down. For example, you can define the minimum and maximum number of servers that can be launched in an array, which availability zones you want server instances to be launched into, as well as basic server launch options that will be used for all server instances including ServerTemplate, SSH Key, Security Group, instance type, and machine image (RightImage). The server array's scaling parameters also dictate how many servers should be launched when scaling-up or how many servers to shutdown when scaling-down. You can also specify different rates for scale-up and scale-down actions. For example, you might want to scale-up quickly by adding four servers at a time, whereas you might take a more conservative approach when scaling-down by terminating only two servers at a time.

When scaling-up, you must define the decision threshold (Default: 51%) at the server array level, which defines the percent of servers that must be voting to `grow` or `shrink` before the array is allowed to scale. This threshold helps prevent an outlier server from unnecessarily scaling the array. For example, one of the application servers might get hit with an odd spike, but the rest of the servers are operating normally. Instead of one server making the decision to scale, you can set a 51% decision threshold to ensure that you only scale-up when a majority of the servers are experiencing the same alert condition. Be sure to check out the voting section that follows so that you thoroughly understand the flow of the voting actions.

If you have predictable scaling patterns, you can also configure a daily/weekly scaling schedule where your array automatically grows/shrinks at predefined times. See [Server Array Schedule](/cm/dashboard/manage/arrays/arrays_concepts.html#server-array-schedule) and [Server Arrays](/cm/dashboard/manage/arrays/arrays_concepts.html#manage-server-arrays) for more information.

## Alerts

An alert (specification) defines the conditions under which an alert is triggered and an alert escalation is called. Several of the most common alerts have already been predefined for your convenience and are already included in many of our ServerTemplates. You can either create an alert from scratch (see [Create an Alert](/cm/rs101/create_a_new_alert_specification.html)) or import an alert from one of the following locations:

* Default (RightScale Alerts) - A list of commonly used alerts configured by RightScale
* Server - An alert that's defined at the Server level
* Private/Imported ServerTemplate - An alert that's defined at the ServerTemplate level

To create your own custom alerts, see [Create a Custom Alert](/cm/rs101/create_a_custom_alert_specification.html).

An alert must be assigned at either the ServerTemplate, Server, or Server Array level.

![cm-assign-alerts.png](/img/cm-assign-alerts.png)

When you create an alert you need to associate it with a particular alert escalation. You can only assign one alert escalation to an alert. However, you can create multiple alerts that monitor the same metric and then vote for a different alert escalation. Similarly, you can have multiple alerts that call the same alert escalation. For example, you might have several alerts that point to the 'default' alert escalation.

## See also

* [Understanding the Voting Process](/cm/rs101/understanding_the_voting_process.html)
* [How do I set up Autoscaling?](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags)
