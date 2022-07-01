---
title: Common Bill Ingestion
layout: optima_layout
description: Describes the Common Bill Ingestion feature, which allows for the ingestion of diverse billing and usage data into Optima
---

## Overview

Common Bill Ingestion (CBI) is a feature of Optima allowing the ingestion of public, private, and custom cloud billing data for easy ad-hoc analysis along-side billing data from other sources. It is a common pipeline capable of ingesting virtually any cost or usage time-series billing data.

The sections in this page provide more detailed instructions for how to build CBI-friendly bills and integrate them into Optima.

### Sample Use-Cases

Below are just three of the common use-cases for when CBI may be used to integrate billing data:

* Adding custom costs to Optima
* Integrating internal (private cloud) costs and usage data
* Integrating infrastructure or container-based costs (such as Kubernetes or VMWare)

### Setup Flow

To connect a bill in Optima with CBI, the following steps are required:

1. Create a CBI Bill Connect using the [Optima Bill Connect API](https://reference.rightscale.com/optima-bill/#/CBIBillConnects)
1. Convert your billing data into the [CBI Default CSV Format](/optima/guides/common_bill_ingestion.html#cbi-default-format) [1]
1. Upload the bill into Optima using the [Optima Bill Upload API](https://reference.rightscale.com/optima-bill-upload/#)
1. Within a few hours you should see your billing data in Optima (could take up to 24 hours)

[1] Please contact your Flexera account manager and inquire about options if converting to the CBI Default CSV Format is difficult or not possible.

### Limitations

The CBI-related APIs and processing pipeline are production-ready. However, we are still making improvements as we identify more use-cases and collect customer feedback.

For this reason, some limitations currently exist, which may or may not be removed at a later time:

* Bills must be uploaded in the [CBI Default CSV Format](/optima/guides/common_bill_ingestion.html#cbi-default-format)
* The number of files per upload is limited [1]
* The size of a single, uploaded billing file is limited [1]
* The time between uploading a set of billing files is limited [1]

[1] See the [Optima Bill Upload API](https://reference.rightscale.com/optima-bill-upload/#) documentation for current limits. If your organization needs any of the above limits increased, please contact your Flexera account manager.

## CBI Default Format

To upload bills via CBI, the bills must first be structured in the CBI Default CSV format. The below table defines the CSV format and indicates what fields map to which Optima dimensions:

CSV Column | Optima Dimension | Required? | Meaning
---------- | ---------------- | --------- | -------
CloudVendorAccountID  | Cloud Vendor Account | NO | A unique ID for an "account" (may be used in Optima to assign costs to Billing Centers)
CloudVendorAccountName  | Cloud Vendor Account Name | NO | A human-readable name for the "account"
Category | Category | NO | The category this usage record belongs in (e.g. "Compute", "Storage", "Network", etc). Set to whatever categories make sense. See here for a [full list of public cloud example categories](/optima/reference/rightscale_dimensions.html#category)
InstanceType | Instance Type | NO | An identifier for common hardware configurations for VMs running a customer workload. For example, "m4.xlarge" (AWS), "D2 v3" (Azure), or "n1-standard-4" (GCP).
LineItemType | Line Item Type | NO | Indicates the type of information the line item is for, such as Usage, Tax, Fee, or Credit
ManufacturerName | Manufacturer Name | NO | The name of a company that manufactured or produced the service associated with this cost, e.g. Amazon, Microsoft, Google, etc.
Region | Region | NO | The physical region where a resource was consumed
ResourceGroup | Resource Group | NO | A unique identifier which can group resources together (if applicable)
ResourceType | Resource Type | NO | A loosely-defined concept; depends on the application, but generally indicates the type of resource consumed within a Service. For AWS, it is "product/productFamily" column in the HCUR bill. For Azure it is a combination of "MeterCategory" and "MeterSubCategory" fields. For GCP, it is the "sku.description" field of the BigQuery billing dataset.
ResourceID | Resource ID | NO | The id of a specific cloud resource. For AWS, it might be a bucket name or instance id. Equivalent for other clouds.
Service | Service | NO | The name of the high-level service consumed. For example, "AmazonS3" (AWS), "Microsoft.Compute" (Azure), or "Compute Engine" (GCP).
UsageType | Usage Type | NO | A loosely-defined concept; depends on the cloud, but generally indicates information about the kind of usage incurred. For AWS, it is "lineItem/usageType" (ex: "DiscountedUsage"). For Azure it is "MeterName" (ex. "Standard Transactions").
Tags | - | NO | Can be used for defining [Custom Dimensions](/optima/reference/custom_dimensions.html). Example: '{"environment": "Test", "department": "Sales", "cpu-count": "24"}'
UsageAmount | Usage Amount | YES | The amount of usage generated in this record in the units specified in UsageUnit (set to 0 if not needed)
UsageUnit | Usage Unit | YES | The units that the Usage Amount metric is reported in
Cost | Cost | YES | The total cost generated in this record in the currency specified by Currency
CurrencyCode | - | NO | The three-letter identifier of the currency for Cost (e.g. USD, CAD, GBP, EUR)
UsageStartTime | - | YES | A UTC time in the RFC3339 format time (e.g. "2006-01-02T15:04:05Z") representing when the usage started. (Note: If a cost record spans a period longer than a day, you will need to break it down into multiple records.)
InvoiceYearMonth | - | YES | The month this usage was billed/invoiced, for example "202003"
InvoiceID | Invoice ID | NO | The identifier for the invoice that this cost/usage was billed under, if any. Helpful for reconciliation of billing data with an invoice.

The first step toward structuring your data in the CBI Default CSV format is to determine the mapping of native bill fields to the CBI Default CSV fields. When determining your mapping from native fields to CBI Default CSV fields, it may be helpful to refer to the [Bill-based dimension documentation](/optima/reference/bill_data_dimensions.html) for similar mappings from existing public clouds.

## Creating CBI Bill Connects

A CBI Bill Connect creates an entry point in Optima, through which you will then be able to upload bills.<br/>
Currently, to create CBI Bill Connects, you must use the [Optima Bill Connect API](https://reference.rightscale.com/optima-bill/#/CBIBillConnects).<br/>

To create one (via [API](https://reference.rightscale.com/optima-bill/#/CBIBillConnects/CBIBillConnects_create)), you need to provide:
* An integration identifier (`cbi_integration_id`): this tells Optima how to parse your bills. For the CBI default CSV format, use: `cbi-oi-optima`;
* A bill identifier (`cbi_bill_identifier`): you can choose any alphanumeric (and `-` or `_`) sequence to uniquely identify this bill connect in your organization, e.g. `test-1`;
* A name (`cbi_name`), which is really just a "human-readable" description of this entry point, e.g. `A first test bill connect to try out CBI default CSV ingestion`;
* A set of parameters that can override the integration's defaults (`cbi_params`); pass an empty object (ie: `"cbi_params":{}`) if you don't have any parameters to pass.
Currently the only supported parameter is `optima_display_name`: it overrides the default "Cloud Vendor" dimension.

The id for your created bill connect will simply be: `<cbi_integration_id>-<cbi_bill_identifier>`. For instance: `cbi-oi-optima-test-1` (using the example values above).

You can create as many bill connects as you want for your organization.<br/>
Two bill connects may have the same integration id, provided their bill identifier differs, so that the resulting bill connect id is unique for your organization:
* `cbi-oi-optima-test-1`;
* `cbi-oi-optima-test-2`;
* etc.

## Uploading Bills

Once you have created a CBI Bill Connect (see section above), you can start uploading bills via the [Optima Bill Upload API](https://reference.rightscale.com/optima-bill-upload/#).
A typical sequence to upload a bill made of three files: `bill-part1.csv`, `bill-part2.csv`, and `bill-part3.csv` would be as follows:
1. [Create a bill upload](https://reference.rightscale.com/optima-bill-upload/#/BillUpload/BillUpload_create); to do so, you pass the bill connect id (e.g. `cbi-oi-optima-test-1`), and the billing period, which currently means the billing month in `YYYY-MM` format, e.g. `2020-09`;
1. The bill upload id (e.g. `0ae0f4c1-7c3a-4172-bcce-e96b9927fa07`) is returned to you in the response from the API; you can now [upload](https://reference.rightscale.com/optima-bill-upload/#/BillUpload/BillUpload_createFile) the three files (in sequence, or in parallel);
1. When you upload a file, the response (if successful) will give you a MD5 hash so that you can check whether the uploaded file matches your original one;
1. Once all the files have been successfully uploaded, you can [commit this bill upload](https://reference.rightscale.com/optima-bill-upload/#/BillUpload/BillUpload_createOperation), via the `commit` operation; this will trigger the processing of this bill.

If after uploading the files, or at any stage after the creation of the bill upload, you want to discard without committing, use the `abort` operation instead.

Note: for a given bill connect, and a given billing period, you can only have one bill upload in progress (i.e. created, but not yet committed nor aborted).

## Monitoring & Alerting

Once committed, each bill upload is tracked through the processing system. If a delay is detected, the bill processing system will automatically retry processing. If this delay is not automatically resolved, Flexera Support is alerted and will investigate the issue. In the event that the delay is caused by invalid data being uploaded, Flexera support or your Flexera account manager will reach out to you to resolve the issue.
