---
title: Writing Your First CAT
description: CAT stands for Cloud Application Template - it contains the definition of your application. A CAT has two primary purposes - to define the resources required by your application, and to define workflows that control the behavior of your application.
---

## Overview

CAT stands for Cloud Application Template - it contains the definition of your application. A CAT has two primary purposes: to define the resources required by your application, and to define workflows that control the behavior of your application. A CAT also contains descriptions of inputs from your user, outputs back to your users, and how to display information in the Self-Service portal.

![CAT Breakdown Image](/img/ss_cat_breakdown.png)

CAT files are uploaded to Self-Service, published to the Catalog as CloudApps that can be launched by users, and then launched by users to create a running CloudApp.

Since CAT files are simple text files, they can and should be managed in your existing source control tools. For now, Self-Service provides only very simple CAT management tools, but no version control or change tracking capabilities. Soon, Self-Service will provide tighter integration into your source control system, such as Github.

## Name and Description

Every CAT file contains metadata about the CloudApp that it defines, such as its name and description. When creating a CloudApp, make sure to give it a name that is meaningful to your users and provide at least a short description that describes what the app does, or what its content is.

~~~ ruby
name "3 Tier Application with MySQL (PHP and Tomcat)"
rs_ca_ver 20161221
short_description "Provides a 3-tier application consisting of 1 HAProxy load balancer, 1 application server, and a master-slave database pair"
~~~

The `name` and `short_description` of the CloudApp show in the Catalog when users are browsing for CloudApps to launch. The `long_description` is shown when someone clicks the “Details” button in the Catalog.

![Catalog Image](/img/ss_catalog_card.png)

