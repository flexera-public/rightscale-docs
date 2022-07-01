---
title: CloudAccounts
layout: general.slim
---

In RightScale, a **Cloud Account** represents a specific account (or subscription, project, etc) in a cloud vendor. Such accounts can be registered with the RightScale Cloud Management platform to provide visibility and management of resources in that account.

This API allows you to list, register, and update cloud accounts with the RightScale platform.

Not all clouds support API-based registration and credential update. The following table lists the supported clouds and the relevant parameters. Note that for many clouds, each region must be registered separately and must be the same cloud account.

## Supported clouds and parameters

### AWS

| Create | Update | **Cloud** | **cloud_href value** | **Required Parameters** | **Optional Parameters** |
| ------ | ------ | --------- | -------------------- | ----------------------- | ----------------------- |
| x |   | AWS US-East | /api/clouds/1 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS EU | /api/clouds/2 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS US-West | /api/clouds/3 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS AP-Singapore | /api/clouds/4 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS AP-Tokyo | /api/clouds/5 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS US-Oregon | /api/clouds/6 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS SA-Sao Paulo | /api/clouds/7 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS AP-Sydney | /api/clouds/8 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS EU-Frankfurt | /api/clouds/9 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS China | /api/clouds/10 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS US-Ohio | /api/clouds/11 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS AP-Seoul | /api/clouds/12 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS EU-London | /api/clouds/13 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |
| x |   | AWS CA-Central | /api/clouds/14 | aws\_account\_number, aws\_access\_key\_id, aws\_secret\_access\_key | ec2\_key, ec2\_cert |

Note: The AWS China region is not yet supported as a public cloud. Customers who wish to use AWS resources in China are required to create an AWS (China) Account which includes a set of credentials that are distinct and separate from other global AWS Accounts. Only customers with an AWS (China) Account will be able to use resources operated in the AWS China (Beijing) region.

### Google

| Create | Update | **Cloud** | **cloud_href value** | **Required Parameters** | **Optional Parameters** |
| ------ | ------ | --------- | -------------------- | ----------------------- | ----------------------- |
| x | x | Google | /api/clouds/2175 | project (create only) | client\_email & private\_key **or** json

### Microsoft Azure

| Create | Update | **Cloud** | **cloud_href value** | **Required Parameters** | **Optional Parameters** |
| ------ | ------ | --------- | -------------------- | ----------------------- | ----------------------- |
| x | x | AzureRM West US | /api/clouds/3518 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Japan East | /api/clouds/3519 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Southeast Asia | /api/clouds/3520 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Japan West | /api/clouds/3521 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM East Asia | /api/clouds/3522 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM East US | /api/clouds/3523 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM West Europe | /api/clouds/3524 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM North Central US | /api/clouds/3525 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Central US | /api/clouds/3526 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Canada Central | /api/clouds/3527 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM North Europe | /api/clouds/3528 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Brazil South | /api/clouds/3529 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Canada East | /api/clouds/3530 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM East US 2 | /api/clouds/3531 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM South Central US | /api/clouds/3532 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Australia East | /api/clouds/3537 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Australia Southeast | /api/clouds/3538 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM West US 2 | /api/clouds/3546 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM West Central US | /api/clouds/3547 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM UK South | /api/clouds/3567 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM UK West | /api/clouds/3568 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM West India | /api/clouds/3569 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Central India | /api/clouds/3570 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM South India | /api/clouds/3571 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Korea Central | /api/clouds/3749 | client_id, client_secret, tenant_id, subscription_id |
| x | x | AzureRM Korea South | /api/clouds/3756 | client_id, client_secret, tenant_id, subscription_id |

### Softlayer

| Create | Update | **Cloud** | **cloud_href value** | **Required Parameters** | **Optional Parameters** |
| ------ | ------ | --------- | -------------------- | ----------------------- | ----------------------- |
| x |   | SoftLayer | /api/clouds/1869 | api\_key, username | &nbsp; |

## Index

### API 1.5

