---
title: Bill-based data dimensions in Optima cost reporting
layout: optima_layout
description: Describes the bill-based data dimensions in Optima and where they are derived from
---

## Overview

Cost dimensions allow you to slice and dice your cost information to provide insights on spend and potential savings. This page describes the bill-based cost dimensions, but there are also [RightScale-generated dimensions](rightscale_dimensions.html) and [custom dimensions](custom_dimensions.html).

Bill-based cost dimensions are dimensions whose values are derived directly from data in the cloud provider bill. These dimensions are generally not modified (or only lightly modified) and represent a true representation of the data in the bill. When the provider adds new values for these dimensions (such as adding a new resource type), the data is immediately available in RightScale.

## Bill-based dimension reference information

The specific mappings from the vendor data to RightScale dimensions can be found for each vendor below. Note that some dimensions are available only in the [Monthly CSV Report](/optima/guides/exporting_data.html#monthly-csv-reports) exports.

### Amazon Web Services

Data for AWS is sourced from the [cost and usage report](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-reports-costusage.html) CSV from AWS. The source columns below are the column names that correlate to data in those billing files.

Optima dimension | Source column | Notes
---------------- | ------------- | -----
Cloud Vendor | N/A | Always `Amazon Web Services`
Cloud Vendor Account | `lineItem/UsageAccountId` | [AWS documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/enhanced-lineitem-columns.html)
Instance Type | `product/instanceType` | Not available for all resources. [AWS documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/enhanced-product-columns.html)
Region | `product/location` | [AWS documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/enhanced-product-columns.html)
Resource Type | `product/productFamily` | [AWS documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/enhanced-product-columns.html)
Service | `lineItem/ProductCode` | [AWS documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/enhanced-lineitem-columns.html)
Resource ID | `lineItem/ReesourceId` | _Monthly Export Only_ <br/>
Resource Name | `resourceTags/user:Name` | _Monthly Export Only_
Usage Type | `lineItem/UsageType` |  _Monthly Export Only_ <br/> If `lineItem/LineItemType` is `DiscountedUsage` or UsageType matches `HeavyUsage`, `MediumUsage`, or `LightUsage`, UsageType is set to "DiscountedUsage". <br/> Additionally if `lineItem/LineItemType` is `Tax` or `Fee` (ie. does not contains `Usage`), `lineItem/LineItemType` is appended to UsageType to differentiate Tax and Fee from Usage type.
Resource Group | |  _Monthly Export Only_ <br/> N/A for AWS
Datacenter | `lineItem/AvailabilityZone` |  _Monthly Export Only_

### Google

Data for Google Cloud Platform is sourced from the [BigQuery billing export](https://cloud.google.com/billing/docs/how-to/export-data-bigquery) from GCP. The source columns below are the column names that correlate to the fields in BigQuery. Reference information for all [fields from Google BigQuery billing exports can be found here](https://cloud.google.com/billing/docs/how-to/export-data-bigquery).

Optima dimension | Source column | Notes
---------------- | ------------- | -----
Cloud Vendor | N/A | Always `Google`
Cloud Vendor Account | `project.id` |
Instance Type |  | Not currently available from Google source data
Region | |  Not currently available from Google source data
Resource Type | `sku.description` |
Service | `service.description` |
Resource ID | | _Monthly Export Only_ <br/> Resource-level is not yet available in GCP, so this field is a unique identifier for the type of usage represented by this cost.
Resource Name | | _Monthly Export Only_ <br/> N/A for Google
Usage Type | |  _Monthly Export Only_ <br/> N/A for Google
Resource Group | |  _Monthly Export Only_ <br/> N/A for Google
Datacenter | |  _Monthly Export Only_ <br/> N/A for Google

### Microsoft Azure Enterprise Agreement

Data for Microsoft Azure is sourced from the Enterprise billing Usage Details API. The source columns below are the fields from that API response. Reference information for all [fields from the Azure billing API can be found here](https://docs.microsoft.com/en-us/rest/api/billing/enterprise/billing-enterprise-api-usage-detail#usage-details-field-definitions).

Optima dimension | Source column | Notes
---------------- | ------------- | -----
Cloud Vendor | N/A | Always `Microsoft Azure`
Cloud Vendor Account | `subscriptionGuid` |
Instance Type | `additionalInfo.serviceType` |
Region | `resourceLocation` |  Falls back to `meterRegion` if the location can't be mapped. Values are normalized to a common format
Resource Type | `meterCategory`-`meterSubCategory` | SubCategory is excluded if it's the same as Category.<br/>"Marketplace Charge-[PublisherName]" for marketplace charges.<br/>"Reservation Order-[Description]" for Reserved Instance charges.
Service | `consumedService` | Prepends "Microsoft." if not already present.<br/>Always "Microsoft.Marketplace" for marketplace charges.<br/>Always "Microsoft.Reservation" for Reserved Instance charges.
Resource ID | `instanceId` | _Monthly Export Only_ <br/>
Resource Name | | _Monthly Export Only_ <br/> N/A for Azure
Usage Type | `meterName` |  _Monthly Export Only_ <br/>
Resource Group | `resourceGroup` |  _Monthly Export Only_ <br/>
Datacenter | |  _Monthly Export Only_ <br/> N/A for Azure

