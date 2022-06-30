---
title: Security Groups - Actions
description: Common procedures for working with Security Groups in the RightScale Cloud Management Dashboard.
---

## Create a New Security Group

### Overview

*Security groups* are essentially firewalls for servers in the cloud. They define which ports are open to allow incoming connections to a server via specific protocols. Security groups only affect ingress (incoming) communications and do not prevent a server from initiating outbound communications.

Each server must have at least one security group assigned. By default, a new security group set up with no associated rules will deny all access to its associated servers. You must add rules in order to allow inbound traffic to the servers.

Security groups give you a flexible way to restrict server access, allowing you to set restrictions specific to particular protocols, ports, IP addresses, or combinations of these. Permissions defined in a security group are additive in nature; so, if a server has two security groups where one group has port 80 open and the other group has port 80 closed, port 80 will be *open* (not closed) on the server.

Use the following procedure to create a new security group (or groups) to use with servers in deployments.

### Prerequisites

* Adding and editing security groups requires the "security_manager" role. See [User Roles](/cm/ref/user_roles.html).

!!info*Note:* The "security_manager" role also enables you to run Infrastructure Audit reports (which include security group audit trail information).

### Steps

#### Create a New Security Group

1. Go to **Manage** > *Networks* > *Select a Network* > *Security Groups Tab* > **New Security Group**.
2. Provide the following information about the security group.

    ![cm-create-new-sec-group.png](/img/cm-create-new-sec-group.png)

  * **Name** - Enter a descriptive name for the security group. (e.g. ProjectX)
  * **Description** - Provide a helpful description. (Note: Required for OpenStack)
  * **Permissions** - Use the checkboxes to create firewall permissions for some of the common TCP ports. The created rule will allow ingress communication from *any* public IP address. (0.0.0.0/0) *Note*: You can create additional firewall rules in the next few steps.

    3. Click **Create**.

#### Add IP-based Permissions

All firewall permissions apply to ingress communication. Create a rule for a specific port or range of ports. Create additional rules as necessary.

