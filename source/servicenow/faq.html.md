---
title: RightScale Application for ServiceNow FAQ
description: Frequently asked questions about the RightScale Application for ServiceNow.
alias: ss/guides/sn_integration_faq.html
---

## Frequently Asked Questions

### What is the minimum ServiceNow version required to use this application?

ServiceNow Version      |  Minimum RightScale Integration Version
------------------------|-----------------------------------------
Fuji (Patch2-Hotfix1 or later) |  v1.0
Geneva                  |  v1.1.11
Helsinki                |  v1.1.11
Istanbul                |  v1.1.13 ([Update set only](/servicenow/releases.html))
Jakarta                 |  v1.1.13 (available in ServiceNow Store)
Kingston                |  v1.1.13 (available in ServiceNow Store)
London                  |  v1.1.13 ([Update set only](/servicenow/releases.html))

[RightScale Integration Releases](releases.html)

### Do I need any additional ServiceNow modules to use this application?

No, no additional modules are needed to use the ServiceNow integration.

### What does RightScale cloud discovery provide?

The cloud discovery feature of the RightScale integration provides information about instances that are running in your connected cloud accounts. This information is generally infrastructure-related; instance types, IP addresses, images, etc. For a full list of attributes available, see [the integration overview page](overview.html). The information made available by RightScale is placed into import sets and can then be imported into the System CMDB.

### How does RightScale cloud discovery compare to the ServiceNow Discovery module?

The RightScale cloud discovery feature generally provides infrastructure related information while the ServiceNow Discovery module provides primarily application information. RightScale discovery provides information gathered from the cloud provider and from the RightScale system, while ServiceNow discovery inspects the network and shells into machines to inspect the software configuration. You can find more information on ServiceNow discovery on this <a href="http://wiki.servicenow.com/index.php?title=Discovery", target="blank">ServiceNow wiki page</a>.

### Is RightScale cloud discovery integrated with ServiceNow Discovery?

The RightScale application does not natively provide integration with ServiceNow Discovery, but it can be easily configured. In order to integrate the RightScale discovery feature with ServiceNow Discovery, there must be a common unique identifier between the two systems. Generally, the IP address of the instance can be used as this common identifier and can be used to combine information from both RightScale and ServiceNow.
