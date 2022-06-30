---
title: Connect Google Cloud Platform to RightScale for Cloud Management
layout: google_layout_page
description: This page walks you through the steps to connect Google Cloud Platform (GCP) to RightScale for cloud management.
alias: clouds/google/google_connect_gce_to_rightscale.html
---

## Overview

Register your Google Compute Engine cloud account with RightScale so that you can use the Dashboard to manage your Google Compute Engine cloud resources. 

RightScale uses [Google Service Accounts](https://cloud.google.com/iam/docs/understanding-service-accounts) to interact with your Google Cloud Platform project. The Service Account does not need to exist in the project that you are registering, but it must have access to the project as defined below.

## Prerequisites

* You have the [project ID of the project](https://support.google.com/cloud/answer/6158840?hl=en) you wish to register 
* The project has [Google Cloud APIs enabled](https://support.google.com/cloud/answer/6158841?hl=en) (this is the default setting for cloud projects) 
* A [Google Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating_a_service_account) has been created 
* You have the [JSON private key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys) for the service account
* You have enough privileges on the project to grant the service account an IAM role (for example, 'Project Owner')
* You have `admin` or `enterprise_manager` on the RightScale account you wish to register the project with
* The RightScale account does not currently have a Google project registered with it

## Connecting RightScale to GCE

### Grant the service account IAM access to the project

In order for the service account to be able to manipulate resources in the project, it must be granted an IAM role on the project. When granting roles, you can use either the `Viewer` role to grant RightScale read-only access, or the `Editor` role to take full advantage of the features in RightScale. 

Follow the steps below to add the IAM role to the service account if this is not already configured.

1. In [Google cloud console](https://console.cloud.google.com), navigate to the project you wish to register

2. From the left menu, select "IAM & admin" -> "IAM"
    ![google-register-1-iam-menu.png](/img/google-register-1-iam-menu.png)

3. Click the "Add" button on top of the IAM page
    ![google-register-2-add-iam-user.png](/img/google-register-2-add-iam-user.png)

4. Enter the ID of the service account and use the Roles dropdown to select Project -> Editor (or Project -> Viewer for read-only access) and click "Add"
    ![google-register-3-add-iam-user.png](/img/google-register-3-add-iam-user.png)

Now that the service account has access to the project, you can use the service account credentials to register the project with RightScale in the step below.

### Register the Project with RightScale

The following instructions are for registering using the Cloud Management UI. If you would prefer using an API call to register the project, see [the API documentation examples](/api/api_1.5_examples/cloudaccounts.html#create-curl)

In order for RightScale to interact with the Project, you must provide the service account credentials and specify which project to link to the RightScale account.

1. In RightScale, select the account you wish to register the project with

2. Using the top menu, select "Clouds" -> "Add Cloud" (note: if you do not see "Add cloud", you do not have enough permissions to add a cloud) and then press the "Connect to a Cloud" button
    ![google-register-4-add-cloud.png](/img/google-register-4-add-cloud.png)

3. Select "Google" from the list on the left (note: if you do not see "Google", this is because you have already registered a Google project with this RightScale account -- select a different account or [create a new RightScale account](/cm/dashboard/settings/enterprise/#actions-and-procedures-create-a-new-account) to register this project)

4. In the dialog that opens, enter the **Project ID** of the project you want to connect and upload the JSON key file for the service account
    ![google-register-5-enter-creds.png](/img/google-register-5-enter-creds.png)

5. Click Continue

6. The system will perform a quick check to ensure that the key file is correct and provides the required access to the Google Project

### Next Steps

Once you have registered your project, you will see that the Google cloud is "enabled" under the Clouds tab in the Dashboard. It may take several minutes, but all of your Google Compute Engine resources are now visible under the Clouds menu (Clouds > Google). 

### Update your account to use Service Account

First, ensure [you have met all of the prerequisites](#prerequisites) listed earlier on this page. 

It is considered best practices to rotate your keys periodically. To rotate service account credentials, first [create a new key for the service account](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys).

The following instructions are for updating credentials using the Cloud Management UI. If you would prefer using an API call to update credentials, see [the API documentation examples](/api/api_1.5_examples/cloudaccounts.html#update-curl).

Follow these steps in all RightScale accounts registered with projects using that service account:

1. In RightScale Cloud Management, navigate using the top menu to Settings -> Account Settings -> Clouds

2. Click on the pencil icon next to "Google" cloud
    ![google-register-update-1-pencil](/img/google-register-update-1-pencil.png)

3. Select the "Update service account credentials" option, select your new key file, and press "Update"
    ![google-register-update-2-upload-key.png](/img/google-register-update-2-upload-key.png)

Once all accounts have been updated with the new keys, you can delete the old key from Google.

### Why is RightScale requesting customers to use Google Service Accounts?

Google Service Accounts are new and were not available when RightScale implementd GCE support.

## TroubleShooting

### Error During Registration

If you are seeing a red error during registration that says something to the effect of: `Project 'your-project' is not accessible`, check the following:

* you have [enabled the Google Cloud APIs](https://support.google.com/cloud/answer/6158841?hl=en)
* the service account has IAM permissions on the project you are registering
* the key file you are using is still valid 
