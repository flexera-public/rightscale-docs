---
title: Active vs. Inactive Servers
layout: cm_layout
description: Describes the difference between Active and Inactive Servers when managed through the RightScale Cloud Management Platform including a summary of RightScale Server states.
---

## Overview

A server either describes an actual instance in the cloud that was created from a ServerTemplate (active server) or how an instance will be configured in the future when the server is launched from the RightScale Dashboard or API (inactive server).

It's important to understand that an active server is not always an operational server in the sense that it has an equivalent physical piece of hardware that's been incarnated at the cloud level. For example, if you're using Spot EC2 instance types, you may have an "active" server that's in the bidding state.

To view all active and inactive servers in a RightScale account, go to Manage -> Servers.

The table below summarizes when a server is classified as active or inactive according to the RightScale Server States that are displayed in the Dashboard. See [Server States](server_states.html)

| RightScale Server States | Active Server | Inactive Server |
| ------------------------ | ------------- | --------------- |
| bidding\* | x | &nbsp; |
| pending | x | &nbsp; |
| booting | x | &nbsp; |
| configuring | x | &nbsp; |
| operational | x | &nbsp; |
| decommissioning | x | &nbsp; |
| shutting-down | x | &nbsp; |
| stranded (booting or decommissioning) | x | &nbsp; |
| stopping\* | x | &nbsp; |
| stopped\* | &nbsp; | x |
| provisioned | &nbsp; | x |
| terminated | &nbsp; | x |

\* Applies to AWS Spot (not On-Demand) instance types only.

How you manage Servers depends largely on whether a server is active or inactive. For more details on how to manage servers, see the following links:

* [Managing Inactive (Next) Servers](managing_inactive_next_servers.html)
* [Managing Active (Current) Servers](managing_active_current_servers.html)
