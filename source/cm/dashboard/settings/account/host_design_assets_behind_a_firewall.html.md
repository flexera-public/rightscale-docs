---
title: Host Design Assets Behind a Firewall
layout: cm_layout
description: RightLink is capable of importing Chef cookbooks from Git and Subversion repositories. If you host your own Git or Subversion servers, you may need to configure your firewall to allow inbound requests from RightScale.
---
## Overview

RightLink is capable of importing Chef cookbooks from Git and Subversion repositories. If you host your own Git or Subversion servers, you may need to configure your firewall to allow inbound requests from RightScale.

### Prerequisites

This information applies to the following environment:

* RightScale customers who use Chef-based ServerTemplates
* Chef cookbook repositories (git or Subversion) that reside behind a firewall

This information **does not apply** to:

* RightScale customers who use RightScript-based ServerTemplates
* Chef cookbook repositories hosted on the Internet (via GitHub, BitBucket or similar)

## Goal

After completing this how-to, you will have configured your network firewall to allow RightScale access to your private repositories. You will be able to import Chef cookbooks for use with the ServerTemplates you build.

## Procedure

### Note RightScale-Operated Networks

RightScale operates network infrastructure in several geographical regions to provide fault tolerance. Your instances generally communicate with infrastructure in a nearby geographical region, but may be redirected to remote regions during network or cloud outages.

| Network/CIDR | Location | Description |
| ------------ | -------- | ----------- |
| 54.225.248.128/27 | US-East | us-3 cluster and island1 resources |
| 54.244.88.96/27 | US-West | us-4 cluster and island10 resources |
| 54.86.63.128/26 | US-East | additional island1 resources |
| 54.187.254.128/26 | US-West | additional island10 resources |

### Enable SCM Repository Requests

You will need to add ingress rules that allow RightScale infrastructure to connect to your design asset repository:

| Source Network/CIDR | Ports | Purpose |
| ------------------- | ----- | ------- |
| 54.225.248.128/27 | configurable (usually tcp/22 or tcp/443) | Receive SCM repository requests from us-3 |
| 54.244.88.96/27 | configurable (usually tcp/22 or tcp/443) | Receive SCM repository requests from us-4 |
| 54.86.63.128/26 | configurable (usually tcp/22 or tcp/443) | Receive SCM repository requests from us-3 |
| 54.187.254.128/26 | configurable (usually tcp/22 or tcp/443) | Receive SCM repository requests from us-4 |

### What's Next

You can now design ServerTemplates that use Chef cookbooks imported from your private repository.

* [Import Chef Cookbooks](/cm/dashboard/design/repositories/repositories_actions.html#import-cookbooks-from-a-repository)
