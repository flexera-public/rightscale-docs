---
title: Dynamic Parameters - LABS
description: This LABS feature allows for CAT parameter values to be dynamically changed during launch time based on other parameter values or on external API calls.
---

!!warning*Note*The features described on this page are currently in Labs. This feature should only be used with CAT version `20161221` or higher.

## Overview

When launching a CloudApp, you might have a need for parameters whose values changed based on other factors. The two primary types of dynamic parameters that are supported today are:

* **Dependent Parameters** - Use cases where the values of one parameter depend on the value of another parameter. For example being able to first select the Cloud, and only then be able to select the available Regions for that Cloud.
* **Dynamic Values** - Use cases where the possible values of a dropdown parameter are populated dynamically when the form is launched via some kind of logic (usually involving API calls, sometimes to RightScale and sometimes to other systems). For example having a dropdown that shows the available software builds from Jenkins

## Labs Limitations

The following are known limitations while this feature is in Labs. There may be additional limitations that are not listed here:

* There is very little error handling, therefore CAT designers must ensure they are meeting the interface requirements and their code is robust
* While in Labs, the implementation requires using an escaped JSON-encoded hash in the CAT -- this approach is not intuitive and will not be the final design
* When using Cloud Workflow to get values, the CWF process will run in the context of the user launching the CloudApp (if they don't have roles in Cloud Management, calls to CM will not work)

## Details

### Dependent Parameters

Although there may be other requirements for dependent parameters in some cases, the current solution only solves the simple case in which one parameter (the **dependent** parameter) must derive its available values from the value of another parameter (the **lookup** parameter). 

The approach is to define a `mapping` in the CAT which contains the valid values for the dependent parameter based on the value of the lookup parameter. The mapping has the syntax:

~~~ ruby
mapping <mapping_name> do {
  <key name> => {
    <lookup parameter value 1> => <array of possible values for dependent parameter>,
    <lookup parameter value 2> => <array of possible values for dependent parameter>,
    <lookup parameter value 3> => <array of possible values for dependent parameter>,
  }
}
~~~

The dependent parameter will need to know which mapping to use, the name of the key, and the name of the lookup parameter. This information is specified in the `description` field of the dependent parameter as an escapted JSON-encoded hash. The hash must contain the following keys:

* `mapping` - the name of the `mapping` in the CAT to use for the lookup
* `key` - the name of the first-level key to use in the mapping
* `parameter` - the name of the parameter this parameter depends on
* `description` (optional) - the description to use for this parameter

The above parameters are supplied in JSON string which is set as the `description` attribute of the `parameter` declaration, prepended with the string `json:`

The designer must take care to avoid circular dependencies.

#### Example

The below example contains a couple of dependent parameters. The "region" depends on the "cloud", and the "network" depends on the "region".

~~~ ruby
name "Dynamic Parameters example"
rs_ca_ver 20161221
short_description "Blank"
 
mapping "region_values" do {
  "cloud" => {
    "AWS" => ["us-east", "us-west"],
    "Azure" => ["us west", "us central", "us east"]
  },
  "network" => {
    "us-east" => ["east net 1", "east net 2"],
    "us-west" => ["west net 1"],
    "us west" => ["az west 1"],
    "us central" => ["central 1"],
    "us east" => ["east 1", "east 2"]
  }
} end
 
parameter "cloud" do
  type "string"
  label "Cloud to launch in"
  allowed_values "AWS", "Azure"
  operations "launch" 
end
 
parameter "region" do
  type "string"
  label "Region to launch in"
  description "json:{\"mapping\":\"region_values\",\"key\":\"cloud\",\"parameter\":\"cloud\",\"description\":\"Pick the region - must choose Cloud first\"}"
  operations "launch"
end
 
parameter "network" do
  type "string"
  label "Network to use"
  description "json:{\"mapping\":\"region_values\",\"key\":\"network\",\"parameter\":\"region\",\"description\":\"Pick the network - must choose Region first\"}"
  operations "launch"
end
~~~

### Dynamic Parameter Values

In some cases, you might want to populate the available values of a dropdown based on some external input (not hard-coded in the CAT). In this case, you can use Cloud Workflow to launch a process that can run arbitrary code, including calling out to external APIs. The dynamically-populated parameter will need to know which RCL definition to use to get the valid values. This information is specified in the `description` field of the dependent parameter as an escapted JSON-encoded hash. The hash must contain the following keys:

* `definition` - the name of the `definition` in the CAT to call to get the values
* `description` (optional) - the description to use for this parameter

The above parameters are supplied in JSON string which is set as the `description` attribute of the `parameter` declaration, prepended with the string `json:`

The designer must ensure that the definition being called meets these requirements:

* the RCL definition specified must exist in the CAT file
* the RCL definition must take no inputs 
* the RCL definition must return an array of strings

Additionally, when using this feature, the designer should concern themselves with the following items:

* do not use a definition that will take a long time to run (the user will be waiting)
* do not use more than 3 of this type of parameter in one CAT (it will affect performance)
* the CWF process will run in the context of the launching user (especially important if making CM API 1.5 calls)
* the definition should always return an array of strings, otherwise the UI may "hang" and prevent launching of the CloudApp

While the Cloud Workflow is running, the parameter will be disabled. Once the Cloud Workflow completes, the parameter will be re-enabled with the strings returned as the allowed values, or, if the Cloud Workflow fails, an error message will be provided to the user and they will be unable to launch the CloudApp. The error message includes the Cloud Workflow process ID that can be used by a designer in CWF Console to debug the error.

The version to use to make the call to Cloud Workflow will be inferred from the version of the CAT automatically.

#### Example

The below example contains 2 parameters that contain dynamic values. The first makes a `GET` http call to github to obtain a list of branches to show to the user. The second calls the [RightScale CM API 1.5](http://reference.rightscale.com/api1.5/index.html) to get a list of subnets for a given cloud – this call assumes the user launching is authorized to make such a call (i.e. they must have `actor` privileges on the given account in RightScale).

~~~ ruby
name "Dynamic Parameters example"
rs_ca_ver 20161221
short_description "Blank"
 
parameter "my_param" do
  label "Dynamic param"
  type "string"
  description "json:{\"definition\":\"getParamValues\", \"description\": \"List the branches available (from github.com/rightscale/rightlink_scripts)\"}"
end
 
parameter "subnet" do
  label "Subnet"
  type "string"
  description "json:{\"definition\":\"getSubnets\", \"description\": \"Pick the subnets in AWS US-Oregon\"}"
  operations "launch"
end
 
define getParamValues() return $values do
  $resp = http_get(url: "https://api.github.com/repos/rightscale/rightlink_scripts/branches")
  $branches = $resp["body"]
  $values = []
  foreach $branch in $branches do
    $values << $branch["name"]
  end
end
 
define getSubnets() return $values do
  @subnets = rs_cm.clouds.get(href:"/api/clouds/6").subnets()
  $values = @subnets.name[]
end
~~~
