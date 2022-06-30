---
title: Policy Template Language Functions
description: This page outlines all functions available in the policy template language.
version_number: "20180301"
alias: [policies/reference/functions.html, policies/reference/v20180301/functions.html]
versions:
  - name: "20180301"
    link: /policies/reference/v20180301/functions.html
---

Functions make it possible to compute values dynamically, for example by concatenating multiple values together or extracting sub-text from an API
response. The syntax for calling a function is:

``` text
<function>(<term>, <term>, …)
```

For example:

``` ruby
size($volumes)
```

Functions can accept a number of basic types as parameters. These basic types strongly parallel what you might find in JSON or JavaScript:
* Number: a number can be an integer or floating point value.
* String: a string value, denoted with ""
* Boolean: true or false.
* Regexp: a regular expression value. Always denoted in the language with // brackets. For example, the function which accepts a Regexp might be called like `contains("hello world", /hello/)`
* Array: an array of any of the other values.
* Object: an object is a hash or map of values. See [policy template language syntax](policy_template_language.html#syntax-object-literals) for details.
* Datasource, Resource: Datasources and resources are treated as an array of objects if used as a parameter to a function.

## Array Functions

### first

``` ruby
first(<array>)
```

`first` returns the first value of an array. The return value type is value of the element. `first` may appear when defining datasource fields or in validations

Examples:

``` ruby
first(@instances) # returns the first instance from an array of instances
```

``` ruby
first(split("x,y,z", ",")) # returns the value "x"
```

In this example we get the first IP address from a list of IP addresses.

``` ruby
first(val(iter_item, "private_ip_addresses"))
```

### last

``` ruby
last(<array>)
```

`last` returns the last value of an array. The return value type is value of the element. `last` may appear when defining datasource fields or in validations.

Examples:

``` ruby
last(@volume) # returns the last volume from an array of volumes
```

``` ruby
last(split("/api/volumes/1234", "/")) # returns "1234"
```

### get

``` ruby
get(index, <array>)
```

`get` returns value of an array at index. Index starts at 0. The return value type is value of the element. `get` may appear when defining datasource fields or in validations.

Examples:

``` ruby
get(2, @instances) # return the third element (index 2) of an array
```

``` ruby
get(1, split("x,y,z", ",")) # returns the second element of the split array, which is "y"
```

### contains

``` ruby
contains(<array>, <select expression>)
```

`contains` returns true if the array contains any elements which match the select expression. The select expression will differ based on the type of the array:
* For an array of numbers, select expression much be a number
* For an array of strings, select expression can be a string or regexp.
* For an array of objects, select expression must be a object denoting which fields to match. Deeper matches can be done by specifying sub objects.

The return type of `contains` is a boolean. `contains` may appear when defining datasource fields or in validations.

This example selects fields out of a basic array using a regular expression.

``` ruby
contains(["John Smith", "John Adams", "Tom Jackson"], /John/) # returns true
contains(["John Smith", "John Adams", "Tom Jackson"], "Tom Jackson") # returns true
```

``` ruby
contains([10,100,500], 100) # returns true
contains([10,100,500], "100") # returns false. The type matters! "100" is a string and the array is an array of numbers.
```

For the next examples @instances is an array of Instance Resources returned by the RightScale API with the following structure:
```
{
	"id": <string>
	"name": <string>
	"cloud_specific_attributes": {
		"ebs_optimized": <boolean>,
	}
}
```

This will get instances where the ebs optimized flag is set to true:

``` ruby
contains(@instances, {"cloud_specific_attributes": {"ebs_optimized": true})
```

### select

``` ruby
select(<array>, <select expression>)
```


`select` returns a new array with zero or more elements matching the select expression. The select expression will differ based on the type of the array:
* For an array of numbers, select expression must be a number
* For an array of strings, select expression can be a string or regexp.
* For an array of objects, select expression must be an object denoting which fields to match. Deeper matches can be done by specifying sub objects.

The return type of `select` is a boolean. `select` may appear when defining datasource fields or in validations.


This example selects fields out of a basic array:

``` ruby
select(["John Smith", "John Adams", "Tom Jackson"], /John/) # returns ["John Smith", "John Adams"]
```


For the next examples @instances is an array of Instance objects returned by the RightScale API with the following structure:
```
{
	"id": <string>
	"name": <string>
	"ip_addresses": [<string>, <string>, ...]
}
```

This example creates a new datasource with public IP addresses selected out:

``` ruby
datasource "test_instances" do
	iterate @instances
	field "private_ips" select(val(iter_item, "ip_addresses"), /(^192\.168)|(^10\.)|(^172\.1[6-9])|(^172\.2[0-9])|(^172\.3[0-1])/)
end
```

### size

``` ruby
size(<array>)
```

`size` returns the size of an array. The return value type is `number`. `size` may appear when defining datasource fields or in validations.

Examples:

``` ruby
size(@volumes) # returns the number of volumes
```

``` ruby
size(["a","b","c"]) # returns 3
```

### jmes_path

``` ruby
jmes_path(<array of objects>|<object>, expression <string>)
```

`jmes_path` will run a [JMESPath](http://jmespath.org/) expression against an array of objects or object. The return type is varied. `jmes_path` should mostly be used in defining [custom datasources](policy_template_language.html#retrieving-data-api-data-with-datasources) and [paginations](policy_template_language.html#retrieving-data-pagination), but can also be used for writing [validations](policy_template_language.html#describing-the-policy-conditions). For more complicated validations, it's highly recommended to use [a JavaScript datasource](policy_template_language.html#processing-datasources-with-javascript).

For example, given a resource named `@clouds`:

```json
[
    {
        "cloud_type": "amazon",
        "description": "Amazon's US Cloud on the East Coast",
        "display_name": "AWS US-East",
        "name": "EC2 us-east-1"
    },
    {
        "cloud_type": "google",
        "description": "Google Cloud, including Google Compute Engine, Google Cloud Storage, etc.",
        "display_name": "Google",
        "name": "Google"
    }
]
```

``` ruby
jmes_path(@clouds, "[].name") # returns ["EC2 us-east-1", "Google"]
```

### jq

```ruby
jq(<array of objects>|<object>, expression <string>[, type "simple_element"|"array"])
```

`jq` will run a [jq](https://stedolan.github.io/jq/) expression against an array of objects or object. The return type is varied. The optional third argument specifies whether the expression is expected to return a single element (`"simple_element"`) or multiple (`"array"`); if unspecified, the default is `"simple_element"` except when used as the expression of a `collect` where it is `"array"`. `jq` should mostly be used in defining [custom datasources](policy_template_language.html#retrieving-data-api-data-with-datasources) and [paginations](policy_template_language.html#retrieving-data-pagination), but can also be used for writing [validations](policy_template_language.html#describing-the-policy-conditions). For more complicated validations, it's highly recommended to use [a JavaScript datasource](policy_template_language.html#processing-datasources-with-javascript).

For example, given a resource named `@clouds`:

```json
[
    {
        "cloud_type": "amazon",
        "description": "Amazon's US Cloud on the East Coast",
        "display_name": "AWS US-East",
        "name": "EC2 us-east-1"
    },
    {
        "cloud_type": "google",
        "description": "Google Cloud, including Google Compute Engine, Google Cloud Storage, etc.",
        "display_name": "Google",
        "name": "Google"
    }
]
```

```ruby
jq(@clouds, ".[].name", "array") # returns ["EC2 us-east-1", "Google"]
```

### xpath

```ruby
xpath(<array of xml node objects>|<xml node object>, expression <string>[, type "simple_element"|"array"])
```

`xpath` will run an [XPath](https://www.w3.org/TR/xpath/all) expression against an array of XML node objects or object. The return type is varied. The optional third argument specifies whether the expression is expected to return a single element (`"simple_element"`) or multiple (`"array"`); if unspecified, the default is `"simple_element"` except when used as the expression of a `collect` where it is `"array"`. `xpath` should be used in defining [custom datasources](policy_template_language.html#retrieving-data-api-data-with-datasources) and [paginations](policy_template_language.html#retrieving-data-pagination).

For example, given the `response` in a datasource:

```xml
<clouds>
  <cloud>
    <type>amazon</type>
    <description>Amazon's US Cloud on the East Coast</description>
    <display-name>AWS US-East</display-name>
    <name>EC2 us-east-1</name>
  </cloud>
  <cloud>
    <type>google</type>
    <description>Google Cloud, including Google Compute Engine, Google Cloud Storage, etc.</description>
    <display-name>Google</display-name>
    <name>Google</name>
  </cloud>
</clouds>
```

```ruby
xpath(response, "//clouds/cloud/name", "array") # returns ["EC2 us-east-1", "Google"]
```

## Object Functions

### header
``` ruby
header(<string>)
```

`header` extracts a single response header from the API request. The return value type is a string. `header` may appear when defining datasource fields.

This example creates a new datasource from a API request and sets the field with the response header value.

``` ruby
datasource "aws_s3_object"
  request do
    auth $auth_aws
    verb "GET"
    host "my_bucket.s3.amazonaws.com"
    path "/"
    query "list-type", "2"
  end
  result do
    encoding "xml"
    collect xpath(response, "//ListBucketResult/Contents", "array") do
      field "key", xpath(col_item,"Key") #the Key / File name
      field "last_modified", header("LastModified") #last modified date
      field "bucket", header("Name") #the bucket name
    end
  end
end
```

### href
``` ruby
href(<object>)
```

`href` extracts a self href from the `links` section of a RightScale resource. The return value type is a string. `href` may appear when defining datasource fields or in validations. This function is provided as a shortcut as the [response](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#show_example_responses) can otherwise be cumbersome to parse.

This example creates a new datasource from an array of RightScale instances with the href field set to the "self" href of the instance.

``` ruby
datasource "instances"
  iterate @instances
  field "id" val(iter_item, "resource_uid")
  field "href", href(iter_item) # set to something like "/api/clouds/1/instances/AE3F0B9AE"
end
```

### hrefs

``` ruby
hrefs(<array of objects>)
```

`hrefs` extracts a self href from the `links` sections of an array of RightScale resources. See [href](#href) above for details.

Example:

``` ruby
datasource "instances" do
  field "all_hrefs" hrefs(@instances) # set to something like ["/api/clouds/1/instances/AAA", "/api/clouds/1/instances/BBB", ...]
end
```


### val

``` ruby
val(<object>, field_name)
```

`val` extracts a field from an object returns the corresponding value. The return value type is the value of the field. `val` may appear when defining datasource fields or in validations.

Example:

``` ruby
val(@instance, "resource_uid") # returns the value of the instance resource_uid field
```

``` ruby
datasource "instances" do
   iterate @instances # iterate previously defined resources
   field "id", val(iter_item, "resource_uid") # rename "resource_uid" into "id"
end
```

### vals

``` ruby
vals(<array of objects>, field_name)
```

`vals` extracts a field from an an array of objects returns an array of the the field values. `vals` may appear when defining datasource fields or in validations.

Example:

``` ruby
vals(@instances, "resource_uid") # returns an array of resource_uids.
```

``` ruby
datasource "instances" do
   field "all_ids", vals(data, "resource_uid")
end
```

## Comparison Functions

### ge

``` ruby
ge(<number>|<string>|<date>, <number>|<string>|<date>)
```

`ge` returns true if the first value is greater than or equal to second value. Values must both be the same type. `ge` may appear when defining datasource fields or in validations.

Examples:

``` ruby
ge(2, 2) # true
ge("hello", "world") # false, hello is lexicographically before world
ge(now, to_d("2015-11-10T11:10:06Z")) # true, current time is greater than supplied value
```

### gt

``` ruby
gt(<number>|<string>|<date>, <number>|<string>|<date>)
```

`gt` returns true if the first value is greater than second value. Values must both be same type. `gt` may appear when defining datasource fields or in validations.

Examples:

``` ruby
gt(3, 2) # true
gt("hello", "world") # false, hello is lexicographically before world
gt(now, to_d("2015-11-10T11:10:06Z")) # true, that date is in the past
```

### le

``` ruby
le(<number>|<string>|<date>, <number>|<string>|<date>)
```

`le` returns true if value1 is less than or equal to value2. Values must both be same type. `le` may appear when defining datasource fields or in validations.

Examples:

``` ruby
le(2, 2) # true
le("hello", "world") # true, hello is lexicographically before world
le(to_d("2015-11-10T11:10:06Z"), now) # true, that date is in the past
```

### lt

``` ruby
lt(<number>|<string>|<date>, <number>|<string>|<date>)
```

`lt` returns true if value1 is less than value2. Values must both be same type. `lt` may appear when defining datasource fields or in validations.

Examples:

``` ruby
lt(2, 3) # true
lt("hello", "world") # true, hello is lexicographically before world
lt(to_d("2015-11-10T11:10:06Z"), now) # true, that date is in the past
```

### ne

``` ruby
ne(<number>|<string>|<date>, <number>|<string>|<date>)
```

`ne` returns true if first value is not equal to second value. Values must both be same type. `ne` may appear when defining datasource fields or in validations.

Examples:

``` ruby
ne(2, 3) # true
ne("hello", "world") # true
```

### eq

``` ruby
eq(<number>|<string>|<date>, <number>|<string>|<date>)
```

`eq` returns true if first value is equal to second value. Values must both be same type. `eq` may appear when defining datasource fields or in validations.

Examples:

``` ruby
eq(2, 2) # true
eq(2, "2") # false, different types
eq("hello", "hello") # true
eq("hello", "HELLO") # false
```

### now

``` ruby
now()
```

`now` returns the current time in UTC timezone. It accepts no parameters.

Examples:

``` ruby
gt(now, to_d("2015-11-10T11:10:06Z")) # true, that date is in the past
```

## String Functions

### split

``` ruby
split(<string>, separator <string>|<regex>)
```

`split` splits a string on separator. Separator may be a string or a regular expression. `split` returns an array of strings. `split` may appear when defining datasource fields or in validations.

Examples:

``` ruby
split("us-east-1a", "-") # returns ["us","east","1a"]
```

``` ruby
split("a, b, c", /\s*,\s*/) # returns ["a","b","c"]
```

### join

``` ruby
join(<array of strings>, separator <string>)
```

`join` joins a string with a separator. Separator must be a string. `join` always returns a string. `join` may appear when defining datasource fields or in validations.

Examples:

``` ruby
join(["us","east","1a"], "-") # returns "us-east-1a"
```

### ljust

``` ruby
ljust(<string>, length <number>, padder <string>)
```

`ljust` left justifies a string by filling it with the padder until it meets a minimum length.  `ljust` always returns a string. `ljust` may appear when defining datasource fields or in validations.

Examples:

``` ruby
ljust("foo", 10, "-=") # returns "foo-=-=-=-"
```

### rjust

``` ruby
rjust(<string>, length <number>, padder <string>)
```

`rjust` left justifies a string by filling it with the padder until it meets a minimum length.  `rjust` always returns a string. `rjust` may appear when defining datasource fields or in validations.

Examples:

``` ruby
rjust("foo", 10, "-=") # returns "=-=-=-=foo"
```

## Logical operators

### switch

``` ruby
switch(<conditional>, <a>, <b>)
```

`switch` operates much like an if statement. It accepts a conditional as the first argument and will return a if true, b if false. Any argument passed in the first argument will be converted to a boolean using [to_b](#conversion-functions-to-b). `switch` may appear when defining datasource fields or in validations.

Examples:

``` ruby
switch(lt("a","b"), "first", "second") # returns "first" as the condition is true
switch(0, "a", "b") # returns "b" as 0 evaluates to false
switch("", "a", "b") # returns "b" as empty string evaluates to false
```

### logic_and

``` ruby
logic_and(<conditional>, <conditional>)
```

`logic_and` returns true if both arguments evaluate to true. Anything passed as the first or second argument will be converted to a boolean using [to_b](#conversion-functions-to-b). `logic_and` may appear when defining datasource fields or in validations.

Examples:

``` ruby
logic_and("first", "second") # true as both are non-empty
logic_and(true, true) # returns true
```

### logic_or

``` ruby
logic_or(<conditional>, <conditional>)
```

`logic_or` returns true if either argument evaluates to true. Anything passed as the first or second argument will be converted to a boolean using [to_b](#conversion-functions-to-b). `logic_or` may appear when defining datasource fields or in validations.

Examples:

``` ruby
logic_or("first", "") # true as first element is non-empty
logic_or(true, false) # returns true
```

### logic_not

``` ruby
logic_not(<conditional>)
```

`logic_not` returns true if the conditional evaluates to false. Anything passed as the first or second argument will be converted to a boolean using [to_d](#conversion-functions-to-b). `logic_not` may appear when defining datasource fields or in validations.

Examples:

``` ruby
logic_not("") # true as first element evaluates to false
logic_not(false) # true
```

## Number Functions

### inc

``` ruby
inc(<number>, <number>)
```

`inc` returns the sum of two numbers. `inc` may appear when defining datasource fields or in validations.

Examples:

``` ruby
inc(2, 3) # 5
```

### dec

``` ruby
dec(<number>, <number>)
```

`dec` subtracts the second argument from the first. `dec` may appear when defining datasource fields or in validations.

Examples:

``` ruby
dec(10, 2) # 8
```

### prod

``` ruby
prod(<number>, <number>)
```

`prod` returns the product of two numbers. `prod` may appear when defining datasource fields or in validations.

Examples:

``` ruby
prod(2, 4) # 8
```

### div

``` ruby
div(<number>, <number>)
```

`div` divides the first argument by the second. `div` may appear when defining datasource fields or in validations.

Examples:

``` ruby
div(10, 2) # 5
```

### mod

``` ruby
mod(<number>, <number>)
```

`mod` takes a modulus of the first number by the second. `mod` may appear when defining datasource fields or in validations.

Examples:

``` ruby
mod(10, 3) # 1
```

## Conversion Functions

### to_n

``` ruby
to_n(<string>)
```

`to_n` converts a string into a number. `to_n` may appear when defining datasource fields or in validations.

Examples:

``` ruby
to_n("10") # 10
```

### to_s

``` ruby
to_s(<string>)
```

`to_s` converts a number into a string. `to_s` may appear when defining datasource fields or in validations.

Examples:

``` ruby
to_s(10) # "10"
```

### to_b

``` ruby
to_b(<anything>)
```

`to_b` converts anything into a boolean value of true or false. For numbers, it'll evaluate to true if the number is not zero. For strings, it'll evaluate to true if the string is non-empty. For arrays, it'll evaluate to true if the array length is greater than 0. `to_b` may appear when defining datasource fields or in validations.

Examples:

``` ruby
to_b(0) # false
to_b(10) # true
to_b("") # false
to_b("any value") # true
```

### to_d

``` ruby
to_d(<string>)
```

`to_d` converts a string into a date in the UTC timezone so it can be used in comparisons. It'll make a best effort to convert most common date formats.

``` ruby
to_d("2009-11-10 04:10:06 -0700") # Ruby default format
to_d("2009-11-10T11:10:06Z") # RFC3339
gt(to_d(some_timestamp), now) # true if some_timestamp takes place in the future
```



## Miscellaneous

### resolve_incident

``` ruby
resolve_incident
```

`resolve_incident` is used in an `escalation` declaration to force the related policy's incident to be marked as resolved and the policy's `resolve` directives to be executed.

Examples:

``` ruby
escalation "stop_instances" do
  email $param_email
  run "stop_instances", data
  resolve_incident
end
```
