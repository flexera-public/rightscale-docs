---
title: Can I get a list of operational IP Addresses that RightScale uses for access control purposes?
category: general
description: If you are setting up your own private cloud so that its resources can be managed through RightScale's Cloud Management Platform, you must configure your network with the appropriate firewall rules.
---

## Background

If you are setting up your own private cloud so that its resources (e.g. instances, volumes, etc.) can be managed through RightScale's Cloud Management Platform (Dashboard and API), you must configure your network with the appropriate firewall rules to allow the necessary communication of both inbound and outbound connections between RightScale's gateway and your private cloud's API endpoint.

In order to provide better support for private clouds, RightScale will occasionally make changes to the list of hostnames and IP addresses in order to provide tighter security control when using RightScale's services.

## Answer

### List of IP Blocks

A list of all IP blocked used by RightScale is available here in our [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html)

### Additional Notes

On September 4, 2013, RightScale started to consolidate IPs to fixed load balancers for outbound private cloud connectivity.

For more information regarding the ports and their corresponding functionality in regards to RightScale please refer to  [RightLink Ports and Protocols.](http://support.rightscale.com/12-Guides/RightLink_6/RightLink_Legacy_Versions/RightLink_5.9/Advanced_Topics/RightLink_Ports_and_Protocols_-_v5.9)
