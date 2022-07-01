---
title: CAT Changelog
description: Change log for the CAT language
---

## Version 20161221

Released February 2017

### New Features

* Introduced the notion of [bulk resources](v20161221/index.html#resources-bulk-resources), allowing N number of a given resource to be defined and launched automatically. Also introduced [Output Sets](v20161221/index.html#output-sets) to help show output values from bulk resources.
* Introduced the notion of [custom provision functions](v20161221/index.html#resources-custom-provision) on resource declarations allowing for custom logic when provisioning resources.
* [IP Address Binding](./v20161221/ss_CAT_resources.html#resources-ip_address_binding) and [Volume Attachment](./v20161221/ss_CAT_resources.html#resources-volume_attachment) resources in CAT now have a `server` field which can reference a server directly. The old `instance` field should now only be used for referencing an instance.
* Mapping values may now be string, integer, boolean, or `null` values.
* [New CAT methods](./v20161221/index.html#built-in-methods-and-other-keywords) are added: `copy_index`, `dec`, `div`, `field`, `get`, `ljust`, `mod`, `prod`, `rjust`, `to_s`.
* Some [methods can now be used on declaration attributes](v20161221/index.html#built-in-methods-and-other-keywords-using-cat-methods-on-attributes) to satisfy common use cases for bulk resources.
*  Integrate your CloudApps with external services using [CAT Plugins](/ss/guides/ss_plugins.html) (added April 2017).

### Breaking Changes

* Any `ip_address_binding` that has a `instance` field that references a `server` declaration must be changed to use the new `server` field instead. 

    Old syntax:
    ~~~ ruby
    resource "my_server", type: "rs_cm.server" do
      ...stuff
    end
    resource "binding", type: "rs_cm.ip_address_binding" do
      instance @my_server
    end
    ~~~

    New syntax:
    ~~~ ruby
    resource "my_server", type: "rs_cm.server" do
      ...stuff
    end
    resource "binding", type: "rs_cm.ip_address_binding" do
      server @my_server
    end
    ~~~

* Any `volume_attachment` that has a `instance` field that references a `server` declaration must be changed to use the new `server` field instead. 

    Old syntax:
    ~~~ ruby
    resource "my_server", type: "rs_cm.server" do
      ...stuff
    end
    resource "binding", type: "rs_cm.volume_attachment" do
      instance @my_server
    end
    ~~~

    New syntax:
    ~~~ ruby
    resource "my_server", type: "rs_cm.server" do
      ...stuff
    end
    resource "binding", type: "rs_cm.volume_attachment" do
      server @my_server
    end
    ~~~


## Version 20160622

Released June 2016

### Breaking Changes

* [Naming restrictions](/ss/reference/cat/v20161221/index.html#overview-declarations) are now enforced on `permission` and `operation` declarations. Use the new 'label' field for human-friendly UI labels. 

    Old syntax:
    ~~~ ruby
    permission "manage sgs" do 
      label "Manage SGs"
    end
    ~~~

    New syntax:
    ~~~ ruby
    permission 	"manage_sgs" do 
      label "Manage SGs"
    end
    ~~~

* Actions and resources for Permission declarations have been moved from the `rs` namespace to the `rs_cm` namespace to match the new [RCL v2](../rcl/v2/index.html) syntax. Here is an example:

    Old syntax:
    ~~~ ruby
    permission "manage_sgs" do
      actions "rs.create", "rs.destroy"
      resources "rs.security_groups"
    end
    ~~~

    New syntax:
    ~~~ ruby
    permission "manage_sgs" do
      actions   "rs_cm.create", "rs_cm.destroy"
      resources "rs_cm.security_groups"
    end
    ~~~

* Short descriptions and labels on `parameter` declarations must not be an empty string or a whitespace-only string. Here is an example:

    Old syntax:
    ~~~ ruby
    parameter "performance" do  
      type "string"  
      label " "
      description ""
      allowed_values "low", "high"
    end
    ~~~

    New syntax:
    ~~~ ruby
    parameter "performance" do  
      type "string"  
      label "Application Performance"
      description "Application performance profile"
      allowed_values "low", "high"
    end
    ~~~

* The `rs_ca_ver` CAT field must be an integer value. Here is an example:

    Old syntax:
    ~~~ ruby
    rs_ca_ver '20131202'
    ~~~

    New syntax:
    ~~~ ruby
    rs_ca_ver 20131202
    ~~~

* All CAT fields must appear before any declarations or definitions. Here is an example:

    Old syntax:
    ~~~ ruby
    resource "database_slave", type: "server" do
      name "Database Slave"  
      cloud "AWS US-East"
      server_template_href "/api/server_templates/123"
    end

    name 'My CloudApp'
    rs_ca_ver 20131202
    short_description 'This is a CloudApp that does something great'
    ~~~

    New syntax:
    ~~~ ruby
    name 'My CloudApp'
    rs_ca_ver 20161221
    short_description 'This is a CloudApp that does something great'

    resource "database_slave", type: "server" do
      name "Database Slave"  
      cloud "AWS US-East"
      server_template_href "/api/server_templates/123"
    end
    ~~~

* Definitions now use [RCL v2](../rcl/v2/index.html) syntax.

### New Features

* [CAT Imports](../../guides/ss_packaging_cats.html)
* Added label field to operations and permissions which will be displayed in the UI

## Version 20131202

Released December 2013

* [First release](v20131202/index.html)
