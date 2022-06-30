---
title: Register a vSphere Cloud with RightScale
description: This article outlines the steps for registering the RightScale Cloud Appliance for vSphere (RCA-V) installation with the RightScale Cloud Management Platform.
---

## Objective

To register the RightScale Cloud Appliance for vSphere (RCA-V) installation with the RightScale cloud management platform so that you can manage your resources using the RightScale Dashboard and/or API.

## Prerequisites

* vSphere setup with a properly installed RCA-V. See [Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere  (RCA-V)](rcav_download_deploy_configure.html).
* 'admin' access to a RightScale account to which you're going to register the vSphere cloud. If you do not have an account, please contact [sales@rightscale.com](mailto:sales@rightscale.com)

## Steps

1. Retrieve the rendez-vous token that's used to uniquely identify an RCA-V through the secure websocket tunnel to the RightScale platform. You can find the token in the RCA-V administrator console (Connectivity > RightScale Platform > Overview card). If you do not have access to the console, please contact the person who installed the RCA-V in the vSphere cloud and ask them to retrieve and provide this value to you.

    ![RCA-V Retrieve Token](/img/rcav-retrieve-token.png)
2. Go to **Settings > Account Settings > Administered Clouds**.
3. Select the RCA-V cloud type from the private clouds dropdown menu and click **Register Cloud**.

    ![RCA-V Register vSphere](/img/rcav-register-vsphere.png)

4. Provide the required information about your vSphere installation. WSTunnel Token is the Rendez-vous token from Step 1.

    ![RCA-V vSphere Registration](/img/rcav-vsphere-registration.png)
  * **Name** - Enter the name that will be used to identify your vSphere installation in the RightScale Cloud Management Platform (under the Clouds menu). It's recommended to use a short but descriptive name.
  * **Description** - A brief description of the vSphere installation. You may want to provide helpful support information such as your vSphere administrator's contact information.
  * **Adapter Username** - Use "rightscale" for the username.
  * **Adapter Password** - Enter the password for the RCA-V. The password should have been changed in the 'RightScale Password' section of the [Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere (RCA-V)](rcav_download_deploy_configure.html) document. (In case you didn't change it, the default value for the Password is `vscale2013@@`) Currently there is no way to retrieve or reset this password. A new RCA-V must be deployed in the vSphere environment if the password cannot be found.
  * **WSTunnel Token** - Enter the Rendez-vous token that was noted in Step 1.

5. Click **Request Registration**.
6. Next, provide the Tenant Name and Tenant Password, and click **Continue**.

      ![RCA-V UserPass Register](/img/rcav-userpass-register.png)

7. RightScale will now use the provided information to query the cloud's API endpoint. If the request is validated, RightScale will query the cloud's controller to retrieve all of the cloud's resources that are available for use for this particular RightScale account. Remember, each account is only granted access to a single tenant, which was defined in vCenter to only have access to a specific datacenter:cluster combination(s).

      ![RCA-V Connecting Cloud](/img/rcav-connecting-cloud.png)

      ![RCA-V Congratulations Register](/img/rcav-congratulations-register.png)
8. **Congratulations!** Your vSphere environment has been successfully registered with RightScale and added as a new cloud resource pool in your RightScale account. Users in the in the RightScale account (with 'actor' user permissions) can now launch (deploy) new instances in the vSphere cloud. It's important that the status of the cloud controller and cloud account are stable (green) under **Settings > Account Settings > Clouds** tab.

      ![RCA-V Cloud Status](/img/rcav-cloud-status.png)
9. You should now see the cloud and all of its resources in the RightScale Cloud Management Dashboard under the **Clouds** menu.

      ![RCA-V View Cloud](/img/rcav-view-cloud.png)

## Next Steps

* [Grant a RightScale Account Access to your vSphere Cloud](rcav_grant_account.html)
