---
title: Packaging CATs
description: A CAT file may be used to package common functionality and share it with other CAT files
---

CAT packages allow designers to reuse common declarations and definitions without having to copy/paste them into each CAT. CAT packages can be used in other CAT files by specifying an `import` field with the desired package path. Note that `rs_ca_ver` [20160622](/ss/reference/cat/v20160622/index.html) **or higher** is required in order to use the `package` and `import` fields.

## Creating a Package

Any CAT may be used as a package by including the `package` field. This field is used to specify a path for the package. Package paths must be forward-slash separated scopes where each scope begins with a lowercase letter or underscore and contains only lowercase/uppercase letters, numbers, and underscores. They may not contain leading or trailing slashes. Package paths must be unique within a project.

!!info*Note:* Package paths beginning with 'rs' or 'rightscale' (case insensitive) are reserved and may not be used.

~~~ ruby
name "Simple Package"
rs_ca_ver 20161221
package "simple/package"
short_description "A package which may be imported into other CATs"
~~~

## Importing a Package

One or more CATs with packaged content may be imported into another CAT by using the `import` keyword. This field contains the package path specified in the CAT to be imported. Note that importing a package does not change a CAT's declarations. The imported declarations must be used explicitly as explained in [Referencing Imported Declarations](#referencing-imported-declarations).

~~~ ruby
name "Simple CloudApp"
rs_ca_ver 20161221
import "simple/package"
short_description "A CAT which imports a package"
~~~

Once a package is imported, it may be referenced by its package name. The package name is the last segment of the package path.

### Using an Alias

The `import` keyword may also be combined with the `as` keyword to make an alias for any package. This is required if there are multiple package paths that have the same package name.

~~~ ruby
name "Simple CloudApp"
rs_ca_ver 20161221
import "simple/package"
import "another/package", as: 'another_package'
short_description "A CAT which imports multiple packages"
~~~

## Referencing Imported Declarations

Once a package has been imported, its declarations are available for use within the importing CAT. Imported packages may be referenced by their package name (the last segment of the package path) or alias. Declarations may be referred to using dot notation, such as `$pkg.param` for declarations and `@pkg.server` for resources.

### Wrapping a Declaration

In order to expose imported declarations and resources, they must be explicitly wrapped using the `like` keyword from within the importing CAT. For example, if an imported package "my_package" provides resource "base_server" and operation "launch", those may be wrapped using:

~~~ ruby
resource "base_server", type: "servers" do
  like @my_package.base_server
end
~~~

~~~ ruby
operation "launch" do
  like $my_package.launch
end
~~~

### Overriding Declaration Fields

Declaration fields can be overridden by specifying them in addition to the `like` field.

~~~ ruby
resource "base_server", type: "servers" do
  like @my_package.base_server
  name "Overriden Name"
end
~~~

### Importing Reference Fields

When wrapping a declaration whose fields reference other declarations, the importing CAT must contain declarations matching the type and name of each reference. For example:

~~~ ruby
name 'Package CAT'
rs_ca_ver 20161221
short_description 'Contains declarations which use references'
package 'examples/references'

parameter 'param' do
  label 'Displayed in the CloudApp'
  type 'string'
end

output 'param_output' do
  label 'Parameter Value'
  # Reference must be available in the importing CAT
  default_value $param
end
~~~

~~~ ruby
name 'Importing CAT'
rs_ca_ver 20161221
short_description 'Wraps declarations which use references'
import 'examples/references'

parameter 'param' do
  like $references.param
end

output 'param_output' do
  # Requires we define a declaration named 'param'
  like $references.param_output
end
~~~

If you attempt to import a declaration without also importing any other declarations it uses you will receive a compiler error telling you. For example if you left out the `$param` declaration above:

~~~ ruby
name 'Importing CAT'
rs_ca_ver 20161221
short_description 'Wraps declarations which use references'
import 'examples/references'

#parameter 'param' do
#  like $references.param
#end

output 'param_output' do
  # Requires we define a declaration named 'param'
  like $references.param_output
end
~~~

The above CAT yields this compiler error:
  ![Missing Imported Reference Image](/img/ss-missing-imported-ref.png)

### Importing Bulk Resources

When a resource is imported into a file by the `import` and `like` keyword, the `copies` attribute is not inherited and must be redefined by the importer.  So the following shows **an error** when compiling the CAT files:

~~~ ruby
name 'Basic declarations'
rs_ca_ver 20161221
short_description 'Defines a server declaration'
package 'basics/decls'
  
resource 'main_server', type: 'server', copies: 10 do
  name "resource_server"
  ...
end
~~~

~~~ ruby
name "Bulk resources"
rs_ca_ver 20161221
short_description ""
import "basics/decls"
  
resource "my_server", type: "server" do
  like @decls.main_server  # will throw an error as @decls.main_server is a bulk resource and 'my_server' is a single resource.
end
~~~

To resolve the above error, simply be sure to specify a `copies` attribute on the declaration that references the imported bulk declaration. For example, the `Bulk resources` CAT above can be corrected as follows:

~~~ ruby
name "Bulk resources"
rs_ca_ver 20161221
short_description ""
import "basics/decls"
  
resource "my_server", type: "server", copies: 3 do
  like @decls.main_server  
end
~~~ 

!!info*Note:*Importing a non-bulk resource declaration and adding the `copies` attribute is supported

## Using RCL Definitions

Definitions are automatically imported without needing to use the `like` keyword. When a definition is imported into an importing CAT it will be available in the importing CAT with the imported package alias prefixed to it. For example, if package `examples/defns` defines a definition `my_defn`, importing CATs could reference it as `defns.my_defn`.

Imported definitions may be used as the definition field for operations or may be called directly from another definition.

### In Operations

Definitions defined in packages you import into your CAT may be used in the `definition` field of Operation declarations. If package `examples/defns` defines a definition `my_defn` then you could use it in an operation like this:

~~~ ruby
import 'examples/defns'

operation 'call_defn' do
  definition 'defns.my_defn'
end
~~~

Note that if the imported definition expects declarations or resources as arguments then you should make sure they're available in the importing CAT.

### In Definitions

RCL definitions from imported CATs may be called directly by using the `call` keyword. For example, if an imported package "examples/defns" provided a definition "my_def" it may be called using:

~~~ ruby
import 'examples/defns'

define foo() do
  call defns.my_def()
end
~~~

## Updating Packages, Recompiling, and Publishing

If you update a package CAT which is used in an importing CAT the importing CAT will need to be recompiled in order to make use of the changes to the package CAT. The UI will detect direct dependents of the package CAT and offer to recompile them when you update the package CAT:

  <div class="media">
  <img src="/img/ss-recompile-prompt.png" alt="Recompile Prompt Image">
  </div>

If the importing CAT is not recompiled it will continue to work as before but simply will not have any changes made to packages it imports made since it was last compiled. This is indicated in the UI:

  ![Stale Template Image](/img/ss-stale-template.png)

CloudApps which were published from a CAT which imports packages must be republished after the importing CAT is recompiled in order for it to make use of the updated packages.
