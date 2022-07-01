---
title: Manage Reserved Instances
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Understanding AWS Reserved Instances

Amazon Web Services (AWS) Reserved Instances (RIs) allow you to reserve Amazon EC2 computing capacity for 1 or 3 years, in exchange for a significantly discounted hourly rate (up to 75%) compared to On-Demand Instance pricing.

Reserved Instances are a reservation for a specific instance type in a specific region and availability zone with a specific platform. You can purchase RIs for standard multi-tenant hardware or for dedicated (single-tenant) hardware.

You can choose between two terms (1 year or 3 years) and three payment options (All Upfront, Partial Upfront and No Upfront). The more you pay upfront, the higher your overall discount. Keep in mind that Partial Upfront and No Upfront RIs require you to pay a monthly charge over the term of the RI, ***whether you use the RI or not***.

## How AWS Applies Reserved Instances

While RIs are purchased from a specific AWS account, if the reservation is not fully used in the purchasing AWS account, the RI discount will then be applied to matching instances (those matching the instance type, region and availability zone of the RI) across other accounts within the consolidated billing account family.

## Determining your RI Requirements

In order to determine how many RIs you need, you’ll need to analyze your past and present cloud usage. A few recommendations to maximize your savings:

* **Centralize RI purchasing** - Since you can apply RIs across an entire consolidated billing account group, you will maximize your ability to purchase and use RIs if you centralize decisions and purchases across all accounts.
* **Standardize instance types** - Since RIs relate to specific instance types, reducing the number of different instance types you use means you can better target your RI purchases.
* **Rationalize your regions and availability zones** - You may need to run workloads across different regions or availability zones for purposes of reducing latency or providing for high availability, failover, and disaster recovery. However, to maximize savings from RIs, you may want to consolidate the regions and availability zones used across your entire application portfolio.
* **Consider future changes in usage** - You will want to take into account expected changes in your future cloud usage. You may have new or growing applications that will increase cloud usage, or declining or end-of-life applications that will decrease future cloud usage. These may impact your decisions on the level of Reserved Instances to purchase.

The Instance Analyzer can help you determine how many reserved instances to buy:

1. **Specify a time period**. For analyzing RI purchases you should analyze at least 6 months of history. If you have significant seasonality in usage (such as peaks in load for holidays), you should include a minimum of 12 months.

    ![ca-specify-time-period.png](/img/ca-specify-time-period.png)

2. **Filter for Cloud Vendor**. If you only want to buy RIs for workloads already running on AWS, filter Cloud Vendor to AWS. If you want to consider moving workloads from other cloud vendors to AWS, you can select those cloud vendors as well. Click **Apply your filter selection** once you have selected your filters.

    ![ca-filter-cloud-vendor.png](/img/ca-filter-cloud-vendor.png)

3. **Pick On-Demand instances**. The Purchase option filter allows you to exclude instances that are already covered by RIs.

    ![ca-pick-on-demand-instances.png](/img/ca-pick-on-demand-instances.png)

4. **Select accounts**. Use the Accounts filter to select which RightScale accounts you want to buy for. If you don’t fully use an RI within the purchasing account, it will automatically be applied to qualifying instances in the same account group.
5. **Start with Windows or Linux**. Use the Operating System filter to pick the platform and then apply your selection.

    ![ca-start-windows-linux.png](/img/ca-start-windows-linux.png)

6. **Pick an instance type**. Start with your most used instance type since it offers the largest opportunity to save money.

    ![ca-pick-instance-type.png](/img/ca-pick-instance-type.png)

7. **Pick a datacenter**. A datacenter is equivalent to an AWS availability zone. Start with the most used datacenter.

    ![ca-pick-datacenter.png](/img/ca-pick-datacenter.png)

8. **Determine the number of instances**. Find the minimum number of instances used historically for this combination of instance size, region, datacenter, and platform. It’s important to look at the Lowest Instance Count field to find the absolute minimum over the time period.

    ![ca-determine-number-of-instances.png](/img/ca-determine-number-of-instances.png)

9. **Evaluate potential changes in the future**. Do you expect the usage for this combination of instance type, region, data center, and platform to change in the future? You may want to consider data center migrations, plans to change instance types, or expected changes in application load.
10. **Determine your desired number of RIs**. You may want to be conservative and purchase RIs at or below the historical minimum or you may want to be more aggressive and take into account future growth.
11. **Repeat for other datacenters and instance types.**

## Deciding What Type of RIs to Buy using Breakeven Analysis

Although the RI discount levels calculated by AWS are based on running an instance 100 percent of the time over the term of the RI, you can still realize (lower) savings for an instance that doesn’t run 100 percent of the time. You can do a breakeven analysis to determine the amount of time an instance must be used before you break even vs on-demand. After that break even point, you start to realize savings for the remainder of the RI term.

The breakeven point for an RI will depend on the discount level. For example, if a No Upfront RI for a particular instance type in a particular region offers a 25 percent discount for a 1-year term, then you will realize some savings as long as you use that RI for at least 75 percent of the year (or at least 9 months). In order to realize the full 25 percent savings, you need to use that RI for the entire year.

[Read more details on RI breakeven points in our blog.](http://www.rightscale.com/blog/cloud-cost-analysis/aws-vs-google-pricing-decoding-new-aws-ri-model)

## Analyzing Reserved Instance Utilization 

Once you’ve purchased Reserved Instances (RI), you want to make sure that you are using them so that you can gain the full savings and avoid wasting money.

To view all types of AWS Reserved Instances (RI) including the utilization information, click the **Reserved Instances** link on the left navigation of Optima. This page shows complete information about your Reserved Instances for the selected organization. For more information on complete RI , check out our new [Reserved Instances page](/ca/ca_analyzing_costs.html#reserved-instances) for accurate utilization report.

Sort on the State column to find **active** RIs, which are RIs that have not expired and are still in effect. If you see any active RIs that have less than 100% utilization, then you will want to make some changes to take advantage of the RI. You can:

* **Move On-Demand instances to new instance types:** Look for instances of similar sizes and move them to the instance size of the RI. Be careful that you don’t move from a much smaller On-Demand instance to a larger Reserved Instance where the RI hourly cost is actually more expensive than the On-Demand cost. Use the Instance Analyzer to find instances that match the datacenter and operating system of the RI, then use Cloud Management to re-launch your instance.
* **Move On-Demand instances to the matching datacenter:** Use the Instance Analyzer to find On-demand instances that match the region, instance size, and operating system of the RI. Use Cloud Management to move the instance to the availability zone that matches the RI.
* **Ask AWS to modify the availability zone or instance type of the RI:** AWS allows you to request a modification of a RI. [You can request a change](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html) to another availability zone in the same region, or to another instance size in the same family. When changing the instance size, [you must maintain the same footprint](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modification-instancemove.html) (e.g. change an RI for one m3.large for one for two m3.mediums).
* **Sell your RI in the RI Marketplace:** If you can’t find a way to use the RI enough to cover the breakeven point, [you can sell the RI in the AWS RI Marketplace](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-selling-guide.html). Keep in mind that when you sell your RI in the Marketplace, the customer will pay the same recurring fee that you would have paid (you cannot change that price). You can set the upfront price you want to charge. If you purchased a No Upfront RI, then you would typically price it to sell with $0 upfront cost. Keep in mind that you must have held the RI for 30 days before you can sell it, and you must have at least one month remaining on the reservation. You must also have funds sent to a bank in the United States.