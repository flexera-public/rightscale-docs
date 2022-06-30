---
title: Self-Service Plugins
---

## Overview

RightScale provides a plugin framework that allows for any service with an HTTP-based API to be incorporated into the RightScale platform for use in Self-Service CAT files and Cloud Workflow code. This allows the use of many common services, such as cloud provider services, 3rd party vendors, and on-premises systems, within your application lifecycle management in Self-Service.

There are two primary components to the plugins in Self-Service, both of which are represented as [declarations](/ss/reference/cat/v20161221/index.html#overview-declarations) within a CAT file. The two declarations are:
* `plugin` - describes the external API resources, actions, types, structure, and more. This is a generic definition that can be reused and shared.
* `resource_pool` - references a `plugin` declaration and provides the usage-specific elements such as endpoint information and credentials

Once a plugin and resource pool have been defined in the CAT, then any resource type defined in the plugin can be used in the CAT definition. Primarily these are used in the CAT language to define new resources that are part of the application. For example, the following declaration defines a DigitalOcean droplet resource using a plugin called `do`:

~~~ ruby
resource "my_droplet", type: "do.droplets" do
  name "my_droplet"
  region "us-east"
  size "small"
end
~~~

Additionally, the plugin can define custom actions on any resource that can be leveraged in Cloud Workflow code. For example, if the "droplet" resource has a custom action defined on it called `reboot`, that action can be called directly from Cloud Workflow.

~~~ ruby
  @my_droplet.reboot()
~~~

For a comprehensive reference of each plugin declaration please refer to the [CAT Plugins reference](/ss/reference/cat/v20161221/ss_plugins.html).

If a resource provider doesn't support an HTTP-based mechanism for interacting with it, a *Plugin Proxy* can be built and deployed to act as the mediator between the RightScale platform and the provider. When building such a service, it is recommended that you use [Goa](https://goa.design/) or [Praxis](http://praxis-framework.io/) frameworks as this will simplify the definition of the *Plugin* in RightScale.

### Plugins

A *plugin* in RightScale is simply a set of metadata about a service provider that the RightScale system can use to interact with the provider.

For any given provider, the *plugin* defines a set of resources that the provider has available, defined using the `type` resource within the plugin. For each resource, the *plugin* defines:
* the fields of the resource that are needed (or optional) to create a new resource
* the structure of the API call needed to interact with this resource type
* the properties of the resource that can be used as "outputs" once a resource is created
* the logic needed to create and destroy this kind of resource
* the operational actions available on this resource
* any links this resource has to other kinds of resources

In addition to resource information, the *plugin* also defines common attributes of the service, such as the base HTTP path to use for this service, any HTTP headers that must be sent along with a request, and other HTTP connection information.

Lastly, plugins may optionally contain any number of "parameters", configuration items that can be set when the plugin is instantiated.

### Resource Pools

A Resource Pool is simply an instance of a Plugin, tied to a specific "account" on the provider, made available to the RightScale platform to interact with. Many Resource Pools may be registered for any given plugin.

The Resource Pool defines any parameter values required by the Plugin, specifies the specific URL/host to use for this service, and specifies the authentication information needed to interact with this instance of the plugin.

## Building a Plugin

### The plugin declaration

The `plugin` declaration in CAT is made up of 3 primary sections:
* **Parameter** - 0 or more configurable variables
* **Endpoint** - describes the HTTP endpoint information
* **Resource Types** - describe the resources made available by this plugin

#### Parameter

A plugin lists the parameters it uses to describe how to make the action requests. The syntax used to declare each parameter is identical to the CAT parameter syntax.

For more details, see [the reference documentation](/ss/reference/cat/v20161221/ss_plugins.html#plugins-parameter).

#### Endpoint

The next section is the plugin *endpoint* section. It defines:
* the base path used by all requests made to the service
* the common HTTP headers used by all requests made to the service
* a default host and scheme for the service (the *plugin resource pool* declaration sets the final values)

Parameters may be used to define the values for any of the properties listed above.

For more details, see [the reference documentation](/ss/reference/cat/v20161221/ss_plugins.html#plugins-endpoint).

#### Resource Types

Finally, plugins also provide information about the resources made available from the given provider. This is the most powerful and complex part of the plugin definition. Each type declaration provides the following information:

* How to make HTTP requests to the type actions (both the CRUD and custom actions)
* How to extract resource hrefs from API responses to build resulting resource collections
* How to provision and delete resources via RCL definitions
* The fields required to build a resource collection of that type
* The fields exposed by the resource collection so that for example CloudApp outputs can use them
* The actions supported by the type and for custom actions the details needed to make the HTTP requests if the default doesn't work
* The links supported by the type including the information needed to build the link hrefs

An important design goal of the declaration syntax is to make it simple to describe simple cases. In that vein most type fields are optional and only required to override the defaults when they don't work.

For more details, see [the reference documentation](/ss/reference/cat/v20161221/ss_plugins.html#plugins-type).

## Creating an instance of a plugin

Actually using the resources defined in a plugin requires the use of the `resource_pool` declaration. This declaration instantiates a plugin by providing actual values to the parameters and an actual endpoint and associated auth (required only if a default host is not defined in the plugin declaration). The `auth` declaration allows specifying how requests sent to the service should be signed.

The syntax for a resource pool declaration is:

~~~ ruby
resource_pool "kube" do
  # Name of plugin
  plugin "kube"

  # Values for plugin parameters
  parameter_values do
    namespace "us_east"
  end

  # Specify host, potentially overriding template's default host
  host "kube-east.example.com"

  # Service auth, see
  auth "key", type: "api_key" do
    key cred("KUBE_US_EAST_API_TOKEN")
    format "Bearer $key"
    location "header"
  end

end
~~~

## Using Plugins

Once the plugin has been declared and a resource pool has been instantiated from the plugin the resources it exposes can be taken advantage of in a CAT and RCL code the same way RightScale resources can.

### Defining plugin packages

Plugins are intended to be defined inside of packages which are then used by other CATs. Note that in order to contain a `plugin` declaration, a CAT must be of `type 'plugin'`. These plugin-type CATs can contain other declarations and can be launched only as [Test CloudApps](/ss/guides/ss_testing_CATs.html#test-cloudapps) (i.e. from Designer) -- with the intent that launching a "plugin" type CAT is done during testing to ensure the plugin definition works as intended.

Once a plugin definition is complete, it is common to then [import](/ss/guides/ss_packaging_cats.html#importing-a-package) the plugin CAT into an "application" CAT which can be published to the Catalog.

The following is an example of a "plugin" CAT that is contained in the `plugins/kubernetes` package.

~~~ ruby
name "Kube Plugin"
rs_ca_ver 20161221
short_description "A CAT defining the Kubernates plugin"
type 'plugin'
package "plugins/kubernetes"

plugin "kube" do
  # Parameter definitions for the plugin
  parameter "namespace" do
    type "string"
    label "Kubernates Namespace"
    description "Namespace used to create all resources"
    default "us-east"
  end

  parameter "region" do
    type "string"
    label "Kubernates Region"
    description "The region in which the resources are created"
  end

  parameter "grouping" do
    type "string"
    label "Grouping"
    description "The grouping"
  end

  # Endpoint definition
  endpoint do
    default_host "kube-$region.example.com"  # `$region` is substituted with the value for the `region` parameter
    default_scheme "https"
    path "/api/v1/namespaces/$namespace"

    headers do {
      "User-Agent" => "Kube namespace"
    } end

    no_cert_check false
  end

  type "pods" do
    href_templates "/namespaces/:metadata.namespace:/pods/:metadata.name:",
      "/namespaces/:items[*].metadata.namespace:/pods/:items[*].metadata.name:"

    provision "provision_pod"
    delete "delete_pod"

    field "kind" do
      type "string"
      required true
    end
    field "metadata" do
      type "composite"
    end
    field "spec" do
      type "composite"
    end

    output "kind", "apiVersion", "metadata", "spec", "status"
    output "namespace" do
      path "metadata.namespace"
    end
    output "status_phase" do
      path "status.phase"
    end

    action "create" do
      path "/pods"
      verb "POST"
    end
    action "list" do
      path "/pods"
      verb "GET"
      output_path "items"
    end
    action "get"
    action "destroy"
  end
end

define provision_pod(@raw) return @pod do
  $raw = to_object(@raw)
  $fields = $raw["fields"]
  @pod = kube.pods.create($fields)
  sleep_until @pod.status_phase == "Running"
end

define delete_pod(@pod) do
  @operation = @pod.destroy()
end
~~~

### Importing plugin packages

Once a plugin has been defined in a package then it can be imported and used within other CATs. Imported plugins are automatically made available -- there's no need to define a plugin which is `like` them. They also do not need to be scoped by the imported package name.

Note the example below which imports the above plugin CAT and defines a `resource_pool` for it. The below CAT is an "application" CAT by default and can be published to the Catalog.

~~~ ruby
name "Kube Plugin"
rs_ca_ver 20161221
short_description "A CAT defining the Kubernates plugin"
import "plugins/kubernetes"

parameter "kub_region" do
  type "string"
  label "Kubernates Region"
  description "Region used to create all resources"
end

mapping "grouping_map" do {
  "grouping" => {
    "1-a" => "Group 1",
    "2-a" => "Group 2"
  }
} end

resource_pool "kube_pool" do
  plugin $kube # $kube is defined in "plugins/kubernetes"
  host "mykube.example.com"

  parameter_values do
    region $kub_region
    grouping map($grouping_map, "grouping", $kub_region)
  end

  auth "my_basic_auth", type: "basic" do
    username "user"
    password cred("MY_PASSWORD")
  end

  auth "my_JWT_auth", type: "jwt" do
    basic @my_basic_auth
    token_url "https://www.example.com/tokens"
    field "Authorization"
  end
end

output "custom_output" do
    label "custom_output"
    default_value @my_pod.status
    description "Pod status from plugin output field"
end

resource "my_pod", type: "kube.pods" do
  kind "Pod"
  metadata do {
    "image" => "nginx:latest"
  } end
end
~~~

### Plugins in CAT

The syntax consists of using the plugin name followed by a period (`.`) as prefix to the resource name, taking the droplet resource type as an example:

~~~ ruby
# Assumes "docean" is the name of the plugin
resource "my_droplet", type: "docean.droplets" do
  # "name" field values inherit from the resource name by default
  name "my_droplet"
  region "us-east"
  size "small"
end
~~~

The resource is created running the corresponding provision definition and deleted using the delete definition. Authentication to the service is done using the information provided in the resource pool declaration auth section.

Other resource fields and outputs in the CAT may use the outputs defined by the plugin resource type, for example the droplet type above defines a memory output so a CAT using that type could define a `droplet_memory` output as follows:

~~~ ruby
output "droplet_memory" do
  label "Droplet RAM"
  category "Configuration"
  default_value @my_droplet.memory
end
~~~

#### XML Support

Simple types (string, number, boolean) can be assumed to be attributes.
An array can be assumed to be an element and a (hash) map can be assumed to be a complex type (object).
In order to convert a simple type to be an element instead of an attribute, it would have to be represented as a one-sized array containing only the simple type.

~~~ ruby
#defining a composite plugin field
field "create_hosted_zone_request" do
  alias_for "CreateHostedZoneRequest"
  type "composite"
  required true
  location "body"
end
~~~

**Example 1:  Resource Declaration**
* `xmlns`  is a string
* `Name`  is a single item array
* `CallerReference` is a single item array

~~~ ruby
# plugin resource declaration
resource "hostedzone", type: "rs_aws_route53.hosted_zone" do
  create_hosted_zone_request do {
    "xmlns" => "https://route53.amazonaws.com/doc/2013-04-01/", # Simple type: Attribute
    "Name" => [ join([first(split(uuid(),'-')), ".rs-example.com"]) ], # One-Sized Arrays become nested elements
    "CallerReference" => [ uuid() ] # One-Sized Arrays become nested elements
  } end
end
~~~

**Example 1: Expected Output**
~~~ xml
<CreateHostedZoneRequest xmlns="https://route53.amazonaws.com/doc/2013-04-01/">
  <CallerReference>c0975dc6-8652-4bd8-9ba2-fc43b5006c79</CallerReference>
  <Name>3898363a.rs-example.com</Name>
</CreateHostedZoneRequest>
~~~

**Example 2: Resource Declaration**
* `xmlns`  is a string
* `Name`  is a single item array
* `CallerReference` is a single item array
* `HostedZoneConfig` is a hash

~~~ ruby
resource "hostedzone1", type: "rs_aws_route53.hosted_zone" do
  create_hosted_zone_request do {
    "xmlns" => "https://route53.amazonaws.com/doc/2013-04-01/", # Simple type: Attribute
    "Name" => [ join([first(split(uuid(),'-')), ".rs-example.com"]) ], # One-Sized Arrays become nested elements
    "CallerReference" => [ uuid() ], # One-Sized Arrays become nested elements
    "HostedZoneConfig" => {          # Hash
      "Comment" => ["Test Zone"],    # One-Sized Arrays become nested elements of Hash
      "PrivateZone" => [ false ]     # One-Sized Arrays become nested elements of Hash
    }
  } end
end
~~~

**Example 2: Expected Output**
~~~ xml
<CreateHostedZoneRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">
  <CallerReference>f4ac75a9-efa9-4731-9920-3c96b8db07fd</CallerReference>
  <HostedZoneConfig>
    <Comment>Test Zone</Comment>
    <PrivateZone>false</PrivateZone>
  </HostedZoneConfig>
  <Name>bdf6c3d1.rs-example.com</Name>
</CreateHostedZoneRequest>
~~~

### Plugins in RCL

All the actions defined on the resource type in the plugin are available to RCL code. This makes it possible to define operations in the CAT that can take advantage of the custom actions, for example a "backup" operation may take advantage of the "snapshot" custom action exposed by a "volume" plugin resource type.

~~~ ruby
define main(@my_droplet) do
  @my_droplet.operate({action_name: "stop"})
end
~~~

