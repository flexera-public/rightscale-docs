---
title: EC2 Placement Groups
layout: cm_layout
description: Placement Groups are logical groupings or clusters of instances in the selected AWS region. Placement groups are specifically used for launching cluster compute instance types.
---

## Overview

!!info*Note:* This feature is only compatible for Legacy Cloud Platform users. If you are on Unified Cloud Platform, you cannot use this feature as it has been deprecated. If you are unsure of whether you have access, contact your account manager or support@rightscale.com

**Placement Groups** are logical groupings or clusters of instances in the selected AWS region. Placement groups are specifically used for launching cluster compute instance types. (e.g. cc2.8xlarge)

**Cluster Compute Instances** provide a large amount of CPU. For example, the cc2.8xlarge instance type has quad-core processors with hyper-threading enabled (8 physical cores with 16 threads). When these instances are grouped together and launched in the context of an EC2 Placement Group, the instances benefit from a high bandwidth interconnect system, which makes them ideal for applications that require lots of network I/O. (e.g. High Performance Compute (HPC) applications and other demanding network-bound applications)

Things to consider:

* Maximum of 8 cluster compute instances per AWS account. Requests to AWS can be made to increase this limit.
* AWS recommends launching all the instances within the cluster placement group at the same time.

![cm-placement-groups.png](/img/cm-placement-groups.png)

## Actions

* [Create a New Placement Group](/cm/dashboard/clouds/aws/actions/ec2_placement_groups_actions.html#create-a-new-placement-group)
* [Launch a Cluster Compute Instance](/cm/dashboard/clouds/aws/actions/ec2_placement_groups_actions.html#launch-a-cluster-compute-instance)

## Further Reading

* [AWS High Performance Computing](http://aws.amazon.com/hpc/)(Cluster Compute Instances)
* [Linux GPU Instances](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using_cluster_computing.html)
