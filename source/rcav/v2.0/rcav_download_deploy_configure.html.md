---
title: Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere (RCA-V)
description: This article describes the steps for setting up a RCA-V cloud installation so that the vSphere environment can be managed by the RightScale Cloud Management Platform.
---

## Objective

To set up a RCA-V cloud installation so that the vSphere environment can be managed by the RightScale Cloud Management platform.

## Prerequisites

* Completion of the [Prepare the vSphere cloud for RightScale Connectivity](rcav_prepare_vsphere_environment.html) steps
* Access to the vSphere client

## Overview

Configure an existing vSphere environment with the RightScale Cloud Management (CM) Platform so that you can launch and manage virtual machines (VMs) as cloud-like instances using the RightScale Dashboard/API. Below is an architectural diagram of a completed setup.

![rcav-setup-diagram.png](/img/rcav-setup-diagram.png)

Follow the steps below to properly deploy and configure the RCA-V in your vSphere environment. The setup consists of the following key steps.

## Download the RCA-V and NAT/DHCP Appliances

* The link to the final RCA-V v2.0 release can be [downloaded from here](http://rightscale-vscale.s3.amazonaws.com/appliances/vscale-2.0-20170517-10.ova).
* The NAT/DHCP appliance can be [downloaded from here](http://rightscale-vscale.s3.amazonaws.com/appliances/rsnet.ova).

## Deploy a NAT/DHCP Appliance (Optional)

If you already have access to a NAT/DHCP service in your vSphere environment, you can skip this step.

1. Open the vSphere Client and choose **File > Deploy OVF Template**.
2. Specify the source location of the OVA file. You can either browse to a locally saved file or enter a URL. Use the following file:
  * **NAT/DHCP Appliance** - Use the local file you previously downloaded.
3. Verify the Template's details and click **Next**.
4. **Name and Location**: Provide a name for the appliance (e.g. RightScale DHCP/NAT Appliance​) and click **Next**.
5. **Host/Cluster**: Choose a datacenter/cluster and click **Next**.
  * **Specific Host**: Choose a specific host within the cluster and click **Next**.
6. **Resource Pool**: (Optional) Select a resource pool (if one exists) and click **Next**.
7. **Storage**: Select a destination storage for the virtual machine (VM) files.
8. **Disk Format**: Specify the format for storing the virtual disks.
  * Choose **Thin Provision** and click **Next**.
9. **Network Mapping**: Specify which networks should be mapped to the instance. You should see both a private and public network. No changes are required. Click **Next**.  
    ![RCA-V NAT Network Mapping](/img/rcav-NAT-network-mapping.png)
10. **Properties**: Configure the additional properties for the appliance and click **Next**.
11. **Ready to Complete**: Review your selections and click **Finish**. But do not turn on the deployment!
12. Before you launch the appliance you should verify that all of your selections were properly allocated. In the vSphere Client, right-click on the virtual machine that you just defined for launching the RCA-V and view its **Properties**. You should see two networks, an internal (private) network and an external (public) network. If you do not see both networks, contact your vSphere administrator.
13. Right-click on the virtual machine and click **Power > Power On**.

## Deploy the RCA-V

1. Open the vSphere Client and choose **File > Deploy OVF Template**.
2. Specify the source location of the OVA file. You can either browse to a locally saved file or enter a URL. Use the following file:
  * **RCA-V Appliance** - Use the local file you previously downloaded.​
3. Verify the Template's details and click **Next**.
4. **Name and Location**: Provide a name for the appliance (e.g. RCA-V1) and click **Next**.

    ![RCA-V Name RCA](/img/rcav-name-RCA.png)
5. **Host/Cluster**: Choose a datacenter/cluster and click **Next**.

    ![RCA-V Select Cluster](/img/rcav-select-cluster.png)
6. **Specific Host**: Choose a specific host within the cluster and click **Next**.

    ![RCA-V Hostname](/img/rcav-hostname.png)
7. **Resource Pool**: (Optional) Select a resource pool (if one exists) and click **Next**.

    ![RCA-V Select Resource](/img/rcav-select-resource-pool.png)
8. **Storage**: Select a destination storage for the virtual machine (VM) files.

    ![RCA-V Select Storage](/img/rcav-select-storage.png)
9. **Disk Format**: Specify the format for storing the virtual disks. Choose **Thin Provision** and click **Next**.

    ![RCA-V Disk Format](/img/rcav-disk-format.png)
10. **Network Mapping**: Specify which networks should be mapped to the instance. You should only see a single (primary) network. No changes are required. Click **Next**.

    ![RCA-V NAT Network Mapping](/img/rcav-NAT-network-mapping.png)
11. **Properties**: Configure the additional properties for the appliance and click **Next**.

    ![RCA-V RCA Properties](/img/rcav-RCA-properties.png)
    * DNS - A comma-separated list of DNS servers. No changes are required.
    * IP - Enter the private IP address of the RCA-V. (e.g. 10.100.100.90)
    * Netmask - The primary subnet of the RCA-V. Enter 255.255.255.0
    * Gateway -  Enter the private IP address of the NAT appliance. (e.g. 10.100.100.99)
12. **Ready to Complete**: Review your selections.  Do not check the "Power on after deployment" option!  Click **Finish**.

    ![RCA-V Finish](/img/rcav-RCA-finish.png)
13. Before you launch the appliance you should verify that all of your selections were properly allocated. In the vSphere Client, right-click on the virtual machine that you just defined for launching the RCA-V and view its **Properties**. You should see two network adapters. One adapter is for the private network (VM Network) and the other is for the public adapter.

14. You are now ready to power on (launch) the appliance. Right-click on the virtual machine and click **Power > Power On**.

15. Once the instance is operational, check its **Summary** tab to verify that it has a single (private) IP address. The IP address should match the one that was specified earlier in Step 11 as the RCA-V's primary IP address. (e.g. 10.100.100.90) Save this value because you will need it in the next step when you open a Remote Desktop Connection to the RCA-V instance.

    ![RCA-V RCA Summary IP](/img/rcav-RCA-summary-IP.png)

## Configure the RCA-V

!!info*Note:* RCA-V Admin UI has been tested using Chrome and Safari browsers. There are certain known issues with using Firefox and Internet Explorer -- they are not recommended at this time.

### Log in to the RCA-V

If you launched the RCA-V instance on your private network, you can access the RCA-V's Admin UI from a device within the same network.

![RCA-V RCA Login](/img/rcav-RCA-login.png)

1. Enter the RCA-V's IP address of the instance in a browser window. Use the IP address from the previous step.
    **Example**: https://10.100.100.90​/
2. Log in to the RCA-V's administrator console by using the default username and password.
    Username: **rightscale**
    Password: **vscale2013@@**

    ![RCA-V RCA Initial Screen](/img/rcav-RCA-initial-screen.png)


<a name="platform"></a>
### RightScale Connectivity - RightScale Platform

Configure the RCA-V to connect to the RightScale platform.

![RCA-V RS Platform](/img/rcav-RS-platform.png)

1. Go to **Connectivity > ​RightScale Platform** in the left navigation bar. Edit the Overview card.​​
    * ​**Gateway**: The status of the connection to RightScale's multi-cloud gateway.
    * **Gateway URL**: The endpoint of the secure websocket tunnel that points to the RightScale platform. Please use the default value (wss://wstunnel10-1.rightscale.com).
    * **Tunnel**: The status of the secure websocket tunnel between the RCA-V and RightScale.
    * **Rendez-vous Token**: The Rendez-vous token is used to identify your RCA-V through the secure websocket tunnel to the RightScale Platform. You will need to create your own token.
      * Enter a 5-7 letter prefix such as your company name or company_enviroment (e.g. acme12). When you click **Save**, a 24-character random string will be automatically appended to the prefix to create the full token string. (e.g. acme12_ABC123abc789=ABC123abc78)
      * Save the Rendez-vous Token because you will use this value later when you [Register the vSphere ​Cloud with RightScale](rcav_register_vsphere_cloud.html).
    * **HTTP(s) Proxy Enabled**: Check this box if RCA-V is using a proxy server to reach the RightScale platform.
      * Unauthenticated proxy example: https://1.2.3.4:3126
      * Authenticated proxy basic username/password: http://basicuser:basicpass@1.2.3.4:3126
      * Authenticated proxy with domain-based username: http://domain\\\\basicuser:basicpass@1.2.3.4:3126
        * NOTE: the need to escape the backslash between domain and user name 3 times.
    * **Mirror**: The status of the RCA-V's connection to the RightScale's mirrors.​
    * **Mirror URL**: The Mirror URL is used to download software updates to the RCA-V and must use the appropriate URL based upon the location of your RightScale account. The correct URL will automatically be added for you.
      * For example, if you are using the 'https://us-4.rightscale.com' cluster, use 'https://island10.rightscale.com' (default).
2. In a few minutes, the status of the connectivity between the RightScale platform and your vSphere environment will be established. All status icons should turn to green.

### RightScale Connectivity - vCenter

Configure the vCenter credentials.

![RCA-V vCenter](/img/rcav-vCenter.png)

1. Go to **Connectivity > vCenter** in the left navigation bar. Edit the vCenter Server card.​
  * **Status**: The status of the connection between the RCA-V and vCenter Server.
  * **vSphere API Version**: The version of the vSphere API that the RCA-V will use to make API requests.
  * **Hostname/IP Address**: Enter either the hostname or IP address of the vCenter Server.  RCA-V must have network access to vCenter server.
  * **Username**: Enter the username for the "RightScale" user that was previously created in the **Create a Non-Admin User** step (in the [Prepare the vSphere cloud for RightScale Connectivity](rcav_prepare_vsphere_environment.html) document).
  * **Password**: Enter the matching password for the "RightScale" user.​

### vSphere Cloud Configuration

#### Overview

1. Go to **Cloud Configuration > Overview** in the left navigation bar. At this point you shouldn't have any tenants defined.

#### Global Policies

1. Go to the **Cloud Configuration > Global Policies** section to view the policies that apply to the entire vSphere cloud.
2. Select the appropriate Datastore for your vSphere cloud. The Datastore will store the RCA-V's configuration information and SSH Keys that will be used to launch new VMs. **Note that a vSAN based datastore can not be used for SSH keys storage or for appliance config storage.**

    ![RCA-V Datastores](/img/rcav-datastores.png)

3. If necessary, you can also change the default values for the VM provisioning policy if they are not preferred for your vSphere cloud. Edit the **VM Policies** card. For more detailed information about the different options, see [About Virtual Disk Provisioning Policies](https://docs.vmware.com/en/VMware-vSphere/5.5/com.vmware.vsphere.hostclient.doc/GUID-4C0F4D73-82F2-4B81-8AA7-1DD752A8A5AC.html).

    ![RCA-V VM Policies](/img/rcav-VM-policies.png)
  * Cloning model:
      * Linked Clone (default)
      * Full Clone
  * Storage provisioning:
      * Thin (default)
      * Thick Lazy
      * Thick Eager
  * MAC Address Allocation: Specify whether or not newly provisioned VMs are dynamically allocated a MAC address. It is **strongly recommended** that you select this option to avoid MAC address conflicts.

4. Global network settings can be specified that will be applied to all VMs launched in the environment.

    ![RCA-V Global Policies - Network Settings](/img/rcav-global-policies-network-settings.png)  
  * **Routes to RightScale:**  Used to specify any additional routes in CIDR format (other than the default gateway) needed to allow servers to get a direct network connection back to RightScale. If specified, the RightScale network agent will add an explicit route to the VM's route table for this destination. If the default gateway is sufficient or DHCP sets the required route(s), then this field should be left blank.
  * **DNS Servers:** What DNS servers should be statically configured on the VM. If preset in the image or DHCP sets the DNS servers, this field should be left blank.
  * **NTP Servers:** What NTP servers should be statically configured on the VM. If preset in the image or DHCP sets the NTP servers, this field should be left blank.
  * **Default VM Network:** During a server launch, a RightScale Dashboard user has the option of selecting “cloud-default” in the event they do not want to explicitly select a network in which to launch their server. In order to support this functionality, you (as the RCA-V administrator) must assign a network as “default” in the **Network Settings** card. Use the **Default VM Network** drop-down to assign a network as “default”. The drop-down lists all the networks where VMs can be launched. (**Note**: Only available in v1.1 and later.)

NOTE: The *Routes to RightScale*, *DNS Servers*, and *NTP Servers* configurations are only applied when using the RightScale Network Agent. See [Advanced Networking for vSphere] (/rl10/reference/rl10_rcav.html) for more information about these advanced networking features employed for VMware environments.


#### Zones

Zones are a cloud constructs that RightScale uses to represent a single cluster+datastore within a specific datacenter in your vSphere environment. They also represent resource boundaries for tenants; the RCA-V partitions the VMs that are accessible in the vSphere environment into non-overlapping zones. After you define your zones, you will create tenants, which are comprised of one or more zones.

    ![RCA-V ZM](/img/rcav-zm.png)

1. Go to **Cloud Configuration > Zones** in the left navigation bar.
2. Click **Add Zone**.

    ![RCA-V Zones](/img/rcav-zones.png)

  * **Zone Name** - The provided name will serve as the name of the availability zone/datacenter within the vSphere cloud as well as within the RightScale Dashboard. (e.g. acme-1a)
  * **Datacenter and Cluster** - Select the datacenter:cluster combination that will be mapped to the zone.
  * **Datastore** - Select the datastore where the VMs within the defined zone can access machine images and other cloud resources. Be sure to select a Datastore that either contains or will contain the required RightLink-enabled images (e.g. RightImages) that are required to launch VMs through the RightScale Cloud Management Platform (Dashboard/API).

    3. Click **Save**.

<a name="tenants"></a>
#### Tenants

The next step is to create tenants in your vSphere cloud. A tenant consists of one or more zones. Later, when you give other RightScale accounts access to your vSphere cloud, you will grant them access to a single tenant that you've defined in the RCA-V. Since a tenant can only be used once, you must create additional tenants for each additional RightScale account that will be granted access to your vSphere cloud.

Note that each new Tenant added here can _optionally_ result in a corresponding vSphere Resource Pool getting created in the vSphere environment. The Tenant configuration (described below) allows for configuring the quota parameters for the vSphere Resource Pool.

    ![RCA-V User Account Mapping](/img/rcav-user-account-mapping.png)

1. Go to **Cloud Configuration > Tenants** in the left navigation bar.
2. Click **Add Tenant**.

    ![RCA-V Add Tenant](/img/rcav-add-tenant.png)

  * **Tenant Name** - Provide a name for the tenant and click Continue. (e.g. Dev)
  * **Tenant Password** - Create a password for the tenant.
  * **Add Zone** - Select and add one or more zones to associate with the tenant. Remember, you can create multiple tenants which leverage resources in the same zones (i.e. datacenter:cluster:datastore combination).
  * Once a Zone has been added to the Tenant, one can edit the  zone parameters by clicking on Edit button.  This allows you to configure the level of resource allocation this tenant would have on that particular zone. Since multiple RightScale accounts have access to essentially the same pool of VMs, you may want users to see other active VMs that were launched from outside of their account. Use the "See Unowned VMs" checkbox to specify whether or not users will also see other VMs.

3. Click **Save**.<br>
4. Please save the tenant name and password. Later, when you add the vSphere cloud to this RightScale account you will need to specify a valid tenant name and password.

    ![RCA-V Edit Zone1](/img/rcav-edit-zone1.png)

#### VM Networks

The next step is to define the network(s) that will be assigned to a VM that is launched via the RightScale cloud management platform (in your vSphere cloud).

1. Go to **Cloud Configuration > VM Networks** in the left navigation bar.
2. Click **Add Network**. Pick a Network from the drop-down list. This network can be configured so that VMs launched via RightScale Dashboard can make use of it.

      ![RCA-V VM Network Private](/img/rcav-VM-network-private.png)
      ![RCA-V VM Network Public](/img/rcav-VM-network-public.png)

  * **IP Assignment**:  Pick a method to be used for IP addresses will be assigned to new VMs.
    * **DHCP Server**: This method assumes that there is a DHCP server available to this network.
    * **Dynamic IPs**:   This method allows you to provide a range of IP address pool that RightScale platform will use to assign IP addresses when VMs are launched via RightScale platform. RightScale will keep track of IP addresses that are already in-use and return the addresses to the pool once the VM is terminated. The VMs will retain their IP address across reboots.
      * IP Range -  Hyphen separated IP address range (inclusive). e.g. 10.10.10.23 - 10.10.10.99
      * Netmask - e.g. 255.255.255.0
      * Default Gateway - address of a default gateway on the subnet. Must not be set if  IP assignment method is set to DHCP.
    * **Static IPs**:  This method assumes that  at the time of VM launch, fixed IP addresses will be passed from RightScale platform. See [Setting a Static IP](rcav_administrator.html#setting-a-static-ip) for details on how to do this.

  * **Connectivity Method**: None -  This interface does not have connectivity to the RightScale platform.Via Default Gateway -  Use gateway IP address that is specified in the "Default Gateway" field or value supplied by DHCP server (in case DHCP is selected as IP Assignment method)Via Explicit Gateway -  Use a different gateway IP address (value specified in "Explicit Gateway" field). Explicit Gateway - (e.g. 10.100.100.91)​

  * **Static Routes**:
    * **Gateway**: Special gateway for routes to the RightScale platform
    * **Route Destinations**:
      * Special routes to reach the RightScale platform via Static Route Gateway. This should not be set if a Default gateway is set and can route to RightScale
      * For proof-of-concept purposes, it is recommended that you set this value to 0.0.0.0/0  (i.e. all traffic will be routed through the same gateway IP address).

3. Click **Save**.

#### Instance Types

Instance Types are the most commonly used practice by cloud providers, to offer predefined VM configuration that can be identified with a label. e.g: small, medium, large, xlarge. Setup the Instance Types for your vSphere Cloud. When launching a VM from RightScale Dashboard, you will have an option of picking an instance type for the VM.

Within RightScale, it is important to associate all VMs with an Instance Type in order to take advantage of RightScale products such as Optima and Self-Service, that rely on Instance Type as a means of identifying VM hardware configuration. Servers launched using RightScale dashboard or API will always have an Instance Type associated with it. However, for VMs that are not launched through RightScale may have VM configuration that does not match any currently defined Instance Types.

In such cases, it is important to go through the "Discover Instance Types" described below, and define new Instance Types so that all VMs are associated with an Instance Type.

![RCA-V Discover Instance Type Button](/img/rcav-discover-instance-type-button.png)

*Discover Instance Types*

This is a new feature is available with RCA-V releases 1.2 and higher. Click on Discover Instance Types button to get a list of all current VMs in the environment. Each VM is mapped to an existing Instance Type, based on its vCPU, Memory configuration. In cases where VM's configuration does not match the Instance Type already defined within RCA-V, the user will have an opportunity to create new Instance Type labels for such VMs.

![RCA-V Discover Instance Types](/img/rcav-discover-instance-types.png)

*Add an Instance Type*

This form allows you to define a new instance type. You must provide Instance Type Name, Description, Memory (in GB), Virtual CPU count for the instance type.

If Memory Reservation is checked, the VM created using such instance type would have a guaranteed lower bound on the amount of  physical memory the host reserves even when host memory is over-committed.

You can Edit an already existing instance type.  VMs that were launched using the original instance type will continue to function and show up as original instance type. VMs launched after modifying instance type will be launched according to the specs of the new instance type.

By default, Small, Small (Memory reserved), Large, Large (Memory reserved) instance types are pre-configured.

![RCA-V Instance Type Page](/img/rcav-instance-type-page.png)

#### Volume Types (v1.1 or later)

A Volume Type is a RightScale construct that captures a variety of low-level concepts that vSphere supports and exposes them as a high level construct. This helps RightScale users create and attach volumes to their servers without having to know details regarding the vSphere infrastructure.

The RCA-V administrator is encouraged to create more than one volume type. At least one volume type must be configured by the RCA-V administrator before a RightScale user can create a volume using the RightScale Dashboard or API.

All volumes created through RightScale are associated with a volume type defined using the Admin UI. This allows RightScale to place the volume based on a storage policy (aka storage profile) on a datastore. Different classes of storage (either with different QoS or SLA) can be placed under different storage profiles.

RightScale dashboard and API also allow creation of volume snapshots, ability to attach and detach volumes to servers or VMs.

![RCA-V Volume Type](/img/rcav-volume-type.png)

A volume type comprises the following parameters:

* **Name**  - This is a label for the Volume Type and will be exposed to the end user on the RightScale dashboard. Please pick a meaningful name that represents the Volume Type.
* **Storage Profile** - A drop-down control with values based on discovery of Storage Profiles in the vSphere environment. Select “None” if you have not defined any Storage Profiles in your vSphere environment.
* **Datastore**  - A drop-down control with values based on discovery of datastores that belong to the Storage Profile selected above. If no storage profiles are defined and you select “None”, all datastores that are available to use are displayed. Volume created for this Volume Type will be stored in the datastore configured here.
* **Datastore For Snapshots** - Specify the datastore where the snapshots for the volumes of this Volume Type must be stored.  
* **Provisioning mode** - Possible selectable values are Thin, Thick Lazy, Thick Eager Zeroed (default).
* **Description** - Enter a short meaningful description of the volume type.

### Proxy Support for Private Clouds

Network admins within enterprises almost always require a proxy as a sentinel between the internal network and the open Internet. Typically, private clouds that are behind a corporate firewall are behind a proxy server as well. All traffic from/to these private clouds has to traverse through the proxy server.

We now support traffic proxying for all communication between:
* RightScale platform and the cloud controller (for OpenStack)
* RightScale platform and RCA-V (for vSphere environment)
* RightScale platform and virtual machines within the private cloud. This is RightLink traffic.
Both *authenticated* and *non-authenticated* proxies are supported.

In order to enable proxy support, please follow the instructions below:

1. From the RCA-V Admin UI, go to **Connectivity** > **RightScale Platform** > **Overview card** > **Edit**.
2. Select the HTTP(s) Proxy Enabled checkmark as shown below and supply the proxy URL.
    ![Overview Card](/img/rcav-rel-note-proxy-enable.png)
3. You can specify the authenticated proxy URL using the following format: `http://username:password@proxyurl:proxyport`
4. To remove the proxy, uncheck the HTTP(s) Proxy Enabled box.

### Cloud Appliance Management

#### RightScale Password

Your setup is almost complete. Change the password for "rightscale" user from default value of "vscale2013@@" before you register the RCA-V with RightScale. This username/password is used to access the RCA-V's Admin UI and by the RightScale platform to securely access the appliance. This username/password cannot be used for ssh access to the appliance.

1. Go to **Cloud Appliance Mgmt > System > RightScale Password** card and click **Edit**.

    ![RCA-V RS Password1](/img/rcav-RS-password1.png)
2. Specify a new password. Please follow the recommended password strength guideline for choosing your password.
3. Be sure to save the password value in a safe place.
4. After you change the password you will need to log in again.

#### Admin Password

You may also want to change the default password for the "admin" user for the appliance. Default value is "vscale2013@@". The password is used to access the RCA-V's Admin UI and to gain ssh access to the appliance. Please follow the recommended password strength guideline for choosing your password.

#### Services Password

"services" user is used to let RightScale services/support access the admin UI and to SSH into the appliance. Please follow the recommended password strength guideline for choosing your password.​

## Next Steps

The RCA-V should now be properly configured with your vSphere cloud. The next step is to register the RCA-V with the RightScale platform so that you can use the RightScale Dashboard and API to manage your vSphere resources.

**Important!** Be sure to give the following information to the person who will be installing and configuring the RCA-V.

    **Rendez-vous token**​: ______________________  (from the [RightScale Platform](#platform) step)<br>
    **Tenant Name**:  _____________________  (from the [Tenants](#tenants) step)<br>
    **Tenant Password**:  _____________________  (from the [Tenants](#tenants) step)

Please proceed to the next step in the setup guide.

* [Upload RightImages to a vSphere Cloud](rcav_upload_rightimages.html)
