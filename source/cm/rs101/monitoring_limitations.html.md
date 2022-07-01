---
title: Monitoring Limitations
layout: cm_layout
description: Describes the limitations associated with monitoring data in RightScale.
---

## Overview

While the monitoring system is designed to scale without limits, certain per-instance limits exist to protect users from mistakes and to provide fairness between users. The following limits exist within the RightScale monitoring platform

### Number of Active Metrics Limit

**1,000 active metrics per instance.**

The monitoring system stores a max of 1000 active metrics per server, additional metrics are ignored. An active metric is defined to be a metric that has sent the monitoring system some data in the past 24 hours. The 1,000 active metrics that are stored are chosen on a first-come-first-serve basis.

If a host has more than 1,000 metrics and one of them is determined to be inactive, the monitoring system will automatically remove the metric and the metric will no longer be accessible. The slot opened by the removal of the inactive metric will be filled by the first ignored metric that sends the monitoring system data after the slot is opened.

### Number of Data Points Every Hour Limit

**400 data points per metric per hour**

The highest resolution stored by the monitoring system is one data value per metric every 20 seconds. This equates to 200 data values every 66.6 minutes, which is the interval at which the highest resolution data values are aggregated. The monitoring system will allow up to 400 data values to be stored for each 66.6 minute period to provide a margin of error, but it will drop any values sent beyond that. For example, if a user sends 60 data values every minute for a metric, the monitoring system will only store data for the first 6-7 minutes of each 66.6 minute period **resulting in gaps in graphs and data queried**.
