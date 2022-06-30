---
title: Bulk Resources in Self-Service
description: Bulk resources in Self-Service provide an easy way to launch a large number of similar resources quickly and efficiently.
---

There are many situations in which you might want to launch more than one of a given resource that is very similar. For example, perhaps you need to launch a distributed database with 5 nodes, all of which launch from the same image/template and have almost identical properties. CAT files and Cloud Workflow provide built-in mechanisms for this kind of situation that combine an easy-to-use syntax with a highly performant backend implementation.

## Introduction to Bulk Resources

Any time that an application requires multiple "copies" of a given resource, even if each copy has slightly different properties, bulk resources should be considered. Defining multiple resources in this way is simple in both CAT and in Cloud Workflow code, with built-in constructs to help declare, launch, manage, and destroy bulk resources.

## Bulk Resources in CAT

In a CAT file, creating bulk resources is as simple as adding the `copies` attribute to a `resource` declaration. For example, the following will create 5 identical servers:

~~~ ruby
resource "basic_server", type: "server", copies: 5 do
  name "Basic Server"
  cloud "EC2 us-west-2"
  ssh_key find("default")
  server_template find("RightLink 10.6.0 Linux Base")
end
~~~

Usually, each of the copies will have _some_ slight difference, such as appending the "number" to the `name` of each server. For this purpose, the [`copy_index` function](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords) can be used to get the current index in the collection. For example, the following code will launch the same 5 servers, but each with their own unique name:

~~~ ruby
resource "basic_server", type: "server", copies: 5 do
  name join(["Basic Server #", copy_index()])
  cloud "EC2 us-west-2"
  ssh_key find("default")
  server_template find("RightLink 10.6.0 Linux Base")
end
~~~

Of course, you can also use a value from a `mapping` or a `parameter` to determine the number of copies to create:

~~~ ruby
parameter "server_count" do
  type "number"
  label "Number to create"
end

resource "basic_server", type: "server", copies: $server_count do
  name join(["Basic Server #", copy_index()])
  cloud "EC2 us-west-2"
  ssh_key find("default")
  server_template find("RightLink 10.6.0 Linux Base")
end
~~~

### Advanced example

There may be cases in which the number of copies needs to be calculated, and where bulk resources need to be created that refer to other bulk resources. CAT provides a set of built-in methods that can be used to help calculate the number bulk resources to launch and to ensure that the right item in a collection of bulk resources is being referenced.

Let's look at an example where there is a variable number of servers being created, each of which needs to have 3 volumes attached:

~~~ ruby
parameter "server_count" do
  type "number"
  label "Number to create"
end

resource "basic_server", type: "server", copies: $server_count do
  name join(["Basic Server #", copy_index()])
  cloud "Google"
  datacenter "us-central1-a"
  instance_type "n1-standard-1"
  server_template find("RightLink 10.6.0 Linux Base")
end

resource "volume", type: "volume", copies: prod(3, $server_count) do
  name join(["Bulk volume #", copy_index()])
  cloud "Google"
  datacenter "us-central1-a"
  size 10
end

resource "volume_attachment", type: "volume_attachment", copies: prod(3, $server_count) do
  cloud "Google"
  server get(div(copy_index(),3), @basic_server)
  volume get(copy_index(), @volume)
  device join(["persistent-disk-", inc(mod(copy_index(), 3),1)])
end
~~~

The `server` resource is pretty clear on how it works - it is creating the number of servers that the user specifies in the `parameter`. The other resources contain some interesting use of built-in methods that it is worth exploring in detail.

First, because we want to attach 3 volumes to each server, note that the `copies` count for each the `volume` and `volume_attachment` resources is the parameter value multiplied by 3, using the [`prod` function](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords).

~~~ ruby 
resource "volume", type: "volume", copies: prod(3, $server_count) do
~~~

Basic math functions can be used in the attributes section of resource declarations, and are [listed here](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords-using-cat-methods-on-attributes).

Another interesting piece of the above CAT is how the `volume_attachment` references both the `volume` and the `server` bulk resources. Every volume attachment resource contains the `server` the volume should be attached to as well as the `volume` to attach. In this case, those resources are defined by bulk resources above and each `volume_attachment` must reference the correct resource. 

For referencing the volume, the solution is straightforward as we need to reference the `volume` with the same index as the current `volume_attachment`. To do this, the [`get()` function](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords) is leveraged to get the specific volume in the bulk collection that corresponds to this iteration of the `volume_attachment`.

~~~ ruby
  volume get(copy_index(), @volume)
~~~

To reference the correct `server` however, it is not as simple, since each server is getting 3 volumes attached to it. In this case we use the basic [`div` function](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords) to get a value of either `0`, `1`, or `2` and then use that as an index into the `basic_server` collection of servers.

~~~ ruby
  server get(div(copy_index(),3), @basic_server)
~~~

Lastly, we give each volume a unique device path which is specified as part of the `volume_attachment`. In GCE, these paths must match the format `persistent-disk-`, appended with a unique number. Using the basic [`mod` and `inc` math functions](/ss/reference/cat/v20161221/index.html#built-in-methods-and-other-keywords), we can derive the correct number for this iteration of the attachment and `join` it to the requisite string prefix.

~~~ ruby
  device join(["persistent-disk-", inc(mod(copy_index(), 3),1)])
~~~

## Bulk Resources in RCL

### Creating Bulk Resources

By using [bulk resource declarations](/ss/reference/rcl/v2/index.html#resources-resource-declarations) in Cloud Workflow, you can use the [`provision` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision) to get a fully populated [resource collection](/ss/reference/rcl/v2/index.html#resources-resource-collections) returned. Generally, [resource declarations](/ss/reference/rcl/v2/index.html#resources-resource-declarations) are defined in a CAT and then passed in to Cloud Workflow definitions -- creating resource declarations manually is outside the scope of this document.

Given a resource declaration with one item in it, RCL provides multiple methods to generate a bulk resource declaration. In a simple case, imagine a resource declaration with one `server` defined in it. To create a bulk declaration from that, you simple use the [`copy` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-copy)

~~~ ruby
define main(@server) return @servers do
  @servers = copy(20, @server)
  provision(@servers)
end
~~~


### Provisioning Bulk Resources

Once a bulk resource declaration has been defined, provisioning the resources is as simple as calling the [`provision` function](/ss/reference/rcl/v2/ss_RCL_functions.html#resource-management-provision) on the declaration. The documentation for the function describes its behavior with bulk resource declarations. To provision the server bulk declaration from above, one would use the following RCL:

~~~ ruby
provision(@servers)
~~~

#### Manually Working with Bulk Resources

Although not recommended, bulk resource declarations can also be manually created outside of the `provision` function. When creating bulk resources using a bulk resource declaration, use of the [`create_copies` built-in action](/ss/reference/rcl/v2/index.html#resources-creating-resources) should be considered, as it simplifies the process and provides performance benefits.

Of particular note when working with bulk resources in custom code is how to deal with errors when creating resources. Since the `create_copies` function makes the `create` call on all of the items in the bulk declaration, care must be taken when there are errors creating one or more items in the declaration. This topic is [covered in the documentation for create_copies](/ss/reference/rcl/v2/index.html#resources-creating-resources).

