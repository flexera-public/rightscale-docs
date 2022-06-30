---
title: Connect a Firewalled Private Cloud to RightScale
layout: cm_layout
description: The RightLink management agent makes outbound HTTP(S) connections to the RightScale infrastructure in order to receive configuration instructions.
---
## Overview

The RightLink management agent makes outbound HTTP(S) connections to the RightScale infrastructure in order to receive configuration instructions. Optional RightScale features such as monitoring and frozen package repositories make outbound connections using other protocols.

When RightLink resides behind a firewall that performs egress filtering, the firewall must be configured to allow this outbound traffic.

### Prerequisites

This information applies to the following environment:

- Private clouds whose API endpoint resides behind a firewall
- RightScale management requests sent to private cloud APIs

This information **does not apply**  to:

- Compute instances that run inside private clouds

Please review the firewall rules you will need to set up in order to enable communication between the RightScale platform and private clouds, end-users, and design asset repositories located inside the firewall as specified in [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).

## Goal

After completing this how-to, you will have configured your network firewall to allow API requests to your private cloud. You will be able to [register your cloud](/cm/dashboard/register_a_private_cloud_with_rightscale.html) with the RightScale platform, [add your cloud](/cm/dashboard/add_a_cloud_account_to_a_rightscale_account.html) to one or more RightScale accounts, and use our UI or API to make cloud-management requests.

## Procedure

### Note RightScale-Operated Networks

RightScale operates network infrastructure in several geographical regions to provide fault tolerance. Your instances generally communicate with infrastructure in a nearby geographical region, but may be redirected to remote regions during network or cloud outages.

| Network/CIDR | Location | Description |
| ------------ | -------- | ----------- |
| 54.225.248.128/27 | US-East | us-3 cluster and island1 resources |
| 54.244.88.96/27 | US-West | us-4 cluster and island10 resources |
| 54.86.63.128/26 | US-East | additional island1 resources |
| 54.187.254.128/26 | US-West | additional island10 resources |

### Enable Cloud API Requests

Your private cloud's API is normally exposed as an HTTPS endpoint on port tcp/443 though the protocol and port can change depending on how you have configured the cloud. RightScale must be able to make API requests to this endpoint from each RightScale-operated network range.

Assuming that your cloud is listening on port 443, you will need to create the following ingress rules:

| Source Network/CIDR | Ports | Purpose |
| ------------------- | ----- | ------- |
| 54.225.248.128/27 | configurable (usually tcp/443) | Receive API requests from us-3 |
| 54.244.88.96/27 | configurable (usually tcp/443) | Receive API requests from us-4 |
| 54.86.63.128/26 | configurable (usually tcp/443) | Receive API requests from us-3 |
| 54.187.254.128/26 | configurable (usually tcp/443) | Receive API requests from us-4 |

!!info*Note:* No Ingress required for VMware vSphere Clouds or AWS VPC

### What's Next

Your firewall has been configured to allow RightScale to make API requests. You can now connect it to RightScale and add it to one or more accounts.

- [Register a Private Cloud with RightScale](/cm/dashboard/register_a_private_cloud_with_rightscale.html)
- [Add a Cloud Account to a RightScale Account](/cm/dashboard/add_a_cloud_account_to_a_rightscale_account.html)
