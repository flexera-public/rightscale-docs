---
title: Optima API Overview
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

[[API Overview
For a general overview of the concepts used across all APIs, including **endpoints**, **authentication**, **headers**, and more, see the following information:
* [RightScale API Overview](/api/general_usage.html)
]]

!!warning*Note*The content below applies to legacy Optima capabilities. The below APIs will be deprecated in the coming months. For new Optima API information, see the [new Optima API documentation](/optima/guides/api.html)

The Optima API provides cost and usage metrics for cloud spend on cloud accounts connected to RightScale. This API, unlike some of the other RightScale APIs, is scoped by user. If you make a request to the Optima API, you do not need to provide an account ID and (by default) will receive information for all of the accounts that your user has access to.

There are three main data sources for the Optima API:
* [CloudBills](#cloudbills) provides data for total cloud spend. Currently, CloudBills are only supported for:
  * Amazon Web Services payer accounts which are using Consolidated Billing ([find out how to set up Cost and Usage reports for RightScale](/clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html)).
  * Microsoft Azure Enterprise Agreement, where all of your available billing data is loaded into Optima. This includes all of the Microsoft Azure accounts and subscriptions that are part of your Microsoft Enterprise Agreement. [Find out how to enable this](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html).
  * Google Cloud Platform, where all of your available billing data is loaded into Optima. [Find out how to enable this](/clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html).
* [Instances](#instances) provides a granular view of instances across all cloud accounts connected to RightScale via Cloud Management. Instances can be filtered by a wide range of attributes, including tags. See [filtering instances](#instances-filtering-instances) for more information. AWS users will also be able to see metrics about their [ReservedInstances](http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-ReservedInstances).
* [PluginCosts](http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-PluginCosts) allows additional costs to be plugged in to Optima, then shown on the dashboard, in scheduled reports, and in budget alerts. Unlike the other two data sources, this one is entirely user-driven: by default, no plugin costs are present.

The [CombinedCosts](http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-CombinedCosts) API provides a simple interface to these three data sources at once. It provides all of the data from the cloud bills and plugin costs data sources, and uses instances data where there is no matching cloud bills data. This is used by the Optima dashboard and in full-cost scheduled reports.

In addition to the above data sources, the Optima API can be used to manage the following resources:
* <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-BudgetAlerts">BudgetAlerts</a>: enable you to set a monthly spend budget and be alerted via email when this is exceeded, based on either actual or forecasted spend. These emails include links to AnalysisSnapshots, which are generated automatically by RightScale.
* <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-ScheduledReports">ScheduledReports</a>: these are emailed to you, and include usage, cost, and the change from the previous reporting period. These emails also include links to AnalysisSnapshots.
* <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-AnalysisSnapshots">AnalysisSnapshots</a>: these can be used to generate unique links to share data using filters over a date range.
* <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-Scenarios">Scenarios</a>: these can be used to model changes in cloud usage to forecast costs over a 3-year period.
  * <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-InstanceCombinations">InstanceCombinations</a>: these represent instances that make-up a Scenario. An InstanceCombination can have many <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-ReservedInstancePurchases">ReservedInstancePurchases</a>, which are not actually purchased in the cloud and are only used for cost simulation purposes. <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-Patterns">Patterns</a> can also be applied to InstanceCombinations to model future growth or other changes in costs.

!!info*Note:* All of the example requests below assume that a `rightscalecookies` file is in the current directory, generated as described at the <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/">Optima API reference</a>. The Optima API also supports <a href="/api/api_1.5_examples/oauth.html">OAuth authentication</a>, although it's not shown in these examples.

## CloudBills

The CloudBills data source has two API resources:

* [CloudBillMetrics][cbm] has cost information for total cloud spend for a time period.
* [CloudBills][cb] has other metadata about the bills. At present, this is limited to filters and the CSV export.

### Total Cloud Spend for a Time Period

To find the total cloud spend for a time period, use the [`CloudBillMetrics#grouped_time_series`][cbm-gts] API call. To find the total cloud spend on Amazon Web Services for May, just do:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-06-01 \
      -d group='[["cloud_vendor_name"]]'
```
###

### Response
```json
[
  {
    "kind": "ca#time_series_metrics_result",
    "timestamp": "2015-05-01T00:00:00+00:00",
    "results": [
      {
        "kind": "ca#metrics_result",
        "group": {
          "cloud_vendor_name": "Amazon Web Services"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 1251.45
        },
        "breakdown_metrics_results": [

        ]
      }
    ]
  }
]
```
###
]]]

The example call above has a `group` parameter, because this is a grouped time series, showing results by month. In this case, we used it for a single month and we chose the grouping so we would get a summary of the total spend.

We can also use the `group` parameter to drill down using nested groups. For instance, `group='[["product_category"]]'` means that the results will be grouped by product category. `group='[["product_category","product"]]'` means that the results will be grouped by product category and product, still at one level deep. `group='[["product_category"],["product"]]'`, on the other hand, means that the results will be grouped by product category and then, within those groups, grouped by product. Here is what that looks like:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-06-01 \
      -d group='[["product_category"],["product"]]'
```
###

### Response
```json
[
  {
    "kind": "ca#time_series_metrics_result",
    "timestamp": "2015-05-01T00:00:00+00:00",
    "results": [
      {
        "kind": "ca#metrics_result",
        "group": {
          "product_category": "Other"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 0.01
        },
        "breakdown_metrics_results": [
          {
            "kind": "ca#metrics_result",
            "group": {
              "product": "AWSQueueService"
            },
            "metrics": {
              "kind": "ca#metrics",
              "total_cost": 0.01
            },
            "breakdown_metrics_results": [

            ]
          }
        ]
      },
      {
        "kind": "ca#metrics_result",
        "group": {
          "product_category": "Network"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 1.64
        },
        "breakdown_metrics_results": [
          {
            "kind": "ca#metrics_result",
            "group": {
              "product": "AWSDataTransfer"
            },
            "metrics": {
              "kind": "ca#metrics",
              "total_cost": 1.64
            },
            "breakdown_metrics_results": [

            ]
          }
        ]
      },
      {
        "kind": "ca#metrics_result",
        "group": {
          "product_category": "Storage"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 0.02
        },
        "breakdown_metrics_results": [
          {
            "kind": "ca#metrics_result",
            "group": {
              "product": "AmazonS3"
            },
            "metrics": {
              "kind": "ca#metrics",
              "total_cost": 0.02
            },
            "breakdown_metrics_results": [

            ]
          }
        ]
      },
      {
        "kind": "ca#metrics_result",
        "group": {
          "product_category": "Database"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 46.96
        },
        "breakdown_metrics_results": [
          {
            "kind": "ca#metrics_result",
            "group": {
              "product": "AmazonRDS"
            },
            "metrics": {
              "kind": "ca#metrics",
              "total_cost": 46.96
            },
            "breakdown_metrics_results": [

            ]
          }
        ]
      },
      {
        "kind": "ca#metrics_result",
        "group": {
          "product_category": "Compute"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 1202.82
        },
        "breakdown_metrics_results": [
          {
            "kind": "ca#metrics_result",
            "group": {
              "product": "AmazonEC2"
            },
            "metrics": {
              "kind": "ca#metrics",
              "total_cost": 1202.82
            },
            "breakdown_metrics_results": [

            ]
          }
        ]
      }
    ]
  }
]
```
###
]]]

