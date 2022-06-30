---
title: CAT File Language
description: A Cloud Application Template (CAT) file comprises a sequence of fields and declarations. It describes the structure and behavior of a Cloud Application (CloudApp).
version_number: "20131202"
alias: ss/reference/ss_CAT_file_language.html
versions:
  - name: 20161221
    link: /ss/reference/cat/v20161221/index.html
  - name: 20160622
    link: /ss/reference/cat/v20160622/index.html
  - name: 20131202
    link: /ss/reference/cat/v20131202/index.html
---

## Overview

A Cloud Application Template (CAT) file comprises a sequence of <em>fields</em> and <em>declarations</em>. It describes the structure and behavior of a Cloud Application (CloudApp).

### Declarations

There are 8 different types of declarations listed below.

* **Parameters** - used to get input to a CloudApp from an end user
* **Mappings** - used to abstract detail away from an end-user
* **Resources** - declaratively describe the cloud resources needed for this CloudApp
* **Conditions** - boolean values based on the environment of the CloudApp
* **Outputs** - used to show running CloudApp information to end users
* **Operations** - define the behaviors that apply to this CloudApp during its lifecycle
* **Definitions** - reusable code components written in a cloud-focused workflow language (RightScale Cloud Workflow)
* **Permissions** - used to specify any additional permissions required to run the CloudApp

Declarations all require a name that can be used to reference them in other areas of the template. Names are required to begin with an underscore or lowercase alphabetic character ('a' - 'z'), followed by any combination of underscores or alpha-numeric characters.

The language also provides many built-in methods that can be used.

<!-- NEED DIAGRAM HERE -->

## Fields

The four fields that can be defined in a CAT are:

* `name` (required): Name of the Cloud Application Template. Must be unique, and must not be whitespace-only.
* `rs_ca_ver` (required): Version of the engine used to parse the CAT. (This reference describes version 20131202)
* `short_description` (required): Short description (shown to users in Catalog view on the front of the card). Must not be whitespace-only. The rendering of this content supports markdown syntax for formatting, lists, code blocks, image insertion, and more.
* `long_description` (optional): Long description (shown to users when they click "Details" on a catalog item). Must not be whitespace-only. The rendering of this content supports markdown syntax for formatting, lists, code blocks, image insertion, and more.

## Parameters

Parameters allow you to get input from end users that can be passed to your cloud resources, used to make decisions on what to configure/launch, and used in custom operation logic. A parameter declaration has a name, a type and other optional fields that let you define things like a default value, or a set of potential values.

Parameters can be referred to in a CAT using the syntax `$<parameter_name>` where `parameter_name` is the string following the `parameter` keyword.

Here is an example of a parameter declaration defining a "performance" parameter which can take one of two values ("low" or "high"):

~~~ ruby
parameter "performance" do  
  type "string"  
  label "Application Performance"  
  description "Application performance profile"  
  allowed_values "low", "high"
end
~~~

### Fields

The available fields are:

