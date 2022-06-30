---
title: Why does RightScale NOT see the resource that was created in the cloud
category: general
description: This article describes the principles of adaptive backoff.
---

### Overview

In certain cases, you may find that a resource exists in the cloud but is not being shown in RightScale. This is due to our "adaptive backoff" for resource discovery -- RightScale will not query for new resources if there has not been a new resource created from RightScale for over 30 days in that cloud account.

### Which clouds does this apply to
* All clouds

### What is considered a resource
* Everything except instances

### When will RightScale discover my resource in the CM Dashboard
* If a new resource is created, the resource will show up in the RightScale dashboard within 18 hours. 

### How to get RightScale to recognize resources faster
* Create/delete anything via RightScale API or Cloud Management Dashboard in that cloud account (for example: create a security group via RightScale)
