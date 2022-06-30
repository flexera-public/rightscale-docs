---
title: CAT File Language
description: A Cloud Application Template (CAT) file comprises a sequence of fields and declarations. It describes the structure and behavior of a Cloud Application (CloudApp).
version_number: "20161221"
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
* **Output Sets** - used to show multiple similar values to end users
* **Operations** - define the behaviors that apply to this CloudApp during its lifecycle
* **Permissions** - used to specify any additional permissions required to run the CloudApp

#### Naming restrictions

Declarations all require a name that can be used to reference them in other areas of the template. Names are required to begin with an underscore or lowercase alphabetic character ('a' - 'z'), followed by any combination of underscores or alpha-numeric characters.

### Built-in methods

The language also provides many built-in methods that can be used, which are [referenced below](#built-in-methods-and-other-keywords).

### Cloud Workflow definitions

In addition to the above CAT declarations, Cloud Workflow definitions may also be included in the CAT file. Cloud Workflow definitions are reusable code components written in a cloud-focused workflow language ([RightScale Cloud Workflow](/ss/reference/rcl/v2/index.html)) which is the backing engine behind Self-Service and CAT files.

## Fields

The seven fields that can be defined in a CAT are:

* `name` (required): Name of the Cloud Application Template. Must be unique, and must not be whitespace-only.
* `rs_ca_ver` (required): Version of the engine used to parse the CAT. (This reference describes version 20161221)
* `short_description` (required): Short description (shown to users in Catalog view on the front of the card). Must not be whitespace-only. The rendering of this content supports markdown syntax for formatting, lists, code blocks, image insertion, and more.
* `long_description` (optional): Long description (shown to users when they click "Details" on a catalog item). Must not be whitespace-only. The rendering of this content supports markdown syntax for formatting, lists, code blocks, image insertion, and more.
* `package` (optional): Package path of the Cloud Application Template. Must be forward-slash separated scopes where each scope begins with a lowercase letter or underscore and contains only lowercase/uppercase letters, numbers, and underscores. For more information about using the package field, see [Creating A Package](/ss/guides/ss_packaging_cats.html#creating-a-package). Note that any package beginning with 'rs' or 'rightscale', case insensitive, is reserved and cannot be used.
* `import` (optional): The package path of another Cloud Application Template, which is to be imported into current Template. For more information about using the import field, see [Importing A Package](/ss/guides/ss_packaging_cats.html#importing-a-package)
* `type` (optional): Possible values include `application` and `plugin`, defaults to `application`. `plugin` type CATs can define plugin-related declarations, are differentiated from other CATs in the UI and may not be published (but can still be launched for testing purposes). `application` type CATs can not contain `plugin` declarations. 


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

In the first example above, the UI will present the "code_branch" parameter to the user both when launching the CloudApp and when running the "pull_code" custom operation. On launch, the value will be pre-populated with the default value ("master"), and when launching the custom operation the value will be pre-populated with whatever the value was the last time it was used. Specifying an explicit list of operations in a parameter declaration will cause the UI to show that parameter only for the corresponding operations (or launch if the string "launch" appears in that list).

### Dynamic Parameters 

!!warning*Note*Dynamic parameters are currently in Labs and can only be used with CAT version `20161221` or higher.

When launching a CloudApp, you might have a need for parameters whose values are dynamic and can't be hard-coded into a CAT file. For example you might have a parameter whose options depend on the value of another parameter. Or, you might have a parameter whose options should be driven by some external system such a list of builds from a build system. 

For such use cases, you can define [Dynamic Parameters](/ss/guides/ss_dynamic_parameters.html).

## Mappings

Mappings allow you to lookup values based on other values that may come from parameters, built-in method results or resource fields. Mapping keys and subkeys must be strings. Mapping values may be strings, integers, booleans, or `null`. Mappings must be two levels deep.

### Usage

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

You can then use the `map` built-in method to look up values:

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

This example uses the value of the "profile" parameter to look up the application instance type.

## Resources

Resources represent a RightScale or cloud provider resource which is part of your cloud application. Resources can be referred to elsewhere in the CAT by using the syntax `@<resource_id>` where `resource_id` is the string following the `resource` keyword.

Resources can be defined singly, or can be defined in "bulk" when many of the same resource are needed. 

### Fields

The fields used to define a resource differ depending on the resource type. See the [Self-Service Resource Reference](ss_CAT_resources.html) for a full list of all available resources and their fields. Additionally, there are some fields that can be used for any resource:

Name | Required? | Description
-----|-----------|------------
`condition $<condition name>` | no | Only instantiate this resource if the condition resolves to true.
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

### Provisioning Resources

All resources can be instantiated by calling the [`provision` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision) on the resource. Every resource type has a default provision function that is used to create the resource, but it is possible to override this default function and instead have the `provision` function use a RCL definition of your choosing. For these cases you can leverage the `provision` attribute of a resource.

To use a custom definition to provision a resource, you simply add a `provision` attribute to the resource declaration and specify which RCL definition in the CAT to use for provisioning. The custom provision definition takes a declaration as parameter and returns a resource collection.

Here is an example of a declaration using a custom provision that creates a server but does not launch it (the default `provision` function for a Server both creates *and* launches it, as well as provides error handling).

!!info*Note:*When using custom `provision` functions, make sure to anticipate the case that the function could be called with a Bulk Resource declaration and might need to provision an array of resources.

~~~ ruby
resource "database_slave", type: "server", provision: "create_without_launch" do
  name "Database Slave"
  cloud "AWS US-East"
  server_template_href "/api/server_templates/123"
end

define create_without_launch(@declaration) return @server do
  $object = to_object(@declaration)
  $fields = $object["fields"]
  @server = rs_cm.servers.create($fields)
  @server = @server.get()
end
~~~

### Bulk Resources

In many use cases, you might find that you need "N" numbers of a given resource, with only small variations such as the name of the resource. For these cases, "bulk" resources can be leveraged to simplify the definition and management of these "collections" of resources. 

To define a "bulk" resource, you simply add a `copies` attribute to the resource declaration. This attribute can be set to a pre-defined number or to a parameter value (of type `number`) input by the user.

You can use the [output_set](#output-sets) in conjunction with bulk resources to show attributes of bulk resources as Outputs in the CloudApp.

Here is an example using bulk declarations to provision 100 servers with the same settings as the single server above:

~~~ ruby
resource "app_servers", type: "rs_cm.server", copies: 100 do
  name join(["Server #", copy_index()])
  cloud "EC2 us-east-1"
  server_template "Base ServerTemplate"
end
~~~

Note the use of the [copy_index()](#built-in-methods-and-other-keywords) function to create unique names for each server created as part of the group.

!!info*Note*Currently, the maximum supported value of the `copies` attribute of a bulk resource is `300`

The example below demonstrates the use of the [get()](#built-in-methods-and-other-keywords) function to refer to specific resources defined within a bulk resource collection. This exmaple creates N number of servers and volumes (along with the attachment of the volumes to the servers) with N/10 number of "placement groups", associating each group of 10 servers to the appropriate placement group.

~~~ ruby
# N/10 number of Placement Groups
resource "app_pgs", type: "placement_group", copies: add(1, div(sub($servers_count,1), 10)) do
  name join(["Placement Group #", copy_index()])
end
  
resource "app_servers", type: "server", copies: $server_count do
  name join(["Server #", copy_index()])
  cloud "EC2 us-east-1"
  server_template "Base ServerTemplate"

  # Each placement group is to contain 10 servers
  # Use `get` to refer to a single placement group
  # Use `field` to access a field of the placement group.
  placement_group field(get(div(copy_index(), 10), @app_pgs), "href") 
end

resource "app_volumes", type: "volume", copies: $server_count do  
  name join(["Volume #", copy_index])                            
  cloud "EC2 us-east-1"
  size 100
  volume_type "standard"
end

resource "app_attachments", type: "volume_attachment", copies: $server_count do
  name join(["Volume Attachment #", copy_index()])
  volume get(copy_index(), @app_volumes)
  server get(copy_index(), @app_servers)
  cloud "EC2 us-east-1"
  device "/dev/xvdb"
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
`label` | no | string | The label of the permission to show in the UI

Resources and actions are both scoped to namespaces using the syntax `namespace.resource_or_action`. All RightScale resources have a namespace of `rs_cm`.

!!info*Note*RightScale resources specified in the `resources` field should match the plurality of the `Resources` names in the [CM API 1.5 docs](http://reference.rightscale.com/api1.5/index.html).

!!info*Note*In general actions specified in the 'actions' field match those described in the [CM API 1.5 docs](http://reference.rightscale.com/api1.5/index.html). In addition to those actions the `rs_cm.ssh_keys` and `rs_cm.credentials` resources support the special actions `rs_cm.index_sensitive` and `rs_cm.show_sensitive` which should be specified if a designer makes use of the `index` or `show` actions on those resources and requests the sensitive view.

### Usage

~~~ ruby
permission "manage_sgs" do                       # The name of the permission
  label     "Manage SGS"                         # The UI label of the permission
  actions   "rs_cm.create", "rs_cm.destroy"      # Actions which may be taken
                                                 #  on the resources
  resources "rs_cm.security_groups"              # Resources which may be used
end
~~~

You can simplify a permission declaration by using the wildcard character `*` in the `actions` field as shown below.

~~~ ruby
permission "serverz_4_dayz" do
  label     "Any Server Action"
  actions   "rs_cm.*"                # Any action
  resources "rs_cm.servers"
end
~~~

Actions you specify in a permission declaration must each apply to at least one of the resources defined in the permission. Likewise, each resource you specify in a permission declaration must have at least one corresponding applicable action defined. Failing either of these requirements will result in a parser error.

~~~ ruby
permission "unused_action" do
  actions   "rs_cm.launch", "rs_cm.create"      # Error: rs_cm.launch doesn't apply
                                                #  to any resources
  resources "rs_cm.security_groups", "rs_cm.security_group_rules"
end

permission "unused_resource" do
  actions   "rs_cm.launch", "rs_cm.terminate"
  resources "rs_cm.instances", "rs_cm.sessions" # Error: there aren't any actions
                                                #  applicable to rs_cm.sessions
end
~~~

## Outputs

Outputs provide a mechanism to expose the result of running an Operation on the CloudApp; they are shown in the UI to your users. Output values may be explicitly returned from Operations or a `default_value` can be specified which is computed after running the "auto_launch" operation (see below). An output declaration consists of a `name`, a `label`, an optional `category`, `description`, and an optional default value. For common attributes that are available for resources, see Self-Service Output Reference.

The `output` declaration is generally intended for individual resources, not bulk resource collections (see [Output Sets](#output-sets) below). If an `output` refers to a bulk resource collection, it will show information about only the first item in the collection.

### Fields

The following fields are available for Outputs:

Name | Required? | Type | Description
-----|-----------|------|-------------
`label` | yes | string | The label of the Output to show in the UI
`category` | no | string | Category to group related outputs together in the UI
`description` | no | string | Description shown in the UI
`default_value` | no |  | The default value of this output, calculated after the "auto_launch" operation is run

The fields available to show resource information in the `default_value` field differ depending on the resource type. See the [Self-Service Output Reference](ss_CAT_outputs.html) for a full list of all available resources and their outputs.

### Usage

The example below shows an output listing the public IP addresses of a running Cloud Application from the "front_end" resource:

~~~ ruby
output 'ip_address' do
  label "IPs"  
  category "Connect"
  default_value join(["Public IP address: ", @front_end.public_ip_address])
  description "Service public IPs"
end
~~~

The value of an Output can be overwritten by using an `output_mapping` in an `operation` declaration ([see below](#operation-fields)).

### User Interface Behavior

The `category` is used to group outputs in the UI and has no other effect. On the main CloudApp "index" page in card view (showing multiple CloudApps), the UI shows the first 6 outputs from the first category. Other categories are shown as tabs in the detail view of the CloudApp.

Any output will be hidden that either: is an empty string, is set to `null` in an `output_mapping`, or contains a reference to a resource that doesn't exist. For example, if your output value is defined as `@server.name` but `@server` is not a resource (perhaps is was excluded by use of a condition), the output will not be shown in the UI.

## Output Sets

The `output_set` declaration can be used in conjunction with [bulk declarations](#resources-bulk-resources) to define one output per resource in the bulk declaration. Both the `label` and the `default_value` field can reference a bulk resource collection (they must reference the same collection) and the `output_set` will create as many outputs as there are resources in the collection. 

Note that the `output_set` declaration concerns itself with resource collections. Resource collections can either be created with [bulk resources](#resources-bulk-resources) declaration or be created in RCL and returned in a custom `launch` operation.

### Fields

The fields for the `output_set` declaration are the same as the [fields for the output declaration](#outputs-fields).

### Usage

The below example produces 20 outputs that each show the `public_ip_address` for the corresponding resource in the bulk resource collection.

~~~ ruby
resource "servers", type: "servers", copies: 20 do
  name join(["Server #", copy_index()])
  server_template "Base ServerTemplate"
end
  
output_set "ip_addresses" do
  label join(["Server ", @servers.name, " IPs"])
  default_value @servers.public_ip_address
  description "Server public IPs"
end
~~~

Note that with the `output_set` declaration, any resource attribute can be used in both the `label` and the `default_value` attributes of the `output_set`.

When an `output_set` is used as the target of an `output_mapping`, all of the calculated outputs are replaced with the new values specified in the `output_mapping`. Note that when doing this, it is not possible to actually return a resource collection directly from the definition into the `output_mapping`, but rather a `resource_mapping` must be used to update the collection in the CAT, which can then be used in the `output_mapping`, like below:

~~~ ruby
resource "servers", type: "rs_cm.servers", copies: 30 do
# ...
end

output_set "status" do
  label join(["Server status ", copy_index()])
  default_value @servers.state
end

output_set "last_backed_up_at" do
  label "Last back up"
end

operation "backup" do
  definition "do_backup"

  # Recalculate the output_set values
  output_mappings do {
    $last_backed_up_at => $timestamps,
    $status => join(["current: ", @servers.state])
  } end

  # Update the @servers collection in the CAT
  resource_mappings do {
    @servers => @new_servers
  } end
end

define do_backup(@servers) return @new_servers, $timestamps do
  $timestamps = map @server in @servers return $timestamp do
    call backup(@server)
    $timestamp = now()
  end
  @new_servers = @servers
end
~~~

The  output sets `status` and `last_backed_up_at` contain as many entries as there are servers in the bulk declaration. Entries of the `last_backed_up_at` array are initialized from the corresponding values in the `$timestamps` array returned from the `do_backup` definition while entries of the `status` array are initialized from the `state` field of each returned server.

### User Interface Behavior

In the Self-Service UI, all `output_set` values will be shown after any `output` values in the given `category'.

## Operations

Operations describe the tasks that happen to your application across its lifecycle. There are five special operations listed below, but any number of custom operations are supported. Custom operations can be made available to end-users through the Self-Service user interface. The operation `name` is shown to end-users as allowable operations on their CloudApps.

Operations can update the resources and outputs that make up a CloudApp by explicitly mapping return values from a definition to the resource/output in the CloudApp.

!!warning*Important:* If you don't explicitly `return` a resource, Self-Service will be unaware of its state, so always make sure to return resources that you modify in an operation.

### Fields

Each operation contains fields that define the operation and mappings that map return values from a definition back to the outputs/resources of a CloudApp:

Name | Required? | Type | Description
-----|-----------|------|------------
`label` | no | string | The label of the operation to show in the UI
`definition` | yes | string | The Cloud Workflow definition name that will be run when this operation is triggered
`description` | no | string | A textual description of what the operations does. This is shown to the user when selecting an operation
`resource_mappings` | no | hash | Overwrites a resource in the CloudApp with a new resource that has been returned by the definition
`output_mappings` | no | hash | Overwrites an output value of a CloudApp with a value returned by the definition. Can be used to modify both `output` values and `output_set` values

!!info*Note:* You can hide an Output in the UI by setting its value to `null` in an `output_mapping`.

~~~ ruby
operation "backup_primary_db" do
  label "Backup Primary Database"
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

Definitions are collections of cloud workflow code written using [RightScale Cloud Workflow language](../../rcl/v2/index.html). Resources and variables from the CAT must be explicitly passed in to definitions. Return values from definitions can be used to update Output values or resources in a CloudApp (see [Outputs](#outputs) above).

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

### Self-Service Context in Definitions

Any Cloud Workflow process that is created from a Self-Service application will contain two global references that can be used to refer to the CloudApp.
* `@@deployment` contains a reference to the [CM deployment object](https://reference.rightscale.com/api1.5/resources/ResourceDeployments.html) that is associated with the CloudApp
* `@@execution` contains a reference to the [Self-Service execution](https://reference.rightscale.com/selfservice/manager/index.html#/1.0/controller/V1::Controller::Execution) (i.e. the running CloudApp) object


## Built-in Methods and Other Keywords

On top of simple values and parameters you may also use any of the following built-in methods to define a `resource` field, `condition` declarations, `output` values, and `output_set` label and value fields.

* `copy_index()`: Only valid in a [bulk resource declaration](#resources-bulk-resources) and an [output_set](#output-sets) declaration. Returns the current index in the collection for this iteration.
* `cred(cred_name)`: Return the value of the `Credential` in Cloud Management with the given name. **Note:** using this function requires the `admin` role, or a [permission](/ss/reference/cat/v20161221/index.html#permissions) that grants the `admin` role.  It will return an exact match if available, if not will return first partial match. 
* `dec(a, b)`: Takes two arguments and subtracts them (`a-b`).
* `div(a, b)`: Takes two arguments and returns the result of the Euclidean dividion (`a/b`).
* `equals?(a, b)`: Condition that evaluates to `true` if `a` and `b` are the same.
* `field(@resource, field_name)`: Extract the value of the `field_name` field of the given resource.
* `find(filter_1: ..., filter_2: ...)`: Look up resource given a list of filters (e.g. name and revision for published resources like ServerTemplates, RightScripts etc.). Useful to prevent hard-coding hrefs in fields (for example so that the same Cloud Application Template can be used across multiple RightScale accounts). ** See note below
* `first([elem1, elem2, .., elemn])`: Extract first element of list.
* `get(index, [val1, val2, .., valn])`: Extract element at given index from list.
* `get(index, @resource_collection)`: Extracts the resource at given index from the resource collection.
* `inc(a, b)`: Takes two arguments and adds them (`a+b`)
* `join([string1, string2, .., stringn], sep)`: Join multiple strings together with given separator. sep is optional, the default value is the empty string.
* `last([elem1, elem2, .., elemn])`: Extract last element of list.
* `ljust(string, padded_length[, padding_value])`: If `padded_length` is greater than the length of `string`, returns a string of length `padded_length` with `string` left justified and padded with `padding_value`; otherwise, returns `string`.
* `logic_and(condition1, condition2)`: Apply logical  and operator to values of two conditions (see the [Conditions section](#conditions) above). This returns a condition, so calls can be nested.
* `logic_not(condition)`: Apply logical not operator to value of condition. This returns a condition, so calls can be nested.
* `logic_or(condition1, condition2)`: Apply logical or operator to values of two conditions (see the [Conditions section](#conditions) above). This returns a condition, so calls can be nested.
* `map(mapping_name, key_name, value_name)`: Look up value from mapping, see the [Mappings](#mappings) declaration section above.
* `mod(a,b)`: Takes two arguments and returns the modulo (`a%b`)
* `null`: A keyword which indicates that a resource field should be excluded from those sent during the provisioning step. May be used in a resource or mapping.
* `prod(a, b)`: Takes two arguments and multiplies them (`a*b`)
* `rjust(string, padded_length[, padding_value])`: If `padded_length` is greater than the length of `string`, returns a string of length `padded_length` with `string` right justified and padded with `padding_value`; otherwise, returns `string`.
* `split(string, sep_or_regexp)`: Split a string by either a string or by using a regular expression.
* `switch(condition, a, b)`: Return `b` if condition is a condition that evaluates to false, `a` otherwise. This method allows you to set a field conditionally depending on the value of a condition declaration. The associated values may in turn be simple values or built-in methods. The condition **must refer to a condition declaration** and may not be an inline expression, e.g. `switch($high_profile, "c3.xlarge", "m1.small")`.
* `tag_value(resource, string)`: Given a resource and the namespace/predicate of a tag, return the value of that tag on that resource. (e.g. tag_value(@server, "ec2:Name")
* `to_s(value)`: Converts `value` to a string. The `value` can be a `number`, `boolean`, or a `string`.
* `uuid()`: Return a guid in standard notation.


### Using CAT methods on attributes

Some of the above methods may be used in attribute values of a declaration. The following methods are available: 
* `dec`
* `div`
* `inc`
* `map`
* `mod`
* `prod`

The following example creates placement groups for `$server_count` servers, each placement group having 10 servers at max, using methods to calculate the value of the copies attribute.

~~~ ruby
resource "app_pgs", type: "placement_group", copies: add(div(dec($server_count, 1), 10), 1) do
  name join(["Placement Group #", copy_index()])
end
~~~

## Cross-Referencing Declarations

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
