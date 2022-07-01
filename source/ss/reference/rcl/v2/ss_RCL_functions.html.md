---
title: Cloud Workflow Functions
description: Functions are built-in operations that execute inside the Cloud Workflow engine using RightScale Cloud Workflow Language (RCL).
version_number: "2"
versions:
  - name: 1
    link: /ss/reference/rcl/v1/ss_RCL_functions.html
  - name: 2
    link: /ss/reference/rcl/v2/ss_RCL_functions.html
---

## Functions Overview

Functions are built-in operations that execute inside the Cloud Workflow engine using RightScale Cloud Workflow Language (RCL). They provide various helpers to address needs like retrieving the current time, generating random numbers, sorting collections and arrays, etc. Functions may operate on values and/or on reference collections and return values and/or reference collections. Arguments passed to functions are read-only. For example, the `sort()` function will return the result of the sort rather than modify the argument. Functions use the `lower_case()` notation.

## Collections Management

The first category of functions relate to managing resource collections and arrays of values.

### find

#### Syntax

`find($type, $name or $hash[, $revision])`

#### Description

This function is syntactic sugar around the resource type get() action. It is the equivalent of calling the get() action with the given filters. It will return the first resource that matches the argument **exactly**, or if none match exactly, the first resource in the list of resources returned by the get() action.

Filters are specified with a hash or with a string and optional integer. If a string is specified then it is equivalent to a having a hash with a key name and the associated value (i.e. by default filter on name). If a integer is specified then is it equivalent to having a hash with a key revision. So:

~~~ ruby
@servers = find("servers", "default")
@servers = find("servers", { name: "default" })
~~~

are equivalent to:

~~~ ruby
@servers = first(rs_cm.servers.get(filter: ["name==default"]))
~~~

and

~~~ ruby
@server_template = find("server_templates", "MySQL Database Manager", 137)
@server_template = find("server_templates", { name: "MySQL Database Manager", revision: 137 })
~~~

are equivalent to:

~~~ ruby
@server_template = first(rs_cm.server_templates.get(filter: ["name==MySQL Database Manager","revision==137"]))
~~~

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none | Resource type, e.g. `servers`, `deployments`, etc.
2 | string _or_ hash | yes | none | Resource name or filters
3 |  string _or_ integer | no | none | Resource revision, if resource is versioned. Not specifying a value for versioned resources returns all resources with the given type and name.

#### Result

A resource collection containing the first resource matching the given filter if any.

### size

#### Syntax

`size($array, $hash, $string or @collection)`

#### Description

This function simply returns the size of the resource collection or array of values given as argument.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values _or_ hash of values _or_ string | yes | none |

#### Result

An integer representing the size of the given array, hash, string or collection.

### first and last

#### Syntax

`first($array or @collection)` and `last($array or @collection)`

#### Description

These functions simply retrieve the first or last element of a resource collection or array of values.

Note: For resource collections, the result is a resource collection itself, consisting of a single resource. However, for an array of values, the result is a single value.

#### Arguments

The only argument is the collection from which the first or last element should be extracted.

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none |

#### Result

A resource collection if the argument is a resource collection or a value if the argument is an array of values.

#### Examples

~~~ ruby
$one = first([1, 2, 3]) # $one == 1
~~~

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
@first = first(@servers) # size(@first) == 1
~~~

### sort

#### Syntax

`sort($array or @collection[, $field][, $order])`

#### Description

The `sort()` function allows sorting resource collections and arrays of values. If sorting an array of values, then all values must be of the same type and the array must not contain `null`. The ordering follows the same logic as the comparison operators:

* Numbers and datetime use the natural order (think of datetime in terms of seconds since the epoch for comparison)
* Strings and arrays follow the lexicographical order
* true > false

Hashes cannot be compared directly, instead the `sort()` function accepts an argument to specify recursively which key should be used for sorting. That same argument can be used on resource collections to specify which field should be used for sorting. If the field ends up being a hash, then recursively what key of the hash should be used. By default, sorting resource collections is done using the `name` field.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none | collection to be sorted
2 | string | only if collection is an array of hashes | `name` for resource collections | name of resource field used to order resource collections _or_ name of key of hash to be used to order for array of hashes <br /> the definition is recursive, each key being separated with the character `/`
3 | `asc` or `desc` | no | `asc` | Sorting order (ascendant or descendant)

#### Result

The result type is the same as the first argument: a resource collection or an array of values.

#### Examples

Sorting a resource collection by name:

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
@sorted_servers = sort(@servers)
~~~

Sorting a collection of instances by their user data descending:

~~~ ruby
@instances = rs_cm.deployments.get(filter: ["name==default"]).server().current_instance()
@sorted_instances = sort(@instances, "settings/user_data", "desc")
~~~

Sorting an array of hashes (using a key called timestamp in this example):

~~~ ruby
$data = [{ "value": 42, "timestamp": d"1/1/2012 12:32" },
         { "value": 43, "timestamp": d"1/1/2012 16:31" }]
$sorted_data = sort($data, "timestamp")
~~~

### contains

#### Syntax

`contains?($array or @collection, elements)`

#### Description

This function checks whether all the elements of a given collection or a specific value are contained in another given collection. The elements may be in different order and they may appear a different number of times, but as long as all elements appear at least once, then the function returns `true`, otherwise it returns `false`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none | Container being tested
2 | resource collection _or_ array of values | yes | none | Elements that must be in container for function to return true

#### Result

`true` if all elements are contained in given collection, `false` otherwise.

#### Examples

~~~ ruby
$array = [1, 2, 3, 4]
contains?($array, [1]) == true
contains?($array, [5]) == false
contains?($array, [2, 1, 3, 3]) == true
contains?($array, [1, 2, 3, 5]) == false
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
@server = rs_cm.get(href: "servers/123") # Assume this server belongs to a deployment named 'default'
contains?(@servers, @server) == true
~~~

### empty

#### Syntax

`empty?($array or @collection)`

#### Description

Returns `true` if the given collection (resource collection or array of values) is empty, `false` otherwise.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none |

#### Result

`true` if given collection is empty, `false` otherwise.

### any

#### Syntax

`any?($array[, $value_or_regexp])`

#### Description

