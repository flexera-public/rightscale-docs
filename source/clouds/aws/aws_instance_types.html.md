---
title: AWS EC2 Instance Types
layout: aws_layout_page
description: RightScale is dedicated to providing powerful and intuitive solutions and ways to take full advantage of Amazon Web Services. EC2 offers a variety of 32-bit and 64-bit instance types
---


## EC2 Instance Types

EC2 offers a variety of 32-bit and 64-bit instance types. Be sure to choose a size that best meets your requirements:

* **Standard Instances** - Best if you are running an application on a server and will have more CPU Memory. Standard Instances are broken up into M4 and M5 instances. M4 instances come at a lower cost but also provide less processing performance. M5 standard instances provide high CPU and memory performance and are best suited for high traffic content management systems, encoding, and memcaching.
* **Micro Instances** - Provides a small amount of consistent CPU resources that can increase CPU capacity in small burst. Best suited if you want lower throughput for applications and websites.
* **High-Memory Instances** - Best if you have memory-intensive, high throughput workloads like databases, memory caching, and rendering.
* **High-CPU Instances** - Best for your compute-level intense applications that will require more CPU resources than memory (RAM).
* **Cluster Compute Instances** - Provides increased network-performance for High Performance Compute (HPC) applications.
* **Cluster GPU Instances** - Through the use of parallel computing power, provides low latency and high throughput to increase application performance.
* **High I/O Instances** - Best for database workloads (provides high levels of CPU, memory, and network performance).

See Amazon's [EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/) for the current instance pricing structure. You can also use the [Simple Monthly Calculator](http://calculator.s3.amazonaws.com/calc5.html?) to estimate your usage costs.

### EBS Optimized Instance

Amazon charges an additional fee to use an Optimized Instance type. Although this instance type is not necessarily required to utilize the functionality of Provisioned IOPS - an Elastic Block Storage (EBS) volume type for running persistent, high-performance, and high-availability databases - it can help communication between EC2 and EBS. Performance benefits can be seen if you're using high amounts of network bandwidth and disk bandwidth at the same time. Additionally, Amazon guarantees that when a Provisioned IOPS volume is attached to an Optimized Instance, the volume will perform within 10% of their provisioned performance 99.9% of the time.

See Amazon's [Instance Types](http://aws.amazon.com/ec2/instance-types/) page for descriptions of the currently available AWS Instance Types with EBS optimization.
