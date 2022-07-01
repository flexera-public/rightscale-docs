---
title: Cloud Workflow Language
description: RightScale's server orchestration solution allows managing entire applications running on the cloud by leveraging the RightScale platform.
version_number: "2"
versions:
  - name: 1
    link: /ss/reference/rcl/v1/index.html
  - name: 2
    link: /ss/reference/rcl/v2/index.html
---

## Overview

RightScale's cloud orchestration solution allows managing entire applications running on the cloud by leveraging the RightScale platform. The orchestration may include activities like configuring and launching servers in order, running operational runlists, scaling server arrays, sending emails, retrieving and analyzing metrics data, sending requests to external applications, prompting users for input, etc.

* A _cloud workflow_ is the static definition of all activities involved in a given orchestration instance. At any point in time a single cloud workflow may have multiple instances running. Such instances are called processes. Each process is launched with (and maintains) its own state.

* A cloud workflow may make calls into other cloud workflows and thus the set of activities that ends up running in a single process may span multiple cloud workflows.

* A cloud workflow is thus akin to the source code of a program while a process is similar to the execution of that program.

## RCL

Cloud workflows are written in a language called **RCL**, an acronym for RightScale Cloud Workflow Language. **Why a new language?** The short answer is that the runtime characteristics of a process are fundamentally different from a typical program execution. Processes tend to execute over long periods of time in an event driven manner, much of the time the process sleeps waiting for the next event to occur at which point it wakes up, makes some decisions and kicks off new actions, and goes to sleep again. Each time it wakes up, the process can be executed by a different server such that changes in load, platform reconfigurations, and machine failures don't affect process execution. Cloud workflows are also often parallel; an event may kick off parallel actions. Sometimes several parallel strategies are initiated and the first one to succeed is pursued while others are aborted. Workflow languages such as RCL are designed to support these characteristics natively, thereby simplifying the writing of robust and powerful workflows. However, an important design criteria is to make it as similar to regular scripting languages as possible to make it intuitive even for users not usually exposed to authoring workflows. The hope is to create a language that is easy to pick up and consistent but also exposes all the basic constructs that are needed to build powerful workflows.

At the core RCL allows writing a sequence of expressions. Such expressions may describe the control flow of a process or may specify actions that need to be taken on resources. A cloud workflow is thus a sequence of expressions executed sequentially (which is not saying that all activities must be executed sequentially; for example, the `concurrent` expression allows for running activities concurrently).

Before going further into the details of the language, here is an example of a complete cloud workflow that can be used to launch servers in order (database first, then application servers). This cloud workflow uses an application name given as an input to find the database servers by name and to build a tag used to retrieve the app servers.

~~~ ruby
define launch_app($app)
  concurrent timeout: 30m do # Launch database master and slave concurrently and wait for up to 30 minutes
    sub do # Launch database master
      @db_master = rs_cm.servers.get(filter: ["name==" + $app + "_db_master"]) # Get server using its name
      assert size(@db_master) == 1 # Make sure there is one and only one server with that name
      @db_master.launch() # Launch server
      sleep_until(@db_master:state[0] == "operational") # Wait for it to become operational
    end
    sub do # Launch database slave
      @db_slave = rs_cm.servers.get(filter: ["name==" + $app + "_db_slave"])
      assert size(@db_slave) == 1
      @db_slave.launch()
      sleep_until(@db_slave.state == "operational")
      @@slave = @db_slave # Save reference to slave in global variable so it can be used later
    end
  end

  # This won't execute until both servers are operational
  @@slave.run_executable(recipe_name: "db::do_init_slave") # Init the slave
  @apps = servers.get(filter: ["name==appserver"])   # Retrieve all the servers with appserver in their name ...
  @apps.launch() # ...and launch them

end
~~~

The code should be fairly self-explanatory, a few hints that may help:

* Variables whose names start with a `$` symbol contain JSON values (strings, numbers, booleans etc) while variables whose names start with a `@` symbol contain collections of resources (deployments, servers, instances etc.). Variables that contain collection of resources are referred to references to differentiate them from variables which contain JSON values. The language also supports global variables prefixed with `$$` and global references prefixed with `@@` whose values are accessible to the entire process definition and do not follow the usual scoping rules.
* Resources have actions and fields that can be called with the `.` operator (e.g. `@db_server.launch()`, `@db_master.state`). Actions take parenthesis while fields do not.
* Code written in RCL always deals with _collections_ of resources and never with a single resource. This explains why `@apps.launch()` ends up launching all the application servers.

Resource actions (`launch()` and `run_executable()` in the definition above) are a special kind of expression that allows interacting with external systems such as the RightScale platform. A resource encapsulates external state and its actions allow managing that state. The state is made available through *fields* (e.g. `state` in the definition above). This is similar in nature to objects (resources), methods (actions) and members (fields) in an object oriented language with the distinction that fields are read-only and can only be updated through actions.

Resources can be located using the resource type *actions* (`get()` in the definition above).

*Functions* are built-in helpers that provide logic that gets run in the engine itself (`size()`, `sleep_until()`) in the definition above).

Finally, expressions can also be adorned with *attributes*, which allow for attaching additional behavior to the execution of the expression (such as error handling, timeout etc.). In the definition above the `timeout` attribute is used to guarantee that the process will not wait for more than 30 minutes for both database servers to become operational.

Put together, resource actions, resource fields, resource type actions, functions and attributes make up the bulk of the language.

## Resources

Resources present the author with a consistent toolset for managing external state. Through resources one can enumerate collections, locate items and act on them. For example, resources allow managing RightScale abstractions like *deployments*, *servers*, *server arrays*, *instances*, etc. Each resource corresponds to an underlying abstraction and is scoped to a *namespace*. For example, a RightScale Server resource might have:

* **namespace:** _rs_
* **type:** _servers_
* **href:** _servers/123_
* **fields:** _cloud: aws-us-east, datacenter: us-east-1a, launchedat: 2011/8/1 16:56:87, ..._
* **links:** _current_instance, deployment, ..._
* **actions:** _launch(), terminate(), clone(), ..._
* **type actions:** _get(), create()_

**Note:** *The resource type name ("servers") is plural.*

The following sections further discuss the various resource properties that are listed above (`href`, `fields`, `links`, etc.).

### Namespaces

Resources are exposed to the cloud workflow engine in the form of HTTP APIs. A namespace exposes a given API to cloud workflows. The `rs` namespace encapsulates RightScale Cloud Management API 1.5 and gives access to all the resources it defines. It also implicitly scopes that access to the account running the process.

