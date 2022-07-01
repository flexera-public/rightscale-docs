---
title: RightScale Cloud Appliance (RCA-V) for vSphere - Administrator Guide
description: The purpose of this guide is to describe the core functionality of RCA-V, system architecture, as well as hardware, software, and network requirements.
---

## Overview

The purpose of this guide is to describe the following topics related to the RightScale Cloud Appliance (RCA-V) for vSphere.

* Core functionality of the RCA-V
* System Architecture
* Hardware, Software and Network Requirements

### System Architecture

The RCA-V sits between the RightScale multi-cloud gateway and the vSphere API implemented by a vCenter server in a VMware vSphere installation. The multi-cloud gateway is part of RightScale’s SaaS service and is operated by RightScale. Whereas the RCA-V is a dedicated virtual machine (VM) that's deployed from the vCenter console as a dedicated appliance within the vSphere environment. It's important that the RCA-V is operated in close proximity to the vCenter server(s) because it requires low latency access to RCA-V API endpoint.

!!info*Note:* The RCA-V is distributed in OVA format.

![RCA-V RCA System Architecture](/img/rcav-RCA-system-architecture.png)

#### RightScale to RCA-V

Once the RCA-V is deployed, it establishes an outbound connection over HTTPS (using websockets) with the RightScale MultiCloud Gateway. Therefore, the RCA-V must be allowed to make outbound connections to the specified IP address range used by the RightScale gateway. Make sure the appropriate network firewall permissions are properly configured before the RCA-V is deployed. See [Prepare vSphere environment for RightScale Connectivity](rcav_prepare_vsphere_environment.html).

#### RCA-V to vCenter

The RCA-V does not require administrator credentials but only requires a non-admin user with a minimum set of privileges required by the RightScale platform to access the vSphere API on the vCenter server(s) over HTTPS. For more details, see [vCenter Access Requirements](rcav_prepare_vsphere_environment.html).

### Multi-tenancy

The RCA-V is designed to leverage the existing vCenter API as much as possible in order to simplify communication between the RightScale platform and the vSphere installation. For example, in order to place a VM onto a host, the implemented solution is to leverage vSphere’s DRS (distributed resource scheduler) instead of encoding a custom algorithm into the appliance.  However, the RCA-V does partition available resources within a vSphere installation in order to enable multi-tenancy, which is one of the core features of a cloud (IaaS) environment.

Tenants are defined in the appliance and consist of a specific `datacenter:cluster` combination(s), where each tenant is associated with a single RightScale account, so multiple RightScale accounts can be granted access to a vSphere installation. Each tenant has a designated partition of the vSphere installation (i.e. cloud-like resources such as VMs, volumes, etc. that can be provisioned for on-demand usage.)  When a resource is provisioned, such as a running VM, it can only belong to a single tenant.​ Since multiple tenants can be configured to leverage the same underlying hosts, tenants can be configured to expose all running instances for a resource pool, which means that a RightScale account associated with tenant 'A' may see VMs that were provisioned to another RightScale account tied to tenant 'B'. Of course, VMs can only be controlled from the account to which they were provisioned. The visibility of all provisioned (running) resources is a configurable option which you may want to enable in order to provide more transparency of known VMs in your vSphere cloud.

## RCA-V Compatibility with other Tools

The RCA-V is designed to be compatible with other tools, such as VMware vSphere client, that access the same vCenter installation. The appliance tracks resources using the IDs exposed in the vSphere API and tries to pay minimal attention to the configuration of each resource. In general, as long as the ID of a resource (such as a template, VM, datacenter, datastore, or network) does not change the appliance will be able to manage each resource as expected. Since resources are identified by their IDs, the names of each resource can be changed. Although it's not possible to change the allocated amount of cpu or memory size to an allocated (running) VM through the RightScale Cloud Management Dashboard/API, or in the RCA-V user interface, a network administrator can manipulate the underlying hardware using VMware tools. The RCA-V always tries to stay synchronized with its vSphere environment so that the names of all resource types are consistent between the vSphere client application and RCA-V admin console, which makes it easier to identify and match known resources in both user interfaces.

