---
title: Firewall Configuration Ruleset
category: general
description: These are the rules firewall administrators should add in order to enable communication between the RightScale platform and private clouds, end-users and design asset repositories located inside the firewall.
---

## Overview

These are the rules firewall administrators should add in order to enable communication between the RightScale platform and private clouds, end-users and design asset repositories located inside the firewall.

This list is designed for ease of use and features a small list of network ranges in which all of our infrastructure is hosted. Not every address in every range requires traffic on every port.

## RightScale-Owned IP Networks

RightScale operates network infrastructure in several geographical regions to provide fault tolerance. Your instances generally communicate with infrastructure in a nearby geographical region, but may be redirected to remote regions during network or cloud outages.  If using RightScale's VPN Secure Connect option then these RightScale-Owned IP Networks below are used for the subnetworks specified inside the VPN tunnel.

> Updated: 2/9/2021

| Network/CIDR | Location |
| ------------ | -------- |
| 54.225.248.128/27 | US-East |
| 54.244.88.96/27 | US-West |
| 54.86.63.128/26 | US-East |
| 54.187.254.128/26 | US-West |

## All-Inclusive Firewall Rules

For each network operated by RightScale, your firewall will need to allow traffic to (and occasionally from) that network on several network ports.   The simplest configuration would be to allow all traffic to/from those network CIDR ranges.  Some users prefer a more granular approach, so the specific port ranges, and their intended purpose are outlined below.

### Egress Rules for Managed Instances

These are the ports and protocols required for your managed cloud instances to communicate with RightScale.

> Updated: 2/9/2021

| Protocol  | Port Range | Required for RightLink 6| Required for RightLink 10 | Notes        |
| --------- | ---------- | ----------------------- | ------------------------- | ------------ |
| https     | tcp/443    | Yes                     | Yes                       | Access to the RightScale API and UI.  Communication with RightScale management system is performed over HTTPS. |
| http      | tcp/80     | Yes                     | Optional                  | HTTP access to RightScale Package Mirrors, typically used by RightLink 6.x and below. |
| ntp       | udp/123    | Yes                     | Optional                  | Public NTP servers made available to RightScale instances.  Required for RL 6.2.1 and below, optional for RL 6.3 and above, and all RL 10.x |
| collectd  | udp/3011   | Yes                     | No                        | Monitoring data using the UDP collectd protocol, used by RightLink 6.x and below. |

### Ingress Rules for Private OpenStack-based Clouds

!!info*Note* No Ingress rules are required for VMware vSphere Clouds, Universal Cloud Appliance (UCA), or AWS VPC.

> Updated: 9/13/2016

| protocol | Port Range                 | Notes |
| -------- | -------------------------- | ----- |
| https    | tcp/443 (but configurable) | RightScale requires access to the private cloud API ports, which are typically hosted on tcp/443, but may use any port assigned by the cloud administrators. |



### Ingress Rules for Internally-Hosted Design Asset Repositories

> Updated: 9/13/2016

If you design your own Chef ServerTemplates and host a cookbook repository behind a firewall, you will need to ensure that RightScale can access your repository. The port and protocol details vary depending on the kind of repository (Git or Subversion) and, in the case of Git, your chosen transport (git+ssh, https, or git binary).

The origin IP for all RightScale Git or Subversion clients will fall into one of the published IP ranges above.


| Protocol | Port Range | Notes |
| -------- | ---------- | ----- |
| ssh      | tcp/22     | Standard port number for SSH, usually used for GIT+SSH access.  The port number exposed is controlled by the respository administrator. |
| https    | tcp/443    | Startard poer number for HTTPS, usually used for GIT+HTTPS or SVN repositories.  The port number exposed is controlled by the respository administrator. |


### Egress Rules for End-User Access to RightScale Web Application

All communication with the RightScale sites are done via HTTPS.  HTTP access is not required, and attempts to connect to the platform via HTTP are redirected to HTTPs when possible.

### Egress Rules (for UI and API Access)

> Updated: 9/13/2016

| Protocol  | Port Range | Notes |
| --------- | ---------- | ----- |
| https     | tcp/443    | Access to the RightScale API and UI.  Communication with RightScale management system is performed over HTTPS. |
