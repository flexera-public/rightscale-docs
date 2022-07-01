---
title: EC2 Elastic IPs
layout: cm_layout
description: An Elastic IP (EIP) is an IP address that you can reserve from AWS for your account for use in RightScale.
---

## Overview

An **Elastic IP (EIP)** is an IP address that you can reserve from AWS for your account. Once you've created an Elastic IP, you can assign it to any instance of your choice. Once you reserve an Elastic IP, nobody else can use that IP address. Elastic IPs are unique because they are dynamically remappable IP addresses that make it easier to manage servers and make global changes in the cloud. Whereas static IPs are associated to a particular machine, EIPs can be reassigned to different instances when necessary as you launch and terminate servers. Typically, you will associate EIPs to your frontend servers. You can assign an EIP to a running instance or associate an EIP when an instance is launched. Be careful, you can also "steal" an EIP from one of your instances. As a best practice, you should age any new EIP before you assign it to one of your public facing servers because that IP address may still be temporarily cached and mapped to its previous instance. You do not want to accidentally inherit unintended traffic from its predecessor.

To work with Elastic IPs in the CM dashboard, got to **Clouds** > *AWS_Region* > **IP Addresses**.

### What are the benefits of using Elastic IPs?

Once you reserve an Elastic IP, nobody else can use that IP address. Remember, when an instance is launched into EC2, Amazon will randomly assign it both a public and private IP address. Amazon has a pool of public IP addresses that's been reserved for use within EC2. Therefore, when you launch an instance in EC2, it might be randomly assigned a public IP address that someone was just using to host their personal blog just a couple hours ago before they terminated their instance. So, depending on the situation you might accidentally inherit traffic from someone else or vice-versa. As a preventative measure, Amazon gives users the ability to reserve a public IP address for your use only from their pool of IP addresses.

With Elastic IPs, you can now allocate an IP address and assign it to an instance of your choice, which replaces the need for normal dynamic IP addressing in the cloud. Elastic IPs are dynamically re-mappable IP addresses that make it easier to manage servers and make global changes compared to static IPs on traditional hosting solutions, because each EIP can be reassigned to a different instance when needed. It's a way of ensuring that you don't 'inherit' traffic from other's servers on EC2, because you're using an IP that's specifically reserved for your usage only, as long as you keep that EIP.

So, if you set up a site and update your DNS A Records to point to your Elastic IPs, you'll never have to update those records over the lifecycle of your system because the same public IP address will be used for each iteration of that server regardless of how many times it's terminated and launched.

You can use the RightScale Dashboard to both create (reserved) Elastic IPs as well as configure servers to use them accordingly. See Create Elastic IP (EIP).

Elastic IPs are also an essential component for creating failover deployments on EC2. For more details, see [Best Practices for using Elastic IPs (EIP) and Availability Zones](/clouds/aws/amazon-ec2/aws_failover_architectures.html).

Elastic IPs are also especially useful for upgrading software releases. Normally, you would have to make a change at the DNS level. Now with Elastic IPs you can make the changes directly inside the Dashboard. The first step is to launch your new instances (FE-2) with normal dynamic DNS from AWS. Once it's been fully tested and is ready to receive traffic, simply associate the Elastic IP to the new server (FE-2) that has the latest software release and in a couple of minutes, all new traffic will served from the new server (FE-2). The best part is that if you see a problem, simply switch the EIP back to the original server (FE-1). Thanks to Elastic IPs, performing regular software upgrades has never been easier!

![cm-switch-eip.png](/img/cm-switch-eip.png)

### Is there a maximum number of Elastic IPs that can be used?

By default, Amazon will let you reserve up to 5 EIPs per account. If you would like to reserve more than 5 EIPs, you can submit a request to Amazon.

### How much do Elastic IPs cost?

Elastic IPs are totally free, as long as they are being used by an instance. However, Amazon will charge you $0.005/hr for each EIP that you reserve and do not use. You will be charged if you ever remap an EIP more than 100 times in a month.

### How do I reserve/create an Elastic IP?

Follow the Create an Elastic IP (EIP) tutorial.

### How do I delete an Elastic IP?

Plan ahead. Before you delete an Elastic IP, verify that it's not in use. Check your DNS records and make sure that it does not contain the Elastic IP that you are going to delete. Remember, there is no undo button. Once it's deleted, you will no longer be able to use that specific IP address ever again.

