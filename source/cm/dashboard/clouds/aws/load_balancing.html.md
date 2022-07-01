---
title: Load Balancing
layout: cm_layout
description: Amazon's Elastic Load Balancing (ELB) distributes incoming traffic requests amongst multiple server instances. Servers can be located in multiple availability zones.
---
## Overview

!!info*Note:* RightScale continues to support a HAProxy software load balancing solution in addition to AWS Elastic Load Balancing (ELB).

**Amazon's Elastic Load Balancing (ELB)** distributes incoming traffic requests amongst multiple server instances. Servers can be located in multiple availability zones. As a best practice for mission critical applications, configuring your Elastic Load Balancer to service more than one zone is recommended. Amazon promises to send new requests to the least loaded server. Therefore, you may notice unpredictable traffic patterns across your application tier.

If you have valid Amazon Web Services (AWS) EC2 credentials, you are automatically granted the Elastic Load Balancer service. No additional service sign-ups are required, however additional charges do apply. See [Amazon](http://aws.amazon.com/elasticloadbalancing/) for current pricing information.

## Actions

* [Create an AWS Elastic Load Balancer](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#create-an-aws-elastic-load-balancer)
* [Add an Instance to an AWS Elastic Load Balancer](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#add-an-instance-to-an-aws-elastic-load-balancer)
* [Remove an Instance from an AWS Elastic Load Balancer](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#remove-an-instance-from-an-aws-elastic-load-balancer)
* [Add Listeners to an Elastic Load Balancer](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#add-listeners-to-an-elastic-load-balancer)
* [Create a New Sticky Session](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#create-a-new-sticky-session)
* [Edit an AWS Elastic Load Balancer Configuration](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#edit-an-aws-elastic-load-balancer-configuration)
* [Delete an AWS Elastic Load Balancer Configuration](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#delete-an-aws-elastic-load-balancer-configuration)

## Further Reading

* [AWS Elastic Load Balancing](http://aws.amazon.com/elasticloadbalancing/)
* [AWS Elastic Load Balancing Developer Guide](http://docs.amazonwebservices.com/ElasticLoadBalancing/latest/DeveloperGuide/)
