---
title: Cloud Pricing in Optima
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Overview

Tracking cloud pricing is very complex and involves many components including different instance sizes, different regions, different operating system options, and specialized pricing such as AWS Reserved and Spot Instances or Google Sustained Use Discounts, Preemptible VMs, and Committed Usage Discounts.

As a result of this complexity, RightScale tracks and manages more than 100,000 unique price points for compute resources across the top public cloud providers, and that number is growing rapidly.

RightScale draws the latest pricing data from cloud provider APIs and also maintains historical data. RightScale also enables you to specify costs for your own internal private clouds.

RightScale pricing data is available through the Optima user interface, as well as the RightScale Cloud Pricing Service API.

## Setting Up Public Cloud Pricing

RightScale automatically draws cloud pricing information from cloud vendors. If you have negotiated special pricing from a particular cloud vendor, RightScale allows you to add those prices as well. See [Cloud Markups and Markdowns](/ca/ca_cloud_markups_markdowns.html).

If you use list pricing, just set up your cloud provider. Go to the navigation bar, click **Accounts**, and connect to a cloud.

## Setting Up Private Cloud Pricing

You can also [add pricing of a private cloud](/cm/dashboard/clouds/generic/instance_types_actions.html#set-instance-type-prices) running [OpenStack](http://www.rightscale.com/products-and-services/multi-cloud-platform/openstack-management), [VMware](http://www.rightscale.com/products-and-services/multi-cloud-platform/vsphere-management), or on bare metal. As soon as you establish a connection between RightScale and your private cloud, then you can analyze the instance usage (in terms of number of virtual machines). Once you have defined your private cloud prices, you can also analyze costs.

To set up your cloud pricing in RightScale Optima, first define the price to be associated with each instance type so that you can also analyze costs. To do this, you will need to work with your finance team to determine the internal price that you want to associate with your private cloud. Your private cloud will have several instance types, and you will need to associate hourly costs with each of them.

Once you have determined your internal prices, go to the RightScale Cloud Management dashboard, navigate to **Clouds** > *CloudName* > **Instance Types**. From here you can then select **Change Pricing** and set an hourly price for each of your instance types.

This price will be used to calculate private cloud costs as well as chargeback and showback reports, which are easily accessible in Optima. Please note that you must be an admin on the account to set private cloud prices — that is, you must be the one who connected your private cloud to RightScale.

## Markups and Markdowns

RightScale also enables you to specify markups and markdowns. Markups and markdowns are applied to cloud prices automatically, and all users will see costs with markups and markdowns already included. See [Cloud Markups and Markdowns](/ca/ca_cloud_markups_markdowns.html) for additional information.

## RightScale Cloud Pricing Service API

RightScale Cloud Pricing Service provides API access to our up-to-date repository of more than 100,000 current and historical public cloud prices. You can access list prices as well as prices after your markups and markdowns via the API. Additionally, if you have purchased AWS Reserved Instances (RIs) you can also access information on your purchased RIs catalog across all of your accounts — there is no need to log in to each account separately. The RightScale Cloud Pricing Service lets you access all these price points through an API so that you can integrate with other systems and automate processes in RightScale or other applications.