This function checks for the existence of an element in an array of JSON values. When only an array is given then returns `true` if the array contains a value that is neither `null` nor `false`. When both an array and a value are provided then returns `true` if the array contains at least once the given value. If the value is a regular expression, it will return `true` if there is a least one value that is a string and that matches the regexp. The syntax used to write a regular expressions is `/regexp/`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | array of values | yes | none |
2 | value or regular expression | no | none |

#### Result

`true` or `false`.

#### Examples

~~~ ruby
$array_of_false = [false, false, null]
any?($array_of_false) == false # All elements are null or false, result is false
$array = [1, 2, 3, "a", "b", "cde"]
any?($array) == true # Array contains values that are not either false or null, result is true
any?($array, 1) == true # Array contains the value 1
any?($array, "cd") == false # Array does not contain value "cd"
any?($array, "/cd/") == true # Value "cde" matches regular expression "cd"
~~~

### all

#### Syntax

`all?($array[, $value_or_regexp])`

#### Description

This function checks whether all elements of an array have a given value. When only an array is provided, then it returns `true` if the array does not contain a value that is either `null` or `false`. When both an array and a value is provided, then it returns `true` if the array values all match the given value. If the value is a regular expression, it will return `true` if all the values in the array are all strings that match the regular expression. It returns `true` if the array is empty.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | array of values | yes | none |
2 | value or regular expression | no | none |

#### Result

`true` or `false`.

#### Examples

~~~ ruby
$array_with_one_false = [1, 2, false]
all?($array_with_one_false) == false # One element is null or false, result is false
$array = [1, 2, 3, "a", "b", "cde"]
all?($array) == true # Array contains no null or false, result is true
all?($array, 1) == false # Not all values are one
all?($array, "/cd/") == false # Not all values are strings that match regular expression "cd"
~~~

### select

#### Syntax

`select($array or @collection, $hash)`

#### Description

This function extracts the elements of a resource collection or of an array of hashes that have fields or values with a given value. The name of the field or hash key that should be selected for comparison correspond to the keys of the hash given as second argument. The values of that hash are the values that the resource fields or hash entries must be selected. If the resource field or hash values are strings, then the selector hash value can represent regular expressions.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none | Container being tested
2 | hash | yes | none | Resource field names associated with value that should be filtered on _or_ Hash key name associated with value that should be filtered on

#### Result

A resource collection composed of resources that have fields with the given values or an array of hashes that have the given values for given keys.

#### Examples

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
@app_servers = select(@servers, { "name": "/app/" }) # @app_servers contains servers whose name match
                                                     # the regular expression "app" (i.e. contain the string "app")
$hashes = [{ "key": "value1" }, { "key": "value2" }]
$hashes_with_value1 = select($hashes, { "key": "value1" }) # $hashes_with_value1 contains hashes whose values
                                                           # stored in key "key" is "value1"
~~~

### unique

#### Syntax

`unique($array or @collection)`

#### Description

This function traverses the given collection and returns a new collection made of all the unique elements. Two resources are considered identical if they have the same `href`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ array of values | yes | none | Container to be traversed and whose unique elements should be extracted

#### Result

A collection composed of the distinct elements in the initial collection. The types of the elements is preserved (so the result is a resource collection or an array of values depending on the argument).

#### Examples

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
@duplicated_servers = @servers + @servers
@unique_servers = unique(@duplicated_servers)
assert @servers == @unique_servers
~~~

## Resource Management

The following functions help you to work with cloud resources. They are helper functions that encapsulate logic to help create and delete resources in a pre-defined way, saving you from having to implement the logic in your code.

### provision

#### Syntax

`provision(@declaration)`

#### Description

