---
title: Add a SoftLayer Cloud to a RightScale Account
layout: softlayer_layout_page
description: This page outlines the steps for registering your SoftLayer cloud account with RightScale so that you can use the RightScale Cloud Management Dashboard to manage your SoftLayer cloud resources.
---

## Objective

Register your SoftLayer cloud account with RightScale so that you can use the Dashboard to manage your SoftLayer cloud resources.

## Prerequisites

* If you do not have a SoftLayer cloud account, you must sign-up and create an [account](http://www.softlayer.com/) before you can complete this procedure.
* In order to add SoftLayer, you must be an 'admin' user of the RightScale account.
* Adequate priveleges on your SoftLayer cloud account.
* An existing RightScale account that you want to enable to manage your SoftLayer resources.

## Add SoftLayer to your Account

Take the following steps to add SoftLayer to your RightScale account.

1. After logging into the Dashboard, go to **Settings** > **Account Settings** > **Clouds**.
2. Click **Connect to a Cloud** and click the (+) icon next to SoftLayer.
3. Enter your SoftLayer cloud credentials.
  * **User ID** - The username used to log into the SoftLayer portal. (e.g. SL234567) In the SoftLayer portal, go to **Administrative > User Administration**.
  * **API Key** - The SoftLayer API Key that's required for managing user access to the SoftLayer API. Each user will have their own unique API Key. (e.g. 9a77337906046812e3a751ce33906046812839e4b9307dab58906046812ab5) In the SoftLayer portal, go to Administrative > API Access. If an API Key does not exist for the user, use the dropdown menu to select the user and click the **Generate API Key** button.
4. Enter your User ID and Api Key and click **Continue**.

Once your cloud credentials have been verified, you will see that the SoftLayer cloud is enabled under the Clouds tab.You will now see all of your SoftLayer resources under the Clouds menu (**Clouds > SoftLayer**).

<!---
![screen-ConnectaCloudtoRightScale.png](screen-ConnectaCloudtoRightScale.png)
--->
<!---
![screen-EnterYourSoftLayerCreds.png](screen-EnterYourSoftLayerCreds.png)
--->

## Check the Cloud Status

Next, use the following steps to check cloud status.

1. On the same **Clouds** tab or on the **Cloud Credentials** widget in the **Overview** tab, you may check the status of your cloud.
2. Both of these items must be valid and active (green) in order to successfully launch cloud servers:

![screen-SoftLayerEnabledCloud.png](/img/softlayer-softlayer-enabled-cloud.png)

## Next Steps

Allow RightScale several minutes to populate your account with the appropriate images before launching servers after initially adding a cloud. In the CM Dashboard, navigate to **Clouds** > **OpenStack** > **Images** where RightScale queries every few minutes for the images.