It's important to remember that changes to the underlying vSphere environment may affect how certain resources are managed via RightScale. For example, the removal of vSphere resources such as datacenters, clusters, or networks may cause affected resources to be left in an unknown or inaccurate state. Before you make any major changes to a vSphere environment, please consult RightScale support to ensure that all changes are handled appropriately in order to minimize any negative impacts to end users.

The RCA-V also discovers any new resources that are created using other third party tools. For example, VMs launched via other tools are discovered as instances and exposed to the appropriate tenant in accordance with the defined multi-tenancy policy.

### Potential Incompatibilities

* **The RCA-V may modify VM templates** If the appliance is configured to use linked clones when launching instances (and an instance is launched from a VM template through the appliance) and if that VM template does not have a current snapshot then the appliance will modify the VM template by creating a snapshot to enable linked clone launching.
* **The RCA-V creates a configurable resource pool for each tenant (if this option is selected)** In each cluster, the appliance may create a configurable resource pool for each tenant that has access to the cluster. The resource pool name can be configured, however this action could conflict with other tools that don’t expect new resource pools to appear. In order to create resource pools, vSphere DRS must be enabled on all clusters, which is used through RightScale. (Note: However, this issue can be circumvented for clusters that are “owned” by a single tenant.)
* **The RCA-V creates a virtual machines folder for each tenant** The virtual machines launched by the tenant will be placed there for purely “cosmetic” purposes; there is no semantic meaning associated with this placement (the association between a tenant and a VM is made through the resource pool, not the virtual machines folder structure.

## Policies and Customization

The API implemented by the RCA-V is similar in nature to that of many public clouds, including EC2, GCE, or OpenStack. As such, its REST API has calls to list images, datacenters, and instances, as well as launch an instance from an image or terminate an instance. These API calls are implemented in the appliance on top of the VMware vSphere SOAP API, which is lower-level than a cloud API. For example, launching an instance requires a few dozen vSphere API calls and a number of decisions to be made.

An important characteristic of the appliance is that it's more of a policy layer than an automation or functionality layer because vSphere already contains automation to do just about anything a cloud needs to do, but it lacks a standardization/policy layer that makes it possible to give end-users control over their set of resources. For example, vSphere has automation to place new VMs onto the most appropriate host. However, what it actually does can be set in many places: in the VM template, in the VM, in the clone/launch call, or in various DRS settings. What the appliance does is to let the cloud administrator decide on which VM placement policy is to be used and then enforce that for all VMs. Similarly the administrator can decide which form of provisioning is to be used, e.g. linked-clone or not, thin, thick-eager, or thick-lazy.

The implementation of the appliance is designed to be configurable by the customer/administrator and customizable by RightScale professional services. For this purpose the implementation is divided into two parts: the core of the appliance with a set of procedures and a customizable policy framework. The policy framework provides a number of options for each policy that can be set by the administrator and, in addition, allows custom policies to be inserted into the code by RightScale professional services. As an example, when selecting which datastore a new instance should be placed into the options available include requesting a recommendation from DRS, selecting a fixed datastore, or selecting the datastore with the most free space. If a different policy is desired it can typically be implemented and inserted into the appliance. Ideally, such custom policies can be written in a generic manner and be included as standard into future appliance releases.

## vSphere Resources

### Object Hierarchy Overview

As a reference, the vSphere object hierarchy is as follows:

* A vCenter server has (can manage) multiple Datacenters
* A Datacenter has multiple Datastores, and has multiple Clusters
* A Cluster has multiple hosts where hosts can have access to multiple Datastores
* A Datastore contains multiple VMs and Templates
* A Host has multiple VMs and has access to multiple Datastores

### Cloud

The RCA-V exposes what RightScale refers to as a private cloud, where a cloud is a set of resources and an administrative domain. The appliance may be configured to only expose a subset (and not all) of the visible vSphere resources.

### Cloud Accounts

The appliance partitions the resources accessible through vSphere into non-overlapping tenants that are called cloud accounts in RightScale. It is imperative that, with a few exceptions, the resources accessible through one tenant be disjoint from the resources accessible through all other tenants. The exceptions are: images can be visible to all tenants (more in the images subsection), networks can be shared across tenants, hosts and datastores are not visible to tenants and can be shared appropriately.

Tenants (cloud accounts) are specified in the appliance configuration where, for each tenant, the datacenter & cluster combinations that the tenant has access to are listed. The appliance then exposes each datacenter & cluster combo as a RightScale datacenter/zone (vSphere uses the term “datacenter” for something different than RightScale does). For each combo a configuration switch determines whether a tenant sees all VMs, or only its own VMs, or its own VMs plus other “unowned” VMs.

This enables typical configurations where a cluster is dedicated to a particular purpose, such as production, or QA and can be exposed as one tenant. It also allows for a cluster to be shared by multiple tenants. In all cases, however, for a given cluster each VM must only be seen by one tenant, so only one tenant can see all VMs or all unowned VMs and if there is a tenant that can see all VMs then it's impossible to configure tenants that see their own VMs too.

### Datacenters

Each cluster in vCenter is exposed as one datacenter/zone in the RCA-V and RightScale Cloud Management Dashboard/API.

### Images

VM templates are mapped to read-only images (i.e. There is no way to create or modify images from the appliance). You can only create or modify VM templates using a vSphere client and not with the RCA-V. Mapping vApp templates, OVFs, or even raw VMDKs to images is not currently possible or supported.

VM templates appear as visible images for all tenants that have access to the datastore in which those templates are stored. Configuring tenant-specific images is currently not supported.  

### Instance Types

The appliance follows the typical IaaS cloud model where instance types are defined by their cpu and memory capacity. Instance types are defined when you set up and configure the RCA-V.

**Note**: An "unknown" type is used for mapping all discovered instances that do not map to another instance type.

### Instances

Virtual machines (that are not templates) in vSphere are mapped 1-1 to instances in the appliance. Powered-off VMs are mapped to stopped instances. The instance type of a VM that was launched through the appliance always reflects the instance type (as it was defined when the VM was launched). Any changes that are made to the VMware tools to the VM’s cpu/memory allocation after the VM is launched will not be reflected in the appliance, although such changes are technically allowed. Stopping/starting an instance is supported and is essentially equivalent to powering off/on a VM in vSphere.

**Note**: If an instance is launched outside of the appliance, its displayed instance type will either match an existing instance type (if a match can be found) or be displayed as a special "custom" type (if a match cannot be found).

### SSH Keys

SSH keys are public SSH keys that can be created in the scope of a cloud tenant for the purpose of logging into servers. The recommended approach is not to use these cloud SSH keys described here but to use RightScale’s “managed login” feature, which allows each end-user to have a unique and private SSH key that is automatically loaded on all instances (assuming the user has the 'server_login' user role permission in the RightScale account). However, the managed login keys are only loaded onto the instance after the RightScale RightLink agent starts and establishes communication with RightScale, which can become problematic and difficult to troubleshoot if instances do not start-up correctly with RightLink properly installed and started. However, this condition typically only occurs during the development of new images. When you're creating new images for your vSphere environment, it's useful to use your cloud SSH keys available because you can use them to SSH into a problematic machine when RightLink is not working as expected. In such cases, you may want to make sure the cloud SSH key is installed early in the boot process by an init.d script.

**Note**: Currently, there is no mechanism for supporting Windows RDP passwords.

### Subnets

The appliance maps vCenter networks into subnets (and each tenant ends up with a single default network per datacenter in the RightScale platform). The networks are read-only from the appliance perspective and their only purpose is to select and determine which public and/or private network an instance will be connected to at launch time.

### IP addresses

The appliance implements support for assigning IP addresses to instances, specifically, to assign an IP address to the network interface on an instance. It does not currently deal with any upstream devices that may NAT external IP addresses to instances or otherwise load balance across instances.  

The appliance offers 3 options for managing an instance’s IP address(es):

1. **DHCP based Assignment** - The images need to contain code in order to set the IP address. (Typically, DHCP is used for this purpose but no restrictions are enforced at this time.)
2. **Dynamic IP Assignment** - Instances are assigned an IP address (at launch time) from a “dynamic” IP address pool configured using RCA-V Admin UI, which will essentially yield the same result as a DHCP service (when DHCP is not available).
3. **Static IP Assignment** - Instances are assigned a specific IP address (at launch time) from a “static” IP address pool. IP assignments are configured by the user launching the VM.

For *option 2*, the configuration of the appliance can include the specification of an IP range for each network. The multicloud gateway then selects an unused IP address for each newly launched instance. Such dynamic IP address ranges are not communicated back to the RightScale platform (beyond the gateway) and are not visible to users. However, the specific IP address assigned to an instance is reported back assuming that it is running the VMware tools.

*Option 3* can be combined with options 1 or 2 giving the user the choice of specifying an explicit IP address from the provided pool or letting a dynamic IP address be assigned automatically.

In all cases the result of assigning an IP address is to set the IP address on the virtual network interface and sending out ARP announcements to let routers establish the appropriate IP to MAC address mapping (assuming that the routers are properly configured). It is also entirely possible for instances to change the IP address of their interface. In such cases, the appliance does not interfere with changes to IP assignments and will simply report any changes back to the RightScale platform so that they are accurately reflected in the RightScale Dashboard.

An important detail is that the appliance uses the IP address reported by the VMware tools to report the actual IP address of an instance back to the RightScale platform. Thus, if the VMware tools are not installed on an instance it is impossible for RightScale to detect the actual IP address.

#### Setting a Static IP

If there is no DHCP server on your private network, you can have RightLink configure a Static IP by adding special metadata options to your server. Setting a static IP will supercede any DHCP configuration if set. Use the following configuration parameters to set a static IP address for a given network interface in the `metadata` textbox under Advanced Options in the Add Server UI or via the `metadata` cloud_specific_attribute in the API:

Parameter Name | Description
-------------- | -----------
`rs_ip0_addr` | IP address to assign
`rs_ip0_netmask` | Network mask (i.e. 255.255.255.0)
`rs_ip0_nameservers` | Comma-separated string of nameserver IP addresses.
`rs_ip0_gateway` | IP address of the default gateway.

Here's an example of setting a static IP address for a given server:
~~~
rs_ip0_addr=10.54.252.234&rs_ip0_netmask=255.255.255.224&rs_ip0_nameservers=8.8.8.8,8.8.4.4&rs_ip0_gateway=10.54.252.225
~~~

Multiple devices can be configured by setting rs_ip1_addr, etc. but only one default gateway should be configured.

## Resource Discovery

Once RCA-V is connected to the underlying vSphere infrastructure, it can discover resources on the fly as they are created or deleted. The following is a list of resources that can be discovered and the mode of discovery.

Resource | Discovery Method
-------------- | -----------
Instances | Dynamic
Images | Dynamic
Instance Types - Defined in the adapter | Static
Datacenters / Zones - Defined in the adapter | Static
SSH Keys | User Defined
Subnets - Defined in the adapter | Static
Volumes | Dynamic
Volume Types - Defined in the adapter | Static
Volume Snapshots | Dynamic

To clarify, cloud resources are dynamic but configurations are static and can only be discovered by manually refreshing and setting them.

## Known Limitations
* Dynamic IP Assignment and Static IP Assignment are only supported with custom images that have RightLink pre-installed. Documentation for creating custom images with RightLink pre-installed can be found here: [Custom Images with RightLink for Linux](/rl10/reference/rl10_install.html) and [Custom Images with RightLink for Windows](/rl10/reference/rl10_install_windows.html)
* Cluster Storage as a target for **Datastore for Snapshots** is not supported - A volume snapshot can be created from a volume that is attached or that is not attached. An SDRS recommendation from vCenter is an operation on VMs. So there is no way to get an SDRS recommendation for an unattached volume, the datastore must be **explicit**.
* vMotion events are not supported.
* IPv6 is not supported.

## See also

* [RightScale Cloud Appliance for vSphere (RCA-V): Installation Guide](rcav_installation_guide.html)



