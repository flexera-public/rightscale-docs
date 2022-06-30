---
title: Chef Server for Linux (RightLink 10) - Tutorial
description: Use this RightLink 10 ServerTemplate tutorial to set up a Chef Server load balancer server or servers in a public or private cloud environment.
---

## Objective

To set up a Chef Server load balancer server or servers in a public or private cloud environment.

## Prerequisites

* You must log in under a RightScale account with "actor" and "library" user roles in order to complete the tutorial.
* For Amazon EC2 and other clouds that support security groups, you must have a security group defined with TCP port 22 open for SSH access, the appropriate web port (80 for HTTP or 443 for HTTPS) open for client access, and any other port and protocol access required by your load balancers. Also, remember that iptables is installed by default on all servers.
* We strongly recommend that you set up credentials for password values and any other sensitive data included as Chef recipe inputs.

## Overview

This tutorial describes the steps for launching one Chef server in the cloud, using the [Chef Server for Linux (RightLink 10)](http://www.rightscale.com/library/server_templates/Chef-Server-for-Linux-RightLin/lineage/57238) ServerTemplate.

## Create Credentials

## Create Elastic IPs (AWS only)

If you are launching Chef servers in EC2, it is recommended that you use Elastic IPs. If you haven't already done so, create an Elastic IP for the Chef Server. Be sure to create the Elastic IPs in the AWS region (e.g. 'us-east') where you intend to launch the load balancer servers. See [Create Elastic IPs (EIP)](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#create-a-new-elastic-ip--eip-).

## Steps

### Add a Server

Follow these steps to add a load balancer server to the deployment.

1. Go to the MultiCloud Marketplace (**Design** > **MultiCloud Marketplace** > **ServerTemplates**) and import the most recently published revision of the [Chef Server for Linux (RightLink 10)](http://www.rightscale.com/library/server_templates/Chef-Server-for-Linux-RightLin/lineage/57238) ServerTemplate into the RightScale account.
2. From the imported ServerTemplate's show page, click the **Add Server** button.
3. Select the cloud for which you will configure a server.
4. Select the deployment into which the new server will be placed.
5. Next, the Add Server Assistant wizard will walk you through the remaining steps that are required to create a server based on the selected cloud.
  * **Server Name** - Provide a nickname for your new load balancer server (e.g., lb1).
  * Select the appropriate cloud-specific resources that are required in order to launch a server into the chosen cloud. The required cloud resources may differ depending on the type of cloud infrastructure. If the cloud supports multiple datacenters / zones, select a specific zone. Later, when you create the other load balancer server you will use a different datacenter / zone to ensure high-availability. For more information, see [Add Server Assistant](/cm/dashboard/design/server_templates/servertemplates_actions.html#add-server-assistant).
  * If you are using Elastic IPs (AWS EC2 only), select an existing Elastic IP from the drop-down, or click New to create a new one.
6. Click **Confirm**, review the server's configuration and click **Finish** to create the server.

### Configure Inputs

The next step is to define the properties of your load balancer server or servers by entering values for inputs. As a best practice, you should define required inputs for the servers at the deployment level. For a detailed explanation of how inputs are defined and used in Chef recipes and RightScripts, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

To enter inputs for the Chef recipes that will run on your load balancers, open the deployment's **Inputs** tab, click **Edit**, and use the following settings to configure input values. We recommend that you set up credentials for password values and any other sensitive data as shown in the examples.

#### Chef Server Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|CHEF_SERVER_ADDONS| A comma separated list of chef server add-ons | text: manager,reporting |
|CHEF_SERVER_FQDN|The FQDN of the chef server.|text: chef-server.example.com|
|CHEF_SERVER_VERSION|The version of chef server to install|text: 12.0.8|
|CHEF_NOTIFICATON_EMAIL|The email address the chef server will use for notifications and alerts.|text: name@example.com|
|LOG_LEVEL|The log level for the chef server install.|text: info|
|SMTP_RELAYHOST|The SMTP Relay host|text:email.relay.com|
|SMTP_SASL_USER_NAME|The username for the mail relay host|cred: SMTP_SASL_USER_NAME|
|SMTP_SASL_PASSWORD|The password for the mail relay host|cred: SMTP_SASL_PASSWORD|
|BACKUP_LINEAGE|The name of the backup|text: chef-server|
|STORAGE_ACCOUNT_ENDPOINT|The cloud storage endpoint|text: https://some.end.point.com/path/|
|STORAGE_ACCOUNT_ID|The Cloud provider Username or key|ccred:AWS_ACCESS_KEY_ID|
|STORAGE_ACCOUNT_PROVIDER|The cloud provider|text:aws|
|STORAGE_ACCOUNT_SECRET|The Cloud provider password or secret|cred:AWS_SECRET_ACCESS_KEY|
|SCHEDULE_ENABLE|Enable or disable the schedule backup|text: true|
|SCHEDULE_HOUR|The backup schedule hour based on the crontab hr|text: 6|
|SCHEDULE_MINUTE|The backup schedule minute base on the crontab min. |text: 30|

### Launch the Server

1. Go to the deployment's **Servers** tab and launch all of the load balancer servers. When you view the input confirmation page, there should not be any required inputs with missing values. If there are any required inputs that are missing values (highlighted in red) at the input confirmation page, cancel the launch and add values for those inputs at the deployment level before launching the server again. Refer to the instructions in [Launch a Server](/cm/dashboard/manage/deployments/deployments_actions.html#launch-a-server) if you are not familiar with this process.  


### Configure DNS Records

If you are using Elastic IPs or already know the public IP addresses that will be used by the load balancer servers, you might have already set up the DNS records for the Chef Server. However, if you do not know the public IP addresses that will be assigned to the load balancer servers, you must manually set up the DNS records after the servers have been launched. Once the servers become operational (and have been assigned their respective public IP addresses), create or update the DNS records with your DNS provider. Each load balancer server should have its own DNS record with the same hostname (e.g. chef-server.example.com) that points to its public IP address.

The DNS records for the Chef sServer should direct traffic from the associated hostname (FQDN) (e.g. chef-server.example.com) to the application servers in its load balancing pool.

## Next Steps

Once your server is operational you can configure your new Chef Server.  Review the documents below to guide you if you are not familiar with the Chef Server configuration.

* Setting up your client
* Uploading cookbooks
* Backup server and schedule backups

## Further Reading
* [Chef Server Getting Started](https://docs.chef.io/index.html)
* [Chef Server Setup and Configure](https://docs.chef.io/install_server.html#standalone)
