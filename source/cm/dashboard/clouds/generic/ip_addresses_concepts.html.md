---
title: About IP Addresses
description: Static, public IP Address which can be assigned to an instance in the RightScale Cloud Management Dashboard.
---

## Overview

Static, public **IP Address** which can be assigned to an instance. Attachable IP addresses typically come from a pool offered by the cloud infrastructure, hence assigning or reassigning to a different instance does not have severe lag times normally associated with DNS propagation.

**Fields**

* **Name** - Name of the Attachable IP Address. This is typically the same as the actual IP address that was pulled from a pool of addresses. Click the hyperlink to see the address show page, revealing additional information. Although the Name can be any string, the default is to display the IP address. That is, if not explicitly set we will set it to the IP Address.
* **Address** - Dot notation IP address that can be used by an instance. Use the link to view the IP in a browser tab/window.
* **Instance** - The Instance using the Attachable IP Address. If this is blank, the address has not been assigned to an instance. If the instance is a Server, the name of the Server is displayed.
* **Resource ID** - Resource Unique IDentifier for the Attachable IP Address.

**Actions**

* **Delete** - Deletes an individual Attachable IP Address from the pool. You will be prompted for confirmation prior to deletion.

!!info*Note:* Although warned first, you can delete an Attachable IP that is in use. (That is, an IP Address that was previously associated with an instance.)

## Actions

* [Create a New (Public) IP Address](/cm/dashboard/clouds/generic/ip_addresses_actions.html)
* [Assign a Public IP Address](/cm/dashboard/clouds/generic/ip_addresses_actions.html#assign-a-public-ip-address)

## Further Reading

* [What is HAProxy and how does it work?](/faq/What_is_HAProxy_and_how_does_it_work.html)
* [How can I use OpenVPN with RightScale?](/faq/How_can_I_use_OpenVPN_with_RightScale.html)