Name | Required? | Type | Description
-----|-----------|------|------------
`name` | yes | string | The name of the parameter, declared in-line, such as `parameter "my_param_name" do`
`type` | yes | string | Defines whether the parameter is a string, a number or a comma separated list of values. The possible values for this field are `string`, and `number`.
`label` | yes | string | The display name shown to the user. Must not be whitespace-only.
`category` | no | string | An optional category used to group parameters in the UI.
`description` | no | string | A description shown in the launch UI
`default` | no |  | Default value for parameter if none is specified. Note this must meet the requirements of the other fields (such as max_length, allowed pattern, etc).
`no_echo` | no | boolean | Whether the value of the parameter should be hidden in UIs and API responses. The possible values for this field are `true` and `false` (default).
`allowed_values` | no | array | A comma-separated list of allowed values. Not valid when `allowed_pattern` is specified.
`min_length` and `max_length` | no | number | The minimum and maximum number of characters in the parameter value. Only valid when `type` is one of `string` or `list`.
`min_value` and `max_value` | no | number | The smallest and largest numeric value allowed for the parameter. Only valid when `type` is `number`.
`allowed_pattern` | no |  | May be a string or a Regexp. If a string is given then it will look for matches of the string in parameter values. Not valid when 'allowed_values' is specified. Note: the Ruby Regexp engine (a PCRE engine) is used to process and validate Regexp values, but there are a few unsupported features. These include modifiers other than 'm' and 'i', modifier groups (such as `/(?mi)example/`), and modifier spans (such as `/(?mi:example)/`). A helpful tool for developing PCRE regular expressions [can be found here](https://regex101.com/#pcre).
`constraint_description` | no | string | Message displayed when any of the constraint is violated. The system generates default error messages, this field allows overriding these to provide a clearer message to the user.
`operations` | no | array | Used to specify during which operations to show this parameter to the user (when using the UI). This will override the default behavior of when to show parameters.

Notes:

* Parameters are displayed in the UI in the same order as they are defined in the template.
* If a default value is set for a parameter, this value will be pre-populated in the UI. For example, for a parameter with allowed values of true/false and a default value of `true`, the resulting checkbox on the UI would be enabled. Additional information on UI behavior is provided below.

### Usage

~~~ ruby
parameter "db_dump_bucket" do
  type "string"
  label "Database S3 bucket"
  category "Database"
  description "URL to S3 bucket that contains MySQL database dump"
  min_length 3
  max_length 63
  allowed_pattern "[a-z0-9]+[a-z0-9\.-]*"
  constraint_description <<-EOS
    Bucket names must be at least 3 and no more than 63 characters long. Bucket names must be a series of one or more labels. Adjacent labels are separated by a single period (.). Bucket names can contain lowercase letters, numbers, and dashes. Each label must start and end with a lowercase letter or a number. Bucket names must not be formatted as an IP address (e.g., 192.168.5.4).
    EOS
end
~~~

Parameters can be used in other declarations using the `$` operator, for example:

~~~ ruby
parameter "cloud" do
  type "string"
  label "Cloud server should be launched in"  
  allowed_values "AWS US-East", "Google"
end

resource "server", type: "server" do  
  name "My server"  
  cloud $cloud  
  server_template_href "/api/server_templates/123"
end
~~~

In the example above, the "server" resource declaration uses the value associated with the parameter "cloud" to initialize the server resource cloud field. See the section below for more information on resources.

It is important to note that parameter values can be specified when launching a CloudApp or when running a custom operation on a running CloudApp. The CAT parser automatically identifies which parameters are required in both cases (in the launch case the parser crawls through all the resource declarations and "launch"/"enable" operations to compute all the required parameters). To override the automatic behavior of the parser, use the `operations` field.

### API Behaviors

When using the API to launch a CloudApp, only those parameters that are required for launch and do not have a default value must be specified  (it is allowable to specify values for other parameters - for example, to override the default value - just not required). Also by default, only parameters that do not have a default value and were not set when launching the CloudApp `must` be set when running a custom operation through the APIs.

So for example, the following CAT defines two operations - "enable" and "pull_code" - both using the same definition "get_code". The "get_code" definition accepts one argument "code_branch". The parser will infer that this parameter is needed to both launch the CloudApp (since that ends up running the "enable" operation) and run the custom "pull_code" operation. Since the parameter definition contains a default value it is acceptable to launch the CloudApp without passing any parameter value and it is also acceptable to run the custom operation "pull_code" without passing any value. In both cases the parameter may be specified and will be used.

~~~ ruby
parameter "code_branch" do
  type "string"
  label "Branch used to deploy code"
  default "master"
end

operation "enable" do
  definition "get_code"
end

operation "pull_code" do
  definition "get_code"
end

define get_code($code_branch) do
  # Run script to pull code from given branch
end
~~~

It is possible to override this default behavior and force a parameter to be passed when launching an operation, even if it has a default or previous value, by using the `operations` field. The following parameter definition would *require* the "code_branch" parameter to be passed in when launching the CloudApp, even though it has a default value in its definition.

Finally, the parameter declaration could also list both operations requiring values to be explicitly specified in both cases.

### User Interface Behavior

By default the UI will display all parameters that are needed to either launch the CloudApp or run the custom operation. The UI will pre-populate parameter values with either their default value or their previously set value, if one exists.

In the first example above, the UI will present the "code_branch" parameter to the user both when launching the CloudApp and when running the "pull_code" custom operation. On launch, the value will be pre-populated with the default value ("master"), and when launching the custom operation the value will be pre-populated with whatever the value was the last time it was used.

Specifying an explicit list of operations in a parameter declaration will cause the UI to only show that parameter for the corresponding operations (or launch if the string "launch" appears in that list). In the second example above, the parameter will only be shown on "launch" and would not be shown when running the "pull_code" custom operation (in this case it uses the previously set value).

In the example above, an `operations` field with no elements could be used to never show the parameter in the UI (since it has a default value defined).

## Mappings

Mappings allow you to lookup values based on other values that may come from parameters, built-in method results or resource fields. Mappings must contain string literals, not resource attributes or other function calls (that is they are static constructs). Also, mappings can only be two-levels deep.

### Mappings Usage

Here is an example of a mapping you could use to define resource field values based on parameters:

~~~ ruby
mapping "profiles" do {  
  "low" => {
    "db_instance_type" => "m1.small",
    "app_instance_type" => "m1.small"  },  
  "high" => {
    "db_instance_type" => "m2.xlarge",
    "app_instance_type" => "c1.xlarge"  } }
end
~~~

You can then use the `map` built-in method to lookup values:

~~~ ruby
resource "app_server", type: "server" do
  name "AppServer"
  cloud "AWS US-East"  
  datacenter "us-east-1a"
  instance_type map($profiles, $profile, "app_instance_type")
  security_groups "ssh", "app_server"  
  server_template find(name: "PHP App Server (v13.5)", revision:187)
end
~~~

This example uses the value of the "profile" parameter to lookup the application instance type.

!!info*Note:* All values defined in a mapping must be string literals.

## Resources

Resources represent a RightScale or cloud provider resource which is part of your cloud application. Resources can be referred to elsewhere in the CAT by using the syntax `@<resource_id>` where `resource_id` is the string following the `resource` keyword.

### Fields

The fields used to define a resource differ depending on the resource type. See the [Self-Service Resource Reference](ss_CAT_resources.html) for a full list of all available resources and their fields. Additionally, there are some fields that can be used for any resource:

Name | Required? | Description
-----|-----------|------------
`condition $<condition name>` | no | Only instantiate this resource if the conditiion resolves to true.
`like @<resource_name>` | no | Inherit all of the field values from the specified resource. Additional fields can be specified and will override the inherited values. Note: if you override a field, it replaces the inherited value(s) (inputs are not appended for example, the original inputs simply aren't used).

Many fields in a Resource can take either a string which will be used to find the resource, or the resource `href` itself. For details see [Self-Service Resource Reference](ss_CAT_resources.html).

!!info*Note:* In every CloudApp there is one global resource that is made available and can be used in your CAT, which is `@@deployment`. This resource represents the deployment that is created to contain this CloudApp and it can be used in custom operations.

### Usage

Here is an example of a "server" resource:

~~~ ruby
resource "database_slave", type: "server" do
  name "Database Slave"  
  cloud "AWS US-East"
  server_template_href "/api/server_templates/123"
end
~~~

## Conditions

A condition consists of a name and a condition function that returns a boolean value. You can attach a condition to a resource, output, or operation to conditionally create the object depending on the result of the condition function.

### Usage

Here is an example of a condition that returns true if the `profile` parameter value is "high":

~~~ ruby
condition "high_profile" do
  equals?($profile, "high")
end
~~~

Conditions can then be used when declaring resources, outputs, or operations. The following example illustrates the use of a condition when declaring a resource.

~~~ ruby
resource "database_slave", type: "server" do
  name "Database Slave"
  condition $high_profile
  cloud "AWS US-East"  
  server_template find(name: "Database Manager with MySQL 5.5 (v13.5)", revision:139)
end
~~~

The functions available to define conditions are described in the [Built-in methods and keywords](#built-in-methods-and-other-keywords) section below. They consist of `equals?`, `logic_or`, `logic_and`, and `logic_not`.

## Permissions

CAT designers use `permissions` declarations to specify additional end-user permissions (in addition to those automatically generated by Self-Service) required to use a CloudApp. For a detailed discussion, see [CloudApp Permissions](/ss/guides/ss_permissions.html).

Permission declarations are named sets of resource types and actions performed on those resource types.

### Fields
Permission declarations have two fields:

Name | Required? | Type | Description
-----|-----------|------|-------------
`actions` | yes | array | A list of namespace-scoped actions which can be performed on resources
`resources` | yes | array | A list of resource types which the specified actions may be performed on  

Resources and actions are both scoped to namespaces using the syntax `namespace.resource_or_action`. All RightScale resources have a namespace of `rs`.

!!info*Note*RightScale resources specified in the `resources` field should match the plurality of the `Resources` names in the [CM API 1.5 docs](http://reference.rightscale.com/api1.5/index.html).

!!info*Note*In general actions specified in the 'actions' field match those described in the [CM API 1.5 docs](http://reference.rightscale.com/api1.5/index.html). In addition to those actions the `rs.ssh_keys` and `rs.credentials` resources support the special actions `rs.index_sensitive` and `rs.show_sensitive` which should be specified if a designer makes use of the `index` or `show` actions on those resources and requests the sensitive view.

### Usage

~~~ ruby
permission "manage_sgs" do                 # The name of the permission
  actions   "rs.create", "rs.destroy"      # Actions which may be taken
                                           #  on the resources
  resources "rs.security_groups"           # Resources which may be used
end
~~~

You can simplify a permission declaration by using the wildcard character `*` in the `actions` field as shown below.

~~~ ruby
permission "serverz_4_dayz" do
  actions   "rs.*"                # Any action
  resources "rs.servers"
end
~~~

Actions you specify in a permission declaration must each apply to at least one of the resources defined in the permission. Likewise, each resource you specify in a permission declaration must have at least one corresponding applicable action defined. Failing either of these requirements will result in a parser error.

~~~ ruby
permission "unused_action" do
  actions   "rs.launch", "rs.create"      # Error: rs.launch doesn't apply
                                          #  to any resources
  resources "rs.security_groups", "rs.security_group_rules"
end

permission "unused_resource" do
  actions   "rs.launch", "rs.terminate"
  resources "rs.instances", "rs.sessions" # Error: there aren't any actions
                                          #  applicable to rs.sessions
end
~~~

## Outputs

Outputs provide a mechanism to expose the result of running an Operation on the CloudApp; they are shown in the UI to your users. Output values may be explicitly returned from Operations or a `default_value` can be specified which is computed after running the "auto_launch" operation (see below). An output declaration consists of a `name`, a `label`, an optional `category`, `description`, and an optional default value. For common attributes that are available for resources, see Self-Service Output Reference.

### Fields

The following fields are available for Outputs:

Name | Required? | Type | Description
-----|-----------|------|-------------
`name` | yes | string | The name of the output, declared in-line, such as `output "my_output_name" do`
`label` | yes | string | The label of the Output to show in the UI
`category` | no | string | Category to group related outputs together in the UI
`description` | no | string | Description shown in the UI
`default_value` | no |  | The default value of this output, calculated after the "auto_launch" operation is run

The fields available to show resource information in the `default_value` field differ depending on the resource type. See the [Self-Service Output Reference](ss_CAT_outputs.html) for a full list of all available resources and their outputs.

The example below shows an output listing the public IP addresses of a running Cloud Application from the "front_end" resource:

~~~ ruby
output 'ip_address' do
  label "IPs"
  category "Connect"
  default_value join(["Public IP address: ", @front_end.public_ip_address])
  description "Service public IPs"
end
~~~

The value of an Output can be overwritten by using an `output_mapping` in an `operation` declaration ([see below](#operations-fields)).

### User Interface Behavior

The `category` is used to group outputs in the UI and has no other effect. On the main CloudApp "index" page in card view (showing multiple CloudApps), the UI shows the first 6 outputs from the first category. Other categories are shown as tabs in the detail view of the CloudApp.

Any output will be hidden that either: is an empty string, is set to `null` in an `output_mapping`, or contains a reference to a resource that doesn't exist. For example, if your output value is defined as `@server.name` but `@server` is not a resource (perhaps is was excluded by use of a condition), the output will not be shown in the UI.

## Operations

Operations describe the tasks that happen to your application across its lifecycle. There are five special operations listed below, but any number of custom operations are supported. Custom operations can be made available to end-users through the Self-Service user interface. The operation `name` is shown to end-users as allowable operations on their CloudApps.

Operations can update the resources and outputs that make up a CloudApp by explicitly mapping return values from a definition to the resource/output in the CloudApp.

!!warning*Important:* If you don't explicitly `return` a resource, Self-Service will be unaware of its state, so always make sure to return resources that you modify in an operation.

### Fields

Each operation contains fields that define the operation and mappings that map return values from a definition back to the outputs/resources of a CloudApp:

Name | Required? | Type | Description
-----|-----------|------|------------
`name` | yes | string | The name of the operation, declared in-line, such as `operation "my_operation_name" do`
`definition` | yes | string | The Cloud Workflow definition name that will be run when this operation is triggered
`description` | no | string | A textual description of what the operations does. This is shown to the user when selecting an operation
`resource_mappings` | no | hash | Overwrites a resource in the CloudApp with a new resource that has been returned by the definition
`output_mappings` | no | hash | Overwrites an output value of a CloudApp with a value returned by the definition

!!info*Note:* You can hide an Output in the UI by setting its value to `null` in an `output_mapping`.

~~~ ruby
operation "Backup Primary Database" do
  description "Creates a backup of the primary database"
  definition "create_database_backup"

  # Updates the 'my_server' resource in the CloudApp with the 'new_server'
  # resource returned by the associated definition
  resource_mappings do {
    @my_server => @new_server
  } end

  # Updates the 'ip_address' Output value to the new string defined by
  # 'new_ip' after being returned by the associated definition
  output_mappings do {
    $ip_address => join(["IP:",$new_ip])
  } end
end
~~~

### Special Operations

When a user **Launches** a CloudApp, Self-Service will run operations in the following order:
1. `launch` operation as defined in the CAT, if one exists
2. `auto_launch` operation built into Self-Service
3. `enable` opeartion as defined in the CAT, if one exists

If the `launch` or `enable` operations are not defined in the CAT, those steps are skipped -- `auto_launch` is always run (its behavior is defined below).

When a user **Terminates** a CloudApp, Self-Service will run operations in the following order:
1. `terminate` operation as defined in the CAT, if one exists
2. `auto_terminate` operation built into Self-Service

If the `terminate` operation is not defined in the CAT, that step is skipped -- `auto_terminate` is always run (its behavior is defined below).

When a user **Stops** a CloudApp, Self-Service will run operations as follows:
* `stop` operation as defined in the CAT, *if one exists*
* If no `stop` operation is defined, Self-Service runs the **Terminate** sequence as defined above

When a user **Starts** a CloudApp, Self-Service will run operations as follows:
* `start` operation as defined in the CAT, *if one exists*
* If no `start` operation is defined, Self-Service runs the **Launch** sequence as defined above

These special operations describe the basic start and stop operations of your application. To use them, simply create an operation with the appropriate name.

* `launch` - used to launch all the services of the application
* `enable` - used to apply the steps necessary to configure your resources as needed (for example, connect the app servers to the load balancers)
* `stop` - used to stop the CloudApp. This operation is called by the scheduler if the CloudApp has a schedule.
* `start` - used to start the CloudApp. This operation is called by the scheduler if the CloudApp has a schedule.
* `terminate` - used to terminate all resources associated with a CloudApp

The built-in operations have the following behavior:

* `auto_launch` - will sequentially provision all resources defined in the CAT that a) were not passed in to the `launch` operation, and b) do not have a condition statement that evaluates to `false`. This operation cannot be overridden.
* `auto_terminate` - terminate and destroy all associated resources defined in the CAT as well as any new cloud resources that have been created as a result of the behavior of the CloudApp (except Volume Snapshots) which are associated with the deployment. This operation cannot be overridden.

**Note:** If any resources provisioned via launch/auto_launch have dependencies, terminate/auto_terminate will delete them in the correct order so they are deleted without any error. For example, deleting a security group used by a server will not cause any error as the server will be deleted before the security group is deleted.

## Definitions

Definitions are collections of cloud workflow code written using [RightScale Cloud Workflow language](../../rcl/v1/index.html). Resources and variables from the CAT must be explicitly passed in to definitions. Return values from definitions can be used to update Output values or resources in a CloudApp (see [Outputs](#outputs) above).

Example:

~~~ ruby
define create_front_end_tier(@front_end1, @front_end2) task_label: "Setup Load Balancer" do
  provision(@front_end1)
  provision(@front_end2)
end
~~~

### Returning Information from Definitions

By using `output_mappings` and `resource_mappings` in Operations, you can return information from RCL back to the CloudApp in Self-Service. To return a variable or resource, simply add it to the return statement of the definition.

For example, if you were to write a custom `launch` operation which launched the `@my_server` resource, you would need to do it like so:

~~~ ruby
define launch(@my_server) return @my_server do  
  provision(@my_server)  # Do something else with the server
end
~~~

Note: if the name of the resource returned by a definition is the same as the resource in the CAT, that resource will be automatically updated without requiring the use of a `resource_mappings` block.

## Built-in Methods and Other Keywords

On top of simple values and parameters you may also use any of the following built-in methods to define a resource field, condition declarations, and output values.

* `null`: A keyword which indicates that a resource field should be excluded from those sent during the provisioning step. May be used in a resource or mapping.
* `find(filter_1: ..., filter_2: ...)`: Look up resource given a list of filters (e.g. name and revision for published resources like ServerTemplates, RightScripts etc.). Useful to prevent hard-coding hrefs in fields (for example so that the same Cloud Application Template can be used across multiple RightScale accounts). ** See note below
* `map(mapping_name, key_name, value_name)`: Look up value from mapping, see the [Mappings](#mappings) declaration section above.
* `join([string1, string2, .., stringn], sep)`: Join multiple strings together with given separator. sep is optional, the default value is the empty string.
* `uuid()`: Return a guid in standard notation.
* `tag_value(resource, string)`: Given a resource and the namespace/predicate of a tag, return the value of that tag on that resource. (e.g. tag_value(@server, "ec2:Name")
* `split(string, sep_or_regexp)`: Split a string by either a string or by using a regular expression.
* `first([elem1, elem2, .., elemn])`: Extract first element of list.
* `last([elem1, elem2, .., elemn])`: Extract last element of list.
* `get(index, [val1, val2, .., valn])`: Extract element at given index from list.
* `switch(condition, a, b)`: Return `b` if condition is a condition that evaluates to false, `a` otherwise. This method allows you to set a field conditionally depending on the value of a condition declaration. The associated values may in turn be simple values or built-in methods. The condition **must refer to a condition declaration** and may not be an inline expression, e.g. `switch($high_profile, "c3.xlarge", "m1.small")`.
* `equals?(a, b)`: Condition that evaluates to `true` if `a` and `b` are the same.
* `logic_or(condition1, condition2)`: Apply logical or operator to values of two conditions (see the [Conditions section](#conditions) above). This returns a condition, so calls can be nested.
* `logic_and(condition1, condition2)`: Apply logical  and operator to values of two conditions (see the [Conditions section](#conditions) above). This returns a condition, so calls can be nested.
* `logic_not(condition)`: Apply logical not operator to value of condition. This returns a condition, so calls can be nested.

You may also refer to other resources defined in the CAT using the `@` operator, for example:

~~~ ruby
resource "master", type: "server" do
  # ...
end

resource "master_volume", type: "volume" do
  # ...
end

resource "master_xvdb", type: "volume_attachment" do
  device "/dev/xvdb"
  instance @master       # Refers to "master" server defined above
  volume @master_volume  # Refers to "master_volume" volume defined above
end
~~~

When setting the value of a field which represents a resource, you have two options: you can use the resource href, or you can use the `find` function to locate a resource using it's name. When using `find`, the engine makes an index request on all resources of the corresponding type in the RightScale account using the filters given and picks the first match.

Note: Using `find` should be done carefully as creating a new resource with the same name in RightScale could end up affecting future executions of the CAT. Using a resource name can be useful for resources with static names (such as clouds, datacenters, instance types) and for building a CAT that works across multiple RightScale accounts (since the same named resource will have different hrefs in different accounts).
