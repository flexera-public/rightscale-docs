---
title: Connect Google Cloud Platform to Optima for Cost Reporting
layout: optima_google_layout_page
description: This page walks you through the steps to connect Google Cloud Platform (GCP) to Optima for cost reporting purposes.
alias: clouds/google/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html
alias: clouds/google/getting_started/google_connect_gce_to_rightscale.html
alias: clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html
---

## Background

Optima uses **bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed with specific data and credentials being shared with Optima.

This page describes the configuration and input information needed to connect Google billing data to Optima using BigQuery billing exports.

For instructions on using Optima to add or update billing information, see [the billing information guide](index.html).
For instructions on connecting your cloud accounts to the platform for management purposes, see the [cloud account management guide](/ca/ca_getting_started.html#connecting-clouds)

If you have any questions and would like live assistance, please join us on our chat channel on [chat.rightscale.com](http://chat.rightscale.com) or email us at [support@rightscale.com](mailto:support@rightscale.com).

## Overview

This page walks you through the steps to connect your Google cloud billing data to RightScale for cost reporting purposes.

The following steps must be completed in order for RightScale to provide insight on your Google cloud bill:
1. [Enable Billing Data Export to BigQuery in GCE](#enable-billing-data-export-to-bigquery-in-gce)
2. [Allow RightScale to access the BigQuery dataset](#allow-rightscale-to-access-the-bigquery-dataset-using-a-service-account)

Each of the steps above is explained in detail on this page.

## Enable Billing Data Export to BigQuery in GCE

RightScale consumes the billing data via the [BigQuery export method in Google](https://cloud.google.com/billing/docs/how-to/export-data-bigquery). This can be enabled in GCE for each Billing Account and will contain data for all projects in that Billing Acccount.

!!info*Why?*RightScale uses BigQuery billing data as the source for billing information because the data is more complete [(per Google)](https://cloud.google.com/billing/docs/how-to/export-data-bigquery). The estimated cost for BigQuery for billing purposes is no more than $100/yr for extremely large usage amounts (lesser usage will incur less cost). In some cases, the cost will be $0 as the entire usage will fall in the free tier of BigQuery.

If you have already configured billing export to BigQuery, please ensure you have the `Dataset ID` and `Project` that contains the dataset, and proceed to the next step.

If you need to configure data export to BigQuery, please [follow the instructions provided by Google](https://cloud.google.com/billing/docs/how-to/export-data-bigquery#how_to_enable_billing_export_to_bigquery_name_short) for your Google billing accounts.

Take note of the `Dataset ID` when you create the dataset as well as the `Project` in which the dataset exists.

!!warning*Dataset ID*Note that the Dataset ID is sometimes shown prepended with the project ID. For example, `project_id:dataset_id`. In this case, please ensure you submit only the _Dataset ID_ when registering your bill.

## Determine ID of the Google Billing Account that pays for this bill's GCP resources

A Cloud Billing Account is a Google construct for managing usage and billing records for GCP resources payed for by a common entity. For more information on Google Cloud Billing Accounts, please see the GCP [Overview of Cloud Billing Concepts](https://cloud.google.com/billing/docs/concepts).

To determine your Google Billing Account ID, [navigate here](https://console.cloud.google.com/billing) and take note of the "Billing account ID" circled in green below containing the billing data your wish to onboard.

![gcp-billing-account-id-screen.png](/img/gcp-billing-account-id-screen.png)

_Note: If you are unable to view any billing accounts in the above UI, please confirm that your user has the required Google privileges._

## Allow RightScale to access the BigQuery dataset using a Service Account

Once your billing data is being exported to BigQuery, RightScale needs access to the BigQuery dataset to read the data. The RightScale platform uses a Google Service Account to gain access to the BigQuery dataset.

Create or identify which [Google Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating_a_service_account) you want to use for this permission, and ensure you have access to the [JSON private key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys) for the service account as well as the service account ID.

Once you have determined the service account you would like to use, the following steps must be completed:

### Grant project-level IAM roles

The first step is to grant the service account the roles necessary to interact with BigQuery within the project.

1. In Google Cloud Platform, navigate to the "IAM" menu
2. Ensure the selected project is the on that contains the billing BigQuery dataset
3. Click on the "Add" icon at the top of the window
4. Enter the service account ID in the "New members" field
5. Select the `BigQuery Job User` role
  * BigQuery Job User - needed to [create query jobs](https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs/query) from which results can be read (currently 2 jobs per day are created)
6. Click "Save"

    ![gce-bigquery-creds-step1.png](/img/gce-bigquery-creds-step1.png)

### Share the dataset with the service account

Additionally, the BigQuery dataset must explicitly be shared with the service account.

1. In Google Cloud Platform, [navigate to BigQuery](https://bigquery.cloud.google.com/)
2. Select the dataset that contains your billing data
3. In the dataset details pane, select "SHARE DATASET"

    ![gce-bigquery-creds-step1.png](/img/gce-bigquery-creds-step2.png)

4. In the "Add members" box, enter the service account ID
5. From the "Select a role" drop down, select "BigQuery" > "BigQuery Data Viewer"
6. Click "Add"
7. Click "Done"

    ![gce-bigquery-creds-step1.png](/img/gce-bigquery-creds-step3.png)

## Submit the information

Follow the [billing configuration guide](/optima/guides/billing_configuration.html) to submit the above information to Optima
