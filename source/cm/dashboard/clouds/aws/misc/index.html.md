---
title: Best Practices for Elastic IPs
alias: cm/dashboard/clouds/aws/misc/best_practices_for_elastic_ips.html
description: Best practices for using Elastic IPs in the RightScale Cloud Management Dashboard.
---

## Overview

It's important to understand some key concepts about Elastic IPs before you attempt to use or troubleshoot your deployment that includes instances with EIPs. If you ignore the information below, you can cause more serious problems.

## Elastic IPs and EC2 Instances

Amazon will let you associate an Elastic IP to any type of EC2 instance (frontend, load balancer, database, etc.). In most cases, you will probably only use Elastic IPs for your public URLs.

Elastic IPs can also be especially helpful if you have an environment where the active server is periodically relaunched, but you want to return to the same service (http, sshd, MySQL) with the same IP address. In such cases, Elastic IPs can provide a static IP address in a dynamically changing server environment.

## Don't Steal Elastic IPs!

Although Amazon prevents other users from using one of your reserved Elastic IPs, they do not protect you from stealing an Elastic IP from yourself. Any server that is launched from your account can be assigned any of your Elastic IPs, even if they are already being used by a running instance. Therefore, you must be careful not to accidentally steal an EIP from one of your running load balancers. If you launch a new instance and associate one of your active EIPs at launch, the new instance will steal the EIP from the active instance. Be sure to lock your Elastic IPs.

For example, let's say you create a clone of your production deployment in order to create a staging deployment for an upcoming software release. If you do not remember to change the configuration for the frontend servers (that are using your EIPs) before launching the staging deployment, you could accidentally replace your production site with your staging site. When cloning a deployment, be sure to check and see which EIPs are being used and change them where necessary.

When you try to edit a running instance's Elastic IP, you will see an `in use` warning next to any EIP that is currently being used by another instance. If you click OK, FrontEnd-2 would steal the Elastic IP (fe1) from FrontEnd-1 and FrontEnd-1 would receive a new dynamic IP address from Amazon.

## Age Your Elastic IPs

When you reserve an EIP from Amazon, you are essentially taking an IP address out of their pool of IP addresses that they use to allocate IP addresses on EC2. It's important to realize that other users were likely using your IP address before you reserved it as an EIP. Therefore, you should take some precautionary steps to ensure that you don't accidentally inherit "old" traffic due to caching. We recommend aging the IP address for a few days before using it for a production deployment.

Be sure to Create an Elastic IP as soon as possible so you can wait a few days for all of the old traffic to give up and move on to other IP address. You can either launch some servers using the EIP or keep them idle in your account. The important thing is that nobody else is using that IP address besides yourself. After a few days, most of the cached addresses will be finished with the TTL value and will drop off from the cache and DNS servers. Once you've "aged" your EIP, you can feel free to use it and move it around for your own projects.

Remember, the same TTL issues will still exist if you move this EIP around within your DNS Records. Users that have cached your old DNS -> IP bindings will see the old IP for a while before the new IP has time to "stick."

To create a better user experience for your users, we recommend keeping the DNS -> IP binding as stable as you possible. You'll have better results if you use the Load Balancer or some other tool to move around services instead of changing your DNS records. When used properly, you'll find that Elastic IPs provide far better flexibility and control than static IP addresses.

As a best practice, before you delete an EIP, we recommend aging the EIP for 24 hours in order to prevent your traffic from being inherited by the next owner of that IP address.

## Lock your Elastic IPs

Since it's relatively easy to steal an Elastic IP from another instance, it's important that you lock any running instance that is using an Elastic IP. The only way to "lock" an Elastic IP is to lock the instance.

!!info*Note:* Locking the deployment will NOT lock an Elastic IP that is being used by an instance inside that deployment.

To lock an instance, go to your deployment and click on the nickname of the running instance using an EIP. Under the Info tab, click lock under "Safety Status."

If you've locked the FE1 instance that is using the "fe1" Elastic IP, you will not be able to launch or transfer the "fe1" Elastic IP to another instance. If you attempt to "steal" an Elastic IP from a locked instance you will receive an error message in the Recent Events pane.
