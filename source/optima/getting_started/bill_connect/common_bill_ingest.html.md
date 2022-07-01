---
title: Connect a Common Bill Ingest Bill to RightScale for Cost Reporting
layout: optima_cbi_layout_page
description: This page walks you through the steps to connect a Common Bill Ingest Bill to RightScale for cost reporting purposes.
---

## Background

Common Bill Ingestion (CBI) is a feature in Optima allowing the ingestion of virtually any kind of time-series billing data into Optima. Multiple use-cases might warrant connecting CBI bills to Optima, such as custom cloud or plugin costs, internal/private cloud billing data, or public clouds not natively supported in Optima.

For more details on CBI, please refer to the [Common Bill Ingestion](/optima/guides/common_bill_ingestion.html) documention.

## Overview

In order to ingest custom billing data to Optima, please refer to the [CBI Setup Flow](/optima/guides/common_bill_ingestion.html#overview) intructions. These instructions will provide an overview for how to create a CBI Bill Connect and upload it to Optima.

## Required Information

In order to create a CBI Bill Connect via the [Optima Bill Connect API](https://reference.rightscale.com/optima-bill/#/CBIBillConnects), you will need the following information:

Parameter | Value | Note
--------- | ----- | ----
cbi_integration_id | cbi-oi-optima | The integration ID indicating which integration to use to process the CBI bill. **Must be "cbi-oi-optima" for a bill in the [CBI Default CSV format](/optima/guides/common_bill_ingestion.html#cbi-default-format).**
cbi_bill_identifier | --anything-- | A unique identifier within your Flexera Org for this particular bill, e.g. "custombill-1".
cbi_name | --anything-- | A human-readable description of the bill connect, e.g. "My Custom Bill 1".
cbi_params | {"optima_display_name": "--anything--"} | A JSON object indicating the desired name to display in Optima for this bill connect.

## Submit the Information

Follow the [CBI Setup Flow](/optima/guides/common_bill_ingestion.html#overview) to submit the above information to Optima.