The rest of this document describes how to work with resources in a cloud workflow. Resources are managed in collections and expose fields, links, and actions. The [Mapping RightScale Resources to the APIs](#mapping-resources-to-the-rightscale-apis) section may help make things more concrete as it lays out how the various constructs map back to the RightScale API in the rs namespace.

### Resource Collections

An important aspect of the language that may not be intuitive is that a cloud workflow always acts on a *collection* of resources. The resources in a collection are always of the *same type* (such as all servers or all instances). For example, executing resource actions is always done on a collection:

~~~ ruby
@servers.launch()
~~~

The expression above will execute the action `launch()` on all the resources in the `@servers` resource collection. [Resource actions](#resource-actions) are further described below.

A quick example of Deployment inputs can be seen below, specific to the `multi_update_inputs` action.

~~~ ruby
# Update the INPUTS with their new Values.
$inp =
{
  "JAVA_VERSION": "text:7",
  "JAVA_HOME" : "text:/usr/loca/myjavalocation"
  }

# Apply inputs to the @deployment resource collection
@deployment.multi_update_inputs(inputs: $inp)
~~~

RCL includes built-in functions to manipulate collections. Functions like `first()`, `last()`, etc. also always return collections of resources (albeit made of a single resource in both these cases). Always working with collections allows for a much simpler language that does not need to differentiate between managing collections or unique items. The language supports constructs for checking the size of a collection and for extracting items (creating another collection with the extracted items). A collection may contain any number of resources, including no resource. Executing an action on an empty resource collection is not an error, it just has no effect.

**Note:** *An empty resource collection still has an associated resource type, attempting to execute an action not supported by the resource type on an empty collection raises an error.*

#### References

Resource collections can be stored into *references*, like `@servers` in the example above. A reference name must start with `@` and may contain letters, numbers, and underscores. The convention used for reference names consists of using *lower_case* although all that really matters to the engine is that the first character be `@`. A reference can be initialized using the results of an action or using one of the operators described in [Resource Collection Management](ss_RCL_operators.html#collection-and-array-operator) section in the [RCL Operators](ss_RCL_operators.html) document.

**Note:** *References must be initialized before they can be used in expressions. Using an uninitialized reference in an expression results in a runtime error. References can be initialized to an empty collection using the resource types `empty()` action described below as in: `@servers = rs_cm.servers.empty()`.*

### Resource Fields

A cloud workflow primarily orchestrates how state propagates through various resources. Computation done on that state should be done primarily by systems exposing these resources (e.g. RightScale's APIs). Sometimes though it can be useful for a cloud workflow to read the value of a given resource field so it can trigger the proper activities. Fields can be read as follows:

~~~ ruby
@servers.name   # Retrieve name of first server in collection
@servers.name[] # Retrieve names of all servers in collection
~~~

The first line returns a string while the second line returns an array of strings, each element corresponding to the name of the resource in the `@servers` collection at the same index.

**Note:** *Resource references always contain a collection of resources and extracting a field, like in the expression `@servers.name[]`, always returns an array, even if the collection consists of only one server. The notation sans brackets is meant to help in the case a collection only contains one element.*

#### Field Values

Fields contain JSON values:

* **Strings(UTF-8 encoded):** "a string", escape " with \ as in "\""
* **Numbers:** 1, 1.2, 3e10, -4E-100
* **Booleans:** true, false
* **Null:** null
* **Arrays:** [ "a", 1 ]
* **Ranges:** [1..3], ["aa".."zz"], ["server-1".."server-3"], [$start..$finish]
* **Hashes:** { "key": "value", "key2": 42, "key3": true }
* **Datetime:** d"2012/07/01", d"2012/07/12 04:21:14 PM"

Elements of arrays and hashes can be retrieved using the square bracket `[ ]` operator. For example:

~~~ ruby
@servers.name[][0]
~~~

The snippet above returns a string containing the name of the first resource in the collection, it does the same as `@servers.name`. Fields are read-only and can only be modified by calling actions on the underlying resource.

Fields can also have datetime values and, for this purpose, the JSON syntax is extended to support datetime values as follows:

`d"year/month/day [hours:minutes:seconds] [AM|PM]`

**Note:** *Date time values are always UTC.*

Examples are:

`d"2012/07/01"d"2012/07/12 04:21:14 PM"`

If no time is specified then midnight is used (00:00:00). If no AM/PM value is specified then AM is assumed unless the hour value is greater than 12.

Range in RCL has a start and finish values separated by `..`. These start/finish values can either be numbers or strings but both start and finish should be of the same type. For example, `["a"..3]` will cause an error.

### Resource Links

Resources also contain links that point to other collections. The main difference with respect to fields is that links yield resource collections rather than JSON values. For example, the RightScale `deployments` resource type has a link named `servers` that represents the collection of all servers in a deployment.

Retrieving the link on a collection will "flatten" the result. For example, if deployment *A* contains server *S1* and *S2* and deployment *B* contains server *S3* accessing the link servers on a collection made of these two deployments will yield a collection composed of *S1*, *S2*, and *S3*.

Links on resource collections can be followed using the following syntax:

~~~ ruby
@servers = @deployments.servers()
~~~

The snippet above assumes that the `@deployments` reference contains a resource collection made of deployments.

Links may take arguments depending on the resource type and the nature of the link. Some links may return a single resource while others may return multiple resources. In both these cases arguments may be used to further specify what should be returned. Some arguments control which resource fields in the results should be initialized (*views*) while others affect what resources should be returned (*filters*). For example:

~~~ ruby
@servers = @deployments.servers(filter: ["state==operational"])
~~~

The example above only returns the operational servers in the given deployments. As with resource fields and actions, the complete list of available links and their arguments is documented in the [CM API 1.5 reference](/api/).

### Provisioning and Terminating Resources

At the end of the day Cloud Workflow is all about managing resources. The most common activities executed by workflows consist of creating and deleting resources. Often times just creating the resource is not enough; for example just creating a RightScale server through the RightScale API is not that useful, instead it would be much more useful if a single operation could create the server, launch it and wait until it is operational. This is the intent behind the built-in `provision()` function. This function behaves differently depending on the resource being provisioned. The exact behavior for each RightScale resource is described in the [Functions section](ss_RCL_functions.html#resource-management). The `provision` function expects a [Resource Declaration](#resources-resource-declarations) to be passed in, and returns a [Resource Collection](#resources-resource-collections).

Similarly, just deleting a RightScale server is not that useful; instead the `delete()` function terminates the server, waits until it is terminated and then deletes it. The `delete` function expects a [Resource Collection](#resources-resource-collections) to be passed in.

In both cases (`provision()` and `delete()`) the intent is for the function to act atomically. In particular the `provision()` function will clean up if anything fails after the resource has been created. For example, if the server fails to go to operational (strands in RightScale) then it is terminated and deleted automatically. If you need more control on how the resource is created or how failure is handled then use the `create()` and `destroy()` actions described in the [Built-in Actions](#built-in-actions) section below, these are a subset of the actions used internally by `provision()` and `delete()`.

### Resource Declarations

So far we have discussed how it is possible to manage resource collections in RCL. Resource collections point to existing resources in the cloud. By definition the `provision()` function cannot take a resource collection as argument but needs a description of what the resource ought to be instead. This description is called a *resource declaration*. 

Resource declarations are most commonly defined [in a CAT file](/ss/reference/cat/v20161221/index.html#resources), but can also be defined directly in RCL using a JSON object which defines the resource `namespace`, `type`, and `fields`. The field values must be JSON encoded, in particular this means that values that are strings must start and end with double quotes. The following example creates a RightScale deployment using the `provision()` function:

~~~ ruby
# Create the new deployment declaration, note that the value
# gets assigned to a variable whose name starts with a "@"
# Also note that "fields" values must be JSON encoded
@new_deployment = { "namespace": "rs_cm",
                    "type":      "deployments",
                    "fields":    { "name": "my_deployment" } }

# Now provision deployment
provision(@new_deployment)

# @new_deployment now contains a resource collection and can be
# used to execute actions (see Resource Actions below)
@new_deployment.update("deployment": { "name": "new_name" })
~~~

Upon success the `provision()` function transforms the declaration given as parameter into a collection.

#### Bulk Resource Declarations

Generally defined in a CAT file using a [bulk resource declaration](/ss/reference/cat/v20161221/index.html#resources-bulk-resources), resource declarations can contain fields that instruct Cloud Workflow to create N number of a given resource. The optional field `copies` can be defined in a resource declaration and specifies how many of the resource to provision. The presence of the field is also how CWF infers whether a given resource declaration should be treated as a "bulk" declaration or not.

The correct way to inject the `copies` attributes into a resource declaration is by leveraging the [copy function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-copy).

Provisioning bulk resource declarations should be done using the [provision](ss_RCL_functions.html#resource-management-provision) function.

#### Advanced usage

!!info*Note*Generally, modifying resource declarations is not recommended. Explore other options before modifying declarations, including [bulk resource declarations](/ss/reference/cat/v20161221/index.html#resources-bulk-resources).

The JSON object that backs a declaration can be retrieved from a declaration using the `to_object()` function. In particular this makes it possible to manipulate declarations given to a definition prior to calling the `provision()` function.

~~~ ruby
# The definition below takes a declaration as parameter
define create_deployment(@deployment) do
  # Retrieve JSON object backing declaration
  $json = to_object(@deployment)
  # Manipulate JSON directly to change declaration
  $json["fields"]["name"] = "some_other_name"
  # Assign the JSON objet back to a declaration
  @new_deployment = $json
  # Now provision deployment
  provision(@new_deployment)
end
~~~

The declaration field values are always strings. The strings may contain literal JSON values like in the example above but may also contain RCL expressions. The expressions get parsed and executed when the declaration is provisioned via the `provision()` function, when `to_object()` is called on it or when a field is accessed (for example `@deployment.name`). This makes it possible to initialize a process with declarations whose fields contain RCL snippets that get parsed and executed when the process starts. For example, such fields may use the `find()` function to find dependent resources dynamically (a server image or instance type, a security group network, etc.). The execution of a field can be delayed until the actual provision happens by marking the field as an unresolved field.

~~~ruby
@security_group = { "namespace": "rs_cm",
                    "type": "security_groups",
                    "fields": { "name": "my_security_group" } }

@server = { "namespace": "rs_cm",
            "type": "servers",
            "fields": { "name": "my_server",
                        "security_group_hrefs": [@security_group] } }
~~~

In the example above, the reference `@security_group` is evaluated when the assignment statement is processed. Add the security group reference to the unresolved fields array to delay its evaluation until the declaration is provisioned (for example if the security group needs to provisioned first):

~~~ruby
@security_group = { "namespace": "rs_cm",
                    "type": "security_groups",
                    "fields": { "name": "my_security_group" } }

@server = { "namespace": "rs_cm",
            "type": "servers",
            "fields": { "name": "my_server",
                        "security_group_hrefs": "[@security_group]" },
            "unresolved_fields": ["security_group_hrefs"] }
~~~

Fields holding direct references to resources collections such as `@security_group` get substituted with the value of the `href` field of the first element in the corresponding resource collection. For example `"[@security_group]"` will be evaluated to `["/api/security_groups/ABDC123"]`.

### Custom Provision Functions

All resources can be instantiated by calling the [`provision` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision) on the resource. Every resource type has a default provision function that is used to create the resource, but it is possible to override this default function and instead have the `provision` function use a RCL definition of your choosing. For these cases you can leverage the `provision` attribute of a resource.

To use a custom definition to provision a resource, you simply add a `provision` top level field to the resource declaration and add a definition with the same name in your RCL code. The custom provision definition takes a declaration as parameter and returns a resource collection.

Here is an example of a declaration using a custom provision that creates a server but does not launch it (the default `provision` function for a Server both creates *and* launches it, as well as provides error handling).

~~~ ruby
define main() do
  # Create the new server declaration with custom provision.
  @declaration = { "namespace": "rs_cm",
              "type": "servers",
              "provision": "create_without_launch",
              "fields": { "name": "my_server"} }
  # Now provision server. This end up calling 'create_without_launch'
  @my_server = provision(@declaration)
end

define create_without_launch(@declaration) return @resource do
  $object = to_object(@declaration)
  $fields = $object["fields"]
  @resource = rs_cm.servers.create($fields)
  @resource = @resource.get()
end

~~~

### Provisioning Dependencies

A resource declaration can have dependencies that need to provisioned before the original declaration. Dependencies can be specified in two forms: explicit (specified using the `dependencies` field of a declaration) or implicit (one of the declaration field referring to another declaration). In the example in the section above the `@security_group` collection is an implicit dependency of the server therefore provisioning the server first provisions the security group (if it isn't provisioned already). The `provision()` function is idempotent so if the argument is already provisioned, it will simply return the argument. Dependencies can also be specified explicitly:

~~~ruby
@master = { "namespace": "rs_cm",
            "type": "servers",
            "fields": { "name": "master server" } }

@slave = { "namespace": "rs_cm",
           "type": "servers",
           "fields": { "name": "slave server" },
           "dependencies": ["@master"] } # Master server should be provisioned before slave
~~~

A declaration provisioned as a dependency of another declaration causes that declaration to be added as a *dependent* of that dependency. In the example above `@server` is added as a dependent of the `@security_group`.

### Deleting Dependents

Since `provision()` keeps track of dependents as the dependencies are provisioned, the `delete()` function can delete the dependents before deleting the collection. Simply destroying the security group before destroying the server would fail because the server is still using it. However thanks to the built-in dependency tracking described above `delete(@security_group)` first deletes the server.

The dependents of a collection are kept in the collection itself along with other properties of a collection. So doing the following causes an error as the code initializes the security group collection using a `find` which does not know about the dependent.

~~~ruby
define delete_security_group() do
  @security_group = find("security_groups", { "name": "my_security_group" })
  delete(@security_group)
end
~~~

The security_group is a newly created collection and doesn't have any information about its dependents so deleting it will not delete the server.

### Resource Actions

Resource actions allow a cloud workflow to act on resources: scripts can be run on running servers, instances can be rebooted etc. Actions may accept zero or more argument(s). For example, the `terminate()` action takes no argument, the `run_executable()` action requires an executable name and inputs, etc.

Argument values are written using the JSON syntax already covered in the [Resource Fields](#resource-fields) section above and all arguments are specified by name. For example, the `run_executable()` action requires two arguments: `recipe_name` is the name of the recipe to run, and `inputs` is the list of inputs to be used for the recipe execution. The following two expressions are equivalent invocations of `run_executable()`:

~~~ ruby
# Argument names must be explicitly given
@instances.run_executable(recipe_name: "lb::setup_lb", inputs: { "lb/applistener_name": "text:my_app" })

# But order does not matter
@instances.run_executable(inputs: { "lb/applistener_name": "text:my_app" }, recipe_name: "lb::setup_lb")
~~~

As a convenience, it is also possible to pass multiple arguments as a single hash value where each key corresponds to the argument name and each value to the corresponding argument value. So the request to execute the `run_executable()` action above is also equivalent to:

~~~ ruby
# Arguments can be given as a single hash value
@instances.run_executable({ "recipe_name": "lb::setup_lb", "inputs": { "lb/applistener_name": "text:my_app" } })
~~~

This makes it convenient to call actions passing in variables that were retrieved programmatically.

### Built-in Actions

All resource collections expose the following actions on top of the actions supported by the resource type:

* **get():** Refresh resource fields
* **update():** updates fields of the underlying resources as supported by the resource type
* **destroy():** destroys all resources in the collection

#### get()

The `get()` action re-fetches the resource and updates the fields with the results. This is useful when waiting on a resource to be in a certain state for example and is used internally by the `sleep_until` function.

#### update()

The `update()` action is used to update resource fields. The set of supported fields is specified by the resource type. For example:

~~~ ruby
@deployment.update(deployment: { "name": "A new name" })
~~~

The snippet above updates the name of all deployments in `@deployment` to "A new name".

The exact set of arguments is dependent on the resource type. The convention used by RightScale resources is to use a hash object whose name is the singular resource type name, the keys are the field names and the values are the new values.

**Note:** *Some resource types do not support updating fields and the `update()` action will fail when called on a collection of that type.*

#### destroy()

The `destroy()` action destroys all resources in the collection. This action does not take any argument. Note that contrary to the built-in `delete()` function the `destroy()` action results in a single API call (per resource in the collection) to destroy the resource (i.e. a DELETE API call). There's no built-in logic around waiting for a server to be terminated, etc.

**Note:** *Some resource types do not support deleting resources and hence the `destroy()` action will fail when called on a collection of that type.*

### Resource Type Actions

So far we have seen the various ways that a cloud workflow may interact with resource collections:

* Actions may be called on collections using `action_name(argument: "argument_value", ...)`
* Fields may be retrieved using `:field_name`
* Links may be followed using `link_name(argument: "argument_value", ...)`

Cloud workflows may also interact with resource types to locate resources, create new resources, and execute actions that apply to a resource type rather than specific resources. For example, the RightScale *instances* resource type exposes actions to terminate or run scripts on multiple instances at once. The syntax to designate a resource type is:

`<namespace>.<resource type>`

For example:

~~~ ruby
rs_cm.clouds.get(href: "/api/clouds/1234").instances()
~~~

The expression above designate the `instances` resource type of the *rs namespace*. Resource types support the following built-in actions:

* **get()** is the resource type action used to locate resources. See [Locating Resources](#resources-locating-resources) below.
* **create()** is used to create a single new resource (see [Creating Resources](#resources-creating-resources) below)
* **create_copies()** is used to create many of a given resource (see [Creating Resources](#resources-creating-resources) below)
* **empty()** returns an empty resource collection of the given resource type.

Resource types may expose custom actions on top of these built-in actions. For example, running a recipe on multiple instances can be done using:

~~~ ruby
rs_cm.clouds.get(href: "/api/clouds/1234").instances().multi_run_executable(recipe_name: "lb::setup_load_balancer", filter: ["name==front_end"])
~~~

While using `multi_run_executable()` is functionally equivalent to using something like `@instances.run_executable()`, where `@instances` was initialized with the same set of resources, the two expressions are executed differently by the engine. In the former case, the engine makes a single call to the RightScale API which dispatches the script or recipe on all instances concurrently. In the latter case, the engine iterates through all the instances in the collection and makes one API call for each to dispatch the script or recipe.

The [Mapping RightScale Resources to the APIs](#mapping-resources-to-the-rightscale-apis) section describes how to find the available RightScale resource type actions and arguments using the RightScale API documentation.

### Creating Resources

The `create()` resource type action allows for creating new resources. For example, creating a new RightScale deployment can be done with:

~~~ ruby
rs_cm.deployments.create(deployment: { "name": "New deployment" })
~~~

The arguments used by the `create()` action are resource type specific and depend on the underlying API. The convention used by RightScale resources is to use a single hash argument whose name is the singular resource type name, the keys of the hash are the field names and the values are the field values. Note that contrary to the [`provision()` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision), the `create()` action makes a single API call to create the resource. There is no logic around launching a server and waiting for it to become operational for example.

The `create_copies` action is a built-in action that makes it possible to create multiple resources of the same type in one expression. Like `create`, `create_copies` accepts the fields used to create the resource but it also accepts additional arguments that specify how many copies to create and can alter the fields of each copy. The [`provision` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision) makes use of `create_copies` internally when provisioning [bulk resource declarations](#resources-resource-declarations).

#### Details of create_copies

`create_copies` runs in two modes:

* In the first mode it makes it possible to create `n` copies of a resource by simply passing `n` as the first argument.
* In the second mode it makes it possible to create resources at specific indices by specifying these indices in an array as the first argument.

The second mode of execution is especially useful when dealing with error conditions, see the [Resource Action Errors](#attributes-and-error-handling-resource-action-errors) section for more information on handling errors when using `create_copies`.

`create_copies` makes it possible to specify fields whose values change with the index of the resource in the created set. This can be used to suffix the names of the created resources with a unique index for example. This is done using the function [copy_index()](#built-in-methods-and-other-keywords) when defining the value of the field, for example `$name + copy_index()`. The fields that make use of the [copy_index()](#built-in-methods-and-other-keywords) function must be specified separately from the other - static - fields so the engine knows which fields can be evaluated once and which ones need to be evaluated for each copy.

`create_copies` accepts a count or a set of indices as first argument, the resource creation fields as second argument and optionally the set of names of the fields that make use of `copy_index` as last argument.

For example the following creates ten RightScale deployments with names `deployment #1` to `deployment #10`:

~~~ ruby
rs_cm.deployments.create_copies(10, { "name": "'deployment #' + (copy_index()+1)"}, ["name"])
~~~

While this example creates 2 RightScale deployments with names `deployment #23` and `deployment #42`:

~~~ruby
rs_cm.deployments.create_copies([23, 42], { "name": "'deployment #' + (copy_index()+1)"}, ["name"])
~~~

### Locating Resources

There are a few ways that resources can be located: by type using the `get()` action on the resource type, by resource href using the `get()` action on the namespace, or by following links.

**Note:** *The tags resource type in the rs namespace exposes a `by_tag()` action which can be used to locate RightScale resources using their tags as well.*

#### Locating Resources of a Given Type

The resource type `get()` action uses arguments specific to each resource type to select which resources should be returned. Different resource types may expose different means of selecting which resources to return. However, most resource types in the *rs* namespace support a *filter* argument which can be used to filter resources using one ore more fields (such as the name). Specifying no argument means that no selection is applied and all resources get returned.

The following example demonstrates how to retrieve all the servers living in the RightScale account running a cloud workflow using the `get()` action:

~~~ ruby
rs_cm.servers.get()
~~~

Arguments can be used to further select which resources should be returned. For example:

~~~ ruby
rs_cm.servers.get(filter: ["name==front_end"])
~~~

retrieves a collection consisting of all RightScale servers whose names contain "front_end".

**Note:** *The `get()` action on a resource type results into an index REST request on the resource type URI. Arguments given to the `get()` action are mapped to the request query string.*

#### Locating Resources by href

Locating resources using their href is done via the `get()` namespace action (which is the only action that exists on namespace resources). The first argument this action takes is the href(s) to the resource(s). The name of the argument is 'href' and the value is either a string representing the resource href or an array of strings representing multiple resource hrefs.

**Note:** *When using an array, all hrefs must point to resources of the same type.*

Some resource types may support additional arguments, for example some of the resources in the *rs_cm* namespace support a *view* argument which can be used to specify what fields from the given resource should be retrieved:

~~~ ruby
rs_cm.get(href: "/api/instances/123", view: "full")
~~~

The first expression above returns a resource collection made of a single resource: the instance with href */api/instances/123*, while the second expression returns a resource collection made up of two instances.

**Note:** *The `namespace get()` action results in a get HTTP request on the resource URI for each href.*

#### Following Namespace Links

The namespace resource itself can expose top level links. The rs namespace exposes links that allow retrieving resources associated with the account running the cloud workflow. These links can take arguments like filters:

~~~ ruby
@security_groups = rs_cm.security_groups(filter: ["name==default"])
~~~

The code above initializes the *@security_groups* collection with all the security groups in the account that are named "default".

**Note:** *Namespace links result in get REST requests on the link URI. Arguments given to the link are mapped to the request query string.*

#### Following Resource Links
Links exposed by resources can be followed to locate resources relatively to others. Links may correspond to one-to-one or one-to-many relationships. For example, the ServerTemplates associated with instances named *front_end* can be retrieved using:

~~~ ruby
@template = rs_cm.clouds.get(href: "/api/clouds/1234").instances(filter: ["name==frontend"]).server_template()
~~~

Links can be followed by a call to an action such as:

~~~ ruby
@clone = rs_cm.clouds.get(href: "/api/clouds/1234").instances(filter: ["name==frontend"]).server_template()
  .clone(server_template: { "name": "New name" })
~~~

And if the action returns a resource collection, then links and action can be recursively applied to it:

~~~ ruby
@images = rs_cm.clouds.get(href: "/api/clouds/1234").instances(filter: ["name==frontend"]).server_template()
  .clone(server_template: { "name": "New name" }).multi_cloud_images()
~~~

In the example above, the *clone* action returns a resource collection consisting of all cloned *ServerTemplates*. The RightScale server_templates resource type exposes a *multi_cloud_images* link that returns a resource collection made of the multi-cloud images used by the ServerTemplate. The end result is thus a collection made of all multi-cloud images from all cloned ServerTemplates.

**Note:** *Resource links result in in get REST requests on the link URI. Arguments given to the link are mapped to the request query string.*

### Cloud Resource Management

Operators and functions allow managing resource collections in various ways. Collections can be merged, extracted, or tested for inclusion.

Collections can be concatenated using the "+" operator:

~~~ ruby
@all_servers = @servers1 + @servers2
~~~

Elements of a collection can be removed from another collection using the "-" operator:

~~~ ruby
@servers1 = @all_servers - @servers2
~~~

**Note:** *All instances of all resources in @servers2 are removed from @all_servers.*

Finally, it is possible to test whether all elements of a collection are contained in another using the "<" and ">" operators:

~~~ ruby
@all_servers = @servers1 + @servers2
@all_servers > @servers1 # true
@servers1 &lt; @all_servers # true
~~~

Cloud workflows can identify specific resources from resource collections in various ways. Items can be extracted by index or range using the bracket operator ([ ]). A range consists of two integers separated by two consecutive dots and is inclusive, like the following:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
@first_server = @servers[0]
@more_servers = @servers[1..3]
~~~

The second line evaluates to a collection consisting of a single element: the first server of deployment *123*. The last line evaluates to a collection containing the second, third, and fourth servers in that deployment. The lower and upper bounds of the range are optional. If no lower bound is specified then the range starts at the first resource in the collection. If no upper bound is specified, then the range ends at the last resource of the collection.

**Note:** *All indices are zero-based.*

For example:

~~~ ruby
@all_other_servers = @servers[1..]
~~~

The code above initializes a collection made of all servers in the initial collection except the first.

No error is raised if the specified bounds exceed the number of resources in the collection. Instead, only the resources that are in the specified range are returned:

~~~ ruby
@servers[42..]
~~~

The example above returns the empty collection if the *@servers* collection has fewer than 43 resources.

While *functions* are covered in a different section, it is worth mentioning the `size()` and `select()`  functions at this point:

* The **size()** function returns the number of resources in a collection.
* The **select()** function traverses a given collection and extracts (selects) all the resources whose fields values match the values given in the second argument (in the form of a hash).

The first argument for both these functions is the collection to be traversed while the second argument is a hash of field name and corresponding value. The value may be a regular expression in which case the field must be of type string and its value must match the given regular expression for the resource to be selected. The syntax used to write regular expressions is:

"/pattern/modifiers"

where *pattern* is the regular expression itself, and *modifiers* are a series of characters indicating various options. The *modifiers* part is optional. This syntax is borrowed from Ruby (which borrows it from Perl). The following modifiers are supported:

* **/i** makes the regex match case insensitive.
* **/m** makes the dot match newlines.
* **/x** ignores whitespace between regex tokens.

You can combine multiple modifiers by stringing them together as in */regex/im*.

For example:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
@app_servers = select(@servers, { "name": "/^app_server.*/i" })
~~~

The above snippet initializes *@app_servers* with the collection of servers in the deployment with href *deployments/123* whose name fields start with *app_server* using a non case sensitive comparison.

## Definitions
<!-- DEFINITIONS SECTION BEGINS HERE -->

A definition is a code block between a `define...end` statements and is written in the RightScale Cloud Workflow Language (RCL). Each definition contains the static definition of a cloud workflow and consists of a sequence of statements. Each statement consists of one or more expressions. The first expression is the `define...end` block:

~~~ ruby
define main(@servers, $wait) return @instances, $duration do
  $now = now()
  @instances = @servers.launch()
  if $wait
    sleep_until(all?(@instances.state, "operational"))
  end
  $duration = $now - now()
end
~~~

A cloud workflow may contain any number of definitions.

Definitions are scoped by the file that contain them: two definitions in the same file cannot have the same name.

### Inputs and Outputs

As shown in the snippet above a cloud workflow may specify arguments and return values. There can be zero or more arguments and zero or more return values. Arguments and return values can either be references (*@server* and *@instance*) or variables (*$wait* and *$duration*), the difference being that references contain resource collections while variables may contain a number, a string, a boolean, a time value, the special *null* value, an array or a hash (references are described in Cloud Workflow Resources and variables are described in Cloud Workflow Variables).

A cloud workflow may execute children definitions using the **call** keyword:

~~~ ruby
define run_application() do
  call get_servers_by_tag(["my_site:role=app"]) retrieve @servers 
  call launch_servers(@servers, true) retrieve @launched_instances, $duration
end

define launch_servers(@servers, $wait) return @instances, $duration
$now = now()
  @instances = @servers.launch()
  if $wait
    sleep_until(all?(@instances.state, "operational"))
  end
  $duration = $now - now()
end

define get_servers_by_tag($tags) return @servers do
  $servers = rs_cm.tags.by_tag(resource_type: "servers", tags: $tags)
  # by_tag returns an array of an array of a hash and the hrefs for the resources are in the "links"
  $servers = first(first($servers))["links"]
  # initialize a collection of servers
  @servers = rs_cm.servers.empty()
  foreach $server in $servers do
    @servers = rs_cm.get(href: $server["href"]) + @servers
  end
end
~~~

This *run_application* definition first initializes the *@servers* resources collection using a tag query then passes the collection of retrieved servers to the *launch_servers* definition above. The list of references and variables specified after the **retrieve** keyword matches the list after the **return** keyword of the definition. These references and variables are initialized with the return values of the definition (so in this example the reference *@launched_instances* of the caller is initialized with the value of the *@instances* reference returned by *launch_servers*). The names can match, but don't have to as shown in the example.

**Note:** *Using **retrieve** is optional and can be skipped if the caller does not need the return values.*

### Structure

A cloud workflow is composed of statements. Each statement is in turn made of expressions. Statements are delimited by newlines, semi-colons or both. Comments all start with the **#** symbol. Any character following that symbol on the same line is part of the comment. Blank characters include tabs, spaces and newlines. There can be zero or more blank characters before and after a statement (pending there is a semi-colon if there is no newline). There can also be zero or more blank characters between arguments, operands, and keywords:

~~~ ruby
@instances = @servers.launch() # Comments can appear at the end of a line
sleep_until(all?(@instances.state[], "operational"))

# is equivalent to:
@instances = @servers.launch();
sleep_until(all?(@instances.state[], "operational"));

# and to:
@instances = @servers.launch(); sleep_until(all?(@instances.state[], "operational"))
~~~

Sequences of statements are encapsulated in blocks. The outer block is the `define...end` block however blocks can be defined at any time using the **sub** keyword:

~~~ ruby
sub do
  @servers = rs_cm.servers.get(filter: ["name==my_server"])
  @servers.launch()
end
sub do
  @servers = rs_cm.servers.get(filter: ["name==my_other_server"])
  @servers.launch()
end
~~~

Using blocks as in the snippet above does not change anything to the execution of the Cloud Workflow (and is thus not that useful...). However, blocks can be used to define scopes for error handlers, timeouts, etc. Blocks also allow defining concurrent activities. For more information about blocks, see the Cloud Workflow Processes section.

### Expressions

As mentioned above, a statement consists of a series of expressions. There are four categories of expressions:

* Resource expressions include calls to resource actions and retrieval of resource links and fields, see Cloud Workflow Resources.
* Flow control expressions include block definitions (**define**, **sub**, **concurrent**), conditional expressions (**if**, **else**, **elsif**), and all looping constructs (**while**, **foreach**, **map**, **concurrent foreach**, **concurrent map**), see Branching and Looping.
* Operators (**+**, **-**, *****, **/**, **%**, **[]**, **==**, **=~**, **>=**, **&lt;=**, **&**, **|**, **!**), see Operators.
* Assignments (= and &lt;&lt;), see Operators.

Expressions can be adorned with attributes. Attributes do not constitute an expression by themselves. For more information about attributes, see Attributes and Error Handling.

## Variables
<!-- VARIABLES SECTION STARTS HERE -->

A major benefit of using a workflow solution is the consistency and availability properties provided by the system. A simple litmus test for identifying the need for a workflow based solution is answering the question, "Where does the state live?"  If it's ok for the state to live on a single system, then running a regular script or program there is probably a simpler solution. Another way to ask the question is this: "Is there a system whose failure makes the operation irrelevant?"  If such a system exists, then it should be the one driving the operation and keeping the state. For example, if the operation consists of cleaning the temporary files of an instance, then that instance failing makes the operation irrelevant. Therefore, it is OK for it to be responsible for scheduling the operation.

For distributed operations, there is often no simple answer to where state can be kept or where a conventional program can be run. The operation must continue regardless of individual system failures. For example, if the operation consists of analyzing the metrics data on all the instances in a deployment and taking action if certain values reach a given threshold, then no single instance is a good place to run the operation. And a separate "management server" isn't good either as it can fail as well. In this case, using a workflow based solution makes sense as the workflow engine is in charge of keeping the state and making sure that the operation is either carried out or gives proper feedback in case of failure. This is obviously not the only reason to use a workflow solution, but state bookkeeping is one of the main perks that come out of it. (Managing concurrent execution of activities is another big one described in the Cloud Workflow Processes section.)

The state of a process is kept in variables and references. References were already covered in Cloud Workflow Resources. They contain collections of resources. A Cloud workflow variables may contain a number, a string, a boolean, a time value, the special null value, an array or a hash. Variables are initialized directly via literal values in code, from resource fields or from the results of a computation. A variable name must start with $ and may contain letters, numbers, and underscores. As with references the naming convention consists of using lower_case. For example:

* Initializing a variable from a literal value

~~~ ruby
$variable = 1
~~~

* Initializing a variable from a resource field:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
$names = @servers.name[]
~~~

The above code initializes the $names variable to an array containing the names of all servers in deployment with href /deployments/123.

Accessing a variable that has not been initialized is not an error, it just returns the value null.

### Writing Explicit Values

The syntax used to write explicit values uses the Javascript notation:

~~~ ruby
$object = { "rails/app_name": "Mephisto", "db_mysql/password": "cred:DB_PASSWORD", "app_server/ports": [80, 443] }
~~~

The above will initialize the $object variable with the given object (hash).

The value stored at a given key of an object can be read using the bracket operator [ ], such as:

~~~ ruby
$object["rails/app_name"] # Will resolve to "Mephisto"
~~~

The value stored at a given index of an array field value can also be read using the bracket operator [ ]. For example:

~~~ ruby
$object["app_server/ports"][0] # Will resolve to 80
~~~

**Note:** *Array indices are 0-based*

### Datetime Data Type

RCL extends the Javascript syntax to add support for the Datetime data type. This type is stored internally as the number of seconds since the epoch and thus supports up to the second granularity. The syntax for writing Datetime values in RCL is:

pre d"year/month/day [hours:minutes:seconds] [AM|PM]"

**Note:** *Date time values do not include a timezone. If needed the timezone information must be stored separately.*

Examples are:

~~~ ruby
d"2012/07/01"
d"2012/07/12 04:21:14 PM"
~~~

If no time is specified then midnight is used (00:00:00). If no AM/PM value is specified then AM is assumed unless the hour value is greater than 12.

### Operations on Variables

The language supports a range of operators for dealing with variables including arithmetic operators to manipulate numbers, operators to concatenate strings, arrays, and objects as well as logical operators. Some examples are listed below:

#### Arithmetic:

~~~ ruby
$one = 1 # 1
$two = 2 # 2
$three = $one + $two # 3
$four = $two ^ 2 # 4
~~~

#### Concatenation / Merging:

~~~ ruby
$string_concat = "foo" + "bar" # "foobar"
$array_concat = [$one, "2"] + [3, 4] # [1, "2", 3, 4]
$object_merge = { "one": 1, "two": 2 } + { "one": 0, "three": 3 } # { "one": 1, "two": 2, "three": 3 }
~~~

#### Boolean Operators:

~~~ ruby
$false = true && false # false
$true = true || false # true
$false = !true # false
$true = 1 == $one # true
$true = $two < 3 # true
~~~

#### Misc:

~~~ ruby
$array_append = [$one, "2"] << 3 # [1, "2", 3]
$regex_compare = "hello" =~ "^h" # true
~~~

Naturally variables can be used wherever values can. The complete list of available operators can be found in the Operators section.

### References and Variables Scope

RCL supports two types of variables and references: local variables and references are only accessible from a limited scope (defined below) while global variables and references are accessible throughout the execution of the process that defines them.

#### Local Variables, Local References and Blocks

A block in RCL is code contained inside a define, a sub, a if or a loop expression (while, foreach or map).

Both local references and variables are scoped to their containing block and all children blocks. This means that a variable initialized in a parent block can be read and modified by child blocks. Consider the following:

~~~ ruby
$variable = 42
sub do
  assert $variable == 42 # $variable is "inherited" from parent block
  $variable = 1
end
assert $variable == 1 # $variable is updated in child block
~~~

The scope of $variable in the example above covers the child block, modifying that variable there affects the value in the parent block (or more exactly both the child and parent blocks have access to the same variable).

Note that the scope is limited to the block where a variable or a reference is first defined and child blocks. In particular the value cannot be read from a parent block:

~~~ ruby
sub do
  @servers = rs_cm.servers.get(filter: ["name==my_other_server"])
    assert @servers.name == "my_other_server" # true, @servers was "overridden"
  sub do
    assert @servers.name == "my_other_server" # true, @servers contains value defined in parent block
  end
end
assert @servers.name == "my_other_server" # RAISES AN ERROR, @servers is not defined in the parent block
~~~

#### Definitions

The only local variables and references that are defined when a definition starts are the ones passed as arguments. Consider the following:

~~~ ruby
define main() do
  @servers = rs_cm.servers.get(filter: ["name==my_server"])
  @other_servers =rs_cm.servers.get(filter: ["name==my_other_server"])
  call launch_servers(@servers)
end

define launch_servers(@servers) do
  assert @servers.name == "my_server" # @servers contains value passed in arguments
  assert @other_servers.name == "my_other_server" # RAISES AN ERROR, @other_servers is not passed in arguments
end
~~~

In the example above the launch_servers definition does not have access to the @other_servers local reference because it is not listed as an argument.

### Global References and Variables

Sometimes it is useful to retrieve a value defined in an inner block or in one of the sub definitions called via call. Global references and global variables can be used for that purpose as their scope is the entire process rather than the current block. Global references are prefixed with @@, while global variables are prefixed with $$:

~~~ ruby
sub do
  $$one = 1
end
assert $$one == 1 # global variable remains set for the entire execution of the process
~~~

Global references and variables exist for the lifetime of the process, independently of where they are set:

~~~ ruby
define init_servers() do
  @@servers = rs_cm.get(href: "/api/servers/234")
end
call init_servers()
assert @@servers.name == "my_server" # @@servers set for the entire execution of the process
~~~

**Note:** *The best practice consists of using return values to retrieve values from a different definition via the return and retrieve attributes as shown in the Cloud Workflows section.*

Obviously special care needs to be taken when using global references or variables in a process that involves concurrency. For more details, see Cloud Workflow Processes.

### Use of Variables in Place of Namespace, Type or Resource Action or Link

It is possible to use a Variable in place of a Namespace, etc. An example would be a definition that creates a resource of unspecified type, which is passed as an argument to that definition:

~~~ ruby
define my_create_method($namespace, $type) return @any do
  @any = $namespace.$type.create(some_common_arguments: { color: "Saffron" })
end
~~~

A Variable can also be used in place of an action or link for either a Namespace, Type or Resource:

~~~ ruby
...
$action = "do_stuff"
$arg = "stuff"
my_ns.$action($arg)          # equivalent to my_ns.do_stuff($arg)
my_ns.my_type.$action($arg)  # equivalent to my_ns.my_type.do_stuff($arg)
@my_resource.$action($arg)   # equivalent to @my_resource.do_stuff($arg)
...
~~~

You can also combine multiple uses of Variables in place of Namespace, etc. into a single command:

~~~ ruby
...
$namespace = "rs_cm"
$type = "servers"
$action = "get"
@result = $namespace.$type.$action(href: $my_href)
...
~~~

Note that a Variable cannot currently be used in place of a field name.

## Attributes and Error Handling
<!-- ATTRIBUTES AND ERROR HANDLING SECTION -->
Some statements can be adorned with attributes that affects their behavior. Attributes appear after the statement on the same line right before the **do** keyword for expressions that have one (e.g. `define`, `sub`, `concurrent`, `map`, `foreach`). There can be multiple attributes specified on a single statement in which case they are separated with commas. Attributes allow specifying and handling timeouts and handling errors and cancelations.

An attribute has a name and a value. The syntax is: `name: value`

The acceptable types for attribute values depend on the attribute: they may be numbers (e.g. `wait_task: 1`), strings (e.g. `on_timeout: skip`), arrays (e.g. `wait_task: [ "this_task", "that_task" ]`), or definition names with arguments (e.g. `on_timeout: handle_timeout()`).

Some of the attributes define behavior that apply to tasks, while others define behavior for the whole process. Processes and tasks are described in detail in the Cloud Workflow Processes section. For the purpose of understanding the attributes behavior described below, it is enough to know that a single process consists of one or more tasks. A task is a single thread of execution.

Some attributes attach behavior to the expression they adorn and all their sub-expressions. The sub-expressions of an expression are expressions that belong to the block defined by the parent expression. Not all expressions define blocks so not all expressions have sub-expressions. Expressions that may have sub-expressions include `define`, `sub`, `concurrent` and the looping expressions (`foreach`, `concurrent foreach`, etc.).

The exhaustive list of all attributes supported by the language are listed below in alphabetical order:

Attribute | Applies to | Possible Values | Description
----------|------------|-----------------|-------------
on_error | define, sub, call, concurrent | name of the definition with arguments, **skip** or **retry** | Behavior to trigger when an error occurs in an expression or a sub-expression. For `concurrent` blocks, the handler is applied to all sub-expressions.
on_rollback | define, sub, call, concurrent, concurrent map, concurrent foreach | name of the definition with arguments | Name of the definition called when an expression causes a rollback (due to an error or the task being canceled).
on_timeout | sub, concurrent, call | name of the definition with arguments, **skip** or **retry** | Behavior to trigger when a timeout occurs in an expression or a sub-expression.
task_name | sub | string representing the name of a task | Change current task name to given value.
task_prefix | concurrent foreach, concurrent map | string representing the prefix of task names | Specifies the prefix of names of tasks created by concurrent loop (suffix is iteration index).
timeout | sub, call | string representing a duration | Value defines the maximum time allowed for expressions in a statement and any sub-expression to execute.
wait_task | concurrent, concurrent foreach, concurrent map | number of tasks to be waited on or name(s) of task(s) to be waited on | Pause the execution of a task until the condition defined by a value is met
task_label | sub, call, define | string representing label | Labels allow processes to return progress information to clients. They are associated with an arbitrary name that gets returned by the cloud workflow APIs.

The `task_name`, `task_prefix`, and `wait_task` attributes are described in Cloud Workflow Processes. This section describes in detail the other attributes dealing with errors and timeouts.

### Errors and Error Handling

Defining the steps involved in handling error cases is an integral part of all cloud workflows. This is another area where workflows and traditional programs differ: a workflow needs to describe the steps taken when errors occur the same way it describes the steps taken in the normal flow. Error handlers are thus first class citizen in RCL and are implemented as definitions themselves. Handling an error could mean alerting someone, cleaning up resources, triggering another workflow, etc. RCL makes it possible to do any of these things through the `on_error` attribute. Only the `define`, `sub`, and `concurrent` expressions may be adorned with that attribute.

The associated value is a string that can be any of the following:

* **skip:** aborts the execution of the statement and any sub-expression then proceeds to the next statement. No cancel handler is called in this case.
* **retry:** retries the execution of the statement and any sub-expression.

To illustrate the behavior associated with the different values consider the following snippet:

~~~ ruby
sub on_error: skip do
  raise "uh oh"
end
log_info("I'm here")
~~~

The engine generates an exception when the `raise` expression executes. This exception causes the parent expression `on_error` attribute to execute. The associated value is **skip** which means *ignore the error and proceed to run the first expression after the block*. The engine then proceeds to the next expression after the block (the `log_info` expression). If the attribute value associated with the `on_error` handler had been **retry** instead, then the engine would have proceeded to re-run the block (which in this case would result in an infinite loop).

As mentioned in the introduction, a cloud workflow may need to define additional steps that need to be executed in case of errors. The `on_error` attribute allows specifying a definition that gets run when an error occurs. The syntax allows for passing arguments to the definition so that the error handler can be provided with contextual information upon invocation. On top of arguments being passed explicitly, the error handler also has access to all the variables and references that were defined in the scope of the expression that raised the error.

The error handler can stipulate how the caller should behave once it completes by assigning one of the string values listed above (**skip** or **retry**) to the special `$_error_behavior` local variable. If the error definition does not define `$_error_behavior`, then the caller uses the default behavior (**raise**) after the error definition completes. This default behavior causes the error to be re-raised so that any error handler defined on a parent scope may handle it. If no error handler is defined or all error handlers end-up re-raising then the task terminates and its final status is failed. The **skip** behavior will not raise the error and will force the calling block to skip any remaining expressions after the error occurs. The **retry** behavior will retry the entire caller block again.

The following example shows how to implement a limited number of retries using an error handler:

~~~ ruby
define handle_retries($attempts) do
  if $attempts <= 3
    $_error_behavior = "retry"
  else
    $_error_behavior = "skip"
  end
end
$attempts = 0
sub on_error: handle_retries($attempts) do
  $attempts = $attempts + 1
  ... # Statements that will get retried 3 times in case of errors
end
~~~

Errors can originate from evaluating expressions (e.g. division by 0) or from executing resource actions (e.g. trying to launch an already running server). A variation on the former are errors generated intentionally using the **raise** keyword. In all these cases the most inner error handler defined using the `on_error` attribute gets executed.

The **raise** keyword optionally followed with a message causes an error which can be caught by an error handler. All error handlers have access to a special variable that contains information about the error being raised. `$_error` is a hash that contains three keys:

* **"type"**: A string that describe the error type. All errors raised using the **raise** keyword have the type set to user.
* **"message"**: A string that contains information specific to this occurrence of the error. The string contains any message given to the **raise** keyword for user errors.
* **"origin"**: A [ _line_, _column_ ] array pointing at where the error occurred in the RCL source.

~~~ ruby
define handle_error() do
  log_error($_error["type"] + ": " + $_error["message"]) # Will log "user: ouch"
  $_error_behavior = "skip"
end
sub on_error: handle_error() do
  raise "ouch"
end
~~~

### Resource Action Errors

Resource actions always operate atomically on resource collections, in other words the expression `@servers.launch()` is semantically equivalent to making concurrent launch API calls to all resources in the `@servers` array. This means that multiple errors may happen concurrently if multiple resources in the collection fail to run the action. When that happens an error handler needs to have access to the set of resources that failed as well as the set that succeeded and the initial collection to take the appropriate actions. We have already seen the special `$_error` variable made available to error handlers in case of an error resulting from calling an action on a resource collection. RCL also makes available the following variables to the error handler:

* _**@_original**_: The resource collection that initially executed the action that failed.
* _**@_done**_: A resource collection containing all the resources that successfully executed the action.
* _**@_partial**_: A resource collection containing the partial results of the action if the action returns a collection of resources.
* _**$_partial**_: An array containing the partial results of the action if the action returns an array of values.
* _**$_errors**_: An array of hashes containing specific error information.

The `$_errors` variable contains an array of hashes. Each element includes the following values:

* **"resource_href"**: Href of the underlying resource on which the action failed, e.g. "/account/71/instances/123"
* **"action"**: Name of the action that failed, e.g. "run_executable"
* **"action_arguments"**: Hash of action arguments as specified in the definition, e.g. { "recipe_name": "sys:timezone" }
* **"request"**: Hash containing information related to the request including the following values...
  * **"url"**: Full request URL, e.g. "https://my.rightscale.com/instances/...run_executable"
  * **"verb"**: HTTP verb used to make the request, e.g. "POST"
  * **"headers"**: Hash of HTTP request headers and associated value
  * **"body"**: Request body (string)
* **"response"**: Hash containing information related to the response including the following values...
  * **"code"**: HTTP response code (string)
  * **"headers"**: Hash of HTTP response headers
  * **"body"**: Response body (string)

In case of resource action errors the `$_error` variable is initialized with the type **"resource_action"** and includes the detailed error message with the problem, summary, and resolution fields as a string.

Given the above, the following definition implements a retry:

~~~ ruby
define handle_terminate_error() do
  foreach $error in $_errors do
    @instance = rs_cm.get($error["resource_href"]) # Retrieve the instance that failed to terminate
    if @instance.state != "stopped"          # Make sure it is still running
      log_error("Instance " + @instance.name + " failed to terminate, retrying...")
      sub on_error: skip do
        @instance.terminate() # If so try again to terminate but this time ignore any error
      end
    end
  end
  $_error_behavior = "skip" # Proceed with the next statement in caller
end
sub on_error: handle_terminate_error() do
  @instances.terminate()
end
~~~

In the definition above the error handler sets the special `$_error_behavior` local variable to "**skip**" which means that the process will not raise the error and will instead skip the rest of the block where the error occurred. Note how the handler itself uses `on_error` to catch errors and ignore them (using skip).

Actions may return nothing, collection of resources, or array of values. In the case an action has a return value (collection or array), the error handler needs to be able to modify that value before it is returned to the calling block. For example, an error handler may retry certain actions and as a result may need to add to the returned value which would initially only contain values for the resources that ran the action successfully. An error handler can achieve this by reading the `@_partial` collection or the `$_partial` array, handling the error cases, and returning the complete results as a return value of the error handler definition.

To take a concrete example let's consider the RightScale servers resource `launch()` action. This action returns a collection of launched instances. The following handler retries any failure to launch and joins the `@_partial` collection with instances that successfully launched on retry:

~~~ ruby
define retry_launch() return @instances do
  @instances = @_partial
  foreach $error in $_errors do
    @server = rs_cm.get($error["resource_href"]) # Retrieve the server that failed to launch
    if @server.state == "stopped" # Make sure it is still stopped
      log_error("Server " + @server.name + " failed to launch, retrying...")
      sub on_error: skip do
        @instance = @server.launch() # If so try again to terminate but this time ignore any error
      end
      @instances = @instances + @instance # @instance may be empty in case the launch failed again
    end
  end
  $_error_behavior = "skip" # Don't raise the error -- skip the rest of the caller block
end
sub on_error: retry_launch() retrieve @instances do
  @instances = @servers.launch()
end
~~~

The definition above adds any instance that is successfully launched in the retry to the `@instances` collection as result of any errors in the `launch()` action.

#### Handling Errors Returned By `create_copies`

[create_copies](#resources-creating-resources) makes it possible to create
multiple resources with one expression. Like any other action `create_copies`
executes atomically. That is it attempts to create all resources concurrently
and thus may have to report multiple errors.

When a call to `create_copies` results in errors the value of the `"type"` field
of `$_error` is set to `create_copies_action`. In this case each element in the
`$_errors` variable also contains a `"copy_index"` field which corresponds to
the index of the copy whose creation resulted in the error.

`create_copies` conveniently accepts a set of indices which represents the
indices to use when evaluating `copy_index` in the field values. This makes it
simple to retry only the create calls that failed. Here is an example of an
implementation of a retry algorithm for `create_copies`:

~~~ ruby
# bulk_create creates n deployments.
# $fields contain the static fields while $copy_fields contains the fields that
# make use of copy_index()
define bulk_create($n, $fields, $copy_fields) return @deployments do
  $attempts = 0
  $create_indices = $n
  @created = rs_cm.deployments.empty()
  sub on_error: compute_indices($attempts, @created) retrieve @created, $create_indices do
    $attempts = $attempts + 1
    @deployments = rs_cm.deployments.create_copies($create_indices, $fields, $copy_fields)
  end
end

# compute_indices looks at $_errors and returns the indices that must be retried.
define compute_indices($attempts, @created) return @created, $failed_indices do
  @created = @created + @_partial
  if $_error["type"] == "create_copies_action" && $attempts <= 3
    $failed_indices = []
    foreach $error in $_errors do
      $failed_indices << $error['copy_index']
    end
    $_error_behavior = "retry"
  else
    $_error_behavior = "error"
    delete(@created)
  end
end
~~~

### Handlers and State

We've seen before that definitions executed via `call` only have access to the references and variables passed as argument (and global references and variables). Definitions executed through handlers, on the other hand, inherit from all the *local* variables and references defined at the time the handler is invoked (so at the time an exception is thrown, a timeout occurs or a cancelation is triggered).

~~~ ruby
define handle_errors() do
 log_error("Process failed while handling " + inspect(@servers)) # Note: handler has access to @servers
 $_error_behavior = "skip"
end
@servers = rs_cm.get(href: "/api/servers/123")
sub on_error: handle_errors() do
  @servers.launch()
end
~~~

In the snippet above, the error handler has access to `@servers` even though that collection is defined in the main scope (the various `log_xxx()` functions allow for appending messages to process logs and the `inspect()` function produces a human friendly string representation of the object it is given).

### Timeouts

The `timeout` and `on_timeout` attributes allow setting time limits on the execution of expressions and specifying the behavior when a time limit is reached respectively:

~~~ ruby
sub timeout: 30m, on_timeout: handle_launch_timeout() do  
  @server = rs_cm.get(href: "/api/server/1234")
  @instance = @server.launch()
  sleep_until(@instance.state == "operational")
  @server = rs_cm.get(href: "/api/servers/1235")
  @instance = @server.launch()
  sleep_until(@instance.state == "operational")
end
~~~

The block in the snippet above must execute in less than 30 minutes otherwise its execution is canceled and the `handle_launch_timeout` definition is executed. Timeout values can be suffixed with **d**, **h**, **m**, or **s** (respectively day, hour, minute or second).

Note that there does not need to be a `on_timeout` associated with all timeout attributes. Instead the most inner expression that includes the `on_timeout` attribute gets triggered when a timeout occurs:

~~~ ruby
sub on_timeout: outer_handler() do
  ...
  sub timeout: 10m, on_timeout: inner_handler() do
    ...
    @instance = @server.launch()
    sleep_until(@instance.state == "operational")
    ...
  end
  ...
end
~~~

In the snippet above, `inner_handler` gets executed if the `sleep_until` function takes more than 10 minutes to return.

Similar to the `on_error` attribute, the `on_timeout` attribute can be followed by a definition name or one of the behaviors values (**skip** or **retry**).

**Note:** *Using the raise behavior in an `on_timeout` attribute will cause the next `on_timeout` handler to be executed. Timeouts never cause error handlers to be executed and vice-versa.*

On top of specifying the behavior directly in the `on_timeout` attribute as in:

~~~ ruby
sub timeout: 10m, on_timeout: skip do
  @instance = @server.launch()
end
~~~

It's also possible for a definition handling the timeout to specify what the behavior should be by setting the `$_timeout_behavior` local variable:

~~~ ruby
define handle_timeout() do
  $_timeout_behavior = "retry"
end
~~~

Finally, the timeout handler may accept arguments that can be specified with the `on_timeout` attribute. The values of the references and variables at the point when the timeout occurs are given to the handler:

~~~ ruby
define handle_timeout($retries) do
  if $retries <  3
    $_timeout_behavior = "retry"
  else
    $_timeout_behavior = "skip"
  end
end
$retries = 0
sub timeout: 10m, on_timeout: handle_timeout($retries) do
  $retries = $retries + 1
  sleep(10 * 60 + 1) # Force the timeout handler to trigger
end
~~~

The snippet above will cause the `handle_timeout` definition to execute three times. The third times `$retries` is equal to 3, the timeout handler definition sets `$_timeout_handler` to skip and the block is canceled.

### Labels
The `task_label` attribute is used to report progress information to clients. It does not affect the execution of the process and is simply a way to report what it is currently doing. The label attribute can be used on `sub` and `call`:

~~~ ruby
define main() do
  sub task_label: "Initialization" do
    ...
  end
  sub task_label: "Launching servers" do
    ...
  end
  call setup_app() task_label: "Setting up application"
end
~~~

### Logging

!!warning*Warning:* The following functions are not yet working. They are here for future planning only.

As shown in the snippet above RCL has built-in support for logging which helps troubleshoot and develop cloud workflows. Each process is associated with a unique log that is automatically created on launch. Logging is done using the following functions:
* `log_title()`: To append a section title to the log
* `log_info()`: To append informational message to the log
* `log_error()`: To append an error message to the log

Logs for a process can be retrieved using the RightScale API or through the RightScale dashboard by looking at the process audit entries.

### Summary

We have seen how a cloud workflow may use attributes to annotate statements and defining additional behaviors. Attributes apply to the statement they adorned and some also apply to its sub-expressions. Definitions can be written to handle errors, timeouts and cancelation. Definitions handling errors that occur during resource action execution have access to all the underlying low level errors and can modify the return value of the action.

## Branching and Looping

### Branching

Branching is done using the customary `if` keyword. This keyword marks the beginning of a block (like `sub`). It must be followed by an expression that must resolve to a value. If the value is `false` or `null`, then the expressions in the block are skipped; otherwise they are executed sequentially.

~~~ ruby
@server = rs_cm.get(href: "/api/servers/123")
if @server.state == "operational"
  @server.terminate()
end
~~~

RCL also supports the `else` keyword with the usual meaning:

~~~ ruby
@server = rs_cm.get(href: "/api/servers/123")
if @server.state == "operational"
  @server.terminate()
else
  if @server.state == "terminated"
    @server.launch()
  end
end
~~~

Finally, RCL also supports the `elsif` keyword which can be used to write the example above more succinctly:

~~~ ruby
@server = rs_cm.get(href: "/api/servers/123")
if @server.state == "operational"
  @server.terminate()
elsif @server.state == "terminated"
  @server.launch()
end
~~~

This notation is especially useful to chain multiple tests without having to keep indenting the code.

### Looping
There are three different kinds of loops: the traditional `while` loop allows repeating a block until a given condition is met. The `foreach` loop allows iterating over a resource collection, a range, or an array of values. Finally the `map` loop is also an iterator but it returns one or more collection(s) built from the elements of the initial collection.

#### While Loops

The `while` keyword marks the beginning of a block. It must be followed by an expression that resolves to a value. The sub-expressions are executed until the value resolves to false or null:

~~~ ruby
# Assumes $app_servers_count, $app_server_definition and $server_name have previously been defined
$count = 0
while $count < $app_servers_count do
  @server = rs_cm.server.create({ "name": $server_name + "_" + $count } + $app_server_definition)
  @server.launch()
  $count = $count + 1
end
~~~

This example will loop `$app_servers_count` times and in each iteration will create a server using a given set of arguments and launch it. The `+` operator applied to hashes returns a hash built from merging the left hand side of the operator into the right hand side. The same operator following a string concatenates the string with the right hand side value (a string or an integer). So the loop body in the example above will override the name used to create the server using a common prefix and the index as suffix.

#### Foreach Loops

Foreach loops allow iterating over either a resource collection, a range, or an array of values. The syntax is:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
$recipes = ["cassandra::default", "cassandra::configure", "cassandra::restart"]
foreach $recipe in $recipes do
  @servers.run_executable(recipe_name: $recipe)
end
~~~

~~~ ruby
@deployment = rs_cm.get(href: "/api/deployments/123")
foreach $name in ["clone-1".."clone-3"] do
  @deployment.clone(deployment: { name: $name })
end
~~~

As mentioned above, `foreach` also allows iterating through collections as in:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
foreach @server in @servers do
  call audit_server(@server.name)
end
~~~

**Note:** *A cloud workflow always acts on resource collections, the elements returned by `foreach` are thus collections themselves (albeit made of a single resource).*

#### Map Loops

The `map` iterator constructs a new collection by iterating over an existing collection and applying a transformation to each element. The full form of the `map` iterator is fairly flexible and can iterate over a collection, a range, or an array of values, and it can construct one or multiple collections or arrays of values. The example below shows it iterating over the `@servers` collection and producing a `$states` array of values and `@instances` collection.

The `map` iterator follows the same syntax as the `foreach` operator, but adds a `return` keyword used to specify which variable(s) or reference(s) from the inner block should be used to build the resulting arrays(s)/collection(s).

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()
$states, @instances = map @server in @servers return $state, @instance do
  $state = @server.state
  if $state == "stopped"
    @instance = @server.launch()
  else
    @instance = @server.current_instance()
  end
end
~~~

The above code creates two collections: the resource collection `@instances` and an the array `$states`. The `@instances` resource collection gets built by appending the content of `@instance` at the end of each iteration. Similarly, `$states` gets built by appending the value of `$state` at the end of each iteration. If a reference or a variable specified after `return` does not get defined in the execution of an iteration, then nothing is appended to the corresponding resulting collection.

## Processes

### Process Overview

Control over the timing of execution of activities is another area that differentiates workflows from traditional programs. A cloud workflow allows for describing explicitly how multiple activities are orchestrated: whether they run sequentially or concurrently and when to synchronize.

The building blocks for describing the sequencing are the `sub` and `concurrent` expressions. All sub-expressions of a `sub` expression execute sequentially while all sub-expressions of a `concurrent` expression execute concurrently. `sub` expressions can be nested inside `concurrent` expressions and vice versa providing the mean for describing what runs concurrently and when to synchronize.

~~~ ruby
concurrent do # the following two blocks execute concurrently
  sub do # Expressions below (until 'end') execute sequentially
    @servers = rs_cm.servers.get(filter: ["name==my_server"])
    @instances = @servers.launch()
    sleep_until(all?(@instances.state, "operational"))
  end
  sub do
    @servers = rs_cm.servers.get(filter: ["name==my_other_server"])
    @instances = @servers.launch()
    sleep_until(all?(@instances.state, "operational"))
  end
end # Marks the synchronization point for the concurrence
# At this point all servers are operational: both concurrent sequences are finished.
~~~

### Process Tasks

All activities taking place in a process occur in tasks. Each iteration of a `concurrent foreach` expression runs in its own task. Processes start with one task: the `main` task. The `task_name` attribute can be used to adorn sub-expressions of the `concurrent` expression to name tasks. This attribute can be specified on any expression (changing the name of the current task each time). However, the convention is to adorn the outer `sub` expression if there is one. That name can then be used to `wait` for that task:

~~~ ruby
# Update code on app servers
define update_code(@app_servers, $branch) do
  # Obtain the current branch (through a tag in one of the app server)
  call get_current_branch(first(@app_servers)) retrieve $previous_branch

  # Concurrently pull code on all app servers
  concurrent foreach @server in @app_servers task_prefix: "codepull", timeout: 10m do
    call run_recipe(@server, "app::pull_code", { branch: $branch })
  end

  # Perform a rolling update on all app servers (detech from loadbalancer, restart service, attach to load balancer)
  foreach @server in @app_servers task_prefix: "restart", on_rollback: rollback_code_update(), on_error: handle_update_error() do
    call run_recipe(@server, "lb::detach", {})
    call run_recipe(@server, "app::restart", {})
    call run_recipe(@server, "lb::attach", {})
  end
end

define rollback_code_update() do
  call run_recipe(@server, "app:pull_code", { branch: $previous_branch })
  call run_recipe(@server, "app::restart", {})
  call run_recipe(@server, "lb::attach", {})
end

define handle_update_error() do
  cancel_task
end

...
~~~

The snippet above pulls code on all application services concurrently. Once the code pull is completed, the service is restarted on each application service sequentially. Any error during this process will cancel the task using `cancel_task` keyword which rolls the code back to the previous known working version.

#### Task Names

Tasks can be referred to using two different names: the local name (used in the example above) is the name used with the `task_name` attribute. This name can only be used to refer to a task that is a sibling, that is a task that was launched by the same task that also launched the task using the name. The other way to address a task is to use its global name: this name is defined using the parent tasks names recursively (excluding the main task) combined with the current task name using / as separator:

~~~ ruby
concurrent do
  sub task_name: "grand_parent" do
    concurrent do
      sub task_name: "parent" do
        concurrent do
          sub task_name: "child" do
            # do something
          end
          concurrent do
            sub do
              wait_task grand_parent/parent/child # cannot use local name for 'child' task because
                                                  # not in a sibling task
              # do something
            end
            sub do
              # do something
            end
          end
        end
      end
    end
  end
end
~~~

Tasks that are not explicitly named using the `task_name` attribute get assigned a unique name by the engine. The `task_name()` function (functions are covered in the next section) returns the global name of the current task.

Task names must be strings or variables containing strings:

~~~ ruby
$name = "foo"
concurrent do
  sub task_name: $name do
    # do something
  end
  sub do
    wait_task $name
    # do something
  end
end
~~~

#### Controlling Tasks
As mentioned earlier tasks can be canceled or aborted. The respective keywords are `cancel_task` and `abort_task` and they will apply to the task executing this action.

A process can also be canceled or aborted in its entirety using respectively the `cancel` or `abort` keyword. Executing any of these has the same effect as executing the corresponding task version in all currently running tasks. In particular, this means that canceling or aborting a process will take effect once all tasks have finished running their current expression. The exact behavior of canceling and aborting are described below in the Ending Cloud Workflow processes section.

~~~ ruby
# If an error occurs during launch then cancel all launching tasks and terminate all servers.
define cancel_launch(@servers) do
  # Wait for the other task to finish before terminating the servers and canceling the process.
  if task_name() == "/root/launch_app_server"
    wait_task launch_app_fe
  else
    wait_task launch_app_server
  end
  @servers.terminate()
  cancel
end

...
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers() # Retrieve all servers of "default" deployment
concurrent return @app_servers do
  sub task_name: "launch_app_server", on_error: cancel_launch(@servers) do
    @app_servers = select(@servers, { "name": "app_server" }) # Select servers named "app_server"
    @app_servers.launch()                                     # and launch them
  end
  sub task_name: "launch_app_fe", on_error: cancel_launch(@servers) do
    @fe_servers = select(@servers, { "name": "front_end" })  # Select servers named "front_end"
    @fe_servers.launch()                                     # and launch them
  end
end
sleep_until(all?(@app_servers.state[], "operational"))       # Wait until all app servers are operational
~~~

#### Checking for Tasks

As covered earlier a task can be waited on using the `wait_task` keyword. The current task blocks until the given task finishes (i.e. completes, fails, is canceled, or is aborted). If the given task is not even started, the current task will wait until it is started before waiting for it to finish. This keyword will have no effect if the task has already completed, but will raise an error if there is no task with the given name.

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
concurrent do
  sub task_name: "launch_app_server" do
    @servers = select(@servers, { name: "app_server" })
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
    # Wait for load balancers to become available
    wait_task launch_app_fe
    call run_recipe(@servers, "lb::attach", {})
  end
  sub task_name: "launch_app_fe" do
    @servers = select(@servers, { name: "front_end" })
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
end
~~~

`wait_task` can also be used with a number indicating the number of tasks that should be waited on. The task running the `wait_task` expression blocks until the given number of tasks complete. Note that this form is mostly useful when used as an attribute on a concurrent expression to indicate how many concurrent tasks should complete before the next expression runs.

Finally, `wait_task` also accepts an array of task names corresponding to the tasks that should complete prior to the execution resuming. This form can also be used as an attribute:

~~~ ruby
@servers = rs_cm.deployments.get(filter: "name==default").servers()
concurrent wait_task: [launch_app_server, launch_app_fe] do
  sub task_name: "launch_app_server" do
    @servers = select(@servers, { "name": "app_server" })
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
  sub task_name: "launch_app_fe" do
    @servers = select(@servers, { "name": "front_end" })
    @servers.launch()
  end
  sub do
    @servers = select(@servers, { "name": "diagnostics_servers" })
    @servers.launch()
  end
end
# At this point the diagnostics servers may not have been launched yet (the last sub block may not have completed)
~~~

### Synchronization Primitives

The most basic synchronization primitive is a bare `concurrent` expression. Each sub-expression of `concurrent` expression runs in its own task. This expression will block until all sub-expressions have completed. Sometimes more control is needed. For example, it may suffice for one of the `concurrent` expressions to finish before proceeding. The `concurrent` expression `wait_task` attribute can be used in two different ways to provide the additional control:

* When `wait_task` is followed by an integer, the `concurrent` expression will return after the corresponding number of tasks have completed.
* When `wait_task` is followed by a list of task names, the `concurrent` expression will return after the corresponding tasks have completed.

In the following example:

~~~ ruby
concurrent wait_task: 1 do
  sub do
    @servers = find("servers", "app_server_1")
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
  sub do
    @servers = find("servers", "app_server_2")
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
end

# At this point at least one of the sequences above has completed
@servers = @servers = find("servers", "front_end")
@servers.launch()
~~~

The front-ends will be launched as soon as either all servers tagged with `app:role=app_server_1` or servers tagged with `app:role=app_server_2` are operational. As stated above tasks can be waited on using their names:

~~~ ruby
concurrent wait_task: databases, app_servers do
  sub task_name: "databases" do
    @servers = find("servers", "database")
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
  sub task_name: "app_servers" do
    @servers = find("servers", "app_server")
    @servers.launch()
    sleep_until(all?(@servers.state[], "operational"))
  end
  sub task_name: "additional"
    @servers = find("servers", "additional")
    @servers.launch()
  end
end

# At this point the databases and app_servers tasks have completed
@servers = find("servers", "front_end")
@servers.launch()
~~~

One interesting application of the `wait_task` attribute is when used in conjunction with the number `0` as follows:

~~~ ruby
concurrent wait_task: 0 do
  sub do
    @servers = find("servers", "database")
    @servers.launch()
  end
  sub do
    @servers = find("servers", "app_server")
    @servers.launch()
  end
end

# At this point tasks above have not completed
@servers = find("servers", "diag_server")
@servers.launch()
~~~

In this case, the process proceeds past the `concurrent` expression without waiting for any of the launched tasks. This is the same behavior as wrapping the whole definition extract above in an outer `concurrent`.

### Tasks and State

Whenever a task is launched it gets its own copy of the parent task state. This includes all references and all variables currently defined in the parent task.

~~~ ruby
$n = 3
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
concurrent do
  sub do
    # $n is equal to 3 and @servers contain all servers in the "default" deployment
    $n = 5
    @servers = rs_cm.deployments.get(filter: ["name==other"]).servers()
    # $n is equal to 5 and @servers contain all servers in the "other" deployment
  end
  sub do
    # $n is equal to 3 and @servers contain all servers in the "default" deployment
  end
end
~~~

Once a task finishes its state is discarded, however, it is sometimes necessary to retrieve state from a different task. RCL provides two mechanisms to share state across tasks:

* The values for global references and variables are stored in the process, they can be written to and read from by any task.
* A `concurrent` sub expression may optionally `return` local variables or references. Such values are merged back into the parent task. If multiple tasks in the concurrence return the same value then the behavior is undefined; in other words the code needs to use different names for values returned by different tasks.

Here is an example using the `return` keyword:

~~~ ruby
define main(@server1, @server2) return @server1, @server2 do
  concurrent return @server1, @server2 do
    sub do
      provision(@server1)
    end
    sub do
      provision(@server2)
    end
  end
  # @server1 and @server2 are now operational
end
~~~

### concurrent foreach
Another way to create tasks in a process apart from `concurrent` is through the `concurrent foreach` expression. This expression runs all sub-expressions in sequence on all resources in the given resources collection concurrently. In other words a task is created for each resource in the collection:

~~~ ruby
@instances = rs_cm.get(href: "/api/deployments/123").servers().current_instance()
concurrent foreach @instance in @instances do
  @instance.run_executable(recipe_name: "cassandra::default")
  @instance.run_executable(recipe_name: "cassandra::configure")
  @instance.run_executable(recipe_name: "cassandra::restart")
end
~~~

In the snippet above, the three RightScripts get run sequentially on all servers in the collection at once. If the `@servers` collection in the example above contained two resources the following would have the same effect:

~~~ ruby
@instances = rs_cm.get(href: "/api/deployments/123").servers().current_instance()
concurrent do
  sub do
    @instance = @instances[0]
    @instance.run_executable(recipe_name: "cassandra::default")
    @instance.run_executable(recipe_name: "cassandra::configure")
    @instance.run_executable(recipe_name: "cassandra::restart")
  end
  sub do
    @instance = @instances[1]
    @instance.run_executable(recipe_name: "cassandra::default")
    @instance.run_executable(recipe_name: "cassandra::configure")
    @instance.run_executable(recipe_name: "cassandra::restart")
  end
end
~~~

Sometimes it is necessary to explicitly refer to one of the tasks that was spawned from the `concurrent foreach` execution. The `task_prefix` attribute is only valid for the `concurrent foreach` expression and allows defining a common prefix for all generated tasks. The task names are built from the prefix and the index of the resource in the collection:

~~~ ruby
concurrent do
  sub task_name: "run_scripts" do
    @servers = rs_cm.get(href: "/api/deployments/123").servers()
    concurrent foreach @server in @servers task_prefix: cassandra_setup do
      @instance = @server.current_instance()
      @instance.run_executable(recipe_name: "cassandra::default")
      @instance.run_executable(recipe_name: "cassandra::configure")
      @instance.run_executable(recipe_name: "cassandra::restart")
    end
  end
  sub do
    wait_task run_scripts/cassandra_setup0 # Wait for execution of scripts on first server in collection above to complete
  end
end
~~~

In the example above, `cassandra_setup0` refers to the task generated to run the `concurrent foreach` sub-expressions on the first resource in the `@servers` collection.

### concurrent map

Apart from `concurrent` and `concurrent foreach`, `concurrent map` is the only other way to create tasks in a process. A `concurrent map` works as expected: each iteration runs concurrently and the resulting collections are built from the results of each iteration.

**Note:** *Even though the resulting collections are built concurrently, `concurrent map` guarantees that the order of elements in the final collection(s) match the order of the collection being iterated on.*

So, for example:

~~~ ruby
@servers = rs_cm.get(href: "/api/deployments/123").servers()

# Launch all servers concurrently and conditionally run a script on the resulting
# instance once it is operational.
@instances = concurrent map @server in @servers return @instance do
  @instance = @server.launch()
  sleep_until(@instance.state == "operational")
  if @instance.name =~ "/^app_/"
    @instance.run_executable(recipe_name: "app::connect")
  end
end
~~~

In the example above the instances in the `@instances` collection will be ordered identically to the servers in the `@servers` collection (that is, the instance at a given index in the `@instances` collection will correspond to the server at the same index in the `@servers` collection).

### Ending processes

A process ends once all its tasks end. There are four conditions that will cause the execution of a task to end:

* Completing the task: the task has no more expressions to run.
* Failing the task: an expression raised an error that was not handled
* Canceling the task: this can be done through the `cancel` and `cancel_task` keywords.
* Aborting the task: this can be done through the `abort` and `abort_task` keywords.

#### Canceling a task or a process

Canceling a task can be done at any time in any task using the `cancel_task` keyword. This provides a way to finish "cleanly" a task that still has expressions to run. The cloud workflow can define rollback handlers that get triggered when the task cancels. These handlers behave much like timeout or error handlers: they may take arbitrary arguments and inherit the local variables and references of the caller. Nested rollback handlers are executed in reverse order as shown in this example:

~~~ ruby
define delete_deployment($deployment_name) do
  @deployment = rs_cm.deployments.get(filter: ["name==" + $deployment_name])
  @deployment.destroy()
end

define delete_servers($server_names) do
  foreach $name in $server_names do
    @server = rs_cm.servers.get(filter: ["name==" + $name])
    @sever.destroy()
  end
end
sub on_rollback: delete_deployment($deployment_name) do  # Assumes $deployment_name exists
  rs_cm.deployments.create(deployment: { "name": $deployment_name })
  # ... do more stuff
  sub on_rollback: delete_servers($server_names) do    # Assumes $server_names exists
    foreach $name in $server_names do
      # Assumes $server_params exists and is a hash of all required params to create a server
      rs_cm.servers.create(server: { "name": $name } + $server_params)
      # ... do more stuff
    end
    # ... do more stuff, initialize $has_errors
    if $has_errors
      cancel_task # Will call both delete_servers and delete_deployment in this order
    end
  end
end
~~~

In this snippet, if `$has_errors` gets initialized then the process is canceled and both the `delete_servers` and the `delete_deployment` get run in that order.

Canceling a process is done using the `cancel` keyword. This causes all the running tasks to be canceled and follow the same logic as above, potentially executing multiple rollback handlers concurrently. Once all rollback handlers finish then the process ends and the status of all its tasks is set to canceled.

#### Aborting a task or a process

Tasks can also be terminated through the `abort_task` keyword. This causes the task to finish immediately bypassing all rollback handlers. The `abort` keyword causes all the tasks in the current process to be aborted. The process thus finishes immediately and the status of all its tasks is set to aborted.

### Concurrency and Expressions

As described in Cloud Workflow and Definitions a definition consists of a sequence of _statements_. Each _statement_ is in turn made of _expressions_. The engine makes the following guarantee:

* Expressions always run atomically

In particular, if we consider any expression running in a concurrence (inside a `concurrent`, `concurrent foreach`, or `concurrent map`), then the rule above dictates that each concurrent expression runs atomically. So if we consider:

~~~ ruby
concurrent do
  sub do
    @servers = rs_cm.servers.get(filter: "name==app_server")
    @@instances << @servers.launch() # (1)
  end
  sub do
    @@instances << rs_cm.get(href: "/api/servers/123").launch() # (2)
  end
end
~~~

In the definition above, statement (1) is composed of two expressions: the call to the `launch()` action followed by the assignment to `@@instances`. Statement (2) is composed of 3 expressions: the call to `get()` followed by the call to `launch()` and finally the append to the `@@instances` collection. Since expressions run atomically the definition above guarantees that the `@@instances` collection will end-up with all instances, there is no need to explicitly synchronize the appends to `@@instances`. There is no guarantee about ordering though so it could be that the single instance retrieved in statement 2 is first in the collection.

Note that the following could generate inconsistent results:

~~~ ruby
# DO NOT DO THIS
@instances = rs_cm.get(href: "/api/deployments/123").servers(filter: ["state==operational"]).current_instance()

$$failed = 0

concurrent foreach @instance in @instances do
  @task = @instance.run_executable(recipe_name: "sys:do_reconverge_list_disable")
  sleep_until(@task.summary =~ "/^completed|^failed/")
  if @task.summary =~ "/^failed"
    $$failed = $$failed + 1 # (1) Oops, $$failed can be overridden concurrently
  end
end
~~~

In the example above, statement (1) is comprised of two expressions: the increment and the assignment. If two tasks were to increment concurrently after reading the same value then one of the increments would get lost (both tasks would write back the same value to `$$failed`). The `concurrent map` expression should be used instead to build results concurrently:

~~~ ruby
# DO THIS INSTEAD
@instances = rs_cm.get(href: "/api/deployments/123").servers(filter: ["state==operational"]).current_instance()

$failed_ones = concurrent map @instance in @instances return $failed_one do
  @task = @instance.run_executable(recipe_name: "sys:do_reconverge_list_disable")
  sleep_until(@task.summary =~ "/^completed|^failed/")
  if @task.summary =~ "/^failed"
    $failed_one = 1  
  end # Do not return anything on success
end
$failed = size($failed_ones)
~~~

The `concurrent map` expression takes care of building the resulting array from the results returned by each concurrent execution. There is no problem of the task overriding values concurrently in this case.

### Summary

A process may run one or more tasks concurrently at any time. RCL allows for describing how these tasks should be synchronized by providing both synchronization primitives and keywords for controlling tasks individually. A process ends once all its tasks end. A task ends when it completes (no more expression to execute), fails (an expression raises an error that is not handled), is canceled or is aborted. Canceling a task will cause any rollback handler to trigger and do additional processing before the task ends.

**Note:** *The concept of tasks and definitions are completely disjoint and should not be confused: a definition always runs in the task that ran the `call` expression. In other words, simply using `call` does not create a new task.*

## Mapping Resources to the RightScale APIs

The [RightScale CM API 1.5 reference documentation](http://reference.rightscale.com/api1.5/index.html) lists all the available resource types in the `rs_cm` namespace and corresponding media types. This section describes how to use that documentation to use the corresponding resources in a cloud workflow.

### API Resource Actions

Resource actions are listed in the corresponding media type document under the **Actions** section. The required arguments are described in the resource document itself. For example, the media type for the `Instances` resource is described in the corresponding document and the actions are:

[from CM API 1.5 Instance Media Type docs](http://reference.rightscale.com/api1.5/media_types/MediaTypeInstance.html#actions)

#### Actions
Note: Only a subset of the available actions are listed here.

Action | Description
------ | -----------
run_executable | Runs a script or recipe on the instance
terminate | Terminates the instance
reboot | Reboots a running instance
launch | Launches this instance with the current configuration


The details on how to call the actions are described in the instances resource document, taking the `launch()` action as example:

[from CM API 1.5 Instance Resource docs](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#launch)

#### launch

Launches an instance using the parameters that this instance has been configured with.

**Note:** *This action can only be performed in "next" instances, and not on instances that are already running.*

**URLs**
* POST /api/clouds/:cloud_id/instances/:id/launch
* POST /api/servers/:server_id/launch
* POST /api/server_arrays/:server_array_id/launch

**HTTP response code**
* 201 Created

**Location**
* Href of the launched Instance

**Required roles**
* actor

**Parameters**

Name | Required | Type | Values | regexp | Blank? | Description
---- | -------- | ---- | ------ | ------ | ------ | -----------
inputs | no |Array | * | * | no |
inputs[][name] | yes | String | * | * | no | The input name.
inputs[][value] | yes | String | * | * | no | The value of that input. Should be of the form `text:my_value` or `cred:MY_CRED`, etc.

Note that the engine will automatically map the **Location** response header to a resource collection and will make that resource collection the return value of the action. The action takes a single parameter inputs which is an array of hashes. Each hash should contain two elements: `name` and `value`. So the `launch()` action can be called in RCL using:

~~~ ruby
@running = @next_instance.launch(inputs: [{ "name": "ADMIN_EMAIL", "value": "text:admin@rightscale.com" },
                                          { "name": "PASSWORD",    "value": "cred:PASSWORD" }])
~~~

### API Resource Fields

Resource fields are listed in the corresponding media type document under the **Attributes** section. Look at the documentation for the media type of the instances resource:

[from CM API 1.5 Instance Media Type docs](http://reference.rightscale.com/api1.5/media_types/MediaTypeInstance.html)

**Attributes**

* private_dns_names
* updated_at
* monitoring_server
* actions
* terminated_at
* inputs
* os_platform
* inherited_sources
* description
* public_ip_addresses
* links
* monitoring_id
* private_ip_addresses
* user_data
* name
* public_dns_names
* resource_uid
* security_groups
* state
* created_at

### API Resource Links

Resources links are listed in the corresponding media type document under the **Relationships** section. Look at the documentation for the media type of the instances resource:

[from CM API 1.5 Instance Media Type docs](http://reference.rightscale.com/api1.5/media_types/MediaTypeInstance.html)

**Relationships**

Name | Description
---- | -----------
parent | Parent Object (Server/ServerArray)
self | Href of itself
datacenter | Associated datacenter
multi_cloud_image | Associated multi cloud image
inputs | List of configuration inputs
server_template | Associated ServerTemplate
ramdisk_image | Associated ramdisk image
volume_attachments | Associated volume attachments
instance_type | Associated instance type
monitoring_metrics | Associated monitoring metrics
kernel_image | Associated kernel image
ssh_key | Associated ssh key
image | Associated image
deployment | Associated Deployment
cloud | Associated Cloud

Relationships are referenced using syntax of `@resource.relationship()` and returns an individual resource or collection of resources. This returned resource or collection can then be referenced like any other resource and even recursively reference the resultant resource's relationships.

In the example above `server_template()` returns a single resource while `volume_attachments()` returns a collection. The possible link parameters are given by the description of the show request of the link resource if the link is for a single resource. Otherwise, they are given by the description of the index request. In the example above, the `server_templates` resource `show` request described in the resource documentation lists one potential parameter view which can be used in RCL as follows:

~~~ ruby
@instance.server_template(view: "default")
~~~

#### Special Handling of Inputs ####
Because inputs are not true resources like other items described by the API (e.g. servers, instances, etc), the `@resource.relationship()` paradigm described above cannot be used. Instead, there is a special function, `multi_update_inputs()` used to set/update a resource's inputs. This function takes as a parameter a hash of one or more `"INPUT_NAME:INPUT_VALUE"` elements. 

Using the `@instance` example above, since the Instance media type has a relationship of `inputs` then it is possible to update the resource's inputs. Assuming the instance is using a ServerTemplate that accepts inputs named, `DB_FQDN` and `DB_PASSWORD`, the inputs would be updated as follows:

~~~ ruby
@instance.multi_update_inputs(inputs: {"DB_FQDN":"mydbserver.example.com", "DB_PASSWORD":"cred:MY_DB_PASSWORD"})
~~~

### API Resource Type Actions

#### get()

The resource types `get()` action map to a index request on the corresponding resource. The parameters are thus described in the resources index request documentation. For example, for instances:

[from CM API 1.5 Instance Resource docs](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#index)

**index**

Lists instances of a given cloud.

Using the available filters, it is possible to craft powerful queries about which instances to retrieve. For example, one can easily list:

* instances that have names that contain "app"
* all instances of a given deployment
* instances belonging to a given server array (i.e., have the same parent_url)

**URLs**
* GET /api/clouds/:cloud_id/instances
* GET /api/server_arrays/:server_array_id/current_instances

**HTTP response code**
* 200 OK

**Content-type**
* application/vnd.rightscale.instance;type=collection

**Required roles**
* observer

**Parameters**

Name | Required | Type | Values | regexp | Blank? | Description
---- | -------- | ---- | ------ | ------ | ------ | -----------
filter | no | Array | * | * | no | See below for valid filter parameters.
view | no | String | `default`, `extended`, `full` | * | no | Specifies how many attributes and/or expanded nested relationships to include.

**Filters**

Name | partial_match? | Description
---- | -------------- | -----------
datacenter_href | no | The href of the datacenter to filter on.
deployment_href | no | The href of the deployment to filter on.
name | yes | Name of the Instance to filter on.
os_platform | yes | The OS platform to filter on.
parent_href | no | The href of the parent to filter on.
private_dns_name | yes | The private dns name to filter on.
private_ip_address | yes | The private ip address to filter on.
public_dns_name | yes | The public dns name to filter on.
public_ip_address | yes | The public ip address to filter on.
resource_uid | no | Resource Unique IDentifier for the Instance to filter on.
server_template_href | no | The href of the ServerTemplate to filter on.
state | no | The state of Instances to filter on.

Filters are given in the filter parameter which corresponds to an array of filter expressions. A filter expression consists of a filter name (from the table above) and a comparison to a value using either `==` or `<>`. For example, to retrieve all instances in the account whose name is not master_db one could write:

~~~ ruby
@instances = rs_cm.instances.get(filter: ["name <> master_db"])
~~~

#### create() and update()

Possible parameters for the resource types `create()` and `update()` actions are described by the corresponding resource request documentation. Looking at the deployments resource as an example, the corresponding documentation for the create request is:

[from CM API 1.5 Instance Resource docs](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#create)

**create**

Creates a new deployment with the given parameters.

**URLs**
* POST /api/deployments

**HTTP response code**
* 201 Created

**Location**
* Href of the created deployment

**Required roles**
* actor

**Required settings**
* premium_deployments

**Parameters**

Name | Required | Type | Values | regexp | Blank? | Description
---- | -------- | ---- | ------ | ------ | ------ | -----------
deployment | yes | Hash | * | * | no |
deployment[description] | no | String | * | * | yes | The description of the deployment to be created.
deployment[name] | yes | String | * | * | no | The name of the deployment to be created.
deployment[ server_tag_scope ] | no | String | `deployment`, `account` | * | yes | The routing scope for tags for servers in the deployment.

So a deployment `create()` action takes a single hash argument named `deployment` which consists of a hash with two keys: `name` and `description`. A deployment can thus be created in RCL using:

~~~ ruby
rs_cm.deployments.create(deployment: { "name": "LAMP Stack",
                                    "description": "Servers making up the LAMP Stack application" })
~~~
