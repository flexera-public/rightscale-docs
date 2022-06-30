---
title: Prepare the vSphere Environment for RightScale Connectivity
alias: rcav/guides/rcav_prepare_vsphere_environment.html
description: Steps for preparing the vSphere Environment for RightScale Connectivity.
---
## Objective

To prepare an existing vSphere environment so that a RightScale Cloud Appliance for vSphere (RCA-V) can be successfully deployed.
Prerequisites

* Access to log in to the vSphere Client
* Ability to create new user roles

!!info*Note:* If you do not have access to make the changes outlined below, contact your vSphere network administrator.

## vSphere Requirements

* **vSphere Requirements**: vSphere 5.1 or 5.5 Enterprise or Enterprise Plus Edition. vSphere Standard Edition is not supported at this time.  *Note*: The vSphere environment must be enabled for Distributed Resource Scheduling (DRS). Datastores placed under Storage DRS is recommended (which is only available in Enterprise Plus), but not required.
* **ESXi hosts must have NTP time sync enabled.** Verify that the NTP client for the hypervisor is enabled, using the vSphere Web client, **Host->Manage->Settings->Time Configuration.**
* **vCenter Server Requirements:** ​ vCenter 5.1 or 5.5 Standard or Foundation edition

## vCenter Access Requirements

Although RightScale **does not require** admin access to vCenter server, please create a role that contains the minimum set of privileges required by the RightScale platform as described below.

You can follow the steps below or use this simple [PowerCLI script](https://github.com/kramfs/rcav-utilities) to create the role, set permissions and add the user to the role.

### Create a RightScale Role

1. The first step is to create a new Role. Open the vSphere Client application and go to **View > Administration > Roles**.
2. Click **Add Role** and name it accordingly. (e.g. RightScaleRole)

    ![RCA-V Edit Role](/img/rcav-edit-role.png)

3. Make sure the role has the following privileges (at a minimum):

  * **Datastore**: All
  * **Datastore Cluster**: All
  * **Folder**: Create, Delete
  * **Global**: Cancel task, Licenses
  * **Host > Local operations**: Create virtual machine, Delete virtual machine, Reconfigure virtual machine
  * **(vSphere 5.5 only) Profile-driven storage**: All
  * **Network**: Assign network
  * **Resource**: Apply recommendation, Assign virtual machine to resource pool, Create resource pool, Modify resource pool, Move resource pool, Remove resource pool
  * **vApp**: Import
  * **Virtual machine**: All

<a name="user"></a>
### Create a Non-Admin User

The next step is to create a new user profile that the RightScale platform will use to log in and access the vSphere environment.

!!info*Note:* Creating a new user account for use with your vSphere environment is strictly optional. You may elect to use an existing user account if you wish, or even an existing _domain user_ account.

1. Open the system's Control Panel and go to User Accounts. Click Add or remove user accounts.
2. Click Create a new account. Provide a descriptive name (e.g. RS-User), select the "Standard" user option, and click Create Account. *Note: The user does not require 'Administrator' privileges.*

    ![RCA-V Create RS User](/img/rcav-create-RS-user.png)

3. Set a valid password for the user.
4. ![RCA-V Save Icon](/img/rcav-icon-save.png) The RightScale platform will use this new user profile to access the vSphere environment. Save the username and password in a safe place and provide this login information to the person who is going to [Download, Deploy, and Configure the RCA-V](rcav_download_deploy_configure.html).

### Assign Permissions for RightScale to the vSphere Infrastructure

Assign the new user (e.g. RS-User) the role that you created in the previous step (e.g. RightScaleRole). *It's important to add the user at the vCenter level so that it can have the same permissions throughout the object hierarchy as well as have access to various services.* From that point on, you can always restrict the "RightScale" user to a specific cluster, you can go down to that specific cluster and add permission for this user.​

1. Go to Home. 
2. Click Host and Clusters.
3. Right-click on the **vCenter** icon and select **Add Permission**.
2. Click **Add**, select the new user (e.g.  RS-User), and click **Add**. Click **OK**.
3. Assign the user the role that you created for the RightScale platform. (e.g. RightScaleRole)  Make sure the "Propagate to Child Objects" option is checked so that the user will have the same permissions to all underlying objects. Click **OK**.

**Note**: Make sure that RS-User has permission to access vSwitches and dvSwitches objects.

![RCA-V Assign Permissions](/img/rcav-assign-permissions.png)

## Hardware Requirements

The requirements below are specific to deploy the RCA-V in the vSphere environment.

* **Requirements**: Single-core 1GB VM with 10GB of disk space (plus overhead); in the future multiple VMs are recommended for fault tolerance.​
* **(Optional)**: An additional NAT / DHCP appliance, which requires a single-core 1GB VM with 10GB of disk space. However, if you already have existing NAT and DHCP mechanisms, you may not need to deploy this additional instance.

## Connectivity Requirements

Update your firewall permissions accordingly to allow egress connectivity between the RCA-V and RightScale.
**Important!** There are no inbound connectivity requirements. (RightScale to RCA-V)

### RCA-V to RightScale
![RCA-V vSphere Network Access RCA](/img/rcav-vSphere-network-access-RCA.png)

* Egress (Outbound) access from RCA-V to RightScale:
  * `https://wstunnel10-1.rightscale.com`: Secure web socket tunnel between RCA-V and RightScale
  * `https://island10.rightscale.com`: RightScale Mirrors which contain required software installation packages (e.g. Ubuntu, rubygem, RCA-V appliance upgrades, etc.) Once the setup is complete, this firewall permission can be removed.
  * (Optional) Access to DNS servers `8.8.8.8` and `8.8.4.4`
  * (Optional) Access to `https://github.com`

### VMs to RightScale

Each instance launched via the RightScale Dashboard/API must be allowed to make the following **egress (outbound)** connections to the RightScale platform in order for all instance-level services to be supported.

**Note**: NTP and DNS can also be provided locally. If true, you do not have to create firewall rules for NTP or DNS.

* Each instance launched through RightScale must synchronize with the global time standard (e.g. through NTP or through other means). If the instance clock drifts by more than two minutes, certain operations will start to fail.

**Please refer to the [firewall rules page](/faq/Firewall_Configuration_Ruleset.html)**. Also note that only the Egress Rules section applies to vSphere environments.

![RCA-V vSphere Network Access VM](/img/rcav-vSphere-network-access-VM.png)

### RCA-V to vCenter Server

The RCA-V communicates with vCenter Server over SSL connection. If there is a firewall between the RCA-V and the vCenter Server, please setup the rules such that the RCA-V is able to make a connection to vCenter Server's IP address on port 443.

## Next Steps

You are now ready to install the RCA-V in your vSphere environment. The person who is installing the RCA-V can now follow the next section of the installation guide.

**Important!** Be sure to give the following information to the person who will be installing and configuring the RCA-V.

The "RightScale User" login information (from the [Create a Non-Admin User](#user) step above).

    **username**: __________________<br>
    **password**: __________________

Please proceed to the next step in the setup guide.

* [Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere (RCA-V)](rcav_download_deploy_configure.html)
