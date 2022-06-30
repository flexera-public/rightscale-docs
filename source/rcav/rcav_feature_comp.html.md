---
title: RCA-V Feature Comparison
description: View and compare the various features and capabilities of each version of the RightScale Cloud Appliance for vSphere (RCA-V).
---

!!warning*Warning!* This topic is currently under development.

The following table outlines the supported features and capabilities of the currently available RCA-V versions.

| RightScale Resource | vScale Resource | Purpose | RCA-V v1.3 | RCA-V v2.0 |
| ------------------- | --------------- | ------- | ---------- | ---------- |
| Cloud Accounts | None - implemented in the appliance | Separate tenants within a vCenter implementation | X |  |
| Datacenters / Zones | Cluster within a datacenter | Fault tolerance separation (datacenters are intended to fail independently) | X |  |
| Images | VM Templates | Immutable images from which instances are launched | X |  |
| Instance Types | Specific VM settings for cpu, memory, etc. | Standardized virtual machine configurations | X |  |
| Instances | VMs | Running virtual servers | X |  |
| Subnets | Networks | Allows instances to be connected to a network | X |  |
| IP Addresses | None | Support static and dynamic IP address assignments | X |  |
| SSH Keys | None | Enables users to SSH into instances | X |  |
| Volumes | VMDKs |  Allows block storage devices to be dynamically mounted on instances. | X |  |
| Network Interfaces | Network Virtual Devices | Allows instances to be connected to multiple subnets. | | |
| Misc. Network Concepts | NSX | May allow networks and network configurations to be managed directly. | | |