### Filtering CloudBills

!!info*Note:* Filters of the same type are OR-ed together. Groups of different filters types are AND-ed. For more information, see the <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/type/V1-MediaTypes-Filter">Filter documentation</a>.

The time series can be filtered. We can get a list of filter options with the [`CloudBills#filter_options`][cb-fo] API call. For example, we can get all of the available product category filters for cloud bills in May 2015:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/cloud_bills/actions/filter_options \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-06-01 \
      -d filter_types='["cloud_bill:product_category"]'
```
###

### Response
```json
[
  {
    "kind": "ca#filter",
    "type": "cloud_bill:product_category",
    "value": "Compute",
    "label": "Compute",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "cloud_bill:product_category",
    "value": "Database",
    "label": "Database",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "cloud_bill:product_category",
    "value": "Storage",
    "label": "Storage",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "cloud_bill:product_category",
    "value": "Network",
    "label": "Network",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "cloud_bill:product_category",
    "value": "Other",
    "label": "Other",
    "tag_resource_type": null
  }
]
```
###
]]]

This shows that the available filter values are `Compute`, `Database`, `Storage`, `Network`, and `Other`. We can then pass the filter object back to the time series call to get storage costs by product for May:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/cloud_bill_metrics/actions/grouped_time_series \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-06-01 \
      -d cloud_bill_filters='[{"type":"cloud_bill:product_category","value":"Storage"}]' \
      -d group='[["product"]]'
```
###

