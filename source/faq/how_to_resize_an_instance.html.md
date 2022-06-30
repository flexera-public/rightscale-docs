---
title: How can I resize an instance?
category: general
description: How can I change the instance type of an instance
---

## Question

Is it possible to change the instance type of an existing instance? If so, how?

## Answer

Changing the instance type of an existing instance is something that you can do from RightScale if it is supported on the cloud in which the instance is running. All major public cloud providers support this behavior. In all cases, you must first `stop` the instance in question, then changes its instance type, then start it again. 

For more details on behavior and limitations for each cloud, refer to the cloud provider documentation:
* [AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-resize.html)
* [Google](https://cloud.google.com/compute/docs/instances/changing-machine-type-of-stopped-instance)
* <a nocheck href="https://azure.microsoft.com/en-us/blog/resize-virtual-machines/">Microsoft Azure</a>

**Automating instance type changes**

The steps above can be automated by leveraging the Cloud Management API 1.5 directly, or via Cloud Workflow code. The relevant API calls to the above steps are:
* [Stop an instance](https://reference.rightscale.com/api1.5/resources/ResourceInstances.html#stop)
* [Update an instance's properties](https://reference.rightscale.com/api1.5/resources/ResourceInstances.html#update)
* [Start an instance](https://reference.rightscale.com/api1.5/resources/ResourceInstances.html#start)

Sample Cloud Workflow (RCL) code for the above is below, assuming that `@instance` refers to the instance in question:
~~~ ruby
@instance.stop()
sleep_until(@instance.state, /(provisioned|stopped)/)
@instance.update('instance'=>{'instance_type_href'=>'/api/instance_types/1234'})
@instance.start()
~~~

**Questions? Concerns?**

Call us at **(866) 787-2253** or feel free to send in a support request from the RightScale dashboard (Support > Email).