When authoring the descriptions, use [markdown syntax](http://daringfireball.net/projects/markdown/syntax) to provide nice formatting of the text and even embed images or links into your descriptions. Take care when adding images to the short description, as images that are too large can cause strange UI artifacts such as wrapping or scrolling in the Catalog view.

## Defining a Resource

At its core, a CloudApp is a container of cloud resources and workflow definitions that operate on those resources. A CloudApp can contain any number of a variety of resource types, and additional resource types can be defined via Self-Service plugins. Built-in resources include most resources available in [RightScale Cloud Management API 1.5](/api/), such as Servers, Server Arrays, IP Addresses, Security Groups, and more.

There are many approaches to defining resources in your CAT: they can be created from scratch, copied from other CATs, or exported from RightScale Cloud Management. To export from Cloud Management, see Exporting Deployments to CAT

Every resource contains a set of attributes that are used when creating, launching, or operating on the resource. In the example below, we are creating a RightScale Server resource by specifying the required attributes, such as which ServerTemplate to use and which cloud to launch in.

~~~ ruby
resource "srv_db_master", type: "server" do
  name "Database Master"
  cloud "EC2 us-west-2"
  security_groups "3tier-all-oregon"
  ssh_key "default"
  server_template find("Database Manager for MySQL 5.5 (v13.3)", revision: 111)
end
~~~

Resources can be grouped together in a CAT and can reference each other in their definitions. In the example below, we are creating an IPAddress resource (an EIP in AWS) and using it and the Server defined above to bind the EIP to the instance.

~~~ ruby
resource "db_ip_address", type: "ip_address" do
  cloud "EC2 us-west-2"
end

resource "db_ip_binding", type: "ip_address_binding" do
  cloud "EC2 us-west-2"
  instance @srv_db_master
  public_ip_address @db_ip_address
end
~~~

For the full list of Cloud Management API 1.5 resources supported by Self-Service, see the [CAT Resource Reference](../reference/ss_CAT_resources.html).

For more information on mappings, see the [CAT Language Reference](../reference/ss_CAT_file_language.html#mappings).

## Getting User Input

Parameters are used to provide input to your CloudApp when it is launched or when custom operations are run. You define Parameters in your CAT file using a `parameter` declaration, and then can use the values elsewhere in your CAT by referring to them by name. Since these will be shown to users, the definition includes display attributes for rendering in the Self-Service portal.

The code below shows two examples of Parameters - one that allows the user to pick from a set of pre-defined values, and the other that allows the user to enter free-form text. In the example, both are used in the resource definition for the server.

~~~ ruby
parameter "cloud" do
  type "string"
  label "Cloud"
  allowed_values "AWS Oregon", "VMware"
  description "The cloud in which to launch the server"
end

parameter "server_name" do
  type "string"
  label "Server Name"
  description "The name to give the server"
end

resource "srv_db_master", type: "server" do
  name $server_name
  cloud $cloud
  security_groups "3tier-all-oregon"
  ssh_key "default"
  server_template find("Database Manager for MySQL 5.5 (v13.3)", revision: 111)
end
~~~

Parameters have many more attributes that can be leveraged to perform validation, define when they are shown, categorize them for UI organization, and more. For the full reference of a Parameter definition, see the [CAT Language Reference](../reference/ss_CAT_file_language.html#parameters).

## Using Lookup Tables

There are many scenarios in which you will need to get user input for your CloudApp, but the input either won’t be used directly on your resource or the input will affect many different properties of a resource. For example, if you provide an input to select which cloud to run in, that may affect not only which cloud a resource is launched in, but also its datacenter and instance type values.

In this case, CAT provides a Mapping, which allows you to use a Parameter input (or other strings) to lookup a set of values that can be used elsewhere in your CAT. The `mapping` declaration contains the string values, and the `map()` function is used to access them in your CAT.

In the example below, we implement a Mapping to contain various values based on what the user selected for the cloud parameter, then we use the `map` function in our resource declaration to leverage those values.

~~~ ruby
parameter "cloud" do
  type "string"
  label "Cloud"
  allowed_values "AWS Oregon", "VMware"
  description "The cloud in which to launch the server"
end

mapping "cloud_mapping" do {
  "AWS Oregon" => {
    "datacenter" => "us-west-2a",
    "instance_type" => "m1.large",
  },
  "VMware" => {
    "datacenter" => "internal-1",
    "instance_type" => "large",
  },
} end

resource "srv_db_master", type: "server" do
  name "DB Server"
  cloud $cloud
  datacenter map($cloud_mapping, $cloud, "datacenter")
  instance_type map($cloud_mapping, $cloud, "instance_type")
  server_template find("Database Manager for MySQL 5.5 (v13.3)", revision: 111)
end
~~~

For more information on mappings, see the [CAT Language Reference](../reference/ss_CAT_file_language.html#mappings).

## Providing Information to the User

Once a CloudApp has been launched by a user, you will want to provide some information to them about how to use the application. In some cases this may as simple as providing an IP address of a server, but in many cases you will want to leverage some more complex logic and combination of properties to show the user something meaningful.

Outputs can be defined in your CAT that define what information to show back to the user and how to render that information. Outputs can be provided with a default value that will be shown, or can be explicitly set as a result of running an Operation. The example below shows how you would show the user the name and IP address of a running server.

~~~ ruby
output do
  label "Server IP Address"
  category "General"
  default_value @srv_db_master.public_ip_address
end

output do
  label "Server Name"
  category "General"
  default_value @srv_db_master.name
end
~~~

For more information on outputs, see the [CAT Language Reference](../reference/ss_CAT_file_language.html#outputs).

## Defining Workflows

Underlying the Self-Service system is a powerful workflow engine called RightScale Cloud Workflow. This engine is a fully featured workflow engine with its own language and easy to use constructs for parallelism, error handling, and more. At the end of the day, all actions on a Cloud Application are defined by underlying workflow definitions. Some of these definitions are internal to the system, but you can also define your own workflows to use with a CloudApp.

A workflow definition is associated with a CloudApp by defining Operations. Most Operations are classified as “custom” operations, but there are also a few “special” operations that can be leveraged during launch, terminate, and scheduled events.

In the example below, we define a custom Operation called “Update application code” which references a fairly straightforward workflow definition that calls a script on a running server. Although this workflow definition is simple, workflows can be extremely complex, as dictated by your use case and application.

~~~ ruby
operation "Update application code" do
  description "Update the application code with the latest from the source"
  definition "update_app_code"
end

define update_app_code(@srv_app) do
  @task = @srv_app.current_instance().run_executable(recipe_name: "app::do_update_code", inputs: {})
  sleep_until(@task.summary =~ "^(completed|failed)")
  if @task.summary =~ "failed"
    raise "Failed to run app::do_update_code"
  end
end
~~~

For more information on operations, see the [CAT Language Reference](../reference/ss_CAT_file_language.html#operations).

For more information about Cloud Workflow, see the [Cloud Workflow Language](../reference/ss_RCL_language.html).

## Customizing Launch Behavior

By default, the logic used to launch a CloudApplication is to sequentially create and launch all resources defined in the CAT in the order in which they’re defined. Note that some resource types may be created earlier in the process if they’re required by others (an IP address will be created before a Server if the Server depends on it).

If your application has an order in which things should be launched instead of the default, you can specify a workflow definition with your own logic. To define the behavior on launch, use the special operation called “launch”. In the example below, a workflow is defined to concurrently launch our servers instead of the default sequential behavior.

~~~ ruby
operation 'launch' do
  definition 'launch_application'
  description 'Creates all the servers'
end

define launch_application(@server1, @server2) return @server1, @server2 do
  concurrent return @server1, @server2 do
    provision(@server1)
    provision(@server2)
  end
end
~~~

<!---For more complex examples, see the [Samples](/ss/samples) section of this handbook.--->