### Response
```json
[
  {
    "kind": "ca#time_series_metrics_result",
    "timestamp": "2015-05-01T00:00:00+00:00",
    "results": [
      {
        "kind": "ca#metrics_result",
        "group": {
          "product": "AmazonS3"
        },
        "metrics": {
          "kind": "ca#metrics",
          "total_cost": 0.02
        },
        "breakdown_metrics_results": [

        ]
      }
    ]
  }
]
```
###
]]]

And so we can see that all of our storage cost in May was the two cents we spent on Amazon S3.

## Instances

Instances have far more API calls available than CloudBills. These are divided into three resources:

* [InstanceMetrics][im] has aggregated cost and usage information, which can be presented in a variety of ways.
* [Instances][i] has other metadata about the instances. Like CloudBills, filter options and CSV export are in this resource, along with instance-level information.
* [InstanceUsagePeriods][iup] enables you to get usage period details from instances. An instance can have many usage periods, which can be caused by stop/start actions or changes to the instance type etc. InstanceUsagePeriods are used internally to calculate aggregate InstanceMetrics.

### Costs by Tag

The Optima API contains instance, deployment, and account tags ([find out more about tags][tags]). These are all available as tags, distinguished by their `tag_resource_type` attribute. When grouping by tags, it's very useful to either filter or group on `tag_resource_type`, in case the same tags exist on different types of resource.

The [`InstanceMetrics#grouped_overall`][im-go] call can summarise and group metrics for a time period. In this case, we will show instance costs on 1 May 2015, by tag, ordered most expensive to least expensive:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instance_metrics/actions/grouped_overall \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-05-02 \
      -d group='["tag_resource_type","tag_key"]' \
      -d metrics='["total_cost","average_instance_count"]' \
      -d order='["-total_cost"]'
