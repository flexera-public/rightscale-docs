---
title: CAT Plugins Reference
description: This page is a detailed reference for declarations related to CAT plugins
version_number: "20161221"
versions:
  - name: 20161221
    link: /ss/reference/cat/v20161221/ss_plugins.html
---

## Overview

CAT Plugins allow CloudApps to interact with external services not natively supported by RightScale. This page provides details about the supported fields for plugin-related declarations. For an introduction to plugins and for an overview of how to write one see the [CAT Plugins guide](/ss/guides/ss_plugins.html).

When working with plugins, there are two primary types of declarations:

- `plugin` - generically describes the API to interact with
- `resource_pool` - provides specific endpoint and login information to use with the `plugin`

A given `plugin` may have multiple `resource_pool`s associated with it, for example to connect to different services or to use different accounts with the same API.

## Plugins

Plugins describe the API of a service provider for the RightScale platform to interact with, including defining the parameters which must be specified to interact with the service, the structure of resources in the service, and how RightScale can create and interact with those resources. A `plugin` declaration must contain exactly one [endpoint](#plugins-endpoint), any number of [parameters](#plugins-parameter), and any number of [types](#plugins-type). Additionally a plugin can define global `href_templates` values.

!!info*Note*A plugin declaration may only be declared in a `plugin` type CAT.

### Usage

~~~ ruby
plugin "kube" do
  parameter "namespace" do
    # parameter fields
  end

  type "node" do
    # type fields
  end

  endpoint do
    # endpoint fields
  end

  href_templates "/namespaces/{{metadata.namespace}}/$type/{{metadata.name}}"
end
~~~

### Parameter

Plugin parameters are used to provide variability in how to construct the requests to the external service. The syntax used to declare each parameter is identical to the [CAT parameter syntax](index.html#parameters). Use a `parameter` when any part of the `endpoint` might change between different `resource_pool` definitions. Parameter values can be used in the following fields of a plugin:

- `endpoint` -> `headers`
- `endpoint` -> `path`
- `type` -> `action` -> `path`

Parameter values must be supplied by resource pools [parameter_values](ss_plugins.html#resource-pools-fields)

#### Fields

See [CAT Parameters](index.html#parameters).

#### Usage

The example below shows a fictitious `kube` plugin that allows managing resources inside a Kubernetes namespace. A "real" Kubernetes plugin would probably not restrict itself to a single namespace, this is an artificial example.

~~~ ruby
plugin "kube" do

  parameter "namespace" do
    type "string"
    label "Kubernetes namespace"
    description "Namespace used to create all resources"
  end

  endpoint do
    ....
    path "/api/v1/namespaces/$namespace" # Base request path, note the use of the $namespace parameter
    ....
  end

  ...
end
~~~

### Endpoint

Endpoints define the base information needed to communicate with the service. It includes the host, scheme, base path and other options if not provided in the resource pool declaration.
Parameters may be used to define the values for any of the properties listed above. Using a parameter simply consists of using the $name notation in string literals where "name" is the name of the parameter. Note that if a path value is specified then that value will be trimmed from resource hrefs if it is present.

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`default_host` | no | string | Default api endpoint
`default_scheme` | no | string | Possible values "http" or "https". Default: "https".
`path` | yes | string | Base request path.
`headers` | no | - | Lists the common headers to inject in all requests
`headers.<header_mapping>` | no | string | The specific headers to send. (e.g. "User-Agent": "Kube namespace")
`no_cert_check` | no | bool | Whether to bypass the SSL certificate validation. Allowed values: `true` or `false`. Default: `true`
`query` | no | hash | A hash of querystring key/value pairs that will be add into the query parameter of every request
`request_content_type` | no | string | the request mime type i.e: `application/json`, `application/xml`. Default: "application/json"

#### Usage

~~~ ruby
endpoint do
  default_host "kube.example.com"
  default_scheme "https"
  # Notice the $namespace which coresponds to a plugin parameter.
  path "/api/v1/namespaces/$namespace"

  # Headers injected into every request
  headers do {
    "User-Agent": "Kube namespace"
  } end

  # Qery parameters injected into every request
  query do {
    "Version": "2017-03-31"
  } end

  # Check the SSL certificate validity
  no_cert_check false
end
~~~

### Type

The `type` declaration is one of the most important, powerful, and complex parts of a CAT plugin; it provides the information required to construct each resource the plugin exposes and specifies how to interact with those resources via actions. In many cases this declaration will be a one to one match with the API that the plugin is interacting with. It's also possible to construct a new resource comprised of one or more other resources that exposes a layer of abstraction above the raw resources.

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`href_templates` | no | comma separated strings | Sets of template used to match a response to the resource and to generate `href`s in the resulting resource collection. See [href_templates](ss_plugins.html#plugins-href-templates) for more information.
`provision` | yes | string | Specifies the Cloud Workflow `definition` that will be called to provision the resource.
`delete` | yes | string | Specifies the Cloud Workflow `definition` that will be called to delete the resource.
`output_path` | no | string | Defines a default [JMESPath](http://jmespath.org/) or [XMLPath](https://www.w3.org/TR/xpath/all) expression to be used on the response body to extract the [output](ss_plugins.html#plugin-type-field-details-output) fields.
`output` | no | object [see below](ss_plugins.html#plugin-type-field-details-output) | Defines a field which can be used in CAT outputs, other CAT resource fields, action `path` and `url` templates and fields that can be accessed in RCL. A `type` can have many `output`s.
`field` | no | object [see below](ss_plugins.html#plugin-type-field-details-field) | Declares a resource field used to create the resource. A `type` can have many `field`s.
`action` | no | object [see below](ss_plugins.html#plugin-type-field-details-action) | Defines a supported action for this resource type. A `type` can have many `action`s.
`link` | no | object [see below](ss_plugins.html#plugin-type-field-details-link) | Defines a link to other resources. A `type` can have many `link`s.

### Href templates

`href_templates` defines the templates used to build one or more hrefs from a response (JSON or XML). Each template may use JMESPath or XMLPath expressions delimited with the '{{' and '}}' strings. The template paths (either JMESPath or XMLPath) are matched against the response and the first template for which all path sections match is used to build the response resource collection.
Template href may be defined at plugin level or [type level](ss_plugins.html#plugins-type)

Plugin-level HREF templates will be applied to all types in the plugin. They also expose a special variable, `$type`, which will be populated with the name of the respective plugin type when it's used for matching. If a `type` does not define any HREF templates of its own then only those at the plugin level will be used. If a `type` defines its own HREF templates then those will be prioritized over any plugin-level HREF templates during matching (that is – plugin-level HREF templates will only be used if no type-level HREF templates match). If a parameter name type is defined in the plugin then that parameter value will be used instead of the type name.

## Plugin Type Field Details

### Output

Defines a field which can be used in CAT outputs, other CAT resource fields, and fields that can be accessed in RCL. Essentially variable storage for a resource.

By default the field is treated as the top level field after applying the [output_path](ss_plugins.html#plugins-type). An optional body_path can be specified to extract fields that are not in the top level of the response. E.g: "kernel_version" in the example below. Alternatively a an optional `header_name` (mutually exclusive with `body_path`) can be specified to extract fields from the response header. `header_name` should be the name of the header which contains the value. Finally a `type` can be specified when the response format is XML, it allows to disambiguate if the output should be an single value or an array.

**Note:** Must be delcared within a [Plugin Type](#plugins-type) declaration

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`body_path` | no | string | Defines a JMESPath relative to the output_path of an output field.
`header_name` | no | string | The name of the header that contains the value of the output to extract.
`type` | no | string | For XML response only. Disambiguate if an output from XML response should be an element or an array. Possible values: `simple_element`, `array`.

#### Usage

Given the following response json:

~~~ json
{
  "instance_details" : {
    "id": "resource_uid",
    "name": "resource_name",
    "memory": "2GB",
    "kernel": {
      "version": "3.10.84"
    }
  }
}
~~~

Use the following output declaration to capture the values.

~~~ ruby
output_path "instance_details"

output "id", "name", "memory"

output "kernel_version" do
  body_path "kernel.version"
end
~~~

### Field

Fields declare the resource fields, they are used in CAT to declare and validate resources and correspond to fields sent to create a resource. Not to be confused with an [output](ss_plugins.html#plugin-type-field-details-output).

**Note:** Must be declared within a [Plugin Type](#plugins-type) declaration

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`type` | yes | string | Defines the type of field. Possible values: `string`, `number`, `boolean`, `resource_array`, `resource`, `array`, `composite`, or `object`.
`required` | no | bool | Declares a resource field used to create the resource. Possible values `true` or `false`. Defaults to `false`.
`location` | no | string | Where this field is used. By default the field is used in the body of the request to create the resource. The location value can be one of: `body`, `header`, `path`, `query`.
`alias_for` | no | string | The actual name used when used in the specified location. By default the name attribute will be used. Since names are unique, if the name of a field in one location collides with the name another field in a different location, an alias can be used.

#### Usage

This example is of a required string that must be passed in the request. The CAT will fail to compile if this field is not passed to the resource.

~~~ ruby
field "name" do
  type "string"
  required true
end
~~~

This example sends a header "X-Api-Version: $api_version" in the request. Where $api_version is the value of the field.

~~~ ruby
field "api_version" do
  type "string"
  location "header"
  alias_for "X-Api-Version"
end
~~~

This example passes the field in the request URL. The request would go to "/api/accounts/$account/resources" where $account is the value of the field.

~~~ ruby

field "account" do
  type "string"
  location "path"
end
~~~

### Action

There are two categories of actions that can be executed on a resource / resource collection:

- CRUD actions (Create Read Update Delete) form the basis needed to create, retrieve, update and destroy resources. These actions exist on all resource types (although some may return errors in case the backend service doesn't actually support it). Each of these actions map to a predefined HTTP request scheme and content.
- create actions translate to HTTP POST requests to the resource collection URL. The request body contains the data needed to construct the resource(s).
- read actions translate to HTTP GET requests either to the resource collection URL (index) or to a specific resource URL (show).
- update actions translate to HTTP PUT requests to the specific resource URL. The request body contains the data needed to update the resource.
- delete actions translate to HTTP DELETE requests to the specific resource URL.
- Custom actions provide additional capabilities specific to the resource type (e.g. snapshot a volume, stop an instance etc.). There is no well defined HTTP format for such requests although the RightScale system defaults to POST requests to the specific resource URL appended with `/actions/<name of action>` (e.g /api/volumes/123/actions/snapshot). This defaults can be overridden by the plugin type declaration.

Actions may return nothing, JSON values or resource collections.

**Note:** Must be delcared within a [Plugin Type](#plugins-type) declaration

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`output_path` | no | string | Overrides the output_path of the resource type for the json returned by this action.
`path` | no | string | The URL path of the action.(Defaults to href (see href_template below) for show, update and destroy, collection href for create and list, and `/actions/<name>` for all others).
`type` | no | string | The `type` of resource returned by the action.
`verb` | no | string | The the HTTP verb (defaults to GET for list and show, PUT for update, DELETE for destroy and POST for everything else)

#### Usage

~~~ ruby
# Example were the target output items exist within the "droplets" subschema of the response json
action "list" do
  output_path "droplets"
end

# Example CRUD operations using default behavior
action "show", "create", "destroy"

# Example action that overrides the path and expects a resource type action returned
action "operate" do
  path "$href/actions"
  type "actions"
end

# Example action that sets the request verb to "GET" and overrides the path
action "kernels" do
  verb "GET"
  path "$href/kernels"
end
~~~

### Link

Links define a relationship using an href to other resources. Links can be used in RCL e.g. `@droplet.actions()`. A link specifies both the type of the resource(s) being linked to and the template used to build the path. Links may also specify an absolute URL instead of a path via the `url` field. The template used to build the path and the url may use any of the output fields for the resource by encapsulating the output name in curly brackets (e.g) `{{output_name}}`. The HREFs for the resources returned for the links are built using the HREF templates for the corresponding resource type.

Note that links are always retrieved via a GET request and must always return resource collections (might be empty, the point is no raw value).

#### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`path` | yes | string | The template used to build the path. It may use any of the `output` fields by prefixing it with `$`. ex: `$output_name`
`url` | no | string | Used to specify an absolute url and path to the resource instead of just the path for the resource.
`type` | yes | string | The `type` of the resource being linked to.
`output_path` | no | string | Overrides the default output_path for "action" type.

#### Usage

~~~ ruby
link "actions" do
  path "$href/actions"
  type "actions"
  output_path "actions"
end
~~~

## Resource Pools

Using the resources defined in a plugin requires the use of the resource pool declaration. This declaration instantiates a plugin by providing actual values to the parameters and an actual endpoint and associated auth (required only if a default host is not defined in the plugin declaration). The "auth" declaration allows specifying how requests sent to the service should be signed.

### Fields

Name | Required? | Type | Description
-----|-----------|------|-------------
`plugin` | no | string | The name of the plugin this resource pool instantiates. Corresponds to the plugin declaration of the plugin itself.
`parameter_values` | no | - | Each plugin parameter is listed here with it's value
`parameter_values.<parameter_name>` | no | string | One or many parameter name to value mappings. Syntax: <parameter_name> "value". See Usage.
`host` | no | string | (Optional) Overrides the default_host of the plugin endpoint.
`auth` | no | - | The authentication details for the resource pool. See [Authentication](#resource-pools-authentication) for detailed examples.

### Usage

The currently recommended form of resource pool authentication refers to credentials that are viewable in the
"Credentials" tab of the Governance portal (i.e. the Credentials Management UI). See [Authentication](#resource-pools-authentication) below for more details.
~~~ ruby
credentials "aws_cred" do
  schemes "aws", "aws_sts"
  label "AWS EC2 Plugin Credentials"
  description "This credential should have read access to AWS EC2 resources"
  tags "provider=aws"
end

resource_pool 'ec2_pool' do
  plugin $aws_ec2_example

  parameter_values do
    # note that CAT plugins currently only accept string parameters
    page_size $launch_page_size
    region $launch_region
  end

  auth $aws_cred
end
~~~

The following is an example of a Resource Pool using the legacy form of authentication, which provides the authentication type and secrets
as fields of the 'auth' declaration.
See [Legacy Authentication](#resource-pools-legacy-authentication) below for more details.
~~~ ruby
resource_pool "kube" do
  plugin "kube"

  parameter_values do
    namespace "us_east"
  end

  host "kube-east.example.com"

  auth "key", type: "api_key" do
    key cred("KUBE_US_EAST_API_TOKEN")
    format "Bearer $key"
    location "header"
  end
end
~~~

### Authentication

Authentication against any external APIs that a Resource Pool uses is handled using credentials entered in the Governance Portal or via the [Credentials Management API](https://reference.rightscale.com/cred-management/). To use Credentials with a Resource Pool, add a `credentials` declaration in the Cloud Application Template (CAT). This declaration specifies all the details needed to use credentials and will allow the user of the CAT to select the appropriate credentials when using the Resource Pool.

```ruby
credentials <name> do
  schemes <type1>, <type2>
  label <label>
  description <description>
  tags <tag filters>...
end
```

* `name` is the variable name for the credentials in the CAT language, which must follow the standard for ruby-style variable names. It is referenced by prefixing the variable name with a dollar sign ($).
* `label` is a short human readable label for the credential, which is shown when viewing and filtering the list of credentials in the UI.
* `description` is a longer description of what the credential is used for in the Resource Pool and is also shown to the user.
* `schemes` is the authentication `scheme` in the credentials service and must be one of `aws_sts`, `aws`, `basic`, `ntlm`, `api_key`, `jwt`, or `oauth2`, matching the API that the credential is used with. Multiple schemes can be listed if the credential and code work with multiple types. Only those credentials whose schemes match the credentials declared by tht CAT can be used to launch an application.
* `tags` is an optional field used to filter the credentials. It may contain tags in the form of `key=value`. By default, the Credentials Management UI use the tag key `provider` for credential matching purposes.

Each `credentials` declaration will require a separate selection from the user.

The following example will authenticate against an AWS API using either an `aws` or `aws_sts` scheme type and export a `$cred_aws` reference.

```ruby
credentials "cred_aws" do
  schemes "aws", "aws_sts"
  label "AWS Credential"
  description "This credential should have read/write access to AWS EC2 Instances"
  tags "provider=aws"
end
```

The following example will authenticate against an Azure API using either an `oauth2`  scheme type. Since there many be many APIs using the `oauth2` scheme, an optional tags declaration is added to this example. Credentials can be tagged with arbitrary key value pairs. In this case, this block is telling it to filter for credentials marked with "cloud=azure"

```ruby
credentials "cred_azure_compute" do
  schemes "oauth2",
  label "Azure compute credential"
  description "Enter a credential with read/write access to Microsoft.Compute resources."
  tags "provider=azure"
end
```

### Legacy Authentication

Legacy Authentication includes fields for secrets in the resource pool declaration, which is no longer considered best
practice. These credentials are statically defined at launch time so they do not get updated when the legacy credentials
from Cloud Management are updated. See [Authentication](#resource-pools-authentication) for the currently recommended approach.

The supported legacy authentication mechanisms are as follows.

#### Basic Authentication

~~~ ruby
auth "my_basic_auth", type: "basic" do
  # Basic auth username
  # Uses standard CAT field syntax
  username "user"
  # Basic auth password
  # Uses standard CAT field syntax
  password cred("PASSWORD")
end
~~~

#### API Key Authentication (header or querystring)

~~~ ruby
auth "my_API_key_auth", type: "api_key" do
  # API key value
  # Uses standard CAT field syntax
  key cred("API_KEY")
  # Location of the authorization, "header" or "query" - defaults to "header"
  location "header"
  # Name of either the authorization header key or the query parameter field (defaults to "Authorization")
  field "Authorization"
  # Type of authorization header, prefixes the key value (defaults to "Bearer")
  type "Bearer"
end
~~~

#### JWT Authentication

Using basic auth or an API key to retrieve the JWT, We will make a call to the `token_url` using either `api_key` or `basic` auth, we expect the token_url to return a 200 status, and the
following json formatted body:

~~~ json
{
  "access_token":  "2YotnFZFEjr1zCsicMWpAA",
  "expires_in":    3600,
  "refresh_token": "tGzv3JOkF0XG5Qx2TlKWIA",
}
~~~

Here the `access_token` field is required in the response and `expires_in` and `refresh_token` fields are optional.
JWT Code:

~~~ ruby
auth "my_JWT_auth", type: "jwt" do
  # API key used to retrieve JWT
  api_key $my_API_key_auth
  # - OR -
  # Basic auth used to retrieve JWT
  basic $my_basic_auth
  # URL used to retrieve JWT, request is a GET to that URL signed with either $my_basic_auth or $my_API_key_auth
  token_url https://example.com/token/
  # Location of the authorization, "header" or "query" - defaults to "header"
  location "header"
  # Name of either the JWT header or the query parameter field (defaults to "Authorization")
  field "Authorization"
  # Type of authorization header, prefixes the key value (defaults to "Bearer")
  type "Bearer"
  # Any additional headers to send with refresh request.
  additional_headers {
    "X-Account": "123"
  }
end
~~~

#### OAuth2 Authentication

OAuth2 supports the following grant types: refresh_token, client_credentials, and jwt_bearer.

##### refresh_token

In this method the `refresh_token` is sent to the `token_url` in exchange for an access token. The refresh_token must be retrieved separately. The token response must be in the following JSON structure:

~~~ json
{
  "access_token":  "2YotnFZFEjr1zCsicMWpAA",
  "expires_in":    3600,
  "refresh_token": "tGzv3JOkF0XG5Qx2TlKWIA"
}
~~~

Here the `access_token` field is required in the response and `expires_in` and `refresh_token` fields are optional.

~~~ ruby
auth "my_rs_auth", type: "oauth2" do
  # Refresh POST URL, request body is "grant_type=refresh_token&refresh_token=$token"
  token_url $oauth_url
  grant type: "refresh_token" do
    # OAuth2 refresh token value
    # Uses standard CAT field syntax
    token cred("RS_REFRESH_TOKEN")
    # Any additional headers to send with refresh request.
    additional_headers do {
      "X-Api-Version" => "1.5"
    } end
    # Basic auth used to refresh the token
    client  @my_basic_auth
    # list of scopes used to create access token
    scopes "gcs:read", "gcs:write"
  end
end
~~~

##### client_credentials

The client can request an access token using only its client credentials (or other supported means of authentication) when the client is requesting access to the protected resources under its
control, or those of another resource owner that have been previously arranged with the authorization server (the method of which is beyond the scope of this specification).

~~~ ruby
auth "azure_auth", type: "oauth2" do
  token_url "https://login.microsoftonline.com/TENANT_ID/oauth2/token"
  grant type: "client_credentials" do
    client_id cred("AZURE_APPLICATION_ID")
    client_secret cred("AZURE_APPLICATION_KEY")
    additional_params do {
      "resource" => "https://management.azure.com/"
    } end
  end
end
~~~

##### jwt_bearer

In this method, a JWT token is constructed with the provided options and signed with the `signing_key` and sent to the `token_url` to fetch an access token.

~~~ ruby
auth "my_google_auth", type: "oauth2" do
  token_url $oauth_url
  grant type: "jwt_bearer" do
    # The issuer of the JWT token
    iss cred("GC_ACCOUNT_EMAIL")
    # The audience of this JWT token
    aud "https://www.googleapis.com/oauth2/v4/token"
    # Any additional claims to be used in JWT
    additional_claims do {
      "scope" => "https://www.googleapis.com/auth/prediction"
    } end
    # The key used to sign the JWT token
    signing_key cred("GC_PRIVATE_KEY")
  end
end
~~~

#### AWS signature based Authentication

Service and region can be set to "inferred" to let the signer determine them automatically from the request URL, allowing a single auth definition to work across multiple AWS services and their regions.

~~~ ruby
auth "my_aws_auth", type: "aws" do
  # The AWS signature version. defaults to 4
  version 4
  # AWS Service for which request is signed, can use "inferred"
  service "ec2"
  # AWS region hosting service endpoint, can use "inferred"
  region "us-east-1"
  # The Access Key ID cred
  access_key cred("AWS_ACCESS_KEY")
  # The Secret Access Key cred
  secret_key cred("AWS_SECRET_KEY")
end
~~~

#### AWS STS signature based Authentication

Service and region can be set to "inferred" to let the signer determine them automatically from the request URL, allowing a single auth definition to work across multiple AWS services and their regions.

~~~ ruby
auth "my_aws_sts_auth", type: "aws_sts" do
  # The AWS signature version. defaults to 4
  version 4
  # AWS Service for which request is signed, can use "inferred"
  service "ec2"
  # AWS region hosting service endpoint, can use "inferred"
  region "us-east-1"
  # The Access Key ID cred
  access_key cred("AWS_ACCESS_KEY")
  # The Secret Access Key cred
  secret_key cred("AWS_SECRET_KEY")
  # Amazon Resource Name (ARN) of the role to assume
  role_arn "arn:aws:iam::031a1f6c8,:role/test-role"
  # Identifier for the assumed role session
  role_session_name "open_buckets_policy"
  # Restrictive IAM policy, mutually exclusive with policy_json, optional
  policy {Version: 2012-10-17...}
  # Restrictive IAM policy in JSON format, mutually exclusive with policy, optional
  policy_json "{Version:2012-10-17...}"
  # Unique identifier that might be required when assuming a role in another account, optional
  external_id "c4202e1830"
end
~~~

## Permissions Required

  Describes the privileges needed to design and publish plugin CATs. [Delegation] (/ss/guides/ss_permissions.html#cloudapp-permission-strategies-delegation) is used
