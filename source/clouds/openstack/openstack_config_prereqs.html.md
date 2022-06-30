---
title: Configuration Prerequisites
layout: openstack_layout_page
description: Before registering your OpenStack cloud and adding it to RightScale, you should read these configuration details about our compatibility and support.
---

## Overview

Before [registering your OpenStack cloud](openstack_register_an_openstack_private_cloud_with_rightscale.html) and [adding it to RightScale](openstack_add_an_openstack_private_cloud_to_a_rightscale_account.html), you should read these configuration details about our compatibility and support. Check out our [OpenStack Reference Architecture](openstack_ref_arch.html) page to see details of the architecture we used and tested against.

## Requirements for RightScale with OpenStack Juno, Kilo, and Liberty

* OpenStack Juno, Kilo, or Liberty version
* Public endpoints available for Keystone, Nova, Glance, Cinder, Swift
* Neutron networking is required. Nova-network is not supported by RightScale
* Outbound network connectivity meeting RightScale requirements
* Metadata service available to all instances
* Functioning DNS server available to all instance
* Network connectivity between instances across compute nodes
* One network must be available to cloud account tenant
* Nova Availability Zones and Host Aggregates are not required but if used, they must be managed by instance flavors
* Update the **keystone.conf** file with the cloud's public endpoint. *Note*: You will use the same URL later in this tutorial as the "Registration URL" when you register the cloud with RightScale.

~~~
..
# The base endpoint URLs for keystone that are advertised to clients
# (NOTE: this does NOT affect how keystone listens for connections)
public_endpoint = <<http://198.101.133.81:5000/>># admin_endpoint = http://localhost:%(admin_port)s/
~~~

## Supported Features in the Cloud Management Dashboard

**Nova Compute (Cloud Compute)**
* Instances and ServerTemplates
* Firewalls (Security Groups)  
* Monitoring, Alerts, Arrays, SSH
* Glance Image Service

**Networking**
* Static IPs
* Subnets

**Cinder Volumes (Block Storage)**
* Create, Attach, Detach, Delete, Snapshot, Create from Snapshot

## Account Selection

Be sure to select the desired account with which you would like to register your OpenStack cloud. A cloud can only be registered to one RightScale account. Cloud registration requires "admin role" privileges. Once a cloud has been successfully registered it cannot be registered with another RightScale account unless you delete it.

## API Endpoints

RightScale relies on "keystone service catalog" for discovery of these endpoints. There are two options with regards to providing RightScale access to the endpoints:
* The following OpenStack endpoint URLs are publicly accessible. This means, the publicURL for each of the following services need to have a public IP address.
* Follow the [wstunnel setup procedure](../../faq/wstunnel_setup.html) to establish an outbound connection from your environment to RightScale. In this case, the endpoints do NOT need to be Internet accessible.

**Please ensure that these URLs (IP addresses and Port numbers) are accessible to RightScale over the Internet or via a wstunnel and are properly configured in firewall settings**.

1. Compute endpoint (Nova)
	* Juno and Kilo support v2
		* API compute endpoint publicURL should look like: **http://109.168.247.227:8774/v2/<tenant-id>**
	* Liberty Supports v2.1
		* API compute endpoint publicURL should look like: **http://109.168.247.227:8774/v2.1/<tenant-id>**
2. Identify endpoint (KeyStone)
	* Juno and Kilo support v2
		* API identity endpoint publicURL should look like: **http://52.24.82.66:5000/v2.0**
	* Liberty supports v3.4
		* API identity endpoint publicURL should look like: **http://52.24.82.66:5000/v3**
3. Image endpoint (Glance)
	* Juno, Kilo and Liberty support v2
		* API image endpoint publicURL should look like: **http://109.168.247.227:9292/v2**
4. Volume endpoint (Cinder)
	* Juno, Kilo and Liberty support v2
		* API volume or volumev2 endpoint publicURL should look like: **http://109.168.247.227:8776/v1/<tenant-id>**
5. Object-store (Swift)
	* Juno, Kilo and Liberty support v2
		* API object-store endpoint publicURL should look like: **http://109.168.247.227:8888/v1/<tenant-id>**
6. Network (Neutron)
	* Juno, Kilo and Liberty support v2
		* API network endpoint publicURL should look like: **http://109.168.247.227:9696**

## Firewall Settings

See [About Firewalls](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Settings/Account/Concepts/About_Firewalls/index.html) for detailed information on configuring your firewall settings for proper use with OpenStack.

## Uploading Images

See [Upload RightImages to a Private Cloud](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Design/MultiCloud_Images/Actions/Upload_RightImages_to_a_Private_Cloud/index.html) to get our base images into your OpenStack cloud.

## Additional Configuration Requirements

If shared networks will be used, the neutron policy must be changed to allow port creation by non-owners. In `/etc/neutron/policy.conf`, ensure the rule '"regular_user": "",' exists. Then add the 'regular_user' rule to 'create_port' and 'create_port:fixed_ips'. 

Example:
"create_port": "rule:regular_user",
"create_port:fixed_ips": "rule:admin_or_network_owner or rule:context_is_advsvc or rule:regular_user",

## Support

If you run into any issues during your OpenStack registration process or otherwise, please book a ticket by emailing [support@rightscale.com](mailto:support@rightscale.com).
