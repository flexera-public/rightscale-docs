---
title: Setup Array Autoscaling Using Cloud Workflow
layout: cm_layout
alias: cm/dashboard/manage/arrays/arrays_cwf.html
description: 
---

## Overview

ServerArrays can be configured to leverage the Cloud Workflow engine to control the orchestration required to scale up and scale down. The integration also makes it possible for Cloud Workflow processes to run periodically -- potentially triggering scaling events either directly or by creating voting tags on instances that are running in the deployment.

For a refresher on ServerArrays and how voting tags affect autoscaling please consult the [Arrays Concepts](/cm/dashboard/manage/arrays/arrays_concepts.html) for alert based ServerArrays. For a refresher on Cloud Workflow and details on the RCL syntax please consult the [Cloud Workflow Language](/ss/reference/rcl/v2/#rcl).

## Key Concepts

Alert based ServerArrays scale up and down based on the alert conditions being met in the array definition. The default behavior of these arrays is to simply launch/terminate more of the specified instances. In some cases, you might want to customize the launch/terminate behavior or modify the server specification before launching more. Such use cases might include: checking and leveraging spot pricing, modifying an instance to utilize an existing Reserved Instance, or having more control over which instance(s) are terminated when scaling down.

To provide you with more control over the launch/terminate behavior of server arrays, you can optionally create the array with an escalation workflow template that controls the launch/terminate logic. If a template is provided then the default autoscaling orchestration is overridden -- it is possible to overwrite either the scale up orchestration, the scale down orchestration or both.  

When provided the system parses the given template and looks for RCL definitions with the following names:

  - `scale_up`: the definition run when a scale up event triggers. The definition should accept one argument which is the number of instances to be launched (as defined in the ServerArray elasticity parameters).
    
  - `scale_down`: the definition run when a scale down event triggers. The definition should accept one argument which is the number of instances to be terminated (as defined in the ServerArray elasticity parameters).
    
  - `monitor`: a definition run roughly every minute when the ServerArray is enabled. The definition accepts no parameter and can be used to monitor an array that is not currently undergoing scaling.

All these definitions have access to the underlying ServerArray object via the built-in `@@array` global reference. The RCL code can inspect the reference to figure out how many instances are currently running or to inspect the elasticity parameters. The [API reference](http://reference.rightscale.com/api1.5/media_types/MediaTypeServerArray.html) lists the fields available on the ServerArray object. Relationships can easily be followed using the RCL link syntax. For example retrieving the current instances in the ServerArray can be done with:

```ruby
@instances = @@array.current_instances()
```


## Helper definitions
The ServerArray escalation template definitions also have access to a few built-in definitions that provide additional control.

The `rs__log` and `rs__update_audit_summary_status` helper definitions can be used to append additional information to the audit associated with the server array and to create new audit sections respectively:

```ruby
call rs__update_audit_summary_status ("Launching new instances")
call rs__log(join(["instance count", to_s($count)], ": "))
```

These definition are especially useful during development to help debug the RCL code. The corresponding audit entries are attached to the server array and are readily available in the dashboard.

The `rs__cancel_process` definition makes it possible to cancel a current Cloud Workflow process. The argument indicates which process to cancel: it can be either `scale_down` or `scale_up`.

```ruby
sub timeout: 2m, on_timeout: rs__cancel_process("scale_down") do
  # …
end
```


## Example RightScale Cloud Workflow Language (RCL) Definitions

#### Basic Example
The example below reproduces the same behavior as the built-in orchestration:
```ruby
define scale_up($count) do
    # Launch $count instances in the array
    concurrent foreach $i in [0..$count] do
        @@array.launch() # Launches 1 instance 
    end
end

define scale_down($count) do
    # Terminate $count instances in the array
    $i = 1
    @instances = @@array.current_instances()
    while $i <= $count do
        @instance = @instances[size(@instances)-$i]
        @instance.terminate()
        $i = $i + 1
    end
end
```

Additional examples available in our GitHub repository [rs-services/serverarray-rcl-definitions](https://github.com/rs-services/serverarray-rcl-definitions)


## Enabling CWF Scaling and Uploading RCL Definitions

To enable CWF Scaling, the Array Type must be set to `alert` and the `server_array[elasticity_params][workflow_specific_params][template]` parameter must be defined and include the RCL definitions that you wish to override. Please note that creating a worklow-based server array [is only possible using the API](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#create).

Below is an example for updating an existing array by setting the workflow template parameter, which also enables CWF Autoscaling. To disable CWF Autoscaling -- unset or empty the `server_array[elasticity_params][workflow_specific_params][template]` parameter value.

_Update Array using rsc_:
```bash
rsc cm15 update https://us-3.rightscale.com/api/server_arrays/12345678790 server_array[array_type]=alert server_array[elasticity_params][workflow_specific_params][template]@/path/to/rcl_definitions.rb 
```

or

_Update Array using curl_:
```bash
curl -i -H "Cookie: $rs_gbl" -H X_API_VERSION:1.5 -X PUT \
    -d server_array[array_type]=alert \
    --data-urlencode server_array[elasticity_params][workflow_specific_params][template]@/path/to/rcl_definitions.rb \
    https://us-3.rightscale.com/api/server_arrays/12345678790
```
See official API docs for [ServerArray Resources](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html) for detailed API spec.

## Testing the Scaling Definitions

If an array has workflow-based scaling enabled, you can trigger a scale up or down by calling the [scale_up](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#scale_up) or [scale_down](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#scale_down) actions of the array via Cloud Management API 1.5. These are the same actions that are triggered when an alert-based array determines that scaling must occur.
