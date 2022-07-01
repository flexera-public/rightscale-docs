---
title: Cluster Compute Instances
layout: aws_layout_page
description: Cluster Compute Instances in AWS provide a high-performance network interconnect along with a high-performance CPU.
---

## Overview

Cluster Compute Instances provide a high-performance network interconnect along with a high-performance CPU. For example, the `cc2.8xlarge` instance type has quad-core processors with hyper-threading enabled (8 physical cores with 16 threads). When these instances are grouped together and launched in the context of an EC2 Placement Group, the instances benefit from a high bandwidth, non-blocking interconnect system, which makes them ideal for applications that require lots of network I/O. (e.g. High Performance Compute (HPC) applications and other demanding network-bound applications)

![diag-NoPlacementGroups-v1.png](/img/aws-diag-PlacementGroups.png)

## Current Limitations

Be sure to reference Amazon's documentation for current limitations. See [Cluster Compute Instance Concepts](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/concepts_cluster_compute.html).

## See also

- [EC2 Placement Groups](/cm/dashboard/clouds/aws/ec2_placement_groups.html)
- [Launch a Cluster Compute Instance](/cm/dashboard/clouds/aws/actions/ec2_placement_groups_actions.html#launch-a-cluster-compute-instance)