Once you delete an Elastic IP from your account, it gets returned to Amazon's pool of IP addresses.

Follow the steps below to make sure that you take the necessary steps before deleting an Elastic IP.

1. Remove the Elastic IP from all DNS entries.
2. Wait a minimum of 24 hrs.
3. While your Elastic IP remains idle in your account, perform some tests to make sure that your new DNS changes have gone through and that your deployment is running as expected without any errors related to the DNS records.
4. Delete your unused Elastic IP. (Clouds > AWS -> Elastic IPs). Click the **Delete** button.  
NOTE: It may take about 5 minutes for the EIP to disappear from your screen after you've deleted it.

### What happens when an instance is launched with an Elastic IP?

[Assigning an Elastic IP at launch](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#Assign_an_Elastic_IP_at_Launch) is a unique feature of the RightScale Dashboard and is not provided by Amazon.

When you launch an instance that's configured to associate a particular Elastic IP at launch, you will notice that the specified Elastic IP that was previously highlighted with italics at the deployment level will seemingly "disappear" and change to -none-. Don't worry, this behavior is expected.

When a machine is launched in EC2 and in the "pending" state, it is randomly assigned a dynamic IP address just like any other instance that is launched that does not have an Elastic IP.

During the booting state, the Elastic IP will be associated to the new instance and the instance will wait for the EIP to settle. Once the instance reaches the operational state, it will be using the specified Elastic IP as its public IP address and will be ready to serve traffic sent to that IP address.

!!info*Note:* The internal IP address is not affected.

### What happens when I associate an Elastic IP after an instance is launched?

See [Assign an Elastic IP after an instance is launched](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#Assign_an_Elastic_IP_After_an_Instance_is_Launched).

* Click the disassociate button to disassociate an Elastic IP from an instance. If you disassociate an EIP from a running instance, it will remain without a public IP address until Amazon re-assigns a new one, which can take several minutes.
* Click the delete button to permanently delete an Elastic IP from your account. When you delete an EIP, you are essentially releasing that IP address back to Amazon so that it can't be reissued to another account. Delete with caution because you will never be able to get that exact same IP address ever again. If you delete an EIP from a running instance, it will remain without a public IP address until Amazon re-assigns a new one, which can take several minutes. When you delete an EIP, it will not disappear from the GUI until Amazon has finished releasing the IP address.
* If an Elastic IP is locked, it cannot be deleted, associated, or disassociated. To lock an EIP, you must lock the server.

!!info*Note:* By default, Amazon will allow you to reserve 5 EIPs per account. You can request more directly with Amazon. EIPs are free to use as long as they are being used (associated) by an operational instance. However, you will be charged by Amazon for *unused* EIPs. This is because they are publicly routable IP addresses. Public IPv4 addresses are a limited resource, so if you reserve addresses and do not use them, it is considered a wasteful practice and you will be charged by Amazon.

## Actions

* [Assign an Elastic IP at Launch](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#assign-an-elastic-ip-at-launch)
* [Transfer an Elastic IP to a running instance](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#transfer-an-elastic-ip-to-a-running-instance)
* [Assign an Elastic IP to an Inactive Server](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#assign-an-elastic-ip-to-an-inactive-server)
* [Check to see if an instance is using an EIP](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#check-to-see-if-an-instance-is-using-an-eip)
* [Disassociate an Elastic IP from a running instance?](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#disassociate-an-elastic-ip-from-a-running-instance)
* [Assign an Elastic IP after an instance is launched](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#assign-an-elastic-ip-after-an-instance-is-launched)
* [Create a New Elastic IP (EIP)](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#create-a-new-elastic-ip--eip-)
* [Switch My Frontends to Use Elastic IPs](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#switch-my-frontends-to-use-eiastic-ips)

## Further Reading

* [Best Practices for Elastic IPs](/cm/dashboard/clouds/aws/misc/best_practices_for_elastic_ips.html)
* [Amazon EC2 Public IP Ranges](http://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html)
* [Does RightScale support Puppet?](/faq/Does_RightScale_support_Puppet.html)
* [What is HAProxy and how does it work?](/faq/What_is_HAProxy_and_how_does_it_work.html)