This function provisions the resource(s) passed in as a [resource declaration](index.html#resources-resource-declarations) and returns a [resource collection](index.html#resources-resource-collections) containing the provisioned resources, or raises an error. A [resource declaration](index.html#resources-resource-declarations) is a description of what a resource ought to be and consists of a hash which defines the resource `namespace`, `type` and `fields` which characterize the resource.

The general behavior is that this function creates the resource(s) and waits until it is in a usable state -- what exactly that means for each resource is a bit different. The following table lists the behavior of the provision function for each RightScale resource.

For a [bulk resource declaration](/ss/reference/cat/v20161221/index.html#resources-bulk-resources), the general behavior of the `provision` function is to retry the provision of each resource in the declaration up to 3 times. If after 3 retries, any resource in the bulk declaration has not provisioned successfully, the entire collection is destroyed and an error is raised. In this case, the `$_errors` [array of hashes](index.html#attributes-and-error-handling-resource-action-errors) will contain errors with `copy_index` fields, indicating which of the resources in the declaration could not be provisioned. See below for resource-specific behavior.

Resource | Behavior | Failure Behavior
-------- | -------- | ----------------
Server | Create the Server<br />Launch the Server<br />Wait for the Server to become "operational"<br />For bulk: if after launching the server state is `inactive`, the launch call will be retried up to 3 times | Terminate the Server<br />Wait for the Server to terminate<br />Delete the Server
ServerArray | Create the ServerArray<br />Enable the ServerArray<br />Launch the ServerArray<br />Wait for at least the `min_count` number of instances to become "operational" | Terminate all instances in the ServerArray<br />Wait for all instances to terminate<br />Delete the ServerArray
Instance | Create the Instance<br />Launch the Instance<br />Wait for the Instance to become "running"<br />For bulk: if after launching the instance state is `inactive`, the launch call will be retried up to 3 times | Terminate the Instance<br />Wait for the Instance to terminate<br />Delete the Instance
IPAddress | Create the IPAddress | N/A
IPAddressBinding | Create the IPAddressBinding | N/A
Volume | Create the Volume<br />Wait for the volume to become "available" | Delete the Volume
VolumeSnapshot | Create the VolumeSnapshot | N/A
VolumeAttachment | Create the VolumeAttachment | N/A

### delete

#### Syntax

`delete(@resource)`

#### Description

This function cleans up and deletes the specified resource. Generally speaking, this function will take care to trigger the resource to be decommissioned and then remove the resource altogether -- the specific actions for each resource are a bit different. The following table lists the behavior of the delete function for each RightScale resource.

Resource | Behavior
-------- | --------
Server | Terminate the Server<br />Wait for the Server to terminate<br />Delete the Server resource
ServerArray | Disable the ServerArray<br />Terminate all instances in the ServerArray<br />Wait for all instances to terminate<br />Delete the ServerArray
Instance | Terminate the Instance<br />Wait for the Instance to terminate<br />Delete the Instance
IPAddress | Delete the IPAddress
IPAddressBinding | Delete the IPAddressBinding
Volume | Delete the Volume
VolumeSnapshot | Delete the VolumeSnapshot
VolumeAttachment | Delete the VolumeAttachment

### copy

#### Syntax

`copy(count, @declaration, [fields])`

#### Description

The `copy` function provides a method to create a [bulk resource declaration](/ss/reference/cat/v20161221/index.html#resources-bulk-resources) from a single declaration. The first argument must be a single resource declaration from which the bulk declaration will be based. The second argument specifies how many copies of the declaration to create. The third, optional, argument is a hash whose fields are merged into the fields of the base resource declaration -- the hash may contain a `copy_index()` function which will return the current iteration in the bulk declaration.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | number | yes | none |
2 | declaration | yes | none |
3 | hash | no | none | May not contain any direct resource field access (i.e. `@server.name`) - use `field` instead

#### Examples

~~~ ruby
# Create a bulk resource declaration with 10 @servers in it
@servers = copy(10, @server)

# Create a bulk resource declaration based on @server where every name is unique
@servers = copy(10, @server, {"name": "My Server #" + copy_index()})
~~~

### field

#### Syntax

`field(@resource, field_name)`

#### Description

Extracts the current value of `field_name` from the first resource in the `@resource` collection. Note: this is different behavior than `@resource.field_name`, which would actually make an API call to get the latest information about the `resource` before returning the value. 

This function is equivalent to: `to_object(@resource)["fields"][0][field_name]`.

If the `field_name` string ends with `[]`, then an array of values is returned, representing the value of the field for every element in the collection. 

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | declaration | yes | none |
2 | string | yes | none | If ending in `[]` will return an array of values, otherwise will return the first value

## Boolean Logic

The following set of functions all evaluate to `true` or `false`. They provide an alternate notation to using operators that may lend itself better when writing declarative code (e.g. when defining the fields of a declaration).

### equals

#### Syntax

`equals?($left or @left, $right or @right)`

#### Description

This function checks whether both arguments are equals, it is equivalent to doing `left == right`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ value | yes | none |
2 | resource collection _or_ value | yes | none |

#### Result

`true` or `false`.

#### Examples

~~~ ruby
$a = 1
$b = 2
$c = 1
equals?($a, $b) == false
equals?($a, $c) == true
~~~

### switch

#### Syntax
`switch($condition, @true_exp or $true_exp, @false_exp or $false_exp)`

#### Description

This function evaluates the condition and returns either the true expression or false expression based on the value of $condition.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
---------| --------------- | -------- | ------------- | -------
1 | value | yes | none |
2 | resource collection _or_ value | yes | none
3 | resource collection _or_ value | yes | none

**Note:** Both true expression and false expression should be of the same type.

#### Result

true expression or false expression

#### Examples

~~~ ruby
$anything_but_null = "foobar"
$false_or_null = null
switch($anything_but_null, $var1, $var2) == $var1
switch($false_or_null, @ec2, @google) == @google
~~~

### logic_and and logic_or

#### Syntax

`logic_and($left, $right)` and `logic_or($left, $right)`

#### Description

These functions apply the logical and or logical or operators respectively to their arguments. They are equivalent to `$left && $right` and `$left || $right` respectively.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | value | yes | none |
2 | value | yes | none |

#### Result

`true` or `false`.

#### Examples


~~~ ruby
$anything_but_null = "foobar"
logic_and($anything_but_null, false) == false
logic_and($anything_but_null, true) == true
logic_and($anything_but_null, null) == false
logic_and(null, null) == false

logic_or($anything_but_null, false) == true
logic_or($anything_but_null, true) == true
logic_or($anything_but_null, null) == true
logic_or(null, null) == false
~~~

### logic_not

#### Syntax

`logic_not($value​)`

#### Description

Applies the logical not operator.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | value | yes | none |

#### Result

`true` or `false`.

#### Examples

~~~ ruby
logic_not(true) == false
logic_not(false) == true
$any_value_but_null = "foobar"
logic_not($any_value_but_null) == false
logic_not(null) == true
~~~

## Data Conversion

The following set of functions are used to convert values from one type to another.

### to_s

#### Syntax

`to_s($value)`

#### Description

Convert value to string. The semantic for each type is summarized in the following table:

Type | Result | Example
---- | ------ | -------
string | no change | `to_s("foo") == "foo"`
number | string representation of number | `to_s(1) == "1"`
boolean | string representation of boolean | `to_s(true) == "true"`
datetime | string representation of datetime | `to_s(d"1/1/2012 6:59 PM") == "d\"2012/01/01 18:59\""`
null | string "null" | `to_s(null) == "null"`
array | JSON representation of an array | `to_s([1, 2, "3"]) == "[1,2,\"3\"]"`
hash | JSON representation of a hash | `to_s({ "one": 1, "two": 2, "three": 3 }) == "{\"one\":1,\"two\":2,\"three\":3}"`

### to_n

#### Syntax

`to_n($value)`

#### Description

Convert a value to a number. The only types that can be converted to numbers are strings, booleans, and datetimes. Attempting to convert a value of a different type (e.g. an array) will result in an error.

Type | Result | Example
---- | ------ | -------
string | corresponding number or 0 if string does not represent a number | `to_n("1.23123") == 1.23123`<br/>`to_n("foo") == 0`
number | no change | `to_n(1) == 1`
boolean | 1 for true, 0 for false | `to_n(true) == 1`
datetime | number of seconds since the epoch | `to_n(d"2012/01/26 1:49:35") == 1327542575`
null | 0 | `to_n(null) == 0`

### to_b

#### Syntax

`to_b($value)`

#### Description

Convert value to boolean. The only types that can be converted to booleans are strings and numbers. Attempting to convert a value of a different type (e.g. an array) will result in an error.


Type | Result | Example
---- | ------ | -------
string | `true` if string is "true", `false` otherwise | `to_b("true") == true`<br/>`to_b("foo") == false`
number | `true` if non 0, `false` otherwise | `to_b(42) == true`<br/>`to_b(0) == false`
boolean | no change | `to_b(true) == true`

### to_d

#### Syntax

`to_d($value)`

#### Description

Convert value to datetime. The only types that can be converted to datetimes are strings and numbers. Attempting to convert a value of a different type (e.g. an array) will result in an error. The accepted syntax for strings representing datetime is:

`year/month/day [h:m[:s]] [AM|PM]`

Trying to coerce a string that does not match this syntax to a datetime value results in an error.

Type | Result | Example
---- | ------ | -------
string | Corresponding datetime if syntax is correct, error otherwise | `to_d("1/1/2012") == d"1/1/2012"`
number | datetime with corresponding unix timestamp | `to_d(42) == d"1/1/1970 00:00:42"`
datetime | no change |

### to_a

#### Syntax

`to_a($value)`

#### Description

Convert hash to array of pairs or a range to an array. Converting a value of type other than hash or range will result in an error.

Type | Result | Example
---- | ------ | -------
hash | Corresponding array of pairs, ordering is random | `to_a({ "one": 1, "two": 2, "three": 3 }) == [ ["two", 2], ["one", 1], ["three", 3] ]`
range | Array of the given range | `to_a([1..3]) == [1, 2, 3]`

### to_object

#### Syntax

`to_object(@declaration or @collection) `

#### Description

Convert given resource declaration or resource collection into a JSON object. Especially useful to convert a declaration into an object, manipulate that object and assign it back to a declaration so that e.g. `provision()` may be called on it.


Type | Result | Example
---- | ------ | -------
collection _or_ declaration | JSON object containing declaration or collection fields. Note that objects created from declarations may be assigned back to a reference | `$data = to_object(@servers)`

### to_json

#### Syntax

`to_json($value)`

#### Description

Convert a value into a JSON string.

Type | Result | Example
---- | ------ | -------
any | JSON string | `to_json({ "one": 1, "two": 2, "three": 3 }) == '{"one":1,"two":2,"three":3}'`

### from_json

#### Syntax

`from_json($value)`

#### Description

Convert a string value into a RCL value.

Type | Result | Example
---- | ------ | -------
string | RCL value | `from_json('{"one":1,"two":2,"three":3}') == { "one": 1, "two": 2, "three": 3 }`

### strftime

#### Syntax

`strftime($date, $format_string)`

#### Description

Converts the given datetime to a string using the format/directives provided.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | datetime value | yes | none |
2 | string value| yes | none | Use any of the directives specified below when creating the string

The directive consists of a percent (%) character, zero or more flags, optional minimum field width, and a conversion specifier as follows:

`%<flags><width><conversion>`

**Flags:**

* `-`  don't pad a numerical output
* `_`  use spaces for padding
* `0`  use zeros for padding
* `^`  upcase the result string
* `#`  change case

The minimum field width specifies the minimum width.

**Format directives:**

**Date (Year, Month, Day)**

Directive | Description
--------- | ------------
`%Y` | Year with century if provided, will pad result at least 4 digits. `-0001`, `0000`, `1995`, `2009`, `14292`, etc.
`%C` | year / 100 (rounded down such as `20` in `2009`)
`%y` | year % 100 (00..99)
`%m` | Month of the year, zero-padded (01..12)
`%_m` | blank-padded ( 1..12)
`%-m` | no-padded (1..12)
`%B` | The full month name (`January`)
`%^B` | uppercased (`JANUARY`)
`%b` | The abbreviated month name (`Jan`)
`%^b` | uppercased (`JAN`)
`%h` | Equivalent to `%b`
`%d` | Day of the month, zero-padded (01..31)
`%-d` | no-padded (1..31)
`%e` | Day of the month, blank-padded ( 1..31)
`%j` | Day of the year (001..366)

**Time (Hour, Minute, Second, Subsecond)**

Directive | Description
--------- | ------------
`%H` | Hour of the day, 24-hour clock, zero-padded (00..23)
`%k` | Hour of the day, 24-hour clock, blank-padded ( 0..23)
`%I` | Hour of the day, 12-hour clock, zero-padded (01..12)
`%l` | Hour of the day, 12-hour clock, blank-padded ( 1..12)
`%P` | Meridian indicator, lowercase (`am` or `pm`)
`%p` | Meridian indicator, uppercase (`AM` or `PM`)
`%M` | Minute of the hour (00..59)
`%S` | Second of the minute (00..60)
`%L` | Millisecond of the second (000..999). The digits under millisecond are truncated to not produce `1000`.
`%N` | Fractional seconds digits, default is 9 digits (nanosecond)
`%3N` | millisecond (3 digits)
`%6N` | microsecond (6 digits)
`%9N` | nanosecond (9 digits)
`%12N` | picosecond (12 digits)
`%15N` | femtosecond (15 digits)
`%18N` | attosecond (18 digits)
`%21N` | zeptosecond (21 digits)
`%24N` | yoctosecond (24 digits). The digits under the specified length are truncated to avoid carry up.

**Weekday** 

Directive | Description
--------- | ------------
`%A` | The full weekday name (`Sunday`)
`%^A` | uppercased (`SUNDAY`)
`%a` | The abbreviated name (`Sun`)
`%^a` | uppercased (`SUN`)
`%u` | Day of the week (Monday is 1, 1..7)
`%w` | Day of the week (Sunday is 0, 0..6)

**ISO 8601 week-based year and week number**

The first week of YYYY starts with a Monday and includes YYYY-01-04. The days in the year before the first week are in the last week of the previous year.

Directive | Description
--------- | ------------
`%G` | The week-based year
`%g` | The last 2 digits of the week-based year (00..99)
`%V` | Week number of the week-based year (01..53)

**Week number**
The first week of YYYY that starts with a Sunday or Monday (according to `%U` or `%W`). The days in the year before the first week are in week 0.

Directive | Description
--------- | ------------
`%U` | Week number of the year. The week starts with Sunday. (00..53)
`%W` | Week number of the year. The week starts with Monday. (00..53)

**Seconds since the Epoch**

Directive | Description
--------- | ------------
`%s` | Number of seconds since 1970-01-01 00:00:00 UTC.

**Literal string**

Directive | Description
--------- | ------------
`%n` | Newline character (`\n`)
`%t` | Tab character (`\t`)
`%%` | Literal `%` character

**Combination** 

Directive | Description
--------- | ------------
`%c` | date and time (`%a %b %e %T %Y`)
`%D` | Date (`%m/%d/%y`)
`%F` | The ISO 8601 date format (`%Y-%m-%d`)
`%v` | VMS date (`%e-%^b-%4Y`)
`%x` | Same as `%D`
`%X` | Same as `%T`
`%r` | 12-hour time (`%I:%M:%S %p`)
`%R` | 24-hour time (`%H:%M`)
`%T` | 24-hour time (`%H:%M:%S`)

#### Example

~~~ ruby
# Format the current date for CM API 1.5
$time = now()
$api_time = strftime($time, "%Y/%m/%d %H:%M:%S +0000")
~~~

### to_base64

#### Syntax

`to_base64($value)`

#### Description

Encodes a string into a Base64 String

Type | Result | Example
---- | ------ | -------
string | string | `to_base64("a string") == "YSBzdHJpbmc="`

### from_base64

#### Syntax

`from_base64($value)`

#### Description

Decodes a base64 string into a string

Type | Result | Example
---- | ------ | -------
string | string | `from_base64("YSBzdHJpbmc=") == "a string"`

### to_html

#### Syntax

`to_html($value)`

#### Description

Encodes a string into a html encoded string

Type | Result | Example
---- | ------ | -------
string | string | `to_html("&") == "&amp;"`

### from_html

#### Syntax

`from_html($value)`

#### Description

Decodes an html string into a string

Type | Result | Example
---- | ------ | -------
string | string | `from_html("&amp;") == "&"`

### to_uri

#### Syntax

`to_uri($value)`

#### Description

Encodes a string into a Uri encoded String

Type | Result | Example
---- | ------ | -------
string | string | `to_uri("http://example.com/?a=\11\15") == "http://example.com/?a=%09%0D"`

### to_uri_esc

#### Syntax

`to_uri_esc($value)`

#### Description

Encodes a string into a Uri encoded String with all non alphabet or number characters escaped

Type | Result | Example
---- | ------ | -------
string | string | `to_uri_esc("http://example.com/?a=\11\15") == "http%3A%2F%2Fexample.com%2F%3Fa%3D%09%0D"`

### from_uri

#### Syntax

`from_uri($value)`

#### Description

Decodes a uri encoded string into a string

Type | Result | Example
---- | ------ | -------
string | String | `from_uri("http://example.com/?a=%09%0D") == "http://example.com/?a=\t\r"`

## Process Information

### task_name

#### Syntax

`task_name()`

#### Description

Returns the global name of the current task. See Cloud Workflow Processes for information on tasks.

#### Arguments

None.

#### Result

A string that represents the global name of the current task.

#### Examples

~~~ ruby
concurrent do
  sub task_name: "launch_app" do
    @servers = find("servers", "db")
    @arrays = find("server_arrays", "appserver")
    concurrent do
    ​  sub task_name: "launch_servers" do
        @servers.launch()
        $name = task_name() # $name == "launch_app/launch_servers"
      end
      sub task_name: "launch_arrays" do
        @arrays.launch()
        $name = task_name() # $name == "launch_app/launch_arrays"
      end
    end
  end
  sub task_name: "notify" do
    # ... do things
  end
end
~~~

### tasks

#### Syntax

`tasks()`

#### Description

#### Arguments

None

#### Result

Returns a hash of task status keyed by global task name. Valid values for a task status are: `completed`, `aborted`, `canceled`, `paused`, or `running`.

### task_label

#### Syntax

`task_label($label)`

#### Description

Sets the label of the current task. This label is displayed in the Self-Service UI to End Users when an operation is running.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none |

#### Result

The new label string.

### task_status

#### Syntax

`task_status($task_name)`

#### Description

Returns the status of the given task. The task name can be relative or absolute (relative match is tried first then absolute if there is no task with a relative name matching the argument).

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | strings | yes | none | Name of task whose status should be returned

#### Result

`completed`, `aborted`, `canceled`, `paused` or `running`. Returns `null` for non-existent tasks.

## Data Introspection

### type

#### Syntax

`type(object)`

#### Description

Returns the name of the type of the given argument. This function is mainly meant to help developing and debugging processes. If the object is a value then the possible type names are: `string`, `number`, `boolean`, `datetime`, `null`, `array` or `hash`. If the object is a resource collection then the returned name consist of `<namespace>.<resource type>`. If the object is a declaration, then function will return `declaration`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ value _or_ declaration | yes | none | Object for which type should be retrieved

#### Result

A string representation of the object type.

#### Examples

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
$type_name = type(@servers) # rs_cm.servers
~~~

### inspect

#### Syntax

`inspect(object)`

#### Description

The `inspect()` function returns a human readable representation of the object given as argument. This function is meant as a debugging aid.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource collection _or_ value | yes | none |

#### Result

String representation of the given object.

#### Examples

~~~ ruby
@servers = rs_cm.deployments.get(filter: ["name==default"]).servers()
log_info(inspect(@servers))
~~~

## String Manipulation

### capitalize

#### Syntax

`capitalize($string)`

#### Description

Returns a string with first letter of `string` capitalized (if it is the first character) and the rest lower-case.

See also: [downcase](#string-manipulation-downcase), [upcase](#string-manipulation-upcase)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
capitalize($string) == "Hello"
$string = "HeLlO"
capitalize($string) == "Hello"
~~~

### downcase

#### Syntax

`downcase($string)`

#### Description

Returns a string with all ASCII letters in `string` changed to lower-case.

See also: [capitalize](#string-manipulation-capitalize), [upcase](#string-manipulation-upcase)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "HELLO"
downcase($string) == "hello"
$string = "HeLlO"
downcase($string) == "hello"
~~~

### gsub

#### Syntax

`gsub($string, $pattern, $replace)`

See also: [sub](#string-manipulation-sub)

#### Description

Returns a string with the all occurrences of `pattern` substituted for the `replace` argument. The pattern is typically a regular expression, but can be a string.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value or regex | yes | none |
3 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello there howard"
gsub($string, "howard", "tom") == "hello there tom"
gsub($string, /e./, "!") == "h!lo th!!howard"
~~~

### include?

#### Syntax

`include?($string, $other_str)`

#### Description

Returns true if `string` contains `other_str`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value | yes | none |

#### Result

Boolean.

#### Examples

~~~ ruby
$string = "hello"
include?($string, "el") == true
include?($string, "yo") == false
~~~

### index

#### Syntax

`index($string, $substr[, $offset])`

#### Description

Returns the index of the first occurrence of `substr` in `string`. Returns `null` if not found. If the `offset` parameter is present, it specifies the position in `string` to begin the search (can be a negative number which will be relative to the end of the string).

See also: [rindex](#string-manipulation-rindex)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value or regex | yes | none |
3 | number | no | 0 |

#### Result

Number or null.

#### Examples

~~~ ruby
$string = "hello 123"
index($string, "he") == 0
index($string, "he", 2) == null
index($string, "23") == 7
index($string, /[1-9]/) == 6
~~~

### insert

#### Syntax

`insert($string, $index, $insertion_string)`

#### Description

Returns a string with `insertion_string` inserted before the character at the given `index` of `string`. Negative indices count from the end of `string`, and insert after the given character. If a positive `index` is given past the end of `string`, `insertion_string` will be inserted at the end. If a negative `index` is given past the beginning of `string`, `insertion_string` will be inserted at the beginning.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | number | yes | none | The position at which to insert the new string
3 | string value | yes | none | The string value to insert

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
insert($string, 0, "oh ") == "oh hello"
insert($string, -1, " there") == "hello there"
insert($string, 4, "llooo") == "helllloooo"
~~~

### join

#### Syntax

`join($array[, $separator])`

#### Description

Join elements of array into a single string using given separator if any.

See also: [split](#string-manipulation-split)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value | no | "" | Empty string by default

#### Result

String.

#### Examples

~~~ ruby
$values = ["some", "dash", "delimited", "string"]
join($values, "-") == "some-dash-delimited-string"
join($values) == "somedashdelimitedstring"
~~~

### lines

#### Syntax

`lines($string[, $separator])`

#### Description

Returns an array of lines in `string` split using the supplied `separator` ($/ by default).

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value | no | $/ |

#### Result

Array

#### Examples

~~~ ruby
$string = "hello\nthere"
lines($string) == ["hello\n","there"]
lines($string, "e") == ["he", "llo\nthe", "re"]
~~~

### ljust

#### Syntax

`ljust($string, $padded_length[, $padding_value])`

See also: [rjust](#string-manipulation-rjust)

#### Description

If `padded_length` is greater than the length of `string`, returns a string of length `padded_length` with `string` left justified and padded with `padding_value`; otherwise, returns `string`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | number | yes | none |
3 | string value | no | " " |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
ljust($string, 10) == "hello     "
ljust($string, 3) == "hello"
ljust($string, "10", "end") == "helloenden"
~~~

### lstrip

#### Syntax

`lstrip($string)`

#### Description

Returns a string with leading whitespace removed from `string`.

See also: [rstrip](#string-manipulation-rstrip), [strip](#string-manipulation-strip)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "  hello"
lstrip($string) == "hello"
~~~

### pluralize

#### Syntax

`pluralize($string)`

#### Description

Returns the plural form of the word in the string. Currently only supports the English locale.

See also: [singularize](#string-manipulation-singularize)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$singular_type = "cloud"
pluralize($singular_type) == "clouds"
pluralize("ip_address") == "ip_addresses"
~~~

### reverse

#### Syntax

`reverse($string)`

#### Description

Returns a string with the characters from `string` in reverse order.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
reverse($string) == "olleh"
~~~

### rindex

#### Syntax

`rindex($string, $substr[, $offset])`

#### Description

Returns the index of the last occurrence of `substr` in `string`. Returns `null` if not found. If the `offset` parameter is present, it specifies the position in `string` to end the search — characters beyond this point will not be considered (can be a negative number which will be relative to the end of the string).

See also: [index](#string-manipulation-index)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value or regex | yes | none |
3 | number | no | none |

#### Result

Number or null.

#### Examples

~~~ ruby
$string = "hello 123 123"
rindex($string, "3") == 12
rindex($string, "3", 11) == 8
rindex($string, /1./) == 10
rindex($string, "4") == null
~~~

### rjust

#### Syntax

`rjust($string, $padded_length[, $padding_value])`

#### Description

If `padded_length` is greater than the length of `string`, returns a string of length `padded_length` with `string` right justified and padded with `padding_value`; otherwise, returns `string`.

See also: [ljust](#string-manipulation-ljust)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | number | yes | none |
3 | string value | no | " " |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
rjust($string, 10) == "     hello"
rjust($string, 3) == "hello"
rjust($string, "10", "end") == "endenhello"
~~~

### rstrip

#### Syntax

`rstrip($string)`

#### Description

Returns a string with trailing whitespace removed from `string`.

See also: [lstrip](#string-manipulation-lstrip), [strip](#string-manipulation-strip)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello  "
rstrip($string) == "hello"
~~~

### singularize

#### Syntax

`singularize($string)`

#### Description

The reverse of pluralize, returns the singular form of a word in a string. Currently only supports the English locale.

See also: [pluralize](#string-manipulation-pluralize)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$plural_type = "clouds"
singularize($plural_type) == "cloud"
singularize("ip_addresses") == "ip_address"
~~~

### split

#### Syntax

`split($string, $separator_or_regexp)`

#### Description

Split given string around matches of the given separator or regular expression.

See also: [join](#string-manipulation-join)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | String value | yes | none |
2 | String value or regex | yes | none |

#### Result

Array of strings.

#### Examples

~~~ ruby
$text = "some-dash-delimited--string--"
$values = split($text, "/-+/") # ["some", "dash", "delimited", "string"]
~~~

### strip

#### Syntax

`strip($string)`

#### Description

Returns a string with leading and trailing whitespace removed from `string`.

See also: [lstrip](#string-manipulation-lstrip), [rstrip](#string-manipulation-rstrip)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "  hello  "
lstrip($string) == "hello"
~~~

### sub

#### Syntax

`sub($string, $pattern, $replace)`

#### Description

Returns a string with the first occurrences of `pattern` substituted for the `replace` argument. The pattern is typically a regular expression, but can be a string.

See also: [gsub](#string-manipulation-gsub)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |
2 | string value or regex | yes | none |
3 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello there howard"
sub($string, "howard", "tom") == "hello there tom"
sub($string, /e./, "!") == "h!lo there howard"
~~~

### upcase

#### Syntax

`upcase($string)`

#### Description

Returns a string with all ASCII letters in `string` converted to upper-case.

See also: [capitalize](#string-manipulation-capitalize), [downcase](#string-manipulation-downcase)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string value | yes | none |

#### Result

String.

#### Examples

~~~ ruby
$string = "hello"
upcase($string) == "HELLO"
$string = "HeLlO"
upcase($string) == "HELLO"
~~~

## HTTP-HTTPS Functions

This set of functions provides the ability to call HTTP/HTTPS endpoints from within Cloud Workflow. There is one function for each of the well-known HTTP verbs (`get`, `post`, `head`, `put`, `patch`, `delete`, `options`, and `trace`). The functions take all request attributes as parameters and return the response in a hash value with the keys `code`, `headers`, `cookies`, and `body` (each containing their respective response attributes).

There is also a generic function called `http_request` which takes the verb as a parameter for any type of HTTP/HTTPS call.
General Information

### Making Requests

When using these functions, there is some specific behavior that is of interest:

* If a body is given for the request and the corresponding value is not a string then the functions will encode the value in JSON.
* The verb-specific functions take a single `url` argument that includes the scheme, host, href, and query strings.
* The generic `http_request` function takes individual arguments (`host`, `https`, `href`, `query_strings`) to form the url.

### Common Parameters for HTTP-HTTPS functions

The following parameters are available for all verb-specific and generic HTTP functions.

Name | Possible Values | Required | Description | Example | Default
---- | --------------- | -------- | ----------- | ------- | -------
headers | hash of string -> string values | no | HTTP request headers, the keys are the classical `content-type` (or `content_type`), `accepts`, etc. Passing lowercase with underscore instead of dash is OK, the implementation normalizes to standard HTTP header names behind the scenes. | `{ "X-Api-Version": "1.0" }` |
body | string (or any value if content-type is JSON) | no | The request body. When unspecified and the method is one of those that expect a body, will default to "" (empty string). A body can be given for methods that don't require it (GET, HEAD) and it will probably get discarded by the server. | |
raw_response | boolean | no | The default is `false`. When `false` (default) and the response is "application/json" (or an extension of it), the response body will contain the parsed value (not the JSON string). <br />In case of XML content (and unless `raw_response` is set to `true`), the XML is turned into a JSON-compatible data structure (a representation of the XML tree). | `true` | `false`
basic_auth | an object with keys `username` and `password` | no | Specifies a pair (username, password) for the basic authentication of this request.| `{ "username": "foo", "password": "bar" }` |
cookies | Array of cookie objects | no | An array of cookies to send to the server. Only `name` and `value` are allowed. | `[ { "name": "zz", "value": "yy" } ]` |
noredirect | boolean | no | The default is `false`. By default the http method will follow any redirection. Infinite loops are detected and raise an error. | `true` | `false`
insecure | boolean | no | The default is `false`. By default the http method will verify SSL certificates. When set to `true`, the check is not done. | `true` | `false`
signature | an object with keys `type`, `access_key`, and `secret_key` | no | Used for signing requests for AWS. The type should be `aws`. The `access_key` and `secret_key` fields specify the AWS credentials to use for signing the request. If the `access_key` or `secret_key` fields are not provided, the default AWS credentials (`AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY`) for the account will be used. Note: when using the default keys, the user launching the CAT must have "admin" role on the account in order to read credential values. | `{ "type": "aws", "access_key": "myaccesskey", "secret_key": "mysecretkey" }` |
auth | a credentials reference | no | A reference to credentials in the credentials service. When called from a policy, credentials references are automatically imported as global variables such as $$auth_aws. When developing via the console, you can use the [signer](#miscellaneous-signer) function to generate an equivalent reference. | signer("aws_default") or $$auth_aws | 

### HTTP-HTTPS Function Responses

The return value of every HTTP/S function is a hash with the following elements:

Name | Type | Description | Example
---- | ---- | ----------- | -------
code | number | The response code. Eg: 200 | 200
headers | hash | The headers from the http response | `{ "Connection": "keep-alive", "Content-Encoding": "gzip" }`
cookies | array of objects | The cookies received in the response | For a cookie received as string, "zz=yy; Domain=.foo.com; path=/; secure", it will be parsed as follows: <br/>`[ { "name": "zz", "value": "yy", "path": "/", "domain": ".foo.com","expires": <DateTime formatted value>, "secure": true }]`
body | string if `raw_response` was set to `true` (or it was set to false but could not be parsed as an object) <br/>object if `raw_response` was set to `false` (which is by default) and the content type was xml or json | The body of the response |

### http_get, http_post, http_head, http_put, http_patch, http_delete, http_options, http_trace

#### Syntax

`http_get($params), http_post($params), http_head($params), http_put($params), http_patch($params), http_delete($params), http_options($params), http_trace($params)`

#### Description

The verb-specific functions have the following parameters, in addition to the "Common Parameters" listed above. The return value from these functions is documented above in "HTTP Function Responses".


Name | Possible Values | Required | Description | Example | Default
---- | --------------- | -------- | ----------- | ------- | -------
url | string | yes | The url for the request including the scheme (http/https), host, href, as well as query strings. | `https://www.googleapis.com/drive/v2...`

### http_request

#### Syntax

`http_request($params)`

#### Description

The general function has the following parameters, in addition to the "Common Parameters" listed above. The return value from these functions is documented above in "HTTP Function Responses".

Name | Possible Values | Required | Description | Example | Default
---- | --------------- | -------- | ----------- | ------- | -------
verb | string | yes | The HTTP verb (should be one of get, post, patch, put, delete, options, head) | `get` |
host | string | yes | The host of the external service | `www.googleapis.com` |
https | boolean | no | Whether to https/http | `true` | `false`
href | string | no | The href of the target resource relative to the host. | `/drive/v2/files/123` | ""
query_strings | hash | no | Query-string values (what comes after a "?" in the URL). Keys must be strings. Values are turned into strings (arrays and hashes are JSON encoded). All the values are escaped. | `{ "updateViewedDate": true }` | `{}`

## Miscellaneous

### assert

#### Syntax

`assert(expression)`

#### Description

This function evaluates an assertion. It takes an expression that resolves to a value as an argument. If the expression does not resolve to a value, resolves to `null`, or resolves to `false` then an error is raised. In all other cases it does nothing.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | expression | yes | none | The expression that should return a value to assert

#### Result

None.

### cred

#### Syntax

`cred($cred_name)`

#### Description

Return the value of the `Credential` in Cloud Management with the given name. 
**Note:** using this function requires the `admin` role, or a [permission](/ss/reference/cat/v20161221/index.html#permissions) that grants the `admin` role. 
**Note:** It will return an exact match if available, if not will return first partial match. 

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none | The name of the `Credential` in Cloud Management

#### Result

The string value of the specified `Credential`, or
Raises an error if the Credential is not found or the user doesn't have the required privileges

### signer

#### Syntax

`signer($identifier)`

#### Description

Return a signer reference defined in the [Credentials dashboard](/policies/users/guides/credential_management.html). This is a newer version of the Cloud Management `Credential` resource. Note for policy developers: Signer references are automatically imported for all `credentials` and `auth` blocks from the Policy engine.
**Note:** using this function requires the `admin` role, or a [permission](/ss/reference/cat/v20161221/index.html#permissions) that grants the `admin` role. 
**Note:** Must exactly match the identifier field of the credential.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none | The identifier of the `Credential` in [Credentials dashboard](/policies/users/guides/credential_management.html)

#### Result

A reference to the `Credentials` resource, or raises an error if the Credentials is not found or the user doesn't have the required privileges


### jwt_encode

#### Syntax

`jwt_encode($algorithm, $payload, $key, $header_fields)`

#### Description

This function creates a JWT from the fields provided. For more information on json web tokens visit: [https://jwt.io/](https://jwt.io/)

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none | Encryption Algorithms Supported(`RS256`,`RS384`,`RS512`,`HS256`,`HS512256`,`HS384`,`HS512`)
2 | hash | yes | none | Hash Payload for jwt token
3 | string | yes | none | Encryption key for the payload, `RS* Encryption requires an RSA Key`
4 | hash | no | none | header fields, such as `typ`

#### Result

A string containing a jwt token

### keys

#### Syntax

`keys($hash)`

#### Description

Return an array made of all the keys of the provided hash.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | hash | yes | none | Hash for which keys should be retrieved

#### Result

Array of strings representing all the keys of the provided hash.

### map

#### Syntax

`map($mapping_name, $key_name, $value_name)`

#### Description

Return the value of a two level hash given a key and value name. This function is syntactic sugar around the [] operator. It may provide a better notation when writing declarative code (e.g. in resource declarations). So doing `map($hash, $key, $value)` is equivalent to `$hash[$key][$value]`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | hash | yes | none | Hash for which value should be retrieved
2 | string | yes | none | Name of key
3 | string | yes | none | Name of value

#### Result

Hash value at given key and value name.

### now

#### Syntax

`now()`

#### Description

Returns the current time in a datetime value. See the [`strftime` function](#data-conversion-strftime) for formatting a datetime into a string.

#### Arguments

None

#### Result

Date time value that represents the current time in UTC.

### rand

#### Syntax

`rand($max_value)`

#### Description

Generates a random number. If `max_value` if specified, the random number is an integer between 0 and `max_value`. If `max_value` is not specified, the random number is a double between 0 and 1.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | number | no | see above | max number to generate a random integer


### sleep

#### Syntax

`sleep($duration)`

#### Description

Makes the current task sleep for the time expressed in duration. A duration consists of numbers suffixed with s (seconds), m (minutes), h (hours) or d (days). Each element of the duration is additive (so 2m30s means 2 minutes plus 30 seconds). If no suffix is specified then the number represents seconds.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | duration | yes | none |

#### Examples

~~~ ruby
sleep(60) # sleep one minute
sleep(1h) # sleep 60 minutes
sleep(2m30s) # sleep 150 seconds
~~~

#### Result

None.

### sleep_until

#### Syntax

`sleep_until(expression)`

#### Description

This function takes an expression that resolves to a value as argument. If the expression does not resolve to a value, then an error is raised. Sleeps until the expression evaluates to a value that is neither `null` nor `false`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | expression | yes | none | The expression that should return a value that is neither `null` nor `false` for the wait to stop

#### Result

None.

### sleep_while

#### Syntax

`sleep_while(expression)`

#### Description

This function takes an expression that resolves to a value as argument. If the expression does not resolve to a value then an error is raised. Sleeps while the expression evaluates to a value that is neither `null` nor `false`.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | expression | yes | none | the expression that is run

#### Result

None.

### tag_value

#### Syntax

`tag_value(@resource, $tag_prefix)`

#### Description

Returns the `value` part of a [machine tag](/cm/rs101/tagging.html#machine-tags-vs--raw-tags-machine-tags) given the `<namespace>:<predicate>` of the tag.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | resource | yes | none | 
2 | string | yes | none | `<namespace>:<predicate>` to find

#### Result

String containing the `value` part of the tag, if it is found. Otherwise, `null`

### uuid

#### Syntax

`uuid()`

#### Description

Returns a string containing a Universally Unique IDentifier.

#### Arguments

None

#### Result

A string containing a UUID.

### values

#### Syntax

`values($hash)`

#### Description

Return an array made of all the values of the provided hash.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | hash | yes | none | Hash for which values should be retrieved

#### Result

Array of strings representing all the values of the provided hash.

### xpath

#### Syntax

`xpath($xml_string, $xpath)`

#### Description

Using a XPath string, extracts information out of an XML string.

#### Arguments

Position | Possible Values | Required | Default Value | Comment
-------- | --------------- | -------- | ------------- | -------
1 | string | yes | none | XML string
2 | string | yes | none | XPath string like "//item[2]/name/text()" or "css:div.li" path

The xpath argument can be passed a "css:" prefix, in which case the path is a CSS path, not a XPath.

#### Result

Array of [XML] strings.

