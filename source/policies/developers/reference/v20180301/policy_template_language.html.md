---
title: Policy Template Language
description: RightScale allows users to not only take advantage of our policies but also write their own based on their organizational needs. This page outlines the policy template language and how to write a new policy.
version_number: "20180301"
alias: [policies/reference/policy_template_language.html, policies/reference/v20180301/policy_template_language.html]
versions:
  - name: "20180301"
    link: /policies/reference/v20180301/policy_template_language.html
---

RightScale Policies provide a flexible solution for defining arbitrary policies that span across Cost, Security, Compliance, and Operational categories. Policies may analyze data exposed by the RightScale platform or by any other service. Policies can combine and validate data coming from multiple services. When a policy check fails an incident is created which may in turn trigger a sequence of actions. Actions may be automated and may take advantage of RightScale Cloud Workflow. This makes it possible for policies to trigger arbitrarily complex orchestration involving any service.

Policies are written in code making it possible to version, share and reuse parts of policies across multiple use cases. The policy template language is a simple DSL (Domain Specific Language) similar to the RightScale CAT (Cloud Application Template) language. Policy templates describe how to retrieve the data, how to validate it and what to do when a validation check fails.

Check out some [sample policies](/policies/getting_started/custom_policy.html#sample-policy-1) as well as the complete list of [RightScale policies](/policies/getting_started/policy_list.html).

## Syntax

A policy template consists of a sequence of definitions. Definitions may be simple definitions of the form:

``` text
<name> <term>
```

Where `<name>` is the name of the definition and `<term>` is a term, for example:

```ruby
short_description "Limit the total number of VMs running in a project."
```

Terms can be [literal values](#syntax-string-literals) like in the example above, [function calls](#syntax-functions), certain [reserved words](#reserved-words) or in some cases [references](#chaining-datasources) to other definitions.

Definitions may also be composite definitions of the form:

``` text
<name> <term> [, <property>: <string literal>] do
   <property> <term>
   <property> <term>
   …
end
```

Where `<property>` is the name of a definition property, for example:

```ruby
parameter "max_instances" do
   type "number"
   label "Maximum number of instances"
end
```

or

```ruby
resources "instances", type: "rs_cm.instances" do
   cloud_href href(@clouds)
   state "operational"
end
```

### Comments

Comments start with the character `#`. They may appear at the end of a line or on a new line:

```ruby
short_description "Limit number of VMs." # Note: only works on cloud X
# Comment on a new line
```

### Reserved Words

The Policy Template Language also defines a few reserved words that make it possible to retrieve contextual information or iterate over data collections. The list of complete reserved words and their usage is described in the [Reserved Word Reference](#reserved-word-reference). For example `rs_org_id` returns the ID of the RightScale organization.

### String Literals

A string literal begins and ends with a double or single-quote mark. Double-quoted string expressions are subject to backslash notation. A
single-quoted string expression isn't; except for \' and \\.

#### Backslash Notation

Also called escape characters, backslashes are used to insert special characters in a string.

Example:

```ruby
"this is a\ntwo line string"
"this string has \"quotes\" in it"
```

| Escape Sequence | Meaning                |
|-----------------+------------------------|
| \n              | newline                |
| \s              | space                  |
| \r              | carriage return        |
| \t              | tab                    |
| \"              | double quote character |
| \'              | single quote character |
| \\              | backslash              |

#### Multiline String Literals

Multi-line string literals can be defined with "here documents", where the delimiter can be any string:

```ruby
<<END
on the one ton temple bell
a moon-moth, folded into sleep,
sits still.
END
```

The syntax begins with `<<` and is followed immediately by the delimiter. To end the string, the delimiter appears alone on a line.

### Number Literals

A number literal can be a integer such as `5` or a floating point number such as `5.5`.

### Array Literals

Arrays are defined using square brackets and commas to separate the elements:

```ruby
["a", "b", "c"]
[1, 2, 3]
["a", [1, "b"]]
```

### Object Literals

Objects are defined using curly braces and colons to separate keys and values:

```ruby
{
   "a": 1,
   "b": "c",
   "d": [2, 3],
   "e": {
      "f": 4
   }
}
```

## Metadata

The first section of a policy template provides generic information about the policy such as its name, a short and long description as well as the policy severity and category:

```ruby
name "Instance Quota"
rs_pt_ver 20180301
type "policy"
short_description "Limit the total number of VMs running in a project."
# Optional metadata
default_frequency "daily"
long_description <<-EOF
The Instance Quota policy sends an email to developer@company.com when the
number of VMs running in the RightScale project exceeds 1,000.
EOF
severity "medium"
category "Cost"
tenancy "single"
info(
  "version": "1.1",
  "provider": "aws",
  "service": "ec2"
)
```

* `name` defines the policy template name. It must be unique in the project.
* `rs_pt_ver` indicates the policy template language version. The value must be
  `20180301`.
* `type` must be `"policy"`
* `short_description` provides a short description of what the policy does.

The following definitions are optional:

* `default_frequency` sets the interval between policy evaluations if another value is not selected by the person applying the policy. It must be one of `"15 minutes"` (default), `"hourly"`, `"daily"`, `"weekly"` or `"monthly"`.
* `long_description` is a long description of what the policy does.
* `severity` indicates the policy severity, it must be one of `"low"` (default),
  `"medium"`, `"high"` or `"critical"`.
* `category` is an arbitrary value used to group policies into categories, for
  example `"Cost"`, `"Compliance"` or `"Security"`.
* `info` specifies an arbitrary list of metadata attached to the policy and should be an mapping of string to string. For [Flexera-built policies](/policies/users/policy_list.html), the standard is to use the following metadata fields:
  * `version` - Version of the template, using semantic versioning. Updated every time a policy template is changed.
  * `provider` - An identifier for which provider the policy applies to, such as "AWS".
  * `service` - Where applicable, which service of the provider the policy applies to, such as "EC2"
* `tenancy` specifies whether this policy can be applied to more than one project at a time and how incidents are grouped together. It must be one of `"multi"`, or `"single"`. If a policy has a `credential` declaration in it, only `single` is supported and is the default if not specified. If a policy does not have such a declaration, then this defaults to `multi`. Generally speaking this should only be set manually in the case where the policy acts on organization-wide resources such as Optima APIs, in which case it should be set to `single`. Otherwise the default is sufficient and this can be omitted.

## Parameters

Parameters allow you to get input from end users that can be passed to your policy, used to make decisions on what to validate, and used in custom operation logic. A parameter declaration has a name, a type and other optional fields that let you define things like a default value, or a set of potential values.

Parameters can be referred to in a Policy Template using the syntax `$<parameter_name>` where `parameter_name` is the string following the `parameter` keyword.

Here is an example of a parameter declaration defining a "tags" parameter which can take a list of tags to be used in the policy template.

~~~ ruby
parameter "tags" do
  type "list"
  label "Tags"
  description "A list of tags for the policy"
end
~~~

### Fields

The available fields are:

| Name                          | Required? | Type    | Description                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ----------------------------- | --------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`                        | yes       | string  | Defines whether the parameter is a string, a number or a list of values. The possible values for this field are `string`, and `number` and `list`.                                                                                                                                                                                                                                                                                      |
| `label`                       | yes       | string  | The display name shown to the user. Must not be whitespace-only.                                                                                                                                                                                                                                                                                                                                                                        |
| `category`                    | no        | string  | An optional category used to group parameters in the UI.                                                                                                                                                                                                                                                                                                                                                                                |
| `description`                 | no        | string  | A description shown in the launch UI                                                                                                                                                                                                                                                                                                                                                                                                    |
| `default`                     | no        |         | Default value for parameter if none is specified. Note this must meet the requirements of the other fields (such as max_length, allowed pattern, etc).                                                                                                                                                                                                                                                                                  |
| `no_echo`                     | no        | boolean | Whether the value of the parameter should be hidden in UIs and API responses. The possible values for this field are `true` and `false` (default).                                                                                                                                                                                                                                                                                      |
| `allowed_values`              | no        | array   | A comma-separated list of allowed values. Not valid when `allowed_pattern` is specified.                                                                                                                                                                                                                                                                                                                                                |
| `min_length` and `max_length` | no        | number  | The minimum and maximum number of characters in the parameter value. Only valid when `type` is one of `string` or `list`.                                                                                                                                                                                                                                                                                                               |
| `min_value` and `max_value`   | no        | number  | The smallest and largest numeric value allowed for the parameter. Only valid when `type` is `number`.                                                                                                                                                                                                                                                                                                                                   |
| `allowed_pattern`             | no        | regexp  | Not valid when 'allowed_values' is specified. Note: the Ruby Regexp engine (a PCRE engine) is used to process and validate Regexp values, but there are a few unsupported features. These include modifiers other than 'm' and 'i', modifier groups (such as `/(?mi)example/`), and modifier spans (such as `/(?mi:example)/`). A helpful tool for developing PCRE regular expressions [can be found here](https://regex101.com/#pcre). |
| `constraint_description`      | no        | string  | Message displayed when any of the constraint is violated. The system generates default error messages, this field allows overriding these to provide a clearer message to the user.                                                                                                                                                                                                                                                     |

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
  allowed_pattern /[a-z0-9]+[a-z0-9\.-]*/
  constraint_description <<-EOS
    Bucket names must be at least 3 and no more than 63 characters long. Bucket names must be a series of one or more labels. Adjacent labels are separated by a single period (.). Bucket names can contain lowercase letters, numbers, and dashes. Each label must start and end with a lowercase letter or a number. Bucket names must not be formatted as an IP address (e.g., 192.168.5.4).
    EOS
end
~~~

Parameters can be used in other declarations using the `$` operator, for example:

~~~ ruby
parameter "tags" do
  type "list"
  label "A List of Tags"
end

# find all instances with the tags from the $tags parameter
resource "instances", type: 'rs_cm.instances' do
  tags any($tags)
end

# pass the $tags parameter to the Cloud Work Flow
define get_code($tags) do
  # use the $tags parameter
  ...
end
~~~

In the example above, the "instances" resource declaration uses the value associated with the parameter "tags" to initialize the instances resource tag field.

## Permissions

Permission declarations validate that the user applying the policy has the required privileges to successfully run the policy.
The declarations must include the privileges required to retrieve the data as well as the privileges required to run the policy actions.
Permission declarations are not required to apply the policy or run the policy actions, however, they are recommended.
The users own privileges are verified against the permission declarations when they attempt to apply the policy.

Each permission declaration can list multiple required privileges. The set is defined by providing a list of resource types and a list of actions that the policy needs to perform on these resources:

```ruby
permission do
   label "List Instances"
   resources "rs_cm.instances"
   actions "rs_cm.index"
end

permission do
   label "List and delete servers and instances"
   resources "rs_cm.servers", "rs_cm.instances"
   actions "rs_cm.index", "rs_cm.destroy"
end
```

The complete set of resources and actions as well as the mapping between privileges and roles is listed in the
[Permission Reference](permissions.html) section.

## Retrieving Data

The first step performed when a policy is evaluated is to retrieve the data that needs to be validated. There are two ways to retrieve data from a policy template:

* *Resources* make it possible to list resources using the RightScale APIs.
* *Datasources* make it possible to retrieve data from any arbitrary service.

Datasources can also be used to further process data retrieved from either resources or other datasources as described in [Chaining Datasources](#chaining-datasources).

### Listing Resources

The `resources` definition identifies a resource type and an optional set of filters used to list resources:

```ruby
resources <name>, type: <resource type> do
   filter do
      <filter> <filter comparator> <filter value>
      <filter> <filter comparator> <filter value>
      ...
   end
   <property> <property value>
   <property> <property value>
   ...
end
```

* `name` defines the resource name and must be unique. It can be referenced using @<name> elsewhere in the code.
* `resource type` is the type of resource.
* `filter` is the API field to filter on, such as "state". If multiple filters are specified it will AND together the results. Only resources which satisfy all the filters will be returned.
* `filter comparator` is optional and must be either `ne:` or `eq:`. If not specified, it defaults to `eq:`.
* `filter value` is either a term or array of terms. **Caution**: Only ever specify an array of terms with `ne:` as the comparator. If you specify it with `eq:` it will do a logical AND and try and set the filter be equal to ALL the values passed in, which will return no results.
* `property` is a property of the resource such as `cloud_href` or `view`.
* `property value` is value of the property.

The complete list of supported resource types, filters, and properties is described in the [Resource Reference](#resource-reference).

This example filters returns active Windows instances on AWS clouds. The first resources block filters upon cloud_type to only return AWS regions. The filter comparator is left off and defaults to `eq:`. The second resources block filters upon the os_platform and [state of the instances](/cm/management_guide/active_vs._inactive_servers.html) to get active instances. It can be referenced later in the policy as `@instances`.

```ruby
resources "aws_regions", type: "rs_cm.clouds" do
  filter do
    cloud_type "amazon"
  end
end

resources "instances", type: "rs_cm.instances" do
  iterate @aws_regions
  cloud_href href(iter_item)
  filter do
    os_platform "windows"
    state ne: ["stopped", "provisioned", "terminated"]
  end
end
```


### Including tags

You can query for resources by tag using `tags` field in your resource. You can also use the `all`, `any`, `none` methods to expand your search with tags. Only one tag field is supported per resource.

```ruby
resources "instances", type: "rs_cm.instances" do
  iterate @aws_regions
  cloud_href href(iter_item)
  tags "ns:name=*"
end

resources "volumes", type: "rs_cm.volumes" do
  iterate @aws_regions
  cloud_href href(iter_item)
  tags any(["ns:name=*","foo:bar=hurray"])
end

# include fields in your datasource
datasource "instances" do
  iterate @instances
  field "href",        href(iter_item)
  field "id",          val(iter_item,'resource_uid')
  field "name",        val(iter_item,'name')
  field "state",       val(iter_item,'state')
  field "type",        "instances"
  field "tags",        val(iter_item,'tags')
end
```
Additional tag filters examples.
```ruby
tags "ns:name=*" # Filter by namespace and key
tags "ns:*"      # Filter by namespace only
tags "*"         # Return any resource with a tag
tags any(["ns:name=*","foo:bar=hurray"]) # Resource must include any tag in array.
tags all(["ns:name=*","foo:bar=hurray"]) # Resource must include all tags in array.
tags none(["ns:name=*","foo:bar=hurray"]) # Resource must not include any tags in array
```

### API Data with Datasources

There are three forms of `datasource` definitions. The first one, discussed here makes it possible to retrieve data from HTTP APIs. The second one, described in the [next section](#processing-datasources-with-javascript) makes it possible to use JavaScript to process existing data and the last one described in [Chaining Datasources](#chaining-datasources) makes it possible to derive a datasource from existing data.

### Authorization

Authorization against any external APIs that a Policy uses is handled using credentials entered in the [credentials page](/policies/users/guides/credential_management.html) of Policy Manager. To use credentials to make API calls, add a `credentials` declaration in the policy template. This declaration specifies all the details needed to use credentials and will allow the user of the policy to select the appropriate credential when applying the policy.

```ruby
credentials <name> do
  schemes <type1>, <type2>
  label <label>
  description <description>
  tags <tag filters>...
end
```

* `name` is the name in the policy template language. The credential is referenceable by this name in `datasource` and `define` declarations.
* `schemes` is the authorization `scheme` in the credentials service and must be one of `aws_sts`, `aws`, `basic`, `ntlm`, `api_key`, `jwt`, or `oauth2`, matching the API that the credential is used with. Multiple schemes can be listed if the credential and code work with multiple types. When a user selects a credential on the [Apply Policy screen](/policies/users/guides/apply_policy.html), they will only be able to select credentials that are of one of the specified schemes.
* `label` is a short human readable label for the credential -- it is shown to the user on the [Apply Policy screen](/policies/users/guides/apply_policy.html)
* `description` is a longer description of what the credential is used for in the policy and is also shown to the user on the [Apply Policy screen](/policies/users/guides/apply_policy.html)
* `tags` is an optional field used to filter the credentials that are shown to a user when applying a policy. It may contain tags in the form of `key=value`. By default, the credential management UI and all Flexera-built policies use the tag key `provider` for credential matching purposes.

Each `credentials` declaration will require a separate selection from the user. Note: older Policies may use define authorization inline using the [auth declaration](/policies/reference/inline_auth.html), but this approach is no longer considered best practice.

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

It is highly recommended to provide a "provider" tag filter and then set the "provider" field when entering credentials into the dashboard so policy managers can easily find credentials when applying the authored policy.


### Pagination

If results from a custom datasource are paginated, you must define a pagination block above your datasource that describes how to extract the next page token from a response and where to insert the token into subsequent queries.

```text
pagination <name> do
  get_page_marker do
    body_path <path term>
    header <header name>
  end
  set_page_marker do
    query <query param name>
    header <header name>
    body_field <body field name>
    uri <true|false>
  end
```

* `<name>` is the name of the paginator. The name can be referred to in the `pagination` field of datasource request blocks with a `$` in front.
* `<path term>` is a call to either the `jmes_path`, `jq`, or `xpath` method describing how to extract the page token from the response body (for backward compatibility, it can also be a string which will be interpreted as either JMESPath for JSON encoding or XPath for XML encoding).
* `<header name>` is the name of the http header containing the page token.
* `<query param name>` is the name of the query string parameter to set.
* `<body field name>` is the name of the field in the body to set.
* `uri` should be set to true if the page token marker is a full URL, such as a `nextLink` attribute returned by Azure ARM services.

For get_page_marker exactly one of `body_path` or `header` must be set. For set_page_marker exactly one of `query`, `header`, `body_field`, or `uri` must be set.

Many AWS API requests contain a variable in the response body called "PageToken". This variable should be set as a HTTP query parameter `NextToken` to subsequent requests. AWS supports both XML and JSON encoding. The datasource definition has an `encoding` of `xml` below so an XPath expression is used for the body_path.
```ruby
pagination "aws_pagination_xml" do
  get_page_marker do
    body_path xpath(response, "//PageToken")
  end
  set_page_marker do
    query "NextToken"
  end
end
```

This is the same paginator except for JSON data.

```ruby
pagination "aws_pagination_json" do
  get_page_marker do
    body_path jmes_path(response, "PageToken")
  end
  set_page_marker do
    query "NextToken"
  end
end
```

The following service has a X-Page-Token header that it both returns and expects:

```ruby
pagination "my_service" do
  get_page_marker do
    header "X-Page-Token"
  end
  set_page_marker do
    header "X-Page-Token"
  end
end
```

The following service contains a `nextLink` parameter in the body that is a full URL to the next page of results. It is assumed that the datasource will specify we want JSON encoding.

```ruby
pagination "azure_arm_pagination_json" do
  get_page_marker do
    body_path jmes_path(response, "nextLink")
  end
  set_page_marker do
    uri true
  end
end
```

The following service contains a `Link` header that includes the full URL to the next page of results.

```ruby
pagination "github_api" do
  get_page_marker do
    header "Link"
  end
  set_page_marker do
    uri true
  end
end
```

The following service is an example of [an AWS service]() where the `NextPageToken` is retrieved and set in the body.

```ruby
pagination "aws_body_pagination" do
  get_page_marker do
    body_path jmes_path(response, "NextPageToken")
  end
  set_page_marker do
    body_field "NextPageToken"
  end
end
```

Some APIs use page numbers rather than a token, this is a case where the power of `jq` comes in handy as it can express mathematical concepts. Here is an example where the JSON body contains the current page number, the number of items per page, and the total number of items:

```json
{
  "paging": {
    "pageIndex": 1,
    "pageSize": 100,
    "total": 381
  },
  ...
}
```

In this case, you would define the following pagination with a `jq` expression which will return the next page number unless we have reached the last page:

```ruby
pagination "sonarqube_pagination" do
  get_page_marker do
    body_path jq(response, "if .paging.pageIndex * .paging.pageSize < .paging.total then .paging.pageIndex + 1 else null end")
  end
  set_page_marker do
    query "p"
  end
end
```

There are also APIs that use page numbers without specifying the page number in the body. In these cases, you can take advantage of the `$marker` variable which is passed in when a `jq` expression is evaluated for a pagination. This `$marker` variable contains the string value of the previous pagination marker (for the first page, the previous page marker is an empty string: `""`). Here is an example of the JSON that one of these APIs might have:

```json
{
  "items": [
    ...
  ]
}
```

Here is a pagination that will work with this API given that there are 500 items per page:

```ruby
pagination "500_items_per_page_pagination" do
  get_page_marker do
    body_path jq(response, "if .items | length < 500 then null else if $marker != "" then $marker | tonumber + 1 else 2 end end")
  end
end
```

Just like the previous pagination, this one also uses `null` to signify that we have reached the last page.

### Request

The syntax of a datasource that retrieved data from an HTTP API is:

``` text
datasource <name> do
   request do
      auth $<credentials reference OR auth definition>
      pagination $<pagination definition>
      host <host>
      verb ["GET"|"POST"]     # defaults to "GET"
      scheme ["http"|"https"] # defaults to "https"
      path <path>
      ignore_status [<http status code>, <http status code>...]
      query <query string name>, <query string value>
      query <query string name>, <query string value>
      ...
      header <header name>, <header value>
      header <header name>, <header value>
      ...
      body_field <body field name>, <body field value>
      body_field <body field name>, <body field value>
      ...
      body <body value>
   end
   result do
      encoding ["json"|"xml"|"text"]
      [collect jmes_path(response, <jmes_path>) do]
      [collect jq(response, <jq>) do]
      [collect xpath(response, <xpath>) do]
      field <field name>, <term>
      field <field name>, <term>
      ...
      [end]
   end
end
```

Where:

* `<name>` is the name of the datasource.
* `<auth definition>` is the name of the credentials reference or auth definition that describes how to authenticate requests made to the API.
* `<pagination definition>` is the name of the pagination definition that describes how to iterate through the response pages if any.
* `<host>` is the API hostname.
* `<verb>` is the HTTP request method and defaults to `"GET"`.
* `<path>` is the HTTP path
* `<ignore_status>` are http status codes to ignore failure on. Normally any status code other than 200-299 will cause the policy to stop evaluation and return a failure. Supply a list of values or a list parameter such as [403, 404] to cause the policy to treat these calls as an empty dataset and continue running.
* `<query string name>` and `<query string value>` describe the request query string elements if any.
* `<header name>` and `<header value>` describe any additional headers you wish to send with the API request.
* `<body field name>` and `<body field value>` describe the body JSON object fields if any. When a `body_field` is specified, `body` may not be specified as well.
* `<body value>` describes the entire body. When `body` is specified, no `body_field`s may be specified as well.

> Note: only JSON encoding is supported in the REQUEST body at this time when using `body_field`; however, other encodings can be sent using `body`.

### Result

The `result` property details how to parse the HTTP response to produce the resulting data. The properties are:

* `encoding`: specifies the response encoding, must be `"json"`, `"xml"`, or `"text"`. With the `"text"` encoding the body of the response will be returned as a string or an array of strings if multiple requests are made (either in the case of iteration or pagination).
* `field`: identifies a field in the resulting data. The provided term is evaluated to initialize the field value. Typically the term is either the `jmes_path`, `jq`, or `xpath` function.

`result` may also make use of `collect` to iterate over the response elements. `collect` accepts a term and a block. The term must be `jmes_path`, `jq`, or `xpath`. The term must return an array which `collect` iterates over. Each element of the array can then be used to define the data fields. The current element is accessed using the `col_item` reserved word as shown in the example below.

```ruby
datasource "volumes_us_east" do
  request do
    auth                      $cred_aws_us_east_1
    pagination                $aws_pagination_xml
    host                      "ec2.amazonaws.com"
    query "Action",           "DescribeVolumes"
    query "Filter.1.Name",    "encrypted"
    query "Filter.1.Value.1", "false"
    header "User-Agent" "My-app"
  end
  result do
    encoding "xml"
    collect xpath(response, "/DescribeVolumesResponse/volumeSet/item") do
      field "id", xpath(col_item, "volumeId")
      field "region", "us-east-1"
      field "size", xpath(col_item, "size")
      field "type", xpath(col_item, "volumeType")
      field "tag_set" do
        collect xpath(item, "tagSet") do
          field "key", xpath(col_item, "key")
          field "value", xpath(col_item, "value")
        end
      end
    end
  end
end
```

## Processing Datasources With JavaScript

Datasources may use JavaScript to combine and transform data from one or more datasources to create a new datasource. The syntax used in this case is:

``` text
datasource <name> do
   run_script $<script>[, <term>]*
end
```

Where `<script>` is the name of script definition and the terms are parameters or datasources given to the script for execution. The script result defines the data returned by the datasource. Terms can be any type (including other datasources, which will show up as arrays of JavaScript Objects).

!!info*Note:* The JavaScript Datasource supports the JavaScript ECMAScript 5/ES 5 Specification. Please review the [reference](https://www.ecma-international.org/ecma-262/5.1/) when writing a JavaScript Datasource.

!!info*Note:* The JavaScript Datasource includes the [underscore library](https://underscorejs.org/). This library includes some useful functions to assist in managing the data objects passed into the datasource. Version 1.4.4 of the library is currently included.

Scripts are defined using script definitions with the following syntax:

``` text
script <name>, type: "javascript" do
  parameters <string literal>[, <string literal]*
  result <string literal>
  code <string literal>
end
```

`parameters` is the list of parameters the script accepts. The parameters will automatically be set as JavaScript variables at the start of script execution.

`result` identifies the name of the JavaScript variable used to extract the data returned by the script. `result` is required.

`code` contains the actual JavaScript code. `code` is required.

Example:

```ruby
datasource "merge_instances" do
   run_script $merge, $instances_us_east, $instances_us_west
end

script "merge", type: "javascript" do
  parameters "instances_us_east", "instances_us_west"
  result "res"
  code <<-EOS
  res = []
  // Concatenate the different arrays of instances
  var instances = []
  instances = instances_us_east.concat(instances_us_west)

  // Build the array of json objects containing the instance information as described above.
  var server_json = {}
  for (var i = 0; i < instances.length; i++) {
    var instance = instances[i]

    var name = instance["name"]
    var state = instance["state"]
    var href = instance["href"]
    var tags = instance['tags']

    // build the json object
    server_json = { "name": name, "href": href, "state": state, "tags": tags }

    // push object onto the output array
    res.push(server_json)
  }
  EOS
end
```

For more complicated examples of JavaScript datasources including scripts that combine together multiple datasources see [policy examples](/policies/getting_started/policy_list.html) such as the [open ports policy](https://github.com/rightscale/policy_templates/blob/master/security/security_groups/high_open_ports/open_ports.pt)

## Chaining Datasources

A Datasource describes one type of API call. However, sometimes multiple levels of requests need to be made if you have a resource that is a subresource to another resource. For example, a policy validating that there are no publicly accessible S3 buckets must first fetch all the bucket names then fetch the ACLs for each bucket. In this case a `datasource` definition can reference a `resources` definition or another `datasource` definition. The syntax used to refer to a `resources` definition is `@<resource definition name>` and the syntax used to refer to another datasource definition is `$<datasource definition name>`. For example:

```ruby
resources "clouds", type: "rs_cm.clouds"

resources "instances", type: "rs_cm.instances" do
   iterate @clouds            # iterate through the data retrieved by the
                              # "clouds" resource definition.

   cloud_href href(iter_item) # iter_item returns the cloud data currently
                              #  being iterated on.
end
```

>Note: `iterate` may appear only once in a given datasource definition.

As shown in the example above references are typically used together with the `iterate` reserved word to iterate over the elements of the data. If the data is not an array then `iterate` takes care of wrapping it with a single element array.

References may also be used directly as argument of other functions such as `val`, `href`, `size` or `select`.

Finally, references can be used when defining the parameters given to `run_script`:

```ruby
datasource "permissions" do
   run_script "get_permissions", @instances, @security_groups
end
```

<a name="describing-the-policy-conditions" /></a>

## Describing the Policy Conditions

Now that we know how to retrieve the data the next step consists of actually writing the conditions they must validate. This is done in the `policy`
definition. There can be only one such definition in a given policy template.

A policy definition consists of a list of validations. Each validation may in turn describe multiple checks. A validation also defines one or more
[escalations](#escalations) that trigger when a check fails and [resolutions](#resolutions) that trigger when an underlying issue is fixed. Finally a validation also provides a default summary and details [text templates](#incident-message-and-email-templates) used to render the incident message.

Each `validate` or `validate_each` is run independently and will generate either 0 or 1 incidents.

The syntax for a policy definition is:

```text
policy <string literal> do
  validate[_each] $<datasource>|@<resources> do
    summary_template <string literal>
    detail_template <string literal>
    hash_include <field_name>, <field_name>, ...
    hash_exclude <field_name>, <field_name>, ...
    escalate $<escalation>
    escalate $<escalation>
    resolve $<resolution>
    resolve $<resolution>
    ...
    check <term>
    check <term>
    ...
    export <path expression> do
      resource_level <boolean>
      field <name> do
        label <string literal>
        format <string literal>
        path <path expression>
      end
      field ...
    end
  end
  validate...
end
```

Where:

* Each validation starts with `validate` or `validate_each`.
  * `validate` applies the checks on the given datasource or resources as a whole.
  * `validate_each` iterates over the given datasource or resources (which must be an array or is wrapped into a single element array) and applies the checks on each element.
* `summary_template` provides a text template that gets applied to the escalation data to render the incident message summary.
* `detail_template` provides a text template that gets applied to the escalation data to render the incident message details. It will be displayed above the export table, if one is specified.
* `hash_include` is array of fields in the escalation data to check in determining whether data has changed and thus actions should be re-run. By default, all fields are checked so if any value changes at all, all actions are run again. This includes emails and cloud workflows. In general, this field does not have to be specified. The general exception is when you have a value such as a timestamp that changes constantly.
* `hash_exclude` is an array of fields in the escalation data to exclude in determining whether data hash changed. This field is mutually exclusive with hash_include.
* `escalate` indicates an [escalation](#escalations) to trigger when a check fails.
* `resolve` indicates an [resolution](#resolution) to trigger when all existing violations are resolved.
* `check` identifies a term that must return anything BUT `false`, `0`, an empty string, an empty array or an empty object. If the term returns one of these values then the check fails, an incident is created and any associated escalation triggers.
* `export` controls whether or not a table of resources is exported for the incident.
  * `path expression` is a string literal corresponding to a [jmes_path](https://jmespath.org/) expression acting upon the violation data. The jmespath can be used to extract a table of resources if the resources exist as a subpath in data. This field is optional.
  * `resource_level` is a boolean stating if the data being exported is resource level data or not. If the data is resource level, available actions can be run on a select group of resources or all of them.
  * `field` specifies a field in the data, such as id. Each field corresponds to a column in the data table. Fields values should be simple types such as integers, strings, booleans, or arrays of simple values.
    * `name` is the object field key/name in the violation `data` row
    * `label` is a human readable label associated with the name and shows up as the header for the column. If omitted, `name` will be used.
    * `format` controls formatting for the column. Currently "left", "center", and "right" keywords are supported. By default, columns are left formatted.
    * `path` is a string literal corresponding to a [jmes_path](https://jmespath.org/) expression acting upon each resource. The jmespath can be used to extract a field from a embedded data structure or to rename a field. By default, `name` is used.

The policy engine runs each check in order and stops when a check "fails". A check fails if the corresponding term returns `false`, `0`, an empty string, an empty array or an empty object. In the case of `validate_each` the policy engine applies that algorithm for each element of the datasource or resources.

Each time a check fails the corresponding data is added to the *violation data*. In the case of `validate` this can only happen once and thus the escalation data ends up being the validated datasource or resources. In the case of `validate_each` this means that only the elements that fail a check are added to the escalation data.

The violation data is exported as a table in the incident view page.

Example:

Assume that the `$reservations` datasource has data like:

~~~ json
[
  {
    "account": {
      "id": 1,
      "name": "my account"
    },
    "region": "us-west-1",
    "instance_type": "m1.small",
    "instance_count": 10,
    "end_time": "2020-01-01 01:02:03",
    "time_left": 10200
  },
  ...
]
~~~

```ruby
policy "ri_expiration" do
  validate_each $reservations do
    summary_template "Reserved instances are nearing expiration."
    detail_template <<-EOS
Found {{ len data }} expired reservations in account id {{ rs_project_id }}
EOS
    export do
      field "account_name" do
        label "Account Name"
        path "account.name"
      end
      field "account_id" do
        label "Account ID"
        path "account.id"
      end
      field "region" do
        label "Region"
      end
      field "instance_type" do
        label "Instance Type"
      end
      field "instance_count" do
        label "Instance Count"
      end
      field "end_time" do
        label "End Time"
      end
      field "time_left" do
        label "Time Left In Seconds"
        format "right"
      end
    end
    hash_include "id", "end_time"
    escalate $alert
    check gt(dec(to_d(val(item, "end_time")), now), 3*24*3600))
  end
end
```

In the example above the policy defines a single validation with a single check. The check returns a boolean value which is false when the duration between a reserved instance expiration data and now is less than 3 days. In this case the `alert` escalation triggers. The violation data consists of an array that contains all the reservations that are expiring in less than 3 days.

A table of information is defined to display in the mail as well as display on the incident show page in the dashboard.

### Triggering Actions

Actions are run anytime the underlying *violation data* changes. By default, all  fields are used in determining whether the data changes. In the case above, the time_left field will be continually changing and causing actions like email to retrigger. `hash_include` and `hash_exclude` can be used to modify this behavior by excluding certain fields form this calculation. By supplying "id" and "end_time" to the hash_include method, we ensure that we only get new alerts when one of these two values is changed. We could have also achieved the same ends by doing `hash_exclude "time_left"` as well -- all other fields in the datasource be relatively stable.

Only top-level fields will be considered for `hash_include` and `hash_exclude`. If you have a nested structure such as:
~~~ json
[
  {
    "id": "abc",
    "config": {
      "foo": "bar",
      "baz": "biz"
    }
  }
]
~~~
Then you may specify `hash_include "config"` to detect any changes in config but not individual fields within config itself. If you wish to hash only a specific field within config such as config.foo, then use a JavaScript based `script` block to transform the nested fields into top-level fields first.


## Escalations

Escalation definitions describe a sequence of action items to be taken when a policy fails to validate. Action items are run in order and the escalation will run until all actions are complete or until an error is encountered running one of the action items. Action items are describe below. Action items may appear any number of times in any order, except when noted.

Syntax:

```ruby
escalation <name> do
  automatic <term>
  label <string literal>
  description <string literal>
  parameter <parameter definition 1>
  parameter <parameter definition 2>
  parameter ...
  <action item 1>
  <action item 2>
  <action item 3>
  <action item ...>
end
```
* `name` is the name of the escalation. It may be referenced in validate and validate_each blocks by `escalate $<name>`.
* `label` gives a human readable label for the escalation.
* `description` is optional and should give a description of what will happen when the action is run.
* `automatic` controls whether the escalation is automatically run when an incident is generated, or is manually run. Automatic can be true or false, or a function that evaluates to true or false. If unspecified, it defaults to true for backwards compatibility. Functions used can operate on [parameter](#parameters) to the applied policy in order to make whether actions are automatically run configurable.
* `parameter` can appear any number of times. parameters are optional parameters to inject into the request approval. They can be referenced by subsequent actions such as Cloud Workflows or emails within the same escalation. See the [Parameters](#parameters) section for more information about defining parameters.

### Action Items

#### Email
`email` causes an email to be sent to the given address or addresses.

```ruby
  email <addresses> do
    subject_template <subject template>
    body_template <body template>
  end
```

* `addresses` can be a string, an array of strings corresponding to email addresses. It can also be [parameter](#parameters) or function which evaluates to a string or array of strings.
* `subject template` must be a [go template](#incident-message-and-email-templates) that is evaluated to be the email subject line. If no subject template is provided, the incident summary is used.
* `body template` must be a [go template](#incident-message-and-email-templates) that is evaluated to be the email body. If no body template is provided, the incident detail is used.


#### Request Approval
`request_approval` creates an approval request, causing the escalation to pause and wait for manual input. The manual input can either be an approval or denial. If its an approval, actions after the request approval will be taken. If its a denial, no further actions will be taken. When applying a policy, policy managers can choose to skip all approvals in the policy using the "Skip Approvals" option
```ruby
  request_approval do
    label <string literal>
    description <string literal>
    parameter <parameter definition 1>
    parameter <parameter definition 2>
    parameter ...
  end
```
* `label` gives a human readable label for the request approval.
* `description` is optional and should give a description of what will happen when the action is approved.
* `parameters` are optional parameters to inject into the request approval. They can be referenced by subsequent cloud workflows or emails within the same escalation. See the [Parameters](#parameters) section for more information.

#### Cloud Workflow
`run` launches a [Cloud Workflow](/ss/reference/rcl/v2/index.html)
using the given RCL definition. The RCL definition may be given parameters
specified in a comma separated list. Parameters may be references or any of
the applicable functions.

```ruby
   run <rcl definition name>[, <parameter>]*
```

* `parameter` can be any term. It may be a reference to a datasource, a parameter, a literal value of any type, a function, or a reserved keyword such as `data`.

##### Cloud Workflow variables

Besides parameters passed explicitly in the `define` declaration, a handful of variables are available automatically:

| Variable    | Type                  | Value                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------- | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@@account` | Integer               | The RightScale project you're currently running in, i.e. `60073`                                                                                                                                                                                                                                                                                                                                         |
| `$$cred_*`  | Credentials reference | Any `credentials` or `auth` declaration is exported based upon name. For example if you have a declaration `credentials "cred_azure" do...` it will be available for signing http_* requests as `$$cred_azure`. Note this differs slightly from the reference name in `datasource` declarations where the reference name would be `$cred_azure`. For an example, see [custom policy](custom_policy.html) |

### Examples

Here is an example employing all previously described actions. It does not run automatically. It first optionally sends an email to a third party asking them to look at the approval request that will be created. If the approval request is approved, a Cloud Workflow is run in order to delete the volumes.

```ruby
# RCL used to delete volumes using Cloud Management.
define run_delete_volumes($data)  do
  # loop through each data item
  foreach $volume in $data do
    # get the volume resource
    @volume = rs_cm.get(href: $volume['href'])
    #delete the volume
    @volume.delete
  end
end

escalation "delete_volumes_with_approval" do
  automatic false
  label "Deleted Volumes"
  description "Delete the selected volumes"
  parameter "param_email" do
    type "string"
    label "Person to notify of action"
    description "If this is not-empty, a notification email will be sent to the following address."
  end
  email $param_email do
    subject_template "Approval request: delete unencrypted volumes found in project {{ rs_project_name }}"
    body_template <<-EOS
Unencrypted Volumes
The following volumes are tagged with one of the tags shown below and are unencrypted:
{{ range $index, $tag := parameters.enforced_tags }}{{ if $index }}, {{ end }}{{ $tag }}{{ end }}
{{ range data }}
| Region       | Volume ID | Volume Tags |
| ------------ | --------- | ----------- |
| {{.region }} | {{.id}}   | {{.tag_set}} |
{{ end }}

We would like your approval to delete the following volumes, please approve or deny this request.

[JIRA Ticket]({{ parameters.jira_url }}/{{ data.jira_ticket_id }})

EOS
  request_approval do
    label "Delete volumes"
    description "Approving this will delete the listed volumes."
  end
  run "run_delete_volumes", data, $param_top_level, rs_project_id
end

```


## Resolutions

Resolutions definitions describe a sequence of action items to be taken when a failing policy is resolved. A policy is resolved when the underlying checks which caused the policy to go into a failed state have been been corrected, either by [escalation](#escalations) actions or by manual intervention. Resolutions may not happen as soon as the condition is fixed; conditions are checked on a schedule (typically 15 minutes) chosen when the policy is applied. An applied policy may be manually run by selecting "Run Now" on the Applied Policies page for a given account.


Syntax:

```ruby
resolution <name> do
  automatic <term>
  label <string literal>
  description <string literal>
  parameter <parameter definition 1>
  parameter <parameter definition 2>
  parameter ...
  <action item 1>
  <action item 2>
  <action item 3>
  <action item ...>
end
```
* `name` is the name of the resolution. It may be referenced in validate and validate_each blocks by `resolve $<name>`.
* `label` gives a human readable label for the resolution.
* `description` is optional and should give a description of what will happen when the action is run.
* `automatic` controls whether the resolution is automatically run when an incident is resolved, or is manually run. Automatic can be true or false, or a function that evaluates to true or false. If unspecified, it defaults to true for backwards compatibility. Functions used can operate on [parameter](#parameters) to the applied policy in order to make whether actions are automatically run configurable.
* `parameter` can appear any number of times. parameters are optional parameters to inject into the request approval. They can be referenced by subsequent actions such as Cloud Workflows or emails within the same resolution. See the [Parameters](#parameters) section for more information about defining parameters.

### Action Items

Action items for resolutions follow the exact same format as action items for escalations. `email`, `request_approval`, and `run` are supported.

### Examples

```ruby
resolution "handle_unencrypted_volumes" do
  label "Email resolution"
  description "Email the resolution report to the email list"
  email $escalate_to do
    subject_template "Unencrypted volumes resolved in project {{ rs_project_name }}"
    body_template <<-EOS
Unencrypted volumes have all been encrypted or deleted.
EOS
end
```

## Incident Message and Email Templates

The Policy Template Language makes it possible to use text templates to define the content of messages shown to users when an incident is created both in the UI and in emails.

Templates have access to the escalation data via the built-in `data` function. They also have access to the policy template parameter values via the `parameters` function. Other functions listed below provide access to contextual information such as the RightScale organization and project. The output of the template is interpreted as [markdown](http://commonmark.org/help/) before being rendered into HTML.

The complete list of functions available to templates is:

* `data`: The policy escalation data.
* `parameters`: The applied policy parameter values as a hash.
* `rs_org_id`: The RightScale organization ID where the policy is applied.
* `rs_org_name`: The RightScale organization name where the policy is applied.
* `rs_project_id`: The RightScale project ID where the policy is applied.
* `rs_project_name`: The RightScale project name where the policy is applied.
* `rs_cm_host`: The RightScale Cloud Management API hostname.
* `rs_ss_host`: The RightScale Self-Service API hostname.
* `rs_optima_host`: The RightScale Optima API hostname.

### Text Template Syntax Overview

Control structures in templates are delimited by `{{` and `}}`. For example the following template:

``` text
"Project {{ rs_project_id }}: {{ rs_project_name }}"
```

produces `Project 123: foo` where `123` is the ID of the RightScale project and `foo` is its name.

If a control structure left delimiter is followed immediately by a minus sign and space character (`{{- `), all trailing white space is trimmed from the immediately preceding text. Similarly, if the right delimiter is preceded by a space and minus sign (` -}}`), all leading white space is trimmed from the immediately following text. The following template produces the same output as the previous one:

``` text
<<EOS
Project
  {{- rs_project_id }}:
  {{- rs_project_name }}
EOS
```

Elements of an object or hash are accessed using `.`, for example the following prints the value of the field `name` in the escalation data:

``` text
"{{ data.name }}"
```

If the escalation data is an array then the values can be iterated over using the function `range`:

``` text
<<EOS
{{ range data -}}
* "{{ .name }}"
{{ end -}}
EOS
```

Note how the fields of the current element are accessed using `.<name-of-field>`. `range` supports an alternative syntax that makes it possible to access the index and the current element explicitly:

``` text
<<EOS
{{ $index, $elem := range data -}}
{{ $index }}. "{{ $elem.name }}"
{{ end -}}
EOS
```

You may want to include your result in a table. Below is an example how to build a table from the data array.

```ruby
# If a value is passed as first parameter of export, we'll extract that subpath into a table.
export "reportData" do
  # resource_level is false by default
  # if true, there must be an "id" field and it must be unique
  resource_level true
  field "id" do
    # label is for display purposes, if left blank the field name (in this case "id") will be used
    label "Billing Center ID"
  end
  field "name" do
    label "Billing Center Name"
  end
  field "budget" do
    label "Budget"
  end
  field "actual" do
    label "Month to Date Spend"
    # format tells the UI how the field should be displayed. It can be semantic
    format "currency"
    # or css style directive
    format "right $%.2f"
  end
end
```

Control structures may also test the value of data for conditional output, for example:

``` text
<<EOS
{{- if .data.email }}
Email: {{ data.email }}
{{- end }}
EOS
```

A condition is true if it evaluates to anything other than false, 0, an empty string, array or data structure. There is also a set of binary comparison operators defined as functions:

* `eq` returns true if arg1 == arg2
* `ne` returns true if arg1 != arg2
* `lt` returns true if arg1 < arg2
* `le` returns true if arg1 <= arg2
* `gt` returns true if arg1 > arg2
* `ge` returns true if arg1 >= arg2

## Reserved Word Reference

The reserved words are defined below

### rs_org_id
`rs_org_id` returns the numerical identifier for RightScale Organization, that the account belongs to which is currently running the policy. It can be used any place a term can be used.

### rs_org_name
`rs_org_name` returns the name of the RightScale Organization Name that the account belongs, which is currently running the policy. It can be used any place a term can be used.

### rs_project_name
`rs_project_name` returns the name of the RightScale account that is currently running the policy. It can be used any place a term can be used.

### rs_project_id
`rs_project_id` returns the numerical identifier of the RightScale account that is currently running the policy. It can be used any place a term can be used.

### rs_cm_host
`rs_cm_host` returns the RightScale CloudManagement endpoints.

### rs_optima_host
`rs_optima_host` returns the RightScale Optima endpoint.

### rs_ss_host
`rs_ss_host` returns the RightScale Self-Service endpoints.

### data
`data` is used in a policy validate to refer to the whole datasource structure.

### item
`item` is used in a policy validate_each to refer to each item element in the datasource

### response
`response` is used to refer to the response XML or JSON data in a datasource result

### iter_item
`iter_item` is used to refer to each item when doing iterate in a resource or datasource

### iter_index
`iter_index` is the index of each item when doing iterate in a resource or datasource

### col_item
`col_item` is used to refer to each item when doing a collect in a datasource

### col_index
`col_index` is the index of each item when doing a collect in a datasource

## Resource Reference

The following table lists all the resources supported by the policy template language. For each resource the table lists the available filters as well as other available properties. Required properties are marked with `(*)`.

| Resource                  | Filters                                                                                                                                                                                                                                         | Properties                                                                                               | Docs                                                                                                         |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| rs_cm.alert               | alert_spec_href<br/>status                                                                                                                                                                                                                      | view                                                                                                     | [Alerts](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#index)                         |
| rs_cm.alert_spec          | description<br/>escalation_name<br/>name<br/>subject_href                                                                                                                                                                                       | instance_href<br/>server_href<br/>server_array_href<br/>server_template_href<br/>view<br/>with_inherited | [AlertSpecs](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#index)                 |
| rs_cm.cloud               | cloud_type<br/>description<br/>name                                                                                                                                                                                                             | view                                                                                                     | [Clouds](http://reference.rightscale.com/api1.5/resources/ResourceClouds.html#index)                         |
| rs_cm.credential          | description<br/>name                                                                                                                                                                                                                            | view                                                                                                     | [Credentials](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#index)               |
| rs_cm.datacenter          | name<br/>resource_uid                                                                                                                                                                                                                           | view                                                                                                     | [Datacenters](http://reference.rightscale.com/api1.5/resources/ResourceDatacenters.html#index)               |
| rs_cm.deployment          | description<br/>name<br/>resource_group_href<br/>server_tag_scope                                                                                                                                                                               | cloud_href(*)<br/>view                                                                                   | [Deployments](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#index)               |
| rs_cm.image               | cpu_architecture<br/>description<br/>image_type<br/>name<br/>os_platform<br/>resource_uid<br/>visibility                                                                                                                                        | cloud_href(*)<br/>view                                                                                   | [Images](http://reference.rightscale.com/api1.5/resources/ResourceImages.html#index)                         |
| rs_cm.instance            | datacenter_href<br/>deployment_href<br/>name<br/>os_platform<br/>parent_href<br/>placement_group_href<br/>private_dns_name<br/>private_ip_address<br/>public_dns_name<br/>public_ip_address<br/>resource_uid<br/>server_template_href<br/>state | cloud_href(*)<br/>view                                                                                   | [Instances](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#index)                   |
| rs_cm.instance_type       | cpu_architecture<br/>description<br/>name<br/>resource_uid                                                                                                                                                                                      | cloud_href(*)<br/>view                                                                                   | [InstanceTypes](http://reference.rightscale.com/api1.5/resources/ResourceInstanceTypes.html#index)           |
| rs_cm.ip_address          | deployment_href<br/>name                                                                                                                                                                                                                        | cloud_href(*)                                                                                            | [IpAddresses](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#index)               |
| rs_cm.network             | cidr_block<br/>cloud_href<br/>deployment_href<br/>name<br/>resource_uid                                                                                                                                                                         | view                                                                                                     | [Networks](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#index)                     |
| rs_cm.network_gateway     | cloud_href<br/>network_href<br/>name                                                                                                                                                                                                            |                                                                                                          | [NetworkGateways](hhttp://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#index)      |
| rs_cm.placement_group     | cloud_href<br/>deployment_href<br/>name<br/>state                                                                                                                                                                                               | view                                                                                                     | [PlacementGroups](http://reference.rightscale.com/api1.5/resources/ResourcePlacementGroups.html#index)       |
| rs_cm.resource_group      | cloud_href<br/>name<br/>state                                                                                                                                                                                                                   |                                                                                                          | [ResourceGroups](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#index)         |
| rs_cm.route_table         | cloud_href<br/>name<br/>network_href                                                                                                                                                                                                            | view                                                                                                     | [RouteTables](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#index)               |
| rs_cm.routes              | cloud_href<br/>description<br/>network_href<br/>next_hop_href<br/>next_hop_ip<br/>next_hop_type<br/>next_hop_url<br/>state                                                                                                                      | route_table_href(*)                                                                                      | [Routes](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#index)                         |
| rs_cm.security_group      | deployment_href<br/>name<br/>network_href<br/>resource_uid                                                                                                                                                                                      | cloud_href(*)                                                                                            | [SecurityGroups](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroups.html#index)         |
| rs_cm.security_group_rule |                                                                                                                                                                                                                                                 | security_group_href<br/>view                                                                             | [SecurityGroupRules](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#index) |
| rs_cm.server              | cloud_href<br/>deployment_href<br/>name                                                                                                                                                                                                         |                                                                                                          | [Servers](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#index)                       |
| rs_cm.server_array        | cloud_href<br/>deployment_href<br/>name                                                                                                                                                                                                         | view                                                                                                     | [ServerArrays](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#index)             |
| rs_cm.ssh_key             | resource_uid<br/>name                                                                                                                                                                                                                           | cloud_href(*)<br/>view                                                                                   | [SshKeys](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#index)                       |
| rs_cm.subnet              | datacenter_href<br/>instance_href<br/>resource_uid<br/>name<br/>network_href<br/>visibility                                                                                                                                                     | cloud_href(*)                                                                                            | [Subnets](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#index)                       |
| rs_cm.user                | email<br/>first_name<br/>last_name                                                                                                                                                                                                              |                                                                                                          | [Users](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#index)                           |
| rs_cm.volumes             | datacenter_href<br/>deployment_href<br/>resource_uid<br/>name<br/>description<br/>parent_volume_snapshot_href                                                                                                                                   | cloud_href(*)<br/>view                                                                                   | [Volumes](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#index)                       |
| rs_cm.volume_attachment   | instance_href<br/>resource_uid<br/>volume_href<br/>                                                                                                                                                                                             | cloud_href(*)<br/>view                                                                                   | [VolumeAttachments](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html#index)   |
| rs_cm.volume_snapshot     | state<br/>deployment_href<br/>resource_uid<br/>name<br/>description<br/>parent_volume_snapshot_href<br/>visibility                                                                                                                              | cloud_href(*)<br/>view                                                                                   | [VolumeSnapshots](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#index)       |
| rs_cm.volume_type         | name<br/>resource_uid<br/>                                                                                                                                                                                                                      | cloud_href(*)<br/>view                                                                                   | [VolumeTypes](http://reference.rightscale.com/api1.5/resources/ResourceVolumeTypes.html#index)               |

## Functions

Functions make it possible to compute values dynamically, for example by concatenating multiple values together or extracting sub-text from an API
response. The syntax for calling a function is:

``` text
<name>(<term>, <term>, …)
```

For example:

```ruby
href(col_item)
```

A function may have zero or more parameters. The [function reference page](functions.html) lists all the functions available for use in policy templates. The list describes the parameters and return values as well as where the function may be used.