```
###

### Response
```json
[
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "accounts",
      "key": "account:demo"
    },
    "metrics": {
      "average_instance_count": 28.0396643518519,
      "total_cost": 51.5431005351713
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "accounts",
      "key": "rs_report:include"
    },
    "metrics": {
      "average_instance_count": 28.0396643518518,
      "total_cost": 51.5431005351713
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "ec2:Name"
    },
    "metrics": {
      "average_instance_count": 19.0396643518519,
      "total_cost": 33.8734404141307
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_monitoring:state"
    },
    "metrics": {
      "average_instance_count": 20.0396643518519,
      "total_cost": 32.4574570847096
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "deployments",
      "key": "selfservice:href"
    },
    "metrics": {
      "average_instance_count": 11.0396643518519,
      "total_cost": 29.937438626944
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "deployments",
      "key": "selfservice:launched_from"
    },
    "metrics": {
      "average_instance_count": 11.0396643518519,
      "total_cost": 29.937438626944
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "deployments",
      "key": "selfservice:launched_from_type"
    },
    "metrics": {
      "average_instance_count": 11.0396643518519,
      "total_cost": 29.937438626944
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "deployments",
      "key": "selfservice:launched_by"
    },
    "metrics": {
      "average_instance_count": 11.0396643518519,
      "total_cost": 29.9374386269439
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "server:uuid"
    },
    "metrics": {
      "average_instance_count": 17.5388425925926,
      "total_cost": 23.9202435826083
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_login:state"
    },
    "metrics": {
      "average_instance_count": 16.0364930555556,
      "total_cost": 18.7398453089306
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "server:private_ip_0"
    },
    "metrics": {
      "average_instance_count": 16.0364930555556,
      "total_cost": 18.7398453089306
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "server:public_ip_0"
    },
    "metrics": {
      "average_instance_count": 15.0364930555556,
      "total_cost": 18.7158268575025
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "database:active"
    },
    "metrics": {
      "average_instance_count": 5.01793981481481,
      "total_cost": 7.82612257806182
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "appserver:active"
    },
    "metrics": {
      "average_instance_count": 4.01357638888889,
      "total_cost": 7.65706713604762
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_launch:type"
    },
    "metrics": {
      "average_instance_count": 4.01357638888889,
      "total_cost": 7.65706713604762
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "loadbalancer:default"
    },
    "metrics": {
      "average_instance_count": 8.50732638888889,
      "total_cost": 7.35703541347038
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "cpa:test"
    },
    "metrics": {
      "average_instance_count": 1.0,
      "total_cost": 3.192
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "appserver:listen_ip"
    },
    "metrics": {
      "average_instance_count": 2.51122685185185,
      "total_cost": 2.47666886236996
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "appserver:listen_port"
    },
    "metrics": {
      "average_instance_count": 2.51122685185185,
      "total_cost": 2.47666886236996
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_dbrepl:master_active"
    },
    "metrics": {
      "average_instance_count": 1.5075,
      "total_cost": 2.47505970079875
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_dbrepl:master_instance_uuid"
    },
    "metrics": {
      "average_instance_count": 1.5075,
      "total_cost": 2.47505970079875
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_dbrepl:slave_instance_uuid"
    },
    "metrics": {
      "average_instance_count": 1.51043981481481,
      "total_cost": 2.47106378359984
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_monitoring:security_updates_available"
    },
    "metrics": {
      "average_instance_count": 7.0,
      "total_cost": 1.44000000273725
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_vote:DR+T2+App+Server+Tier"
    },
    "metrics": {
      "average_instance_count": 1.0,
      "total_cost": 0.0
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "tag_resource_type": "instances",
      "key": "rs_vote:PROD-APP"
    },
    "metrics": {
      "average_instance_count": 2.0,
      "total_cost": 0.0
    },
    "breakdown_metrics_results": [

    ]
  }
]
```
###
]]]

The two most expensive tags were account tags. This is to be expected because the user in these examples only has access to one account. The tags with the `selfservice` namespace are automatically added by [RightScale Self-Service](/ss/), so approximately 57% of the costs for this day were from Self-Service managed instances.

(Note: because an instance can have multiple tags, the sum of the total cost will not be the same as the total instance cost for that time period, because the same instances can be counted under multiple groups. For the total without grouping, use [`InstanceMetrics#overall`][im-o].)

### Filtering Instances

!!info*Note:* Filters of the same type are OR-ed together. Groups of different filters types are AND-ed. For more information, see the <a href="http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/type/V1-MediaTypes-Filter">Filter documentation</a>.

Calls to Instances resources can, where available, be filtered by passing the `instance_filters` parameter. To get a list of the available filters, use the [`Instances#filter_options`][i-fo] call. This one shows the platforms (operating systems) used on our account during 1 May 2015:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instances/actions/filter_options \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-05-02 \
      -d filter_types='["instance:platform"]'
```
###

### Response
```
[
  {
    "kind": "ca#filter",
    "type": "instance:platform",
    "value": "Linux/UNIX",
    "label": "Linux/UNIX",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "instance:platform",
    "value": "Windows",
    "label": "Windows",
    "tag_resource_type": null
  }
]
```
###
]]]

We can then filter our previous grouped overall request by platform, by passing one of these filters as well (for Instances, only the `type` and `value` attributes are required, along with `tag_resource_type` if the filter is a tag filter):

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instance_metrics/actions/grouped_overall \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-05-01 \
      -d end_time=2015-05-02 \
      -d group='["tag_resource_type","tag_key"]' \
      -d metrics='["total_cost","average_instance_count"]' \
      -d order='["-total_cost"]' \
      -d instance_filters='[{"type":"instance:platform","value":"Windows"}]'
```
###

