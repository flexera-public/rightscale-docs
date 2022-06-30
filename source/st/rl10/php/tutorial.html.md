---
title: PHP Application Server for Chef Server (RightLink 10) - Tutorial
description: Use this RightLink 10 ServerTemplate tutorial to set up a PHP application server in a public or private cloud environment.
---

## Objective

To set up a PHP application server in a public or private cloud environment.

## Prerequisites

The following are prerequisites for completing this tutorial:

* Required user roles: 'actor', 'designer', and 'library'
* For Amazon EC2 and other clouds that support security groups, you must have a security group defined with TCP port 22 open for SSH access, the default application port (8000) open to applicable load balancer servers/service, and any other port and protocol access required by your application. Also, remember that iptables is installed and enabled by default on all servers.
* We strongly recommend that you set up credentials for password values and any other sensitive data included as Chef recipe inputs. See the "Create Credentials" section below.
* This tutorial assumes that you are setting up application servers that will function as part of a three-tier architecture that includes both back-end MySQL database servers and front-end load balancer servers (e.g. HAProxy or aiCache) or services (e.g. Amazon Elastic Load Balancing (ELB)). For information on setting up your database servers, see [Database Manager for MySQL (RightLink 10) - Tutorial](/st/rl10/mysql/tutorial.html).
* A deployment into which you are going to add the server. See [Create a New Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#create-a-new-deployment).
* You must have a [Chef Server](../chef-server/overview.html) or use Hosted Chef to use this ServerTemplate.  
* You must upload the [rs-application_php](https://github.com/rightscale-cookbooks/rs-application_php) and other required cookbooks to your Chef Server.

## Overview

This tutorial describes the steps for launching one or more application servers in the cloud.

For a technical overview of this ServerTemplate, see [PHP Application Server](/st/rl10/php/overview.html).

## Create Credentials

In order to use the default input values in the ServerTemplate, you must set up credentials with the following names. For more information on setting up credentials, see [Create a New Credential](/cm/dashboard/design/credentials/credentials.html#create-a-new-credential).

* **DBAPPLICATION_PASSWORD** - Password of a database user with user-level privileges.
* **DBAPPLICATION_USER** - Username of a database user with user-level privileges.
* **SSH_KNOWN_HOST_KEY** *(Optional)* - Create a credential with a valid SSH key which will be appended to the `/root/.ssh/known_hosts` file. Creating and using this credential is optional but highly recommended to prevent MiTM attacks.

Set up the appropriate set of authentication credentials based upon where the application code will be retrieved.

## Steps

### Add a Server

Follow these steps to add a load balancer server to the deployment.

1. Go to the MultiCloud Marketplace (**Design** > **MultiCloud Marketplace** > **ServerTemplates**) and import [PHP Application Server for Chef Server (RightLink 10) ServerTemplate](http://www.rightscale.com/library/server_templates/PHP-Application-Server-for-Che/lineage/57408) into the RightScale account.
2. From the imported ServerTemplate's show page, click the **Add Server** button.
3. Select the cloud for which you will configure a server.
4. Select the deployment into which the new server will be placed.
5. Next, the Add Server Assistant wizard will walk you through the remaining steps that are required to create a server based on the selected cloud.
  * **Server Name** - Provide a nickname for your new load balancer server (e.g., lb1).
  * Select the appropriate cloud-specific resources that are required in order to launch a server into the chosen cloud. The required cloud resources may differ depending on the type of cloud infrastructure. If the cloud supports multiple datacenters / zones, select a specific zone. Later, when you create the other load balancer server you will use a different datacenter / zone to ensure high-availability. For more information, see Add Server Assistant.
  * If you are using Elastic IPs (AWS EC2 only), select an Elastic IP.
6. Click **Confirm** , review the server's configuration and click **Finish** to create the server.

### Configure Inputs

The next step is to define the properties of your application balancer server or servers by entering values for inputs. As a best practice, you should define required inputs for the servers at the deployment level. For a detailed explanation of how inputs are defined and used in Chef recipes and RightScripts, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

To enter inputs for the Chef recipes that will run on your load balancers, open the deployment's **Inputs** tab, click **Edit** , and use the following settings to configure input values. We recommend that you set up credentials for password values and any other sensitive data as shown in the examples.

#### Chef Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
| CHEF_ENVIRONMENT | The chef environment name to use | text: _default |
|CHEF_SERVER_URL|The url of your chef server|text:https://chef-server.example.com|
|CHEF_VALIDATION_KEY|The chef orgainization validation key.| cred:CHEF_VALIDATION_KEY |
|CHEF_VALIDATION_NAME|The chef validator name|text:example-validator|
|LOG_LEVEL|Chef client log level|text:info|
|VERSION|The version of chef client to install|text:12.16|

#### RS-APPLICATION_PHP Inputs

| Input Name | Description | Example |
| ---------- | ----------- | ------- |
| APPLICATION_NAME | The name of the application. This name is used to generate the path of the application code and to determine the backend pool in a load balancer server that the application server will be attached to. Application names can have only alphanumeric characters and underscores.  This value should be unique across deployments | text: example |
|APPLICATION_ROOT_PATH|The path of application root relative to /usr/local/www/sites/<application name> directory. Example: my_app|text:myapp|
|BIND_NETWORK_INTERFACE|The network interface to use for the bind address of the application server. It can be either 'private' or 'public' interface.|text: private|
|DATABASE_HOST|The FQDN of the database server. Example: db.example.com
|text: db.example.com|
|DATABASE_PASSWORD|The password for the application to access the database|cred: APPLICATION_DB_PASSWORD|
|DATABASE_SCHEMA|The name of the database schema|text: app_db|
|DATABASE_USER|The username used to connect to the database. |cred:MYSQL_APPLICATION_USERNAME|
|LISTEN_PORT|The port to use for the application to bind. Example: 8080|text: 8080|
|MIGRATION_COMMAND|The command used to perform application migration. Example: php app/console doctrine:migrations:migrate||
|REFRESH_TOKEN|The Rightscale OAUTH refresh token. The token is used to run commands on other servers, such as attaching or detaching from the Load Balancer| cred: MY_REFRESH_TOKEN|
| SCM_REPOSITORY | The repository location to download application code. | text: [git://github.com/rightscale/examples.git](git://github.com/rightscale/examples.git) |
| SCM_REVISION | The revision of application code to download from the repository. | text: unified_php |
| VHOST_PATH | The virtual host served by the application server. The virtual host name can be a valid domain/path name supported by the access control lists (ACLs) in a load balancer. Ensure that no two application servers in the same deployment having the same application name have different vhost paths. Example: http:://www.example.com, /index | text: http://www.example.com, /index |

### Launch the Server

Now that you have finished defining server details, you are ready to launch a server in the cloud with the new settings. Click the server's **Launch** button.

Review the inputs that you set at the Inputs confirmation page and click **Launch**.
