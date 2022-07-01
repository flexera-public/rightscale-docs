---
title: Add a vSphere Cloud to a RightScale Account
alias: rcav/guides/rcav_add_vsphere_cloud.html
description: Procedure for adding a vSphere Cloud to a RightScale Account including connecting to a Cloud, checking Cloud Status, and troubleshooting.
---

## Objective

To add a vSphere cloud to a RightScale account.

## Prerequisites

* The vSphere environment that you're going to add must be properly configured and registered with RightScale. See the [RightScale Cloud Appliance for vSphere (RCA-V) Installation Guide](rcav_installation_guide.html) for details.
* 'admin' user role privileges in the RightScale account to which you're going to add the vSphere cloud.
* A **Cloud Token** (e.g. VI1IDTEWNA) that was created and given to you from the cloud administrator of the vSphere cloud. The token is used to uniquely identify the vSphere cloud that you're going to add to this RightScale account.
* **Tenant Name and Password** that the RightScale account uses to access the vSphere cloud.

## Steps

### Connect to a Cloud

1. Log into the RightScale account to which you're going to add the vSphere cloud and go to **Settings > Account Settings > Clouds** tab.
2. Click **Connect to a Cloud**.
3. Click **Connect to a Private Cloud**.
4. Enter the Cloud Token and click **Continue**.

    ![RCA-V Add Cloud Token](/img/rcav-add-cloud-token.png)

5. Enter the required cloud credentials and click Continue.
  * **Tenant Name and Password** - Provide the login information for the user profile that the RightScale platform uses to make authenticated API requests to the vSphere cloud environment. Typically, this user does not have 'admin' access in the vSphere cloud. Use the same user that was used to configure the RCA-V in the [Tenants](rcav_download_deploy_configure.html#tenants) step of the [Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere (RCA-V)](rcav_download_deploy_configure.html) document.

        ![RCA-V User Password](/img/rcav-user-password.png)

6. RightScale will now use the provided information to query the cloud's API endpoint. If the request is validated, RightScale will query the cloud's controller to retrieve all of the cloud's resources that are available for use for this particular RightScale account. Remember, each account is only granted access to a single tenant, which was defined in vCenter to only have access to a specific `datacenter:cluster` combination(s).

### Check the Cloud's Status

1. Check the cloud's status. Go to **Settings > Account Settings > Clouds** tab to check the status of your cloud. Both of these items must be valid and active (green) in order to successfully launch cloud server. Allow RightScale several minutes to populate your account with the appropriate images before launching servers.

    ![RCA-V Cloud Status](/img/rcav-cloud-status.png)

#### Troubleshooting

* [Why is the Cloud Controller status red (and not green)?](/rcav/v1.3/rcav_troubleshooting_guide.html#troubleshooting---frequently-asked-questions-why-is-the-cloud-controller-status-red--and-not-green--)
* [Why is the Cloud Account status red (and not green)?](/rcav/v1.3/rcav_troubleshooting_guide.html#troubleshooting---frequently-asked-questions-why-is-the-cloud-account-status-red--and-not-green--)
