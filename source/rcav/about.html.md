---
title: About RightScale Cloud Appliance for vSphere (RCA-V)
description: The RightScale Cloud Appliance for vSphere is a lightweight virtual software appliance that lets you to manage your vSphere environment as if it were a private cloud.
---

The RCA-V is a stateless web service that presents a compute cloud API on top of of VMware vSphere environment. Its purpose is to enable the RightScale Cloud Management Platform to manage a vSphere installation (or designated sub-portion) as if it were an on-premise cloud environment (resource pool) similar to public cloud IaaS offerings such as Amazon Web Services or Google Cloud Platform, or private clouds such as OpenStack.

The appliance is a minimal layer on top of vSphere that serves three main purposes:

* Provides a simple REST-based cloud API
* Enforces a set of policies, most of which are actually implemented by vSphere
* Creates a multi-tenant environment where a tenant can only be associated with a single RightScale account.

!!info*Note:* Because RCA-V is designed to be stateless, you can run multiple appliances in parallel for fault tolerance. In such cases, both appliances must be able to communicate with each other.

[[Current RightScale Cloud Appliance for vSphere (RCA-V) Versions
Two separate versions of the RCA-V are currently supported and generally available. Follow the links below to learn more about each of these versions, their supported features, and procedures for upgrading.

<!-- * [Feature Comparison Chart](/rcav/rcav_feature_comp.html) -->
* [RCA-V Version 3.0](/rcav/v3.0/index.html)
* [RCA-V Version 2.0(Deprecated)](/faq/end_of_life_end_of_service.html#schedule-rcav)
* [RCA-V Version 1.3(Deprecated)](/faq/end_of_life_end_of_service.html#schedule-rcav)
* [Upgrading to v3.0](/rcav/v3.0/rcav_upgrade_to_3_0.html)
]]
