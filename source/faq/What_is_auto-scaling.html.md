---
title: What is Auto-Scaling?
category: general
description: Auto-scaling is a way to automatically scale up or down the number of compute resources that are being allocated to your application based on its needs at any given time.
---

## Background Information

Auto-scaling is a way to automatically scale up or down the number of compute resources that are being allocated to your application based on its needs at any given time.

Before cloud computing, it was very difficult to scale a website, let alone figure out a way to automatically scale (autoscale) a server setup. In a traditional, dedicated hosting environment, you are limited by your hardware resources. Once those server resources are maxed out, your site will inevitably suffer from a performance perspective and possibly crash, thereby causing you to lose data and/or potential business. RightScale allows you to set up and configure the necessary trigger points, called alerts and alert escalations, so that you can create an automated setup that automatically reacts to various monitored conditions when thresholds are exceeded.

Today, cloud computing is totally revolutionizing the way computer resources are allocated, making it possible to build a fully scalable server setup on the Cloud. If your application needs more computing power, you now have the ability to launch additional compute resources on-demand and use them for as long as you want, and then terminate them when they are no longer needed.

* * *

## Answer

### Why do I need autoscaling?

Autoscaling is useful whenever your site/application needs additional server resources to satisfy the number of page requests or processing jobs.  Many people think about autoscaling in terms of handling sudden bursts or traffic spikes, but autoscaling is equally beneficial over the lifetime of your setup whether it's one year or ten years.

The key point is that you can now design a scalable architecture that will automatically scale-up or scale-down to meet your needs over the lifetime of your setup regardless of how fast/slow or big/small your site grows over that time.

Here are the most popular ways of autoscaling:

* **Front-end Site Traffic**
  * Scale based on the number of incoming requests (e.g. web pages, objects, data transfer)


* **Back-end Batch Processing  (Scale Horizontally)**
  * Load-based Scaling - Scale based on the number of jobs in the queue
  * Time-based Scaling - Scale based on how long jobs have been in the queue

### How do I use RightScale for autoscaling?

RightScale provides an automated, cloud management platform where you can set up your deployment to automatically scale based on conditions that you define.  For example, you can set up a series of alerts and escalations that will automatically scale-up your deployment when your servers are using more than 80% of their processing power.  Conversely, you can set up your deployment to automatically scale-down when your servers are only using 15% of their processing power.

RightScale also uses a democratic voting system in order to ensure that an "over-worked" server doesn't accidentally trigger a scale-up/down for the entire deployment.  By default, 51% of your server resources must vote for the same escalation before any action takes place.

You can also define how many servers are launched when you scale-up/down, as well as a maximum number of servers that can be allocated to a deployment.  The Dashboard gives you full control of how your deployment scales.

For front-end autoscaling for the Standard Edition, see [How do I set up Autoscaling?](http://support.rightscale.com/03-Tutorials/02-AWS/02-Website_Edition/How_do_I_set_up_Autoscaling%3F/)

