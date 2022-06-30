---
title: Optima Costs Explained
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Costs on the Dashboard

Optima uses several methods to show you costs on the Dashboard:

Provider | Source 
-------- | ------------
**AWS** | [Hourly Cost and Usage CSV Reports](/clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html)
**Azure** | [Azure Enterprise Agreement](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html) <br /> [Microsoft Cloud Solution Provider program](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html)
**Google** | [Billing CSVs](/clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html) Includes Google Committed Usage Discounts
**Other Cloud**| Data based on instances only

### Handling of cloud bill credits

All credits contained in the bill are accounted for in cost dashboard including billing center dashboards.

## Costs on the Instance Analyzer page

The Instance Analyzer pages displays Instances only costs based on usage data collected by RightScale multiplied by the relevant cloud prices with any markups or markdowns that you have specified. This is an estimate of instance costs that allows you to slice and dice by a variety of factors beyond what is available in your cloud bill. Azure and Google's Instant Analyzer costs are calculated by blending the compute costs over the instance usage.

### Excluded costs in AWS on Instance Analyzer page

* <b>EBS costs</b>: compute costs on your AWS bill include EBS charges as well as Instance costs. EBS costs may represent a significant portion of your AWS Compute costs. The Instance Analyzer pages only include instance costs and <b>do not include</b> EBS costs.
* <b>Upfront costs for Reserved Instances</b>: if you have purchased Reserved Instances, any portion that is Upfront payments are not included in Instances only costs. As a result, for “All Upfront” Reserved Instances, you will not see any costs in Instance Analyzer page but you will see the number of instances.
* <b>Reserved Instances from accounts not linked to RightScale</b>: if you have unused Reserved Instances in an AWS account, AWS will allocate those Reserved Instances to any linked AWS accounts that have instances matching the Reserved Instances characteristics . Your entire AWS account family, including the payer account and linked accounts, must be connected to a RightScale account in order to get accurate information about all Reserved Instances.
* <b>Premium operating systems (RHEL, SLES, Windows SQL)</b>
* <b>Dedicated instances</b>
* <b>Usage in AWS regions not supported by RightScale</b>:
[See full list of Supported Amazon Regions](/clouds/aws/amazon-ec2/aws_regions.html)


### Costs in Azure on Instance Analyzer page

*  RightScale uses the cost for compute on the cloud bill and allocates it to each individual instance based on the elapsed time it is used for. 

### Costs in Google on Instance Analyzer Pager

* RightScale uses the cost for compute on the cloud bill and allocates it to each individual instances based on the elapsed time it is used for. 
* **Google Sustained Usage Discounts savings and Committed Usage Discounts**: If you connect all your GCE account creds in Cloud Management, and if you are set up for GCE [billing data](/clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html), we incorporate sustained usage discounts and committed usage discounts by calculating the costs using the average price for each instance **type** on a monthly basis. The average cost per instance-hour is recalculated daily, which means that your monthly costs may drop each day as you accrue discounts. The current reflected daily cost may appear to spike at the first of the month as your sustained usage discount falls away until you surpass the sustained usage discount limit for the month, recalculating the average cost and updating that spike on the first day to reflect the new average rate across all days of this month.

### Costs in SoftLayer and private clouds on Instance Analyzer page

* Costs based on usage data are collected by RightScale and multiplied by the relevant cloud prices with any markups or markdowns that you have specified.

## Granting Access to Dashboard
Anyone who has the [ca_user role](/cm/ref/user_roles.html#-ca_user) on your RightScale account can see Optima. Please see the [roles](/cm/ref/user_roles.html) page</a>.<br><br>
If you give access to a user to the payer account, they will be able to see full costs of the consolidated bill. If you'd like to give access to only specific accounts, then give permissions at those levels (RightScale child accounts).


## Historical Data Cost

### Dashboard
  * AWS:   With [Hourly Cost and Usage CSV Reports](/clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html)
    - Dashboard will show data for all months that the `hourly cost and usage report` csv exists in the specified bucket.
  * Google: 
    - If you have set up your [billing buckets](/clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html), and your bill CSVs are in that bucket, then you will see your historic costs for as long as you have CSVs in the bucket.
  * Azure: 
    - We will digest all your history as provided by the [Azure Enterprise Agreement](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html) API.
  * SoftLayer/Other Cloud Providers 
    - We poll their APIs and gather usage information and build cost information from the time you enter credentials moving forward.

### Instance Analyzer 
   * All Clouds:  Shows **usage** data from the time of credentials entered in Optima going forward.  

## Freqency of Data Updates

### Dashboard
  * The data in the Dashboard is updated roughly as often as it is updated by the cloud provider. In some cases this is once per day, in other cases it is updated multiple times per day.

### Instance Analyzer
  * The data on the Instant Analyzer is updated every few hours. The prices within Scenario Builder are updated within a few days of a price change.