1. If you are building a 3-tier deployment, see [Configuring Multiple Security Groups for a Multi-Tiered Deployment](/cm/dashboard/clouds/generic/security_groups_actions.html#configuring-multiple-security-groups-for-a-multi-tiered-deployment) to verify that you are creating the appropriate firewall rules for your type of reference architecture.
2. Go to the **Info** tab of the security group. Create a new firewall rule under the "Permissions" section.

    ![cm-add-IP-rule.png](/img/cm-add-IP-rule.png)

  * Select the IP **protocol** (TCP, UDP, ICMP). *Note*: For ICMP, use **-1** as a wildcard (that is, all ICMP Types and Codes).
  * Define the level of **IP** access using CIDR notation. For example, to allow *any* IP addresses, enter: `0.0.0.0/0`.
  * Define the **port** or range of ports. To open a single port, enter the port number in both fields. (*Note*: For OpenStack, the port must be greater than zero.)
  * Provide a helpful **description** for the firewall rule.

    3. Click **Add**. **Warning!** - Changes to firewall permissions are applied immediately and will affect any running instances that are using the security group.<br>
    4. Repeat the steps above to add additional firewall rules, as necessary.

#### Add Group-Based Permissions

Use the "Add Group" feature to add security groups to other security groups or to add a security group to itself. This feature grants group-wide access permissions that apply to all servers in the added group. See [Add a Security Group to Another Security Group](/cm/dashboard/clouds/generic/security_groups_actions.html#add-a-security-group-to-another-security) or [Add a Security Group to Itself](/cm/dashboard/clouds/generic/security_groups_actions.html#add-a-security-group-to-itself).

#### Troubleshooting Security Groups

When experiencing communications issues with servers in a deployment, you may need to troubleshoot your security group settings. The following is a list of common issues often associated with the setup and configuration of security groups.

* Ports not opened correctly
  * No website access? Port 80 may be closed.
  * SSH sessions fail? Port 22 may be closed. (For non-RightLink-enabled machine images, incorrect or absent SSH keys can affect operational and decommissioning RightScripts also.)
  * No SSL support? Port 443 may be closed.
* Accidental use of /32 in CIDR IP address notation, instead of a less restrictive /0.
* If too many ports are open on your server, you may have specified a *range* of ports when trying to specify a single port in your security group (e.g., ports 80 *through* 8000 instead of only ports 80 and 8000).
* If servers within a security group are not communicating correctly, you may need to either explicitly open the communications ports to all IP addresses, or add the security group to itself, which allows *all* servers in the security group to communicate with each other.

## Add a Security Group to Itself

### Overview

Servers in the same security group can communicate with each other over both private and public IP addresses, on the ports that are explicitly open to those addresses in the servers' security groups.

In general, it is best to set up servers in your configuration to communicate with each other only over *private* IP addresses. To allow communication across all ports over private IP addresses for all servers in a security group, you can add the security group to itself. This is similar to adding a security group to another security group, except that it applies to servers in the *same* security group rather than another, external security group.

Use the following procedure to add a security group to itself so servers in that group can communicate with each other using all protocols and ports, on private IP addresses.

### Prerequisites

* A security group.
* Adding and editing security groups requires the "security_manager" role. See [User Roles](/cm/ref/user_roles.html).

### Steps

* Open the security group that you need to edit (Clouds > *CloudName* > Security Groups) and click **Edit**.
* Select "Group" in the **New Permission** dropdown (**IPs** is the default). You must *manually* enter the security group name in the "Group" field in order to add it to itself.  

!!warning*Important!* This is different than selecting the "default" security group, which is pre-populated in the "Group" field. Leaving "Group" set to "default" will likely produce undesired results in your deployment.

* In the example below, the group "Standard" is used. *Warning*: Ensure that the group name is spelled correctly.

![cm-SG-add-group-services.png](/img/cm-SG-add-group-services.png)

* Click **Add**. The security group is added to itself and displayed in the Permissions section, as in the screen shot below. ("Standard" in our example, along with default values for all other fields.)

![/img/cm-security-group-add-group-perms.png](/img/cm-security-group-add-group-perms.png)

After you add the "Standard" security group to itself, all servers in the "Standard" security group can establish connections (i.e., send requests) to other servers in that security group, on *any* ports that security group "Standard" instances are listening on. Connections are established over private IP addresses.

## Add a Security Group to Another Security Group

### Overview

When you add a security group to another security group (including to itself), you create a firewall rule that will allow servers of the other security group to communicate on the private IP network. Typically, server-server communication on the private IP network is only available if both servers are located in the same cloud/region. Whereas communication between two servers located in different clouds/regions must be performed over the public IP network.

If you are setting up an application stack in a cloud infrastructure that consists of multiple tiers and servers, use the "Add Group" option for additional security. Instead of opening a port to *any* IP address, you can use a more restrictive setting that only allows a designated group(s) of servers to make successful requests, as well as ensure that they communicate with each other over the private (not public) IP network for faster and more secure communication.

For example, if you have separate application and database server tiers, the database tier should only be accessible by other database servers (e.g. mirroring/synchronization) and to application servers that need to connect to the database.

The following clouds support the use of security groups:

* Amazon EC2*
* OpenStack*
* Google Compute Engine

\* Security groups for these clouds are configured with Network Manager.

### Prerequisites

* Adding and editing security groups requires the 'security_manager' role. See [User Role Privileges](/cm/ref/user_role_privs.html).
* RightScale account with valid cloud credentials for Google
* In order to add a security group, you must know the "owner" that created the security group as well as the exact name.
* An existing security group. If you need to create one, see [Create a New Security Group](/cm/dashboard/clouds/generic/security_groups_actions.html#create-a-new-security-group).

### Steps

#### Determine Which Servers Can Initiate Communications

First, you must determine which types of communications are necessary between servers in your configuration. The following sample scenario includes one security group with public-facing web servers and another security group containing MySQL database servers that are not publicly accessible. The web servers must make requests to the MySQL database; however, the database servers *never* need to initiate communications with the web servers.

#### Add Group Rule

1. Open the security group that you need to edit (Clouds > *CloudName* > Security Groups) and go to the "Permissions" section under the **Info** tab.

![cm-add-group-TCP-rule.png](/img/cm-add-group-TCP-rule.png)

* **Owner** - The cloud account user. For AWS, the 'owner' is defined by the AWS account number (e.g. 1234-1234-1234). If you do not know the 'user' name, contact the cloud's system administrator.
 * **Google** - N/A
* **Group** - The security group you want to add a rule for in the current security group. *Note*: You can add a security group to itself.
 * **Google** - Enter the 'Resource UID' of the security group you wish to add. (e.g. sg-5e60afa31)
* **Protocol** - Select the IP protocol (TCP, UDP) for the firewall rule.
* **Ports** - Enter the port or range of ports that you wish to open to the added security group. To open all ports, use 0..60000.

## Configuring Multiple Security Groups for a Multi-Tiered Deployment

### Overview

Using a single Security Group for a multiple Server, multi-tiered Deployment is fine during the test and development phase of a project, but it is not recommended for production environments. This section discusses a possible implementation using multiple Security Groups for a typical 3-tiered Deployment in the cloud. For example, a Deployment with the following 3 tiers:

1. Front end load balancers
2. Application Servers (one or more, possibly even a Server Array)
3. Back end database Servers (master/slave)

![cm-3tiered-security-groups.png](/img/cm-3tiered-security-groups.png)

### Implementation

Create a Security Group for each tier:

* **Tier one - Front Ends (Load Balancers)**
  * Open ports 22 and 80
  * Open port 443 if you require SSL (optional)
  * Open ICMP if you want to ping the server (optional)
* **Tier two - Application Servers**
  * Open port 22
  * Add the tier 1 front end Security Group to the application Security Group. Open up port 8000 for the HAproxy listener.
  * Open application specific ports (if any). For example, a port used for administrative purposes or dedicated communications port.
* **Tier three - Database Servers**
  * Open ports 22
  * Add the tier 2 application Security Group to the database Security Group. Open up port 3306 for MySQL.
  * *Note*: The Dashboard allows you to configure port level security. That is, only application Servers can communicate to database Servers, and that only on a specific port (e.g. 3306).

Although changes to existing Security Groups that are being used by running Servers are dynamic and take effect immediately for new connections, you cannot change which Security Groups are assigned to a running Server. Security Groups can only be assigned to an instance at launch time and cannot be changed once a launch request has been made. Therefore, in order to assign a different Security Group to a running server you must either terminate the existing server and launch a new one or use the relaunch option to launch the "Next" server with the modified configuration. Remember, you can only modify which Security Group(s) will be assigned to a server before it is launched.

Follow the guidelines below to modify your Security Group configurations.

* For each Server, select the "next" in the Server Timeline.
* Edit the Server configuration
  * Remove the "old" (wide open) Security Group
  * Add the new Security Group (for the appropriate tier 1, 2 or 3)
  * Save your changes
* Terminate running Servers
  * If required by your application, you may need to terminate servers in a specific order
  * Otherwise, disable your Server Array (if you have one), then terminate your front end Servers, application Servers (or Array) and then database Servers
* Launch Servers
  * Launch new Servers in a specific order if called for by your application
  * Otherwise, launch your Master (once operational, launch your Slave*), launch your front ends, launch your application servers. Remember to enable and then launch if using a Server Array for your application servers.

Make sure your Deployment is up, running and functioning properly.

The primary benefit of deploying multiple Security Groups tailored to your specific Deployment is increased security. Certainly there is no reason to have a database port potentially opened up to the world. The scenario above increases security, particularly with respect to tiers 2 and 3.

\* Make sure the INIT_SLAVE_AT_BOOT Input is set to "true" when you launch your slave database Server.