### Response
```json
[
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "account:demo"
    },
    "metrics": {
      "average_instance_count": 6.0031712962963,
      "total_cost": 20.1016117806857
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "rs_report:include"
    },
    "metrics": {
      "average_instance_count": 6.0031712962963,
      "total_cost": 20.1016117806857
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "ec2:Name"
    },
    "metrics": {
      "average_instance_count": 5.0031712962963,
      "total_cost": 16.909611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "selfservice:href"
    },
    "metrics": {
      "average_instance_count": 4.0031712962963,
      "total_cost": 13.717611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "selfservice:launched_from_type"
    },
    "metrics": {
      "average_instance_count": 4.0031712962963,
      "total_cost": 13.717611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "rs_monitoring:state"
    },
    "metrics": {
      "average_instance_count": 4.0031712962963,
      "total_cost": 13.717611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "selfservice:launched_by"
    },
    "metrics": {
      "average_instance_count": 4.0031712962963,
      "total_cost": 13.717611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "selfservice:launched_from"
    },
    "metrics": {
      "average_instance_count": 4.0031712962963,
      "total_cost": 13.717611775779
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "rs_launch:type"
    },
    "metrics": {
      "average_instance_count": 1.50234953703704,
      "total_cost": 5.18039827367766
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "appserver:active"
    },
    "metrics": {
      "average_instance_count": 1.50234953703704,
      "total_cost": 5.18039827367766
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "server:uuid"
    },
    "metrics": {
      "average_instance_count": 1.50234953703704,
      "total_cost": 5.18039827367766
    },
    "breakdown_metrics_results": [

    ]
  },
  {
    "kind": "ca#metrics_result",
    "group": {
      "key": "cpa:test"
    },
    "metrics": {
      "average_instance_count": 1.0,
      "total_cost": 3.192
    },
    "breakdown_metrics_results": [

    ]
  }
]
```
###
]]]

We can see that there are no `loadbalancer:default` tags here, because the instances with that tag on this account are all Linux, rather than Windows.

### Showing Running Instances

The number of running instances is given by the [`InstanceMetrics#current_count`][im-cc] call, which takes no parameters:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instance_metrics/actions/current_count \
      -b rightscalecookies \
      -H X-Api-Version:1.0
```
###

### Response
```json
{
  "current_instances_count": 21
}
```
###
]]]

That is not necessarily very interesting, though. _Which_ instances are running will be more useful. The `instance:state` can be used for this, so we get the possible values:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instances/actions/filter_options \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-06-05 \
      -d end_time=2015-06-06 \
      -d filter_types='["instance:state"]'
```
###

### Response
```json
[
  {
    "kind": "ca#filter",
    "type": "instance:state",
    "value": "terminated",
    "label": "terminated",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "instance:state",
    "value": "stopped",
    "label": "stopped",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "instance:state",
    "value": "operational",
    "label": "operational",
    "tag_resource_type": null
  },
  {
    "kind": "ca#filter",
    "type": "instance:state",
    "value": "booting",
    "label": "booting",
    "tag_resource_type": null
  }
]
```
###
]]]

The available values are `terminated`, `stopped`, `operational`, and `booting`. From these, we want `operational` and `booting` instances, so we pass the appropriate filters to [`Instances#index`][i-i]:

