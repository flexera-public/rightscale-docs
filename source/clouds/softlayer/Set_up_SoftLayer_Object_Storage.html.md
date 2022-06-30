---
title: Set up SoftLayer Object Storage
layout: softlayer_layout_page
description: This page outlines the steps for setting up SoftLayer's Object Storage and creating the required credentials for a SoftLayer cloud account.
---

## Objective

To set up SoftLayer's Object Storage and create the required credentials for a SoftLayer cloud account.

## Prerequisites

* Access to log into a SoftLayer account.

## Steps

### Sign-up for Object Storage

1. Log into the SoftLayer account. 
2. Go to **CloudLayer** > **Object Storage** and click on the **Order Object Storage** text link.
3. Select the desired service option plan. (e.g. Object Storage - Pay as you go) and complete the sign-up process.

### Create Object Storage Credentials

In order to successfully save and retrieve objects from a container in SoftLayer's Object Storage, you must provide a valid user ID and API Key for authentication purposes. As a best practice, you should create credentials in the RightScale Dashboard (Design > Credentials), to keep these sensitive values hidden, but usable by related storage and retrieval scripts.

1. To locate the required Object Storage credentials, log into the SoftLayer management portal and go to **CloudLayer** > **Object Storage**. *Note*: If the SoftLayer account has more than one Tenant ID you must select one.
2. Select the geographic region (cloud) where you will create containers to store objects. (e.g. Amsterdam, Dallas, Singapore, etc.)
3. Click **View Credentials**.
4. Create user-defined credentials in the RightScale Dashboard for the Username and API Key values. *Note*: You do not need to create a credential for the Auth Endpoint value because RightScale already knows this value.
  * **SOFTLAYER\_USER\_ID** - The username of a SoftLayer user with API privileges. Use this credential for the "Backup Primary User" and/or the "Secondary Backup User" input if you are using SoftLayer Object Storage for primary and/or secondary backups. (e.g. SLOS22334-1:SL123456), where 'SLOS22334-1' is the Tenant ID and 'SL123456' is the Username.
  * **SOFTLAYER\_API\_KEY** -  The matching SoftLayer API Access Key for the specified SoftLayer user. Use this credential for the "Backup Primary Secret" and/or the "Secondary Backup Secret" input if you are using SoftLayer Object Storage for primary and/or secondary backups. (e.g. 68734787202aecdef123767678asdf72364872asdf468273478237as287df67)

## See also

- [Create a New SoftLayer Object Storage Container](Create_a_New_SoftLayer_Object_Storage_Container.html)
- [Upload Files to a SoftLayer Object Storage Container](Upload_Files_to_a_SoftLayer_Object_Storage_Container.html)