[CM 1.5 Cloud Accounts API](https://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#index) lists all the cloud accounts available in our RightScale account. The API requires `observer` role.

**Sample Response**

~~~
{
  "created_at": "2018/06/18 17:47:49 +0000",
  "updated_at": "2018/06/18 17:47:49 +0000",
  "links": [
    {"rel":"self","href":"/api/cloud_accounts/7773"},
    {"rel":"cloud","href":"/api/clouds/888"},
    {"rel":"account","href":"/api/accounts/69444075"}
  ]
}
~~~

### API 1.6

[CM 1.6 Cloud Accounts API](https://reference.rightscale.com/api1.6/index.html#/1.6/controller/V1_6-Definitions-CloudAccounts/index) is the upgraded version and exposes all cloud accounts registered in the RightScale account. The index call will return the subscription-id for Azure, Account id for AWS, and Project name for Google in the `tenant_uid` field of the response. The API requires `observer` role on any account. We recommend using API 1.6 over 1.5.

**Sample Response**

~~~
{
  "id": 123,
  "href": "/api/cloud_accounts/123",
  "kind": "cm#cloud_account",
  "tenant_uid": "123412341234",
  "timestamps": {
    "created_at": "2014-11-10T16:15:22+00:00",
    "updated_at": "2014-11-10T16:15:23+00:00"
  },
  "links": {
    "cloud": {
      "id": 1,
      "href": "/api/clouds/1",
      "name": "EC2 us-east-1",
      "kind": "cm#cloud",
      "cloud_type": "amazon",
      "region": "us-east-1"
    },
    "account": {
      "id": 123,
      "href": "/api/accounts/123",
      "name": "TestAccount",
      "kind": "cm#account"
    }
  }
}
~~~

## Create

### Azure Resource Manager

The below demonstrates registering an Azure Resource Manager subscription with a RightScale account using cookie-based auth -- it is possible to use OAuth as well.

#### curl

~~~
curl --request POST "https://us-3.rightscale.com/api/cloud_accounts" \
--data-urlencode cloud_account[creds][client_id]=<client_id> \
--data-urlencode cloud_account[creds][client_secret]=<client_secret> \
--data-urlencode cloud_account[creds][tenant_id]=<tenant_id> \
--data-urlencode cloud_account[creds][subscription_id]=<subscription_id> \
--include \
-d "cloud_account[cloud_href]=<cloud href>" \
-H "X-API-Version:1.5" \
-b mycookie"
~~~

### Google

When registering a Google project, you can either provide the JSON key content file directly, or provide the individual credential components as separate attributes. When providing separate attributes, they can either be in a JSON hash, or can be individual URL parameters.

The below demonstrates 3 different methods for registering a GCE project with a RightScale account.

#### curl

~~~
#!/bin/sh -e
PROJECT_ID="project_id"
CLIENT_EMAIL="service account email" 
PRIVATE_KEY="private key\ncontent"
CLOUD_HREF="/api/clouds/2175"
 
# Using the JSON key file 
curl -i -H X_API_VERSION:1.5 -b mycookie \
-d cloud_account[cloud_href]=$CLOUD_HREF \
—data-urlencode cloud_account[creds][project]=$PROJECT_ID \
—data-urlencode cloud_account[creds][json]@credentials.json \
-X POST https://my.rightscale.com/api/cloud_accounts

# Specifying the JSON manually 
curl -i -H X_API_VERSION:1.5 -b mycookie \
-d cloud_account[cloud_href]=$CLOUD_HREF \
—data-urlencode cloud_account[creds][project]=$PROJECT_ID
—data-urlencode cloud_account[creds][json]='{"client_email": $CLIENT_EMAIL, "private_key": "$PRIVATE_KEY"}' \
-X POST https://my.rightscale.com/api/cloud_accounts

# Specifying the values manually  
curl -i -H X_API_VERSION:1.5 -b mycookie \
-d cloud_account[cloud_href]=$CLOUD_HREF \
—data-urlencode cloud_account[creds][project]=$PROJECT_ID \
—data-urlencode cloud_account[creds][client_email]=$CLIENT_EMAIL \
—data-urlencode cloud_account[creds][private_key]="$PRIVATE_KEY" \
-X POST https://my.rightscale.com/api/cloud_accounts
~~~

## Update

### Azure Resource Manager

When updating a registration, you may only update the credentials for an already registered subscription. If you need to register a different subscription, first **delete** the CloudAccount, and then re-create one with the new subscription (all resources in RightScale will be removed).

When updating a registration that was previously registered using [an Azure AD Application via the API](/clouds/azure_resource_manager/getting_started/register_using_ad_application.html), at least one of the credential attributes must be provided.

When updating a registration that was previously registered using [the RightScale Service Principal via the UI](/clouds/azure_resource_manager/getting_started/register.html), **all** of the credential attributes must be provided.

#### curl

~~~
curl -i -X PUT https://us-3.rightscale.com/api/cloud_accounts/<cloud_account_id> \
--data-urlencode cloud_account[creds][client_id]=<client_id> \
--data-urlencode cloud_account[creds][client_secret]=<client_secret> \
--data-urlencode cloud_account[creds][tenant_id]=<tenant_id> \
-H X_API_VERSION:1.5 \
-b mycookie"
~~~

### Google

When updating a registration, you may only update the credentials for an already registered project. If you need to register a different project, first **delete** the CloudAccount, and then re-create one with the new project (all resources in RightScale will be removed).

The below demonstrates 3 different methods for updating GCE project credentials associated with a RightScale account. 

#### curl

~~~
#!/bin/sh -e
CLIENT_EMAIL="service account email"
PRIVATE_KEY="private_key\ncontent"
CLOUD_ACCOUNT_ID="cloud account id"

# Using the JSON key file 
curl -i -H X_API_VERSION:1.5 -b mycookie \
—data-urlencode cloud_account[creds][json]@credentials.json \
-X PUT https://my.rightscale.com/api/cloud_accounts/$CLOUD_ACCOUNT_ID

# Specifying the JSON manually 
curl -i -H X_API_VERSION:1.5 -b mycookie \
—data-urlencode cloud_account[creds][json]='{"client_email": $CLIENT_EMAIL, "private_key": "$PRIVATE_KEY"}' \
-X PUT https://my.rightscale.com/api/cloud_accounts/$CLOUD_ACCOUNT_ID
 
# Specifying the value manually 
curl -i -H X_API_VERSION:1.5 -b mycookie \
—data-urlencode cloud_account[creds][client_email]=$CLIENT_EMAIL \
—data-urlencode cloud_account[creds][private_key]="$PRIVATE_KEY" \
-X PUT https://my.rightscale.com/api/cloud_accounts/$CLOUD_ACCOUNT_ID
~~~