[[[
### Request (using curl)
```shell
curl -Gs https://analytics.rightscale.com/api/instances \
      -b rightscalecookies \
      -H X-Api-Version:1.0 \
      -d start_time=2015-06-05 \
      -d end_time=2015-06-06 \
      -d instance_filters='[{"type":"instance:state","value":"operational"},{"type":"instance:state","value":"booting"}]'
```
###

### Response
```json
[
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-59b36a6f",
    "instance_uid": "i-59b36a6f",
    "instance_rsid": "D3FSLG9QJ6BPI",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2013-12-19T01:33:57+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2b",
    "datacenter_name": "us-west-2b",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "PROD T1 LB2",
    "server_template_id": 327687003,
    "server_template_name": "Load Balancer with HAProxy (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 42138,
    "provisioned_by_user_email": "ryan.geyer@rightscale.com",
    "incarnator_id": 955019003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-4e6b2b47",
    "instance_uid": "i-4e6b2b47",
    "instance_rsid": "41T45JQGC1FS8",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-04-03T15:00:30+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2a",
    "datacenter_name": "us-west-2a",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "PROD T1 LB1",
    "server_template_id": 327687003,
    "server_template_name": "Load Balancer with HAProxy (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 3472,
    "provisioned_by_user_email": "matthew@rightscale.com",
    "incarnator_id": 952612003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-97c5979e",
    "instance_uid": "i-97c5979e",
    "instance_rsid": "A0QARNLSITSA7",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-04-15T06:42:40+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2a",
    "datacenter_name": "us-west-2a",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "PROD T3 DB Master",
    "server_template_id": 327688003,
    "server_template_name": "Database Manager for MySQL 5.5 (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 65467,
    "provisioned_by_user_email": "bruno.ciscato@rightscale.com",
    "incarnator_id": 952611003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-0935f301",
    "instance_uid": "i-0935f301",
    "instance_rsid": "54730DUUI1TII",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-04-15T06:42:44+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2b",
    "datacenter_name": "us-west-2b",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "PROD T3 DB Slave",
    "server_template_id": 327688003,
    "server_template_name": "Database Manager for MySQL 5.5 (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 65467,
    "provisioned_by_user_email": "bruno.ciscato@rightscale.com",
    "incarnator_id": 955018003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2183::i-69b1b038f",
    "instance_uid": "i-69b1b038f",
    "instance_rsid": "F2MVJ5JRSTE7T",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-07-12T08:52:56+00:00",
    "cloud_vendor_name": "Microsoft Azure",
    "cloud_id": 2183,
    "cloud_name": "Azure West Europe",
    "datacenter_key": "2183::",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "8::small",
    "instance_type_name": "small",
    "instance_name": "DR T3 DB Slave",
    "server_template_id": 327688003,
    "server_template_name": "Database Manager for MySQL 5.5 (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 65467,
    "provisioned_by_user_email": "bruno.ciscato@rightscale.com",
    "incarnator_id": 990320003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.855450001626096,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-287f5b23",
    "instance_uid": "i-287f5b23",
    "instance_rsid": "177N0Q6ENPOGG",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-08-31T22:18:04+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2a",
    "datacenter_name": "us-west-2a",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::c1.medium",
    "instance_type_name": "c1.medium",
    "instance_name": "PROD App Server Tier #30",
    "server_template_id": 327686003,
    "server_template_name": "PHP App Server (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 0,
    "incarnator_id": 226682003,
    "incarnator_type": "ServerArray",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-2b7f5b20",
    "instance_uid": "i-2b7f5b20",
    "instance_rsid": "E5O0I0TUFG6A4",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2014-08-31T22:18:10+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2a",
    "datacenter_name": "us-west-2a",
    "deployment_id": 444420003,
    "deployment_name": "3-Tier w/ DR",
    "instance_type_key": "5::c1.medium",
    "instance_type_name": "c1.medium",
    "instance_name": "PROD App Server Tier #31",
    "server_template_id": 327686003,
    "server_template_name": "PHP App Server (v13.5)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 0,
    "incarnator_id": 226682003,
    "incarnator_type": "ServerArray",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.0,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::1::i-6e0f579f",
    "instance_uid": "i-6e0f579f",
    "instance_rsid": "D0NMOTAUIF0B0",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-02-11T18:38:41+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 1,
    "cloud_name": "EC2 us-east-1",
    "datacenter_key": "1::us-east-1e",
    "datacenter_name": "us-east-1e",
    "instance_type_key": "5::m1.medium",
    "instance_type_name": "m1.medium",
    "instance_name": "Webinar Instance",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 29927,
    "provisioned_by_user_email": "shivan@rightscale.com",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 1.24040250261006,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-f3cdc9ff",
    "instance_uid": "i-f3cdc9ff",
    "instance_rsid": "DRAIJCSKGT9NU",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-02-24T15:31:20+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2b",
    "datacenter_name": "us-west-2b",
    "instance_type_key": "5::t1.micro",
    "instance_type_name": "t1.micro",
    "instance_name": "Ubuntu_10.04_x64_v5.8.8_EBS",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.285149998038092,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::1::i-3b1463d4",
    "instance_uid": "i-3b1463d4",
    "instance_rsid": "32HR4HIEOIAPQ",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-03-02T20:08:58+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 1,
    "cloud_name": "EC2 us-east-1",
    "datacenter_key": "1::us-east-1a",
    "datacenter_name": "us-east-1a",
    "deployment_id": 59344,
    "deployment_name": "Default",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "AWS VPC NAT",
    "server_template_id": 352499003,
    "server_template_name": "AWS VPC NAT ServerTemplate (v14.0.1)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "incarnator_id": 1078304003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.627330002138831,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::1::i-d3eba623",
    "instance_uid": "i-d3eba623",
    "instance_rsid": "26F7T1MKMNV92",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-03-18T07:17:58+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 1,
    "cloud_name": "EC2 us-east-1",
    "datacenter_key": "1::us-east-1e",
    "datacenter_name": "us-east-1e",
    "instance_type_key": "5::t1.micro",
    "instance_type_name": "t1.micro",
    "platform": "Linux/UNIX",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.285150000832628,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::1::i-78fbb688",
    "instance_uid": "i-78fbb688",
    "instance_rsid": "6TQKASRQAHTFR",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-03-18T07:32:38+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 1,
    "cloud_name": "EC2 us-east-1",
    "datacenter_key": "1::us-east-1e",
    "datacenter_name": "us-east-1e",
    "instance_type_key": "5::m3.medium",
    "instance_type_name": "m3.medium",
    "instance_name": "BrunoWinRl6",
    "platform": "Windows",
    "provisioned_by_user_id": 65467,
    "provisioned_by_user_email": "bruno.ciscato@rightscale.com",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 1.8962475,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::1::i-27f0bdd7",
    "instance_uid": "i-27f0bdd7",
    "instance_rsid": "7H7DRFTDIIJTV",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-03-18T07:43:01+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 1,
    "cloud_name": "EC2 us-east-1",
    "datacenter_key": "1::us-east-1e",
    "datacenter_name": "us-east-1e",
    "instance_type_key": "5::m3.medium",
    "instance_type_name": "m3.medium",
    "platform": "Windows",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 1.89624750291484,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::6::i-ecfb441b",
    "instance_uid": "i-ecfb441b",
    "instance_rsid": "5VCMP5QPSD1JE",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-15T17:54:13+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 6,
    "cloud_name": "EC2 us-west-2",
    "datacenter_key": "6::us-west-2a",
    "datacenter_name": "us-west-2a",
    "deployment_id": 509558003,
    "deployment_name": "CM future",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "Base ServerTemplate for Linux",
    "server_template_id": 349567003,
    "server_template_name": "Base ServerTemplate for Linux (RSB) (v13.5.11-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 65467,
    "provisioned_by_user_email": "bruno.ciscato@rightscale.com",
    "incarnator_id": 1108563003,
    "incarnator_type": "Server",
    "state": "booting",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.237030928163065,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2179::i-a86ef4a19",
    "instance_uid": "i-a86ef4a19",
    "instance_rsid": "DUEJS384V0DR6",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-22T17:13:34+00:00",
    "cloud_vendor_name": "Microsoft Azure",
    "cloud_id": 2179,
    "cloud_name": "Azure East US",
    "datacenter_key": "2179::",
    "deployment_id": 511869003,
    "deployment_name": "ROL  - test-drbcsluw0j7n",
    "instance_type_key": "8::large",
    "instance_type_name": "large",
    "instance_name": "Tier 1 - LB 1",
    "server_template_id": 357605003,
    "server_template_name": "Load Balancer with HAProxy (v13.5.11-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 73964,
    "provisioned_by_user_email": "hassan+ca_demo2@rightscale.com",
    "incarnator_id": 1112104003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 3.4218,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-4c7b94aa",
    "instance_uid": "i-4c7b94aa",
    "instance_rsid": "6LEBNHRMSG2NK",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:55:03+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "Tier 1 - LB 1",
    "server_template_id": 342260003,
    "server_template_name": "Load Balancer with HAProxy (v13.5.5-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "incarnator_id": 1113268003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.670102480866756,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-d27a9534",
    "instance_uid": "i-d27a9534",
    "instance_rsid": "9AUU3K1FFHB9B",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:55:12+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.small",
    "instance_type_name": "m1.small",
    "instance_name": "Tier 1 - LB 2",
    "server_template_id": 342260003,
    "server_template_name": "Load Balancer with HAProxy (v13.5.5-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "incarnator_id": 1113269003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 0.67010251530678,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-dc7a953a",
    "instance_uid": "i-dc7a953a",
    "instance_rsid": "E71NE48BETG0B",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:55:30+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "Tier 3 - DB 1",
    "server_template_id": 342262003,
    "server_template_name": "Database Manager for MySQL 5.5 (v13.5.8-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "incarnator_id": 1113270003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 2.70892500765358,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-407b94a6",
    "instance_uid": "i-407b94a6",
    "instance_rsid": "31LF0R9GP4VFV",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:55:53+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "Tier 3 - DB 2",
    "server_template_id": 342262003,
    "server_template_name": "Database Manager for MySQL 5.5 (v13.5.8-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 81064,
    "provisioned_by_user_email": "mitchell.gerdisch@rightscale.com",
    "incarnator_id": 1113271003,
    "incarnator_type": "Server",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 2.708925,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-a3789745",
    "instance_uid": "i-a3789745",
    "instance_rsid": "984UMQHKNMOJS",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:59:06+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "Tier 2 - PHP App Servers #1",
    "server_template_id": 342261003,
    "server_template_name": "PHP App Server (v13.5.5-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 0,
    "incarnator_id": 321402003,
    "incarnator_type": "ServerArray",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 2.70892500765579,
    "estimated_managed_rcu_count_for_period": 0.0
  },
  {
    "kind": "ca#instance",
    "instance_key": "30601::2::i-ae789748",
    "instance_uid": "i-ae789748",
    "instance_rsid": "336M51DJU24K0",
    "account_id": 30601,
    "account_name": "[RS Demo] Hybrid Cloud",
    "instance_start_at": "2015-05-27T22:59:12+00:00",
    "cloud_vendor_name": "Amazon Web Services",
    "cloud_id": 2,
    "cloud_name": "EC2 eu-west-1",
    "datacenter_key": "2::eu-west-1a",
    "datacenter_name": "eu-west-1a",
    "deployment_id": 513156003,
    "deployment_name": "test lamp with new relic reporting-xd86s6tm0klv",
    "instance_type_key": "5::m1.large",
    "instance_type_name": "m1.large",
    "instance_name": "Tier 2 - PHP App Servers #2",
    "server_template_id": 342261003,
    "server_template_name": "PHP App Server (v13.5.5-LTS)",
    "platform": "Linux/UNIX",
    "provisioned_by_user_id": 0,
    "incarnator_id": 321402003,
    "incarnator_type": "ServerArray",
    "state": "operational",
    "total_usage_hours": 14.2575,
    "estimated_cost_for_period": 2.70892498468829,
    "estimated_managed_rcu_count_for_period": 0.0
  }
]
```
###
]]]

This returns the 21 instances listed by the count call, but in much more detail.

## Next Steps

The [Optima API reference][casapi] contains detailed descriptions of the calls available and their parameters.

[casapi]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/
[cb]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-CloudBills
[cbm]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-CloudBillMetrics
[im]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-InstanceMetrics
[i]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-Instances
[iup]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-InstanceUsagePeriods
[jq]: http://stedolan.github.io/jq/
[cb-fo]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-CloudBills/filter_options
[cc-gts]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-CustomCosts/grouped_time_series
[im-cc]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-InstanceMetrics/current_count
[i-i]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-Instances/index
[tags]: /cm/rs101/tagging.html
[im-o]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-InstanceMetrics/overall
[i-fo]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/1.0/controller/V1-ApiResources-Instances/filter_options
