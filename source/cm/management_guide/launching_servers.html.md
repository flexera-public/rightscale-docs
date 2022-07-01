---
title: Launching Servers
layout: cm_layout
description: Guidelines for launching your virtual machine instances (servers) in RightScale using Amazon Machine Images (AMIs), RightScale ServerTemplates, or the RightScale API.
---
## Overview

There are several different ways that you can launch servers with RightScale.

## Launch a Server from an AMI

Many Clouds offer self-service tools where anyone can launch and terminate servers on-demand. Perhaps you've already launched a server on EC2 using one of the public AMIs (Amazon Machine Image) or bundled an image before. So, you might be wondering, *"How does RightScale make my life easier and better?"*

To truly understand the value of RightScale, let's compare the two most popular ways of launching instances in the Cloud.

### Option 1: Bundle and Hack Images

Although it's pretty easy to launch a new instance on EC2 using one of Amazon's AMIs, you'll soon discover that you will waste a lot of time and effort trying to maintain this process going forward, not to mention the fact that it's very prone to human error. At RightScale, we strongly believe that Option 2 is a far better solution for launching servers in the Cloud.

1. Find an AMI of your choice and launch a new instance. Wait for the instance to boot and become operational.
2. Modify the instance. Keep track of your changes. Test.
3. Bundle the instance to create a new image. Wait for the bundling to complete.
4. Launch an instance using the new image. Wait for the instance to boot and become operational.
5. Test again. If something is wrong, go back to Step 1 or 2. If things look good, go to Step 6.
6. Launch additional instances for all servers that use the new image.
7. Move data from old instances to new instances and switch over your DNS.

This process may seem tolerable initially, but it's definitely not the most reliable, reproducible, or scalable process. It's a very manual process that will waste a lot of time, as well as cause a lot of headaches and frustrations. Imagine trying to keep track of all your changes, revert back to older versions, update software versions, etc. Images are also very static. Even if you need to make a small change to your code, you'll have to repeat the whole process all over again. As you can see, performing even the smallest change can easily consume several hours of your day. So, at the end of the day, what is going to yield the highest ROI? Spending the majority of your time configuring your system or developing new features for your application?

If you want to run a solid production-level deployment in the Cloud, you'll need tools that will provide a higher level of control, flexibility, and automation.

### Option 2: RightScale with ServerTemplates

RightScale developed ServerTemplates to be a real world solution for designing and managing production-level deployments in the Cloud. In the Cloud, it's important to think of servers as dynamic objects that you can configure and multiply automatically, instead of as static boxes.

Our ServerTemplates are designed to give you the control and flexibility that you need to create a system in the Cloud that is

* Dynamic
* Modular
* Automated
* Configurable
* Reproducible
* Scalable
* Transparent

## Launch a Server from a ServerTemplate

A **ServerTemplate** is a preconfigured 'template' that is used to launch new servers in the Cloud, where each server is configured to satisfy a particular 'role' or perform a specific task (database server, application server, load balancer, etc.). See [ServerTemplates](/cm/dashboard/design/server_templates/index.html) for more information.

### What happens when you launch a Server using a ServerTemplate?

When you launch a server directly from a ServerTemplate it will automatically be associated with the "Default" deployment in your account. Typically, you will want to add servers to a specific deployment before launching a server. See Launch a Server in a Deployment below. However, if you launch a server directly from a ServerTemplate, you will be taken through a series of steps where you will need to define a few server configurations. See diagram below for details.

![cm-server-launch-template.png](/img/cm-server-launch-template.png)

It's important to understand what type of information is defined inside of a ServerTemplate and what information is user-defined. ServerTemplates are designed to be cloud agnostic. (That is, you can use the same ServerTemplate to launch servers into multiple cloud infrastructures.) By default, all of the ServerTemplates that are published by RightScale use our RightImages<sup>TM  </sup>and are already designed to launch servers in both Amazon EC2 regions (EC2-US, EC2-EU). However, if you have valid cloud credentials for additional cloud infrastructures such as a private cloud, you must manually add support for those clouds to a ServerTemplate under its Clouds tab. When you add a cloud, you will need to select a specific machine image that will be used for the server's base OS installation.

**Note**: You can only launch one server directly from a ServerTemplate into the Default deployment. Before you can launch another server directly from a ServerTemplate, you must first delete the previous server from the Default deployment.

## Launch a Server in a Deployment

As a best practice, you should always try to launch servers in the context of a deployment. Unless you're launching a server for demo purposes only, you'll most likely want to launch servers in the context of a deployment where it's linked and related to other servers in the setup. For example, you're application servers will need to communicate with the master database and the load balancers will need to communicate with the application servers. Deployments provide a way of grouping these related servers together so that you can configure them in a single place and share common configurations such as inputs. A deployment consists of a cluster or group of servers that work together and share common input variables and cloud configurations. In a deployment, you can manage a group of servers in the same way that you would manage a single server. You can define common input variables, execute RightScripts on some or all servers, as well as create multiple server environments for production, development, staging, and maybe even failover scenarios. When you add a server to a deployment with a ServerTemplate, the server will inherit any inputs that are defined at the deployment level. See [Understanding Inputs](/cm/rs101/understanding_inputs.html).

In the diagram below, we've added two FrontEnd PHP servers using the same ServerTemplate. In this example, we've defined the APPLICATION input at the deployment level so any server in the deployment will use 'myapp' for the APPLICATION input value. This way, we only have to set this value once (at the deployment level) instead of worrying about setting it in each individual server. In the example below, the ADMIN_EMAIL and APACHE_MPM inputs were not defined at the Deployment level so the server naturally inherited the value that was set at the ServerTemplate level.

![cm-server-launch-deployment.png](/img/cm-server-launch-deployment.png)

## Launch a Server with the RightScale API

The RightScale API uses standard REST conventions when possible. See the [RightScale API General Usage Overview](/api/general_usage.html) or [RightScale API Examples](/api/api_1.5_examples/index.html) for more information.

## Launch Servers Automatically (Autoscaling)

Automation is one of the key advantages of the RightScale Management Platform. Configure a deployment with the necessary alerts and alert escalations so that a server array can automatically scale up or down based upon the metrics and thresholds that you define. See [How do I set up Autoscaling?](/cm/dashboard/manage/arrays/index.html)
