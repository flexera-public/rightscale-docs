---
title: Connect Alibaba Cloud to Optima for Cost Reporting
layout: optima_alibaba_layout_page
description: This page walks you through the steps to connect Alibaba Cloud to Optima for cost reporting purposes.
---

## Overview

Optima integrates with Alibaba Cloud by ingesting billing data exported to an [Object Storage Service](https://www.alibabacloud.com/product/oss) bucket via the [SubscribeBillToOSS](https://www.alibabacloud.com/help/doc-detail/87993.htm?spm=a2c63.l28256.b99.32.c1607d446VovQW) API call. Once ingested into Optima, the data is made available for pre-built and ad-hoc analyses alongside other public, private, and custom billing data.

To gather cost and usage information from Alibaba, certain configuration steps must be performed with specific data and credentials being shared with Optima. This is currently a manual process assisted by Flexera, with an automated onboarding flow to follow in the future. Please contact your Flexera account manager for more details on setting up an Alibaba Cloud Bill Connect in Optima.

!!info*Note*Amortization is not currently supported.

## Configuration
<!-- markdownlint-disable -->
1. Create a [Bill Connect](https://docs.rightscale.com/optima/guides/common_bill_ingestion.html#creating-cbi-bill-connects).
[[[
### Bash
```bash
curl --header "Content-Type: application/json" --header "Authorization: Bearer <BEARER TOKEN>" --header "Api-Version: 1.0" --request POST --data '{ "cbi_bill_identifier": "1", "cbi_integration_id": "cbi-oi-alibaba", "cbi_name": "Alibaba", "cbi_params": { "optima_display_name": "Alibaba International", "vendor_name": "Alibaba" } }' https://onboarding.rightscale.com/api/onboarding/orgs/< ORG_ID >/bill_connects/cbi
```
###

### PowerShell
```powershell
$HEADERS = @{
    "Authorization"= "Bearer <BEARER TOKEN>";
    "Content-Type"= "application/json";
    "Api-Version"= "1.0";
}
$BODY = @{
    "cbi_bill_identifier"= "1";
    "cbi_integration_id"= "cbi-oi-alibaba";
    "cbi_name"= "Alibaba";
    "cbi_params"= @{ 
        "optima_display_name"= "Alibaba International";
        "vendor_name"= "Alibaba";
    }
} | ConvertTo-Json -Depth 10
Invoke-RestMethod -Uri "https://onboarding.rightscale.com/api/onboarding/orgs/< ORG_ID >/bill_connects/cbi" -Headers $HEADERS -Method Post -Body $BODY
```
###
]]]

<!-- markdownlint-restore -->
* Configure Alibaba Function to upload files to CBI. [Example](https://github.com/flexera/optima-tools/tree/master/alibaba).

!!info*Note*This tool is customer contributed and not supported by Flexera.

## Additional Info

If you have any questions or would like assistance, please join our community at [community.flexera.com](https://community.flexera.com/) or email us at [support@flexera.com](mailto:support@flexera.com).
