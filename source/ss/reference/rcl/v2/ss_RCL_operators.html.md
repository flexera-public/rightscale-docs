---
title: Cloud Workflow Operators
description: The RightScale Cloud Workflow Language supports a variety of operators for manipulating values and resource collections.
version_number: "2"
versions:
  - name: 1
    link: /ss/reference/rcl/v1/ss_RCL_operators.html
  - name: 2
    link: /ss/reference/rcl/v2/ss_RCL_operators.html
---

## Operators Overview

RCL supports a variety of operators for manipulating values and resource collections. There are arithmetic operators for calculations (+, -, *, /, ^, %), collections and array management operators for retrieving and adding elements as well as checking inclusion ([ ], <<, <, >), the usual equality and boolean operators (==, !=, <, >, <=, >=, &, |, !) as well as the regexp operator for match strings with regular expressions (=~, !~).

### RCL Operator Precedence

The following table lists the precedence of RCL operators. Operators are listed top to bottom, in descending precedence.

Precedence |  Operators | Notes
-----------|------------|-------
0 | `[]` |  slice operator (retrieve item(s) of array, hash or collection given an index, key or range)
1 | `^` | exponent
2 | `!`, `+`, `-` | logical not, unary plus, unary minus
3 | `*`, `/`, `%` | multiplication, division, modulo
4 | `+`, `-` | addition or string, array or collection concatenation - subtraction or array collection difference
5 | `<<` | array append
6 | `==`, `!=`, `=~`, `!~`, `>=`, `<=`, `>`, `<` | relational and equality operators
7 | `&` | bitwise AND
8 | <code>&#124;</code> | bitwise OR
9 | `&&` | logical AND
10 | <code>&#124;&#124;</code> | logical OR

## Operator Semantics

The following sections list all the operators and their semantic depending on the types of the operands. The left column represent the left hand side operand type while the top row represents the right hand side operand type. The values describe the semantic of the operation or list error if the corresponding operator cannot be applied with the given operand types.

### Arithmetic Operators

#### +

`+` | number | string | array | hash | res collection | other
--- | ------ | ------ | ----- | ---- | -------------- | -----
number | addition | error | error | error | error | error
string | concatenation | concatenation | error | error | error | error
date/time | addition (seconds) | error | error | error | error | error
array | error | error | concatenation | error | error | error
hash | error | error | error | merge left into right | error | error
res collection | error | error | error | error | concatenation | error
other | error | error | error | error | error | error

#### -

`-` | number | date/time | array | res collection | other
--- | ------ | --------- | ----- | -------------- | -----
number | subtraction | error | error | error | error
date/time | subtraction (seconds) | subtraction (seconds) | error | error | error
array | error | error | array difference | error | error
res collection | error | error | error | coll difference | error
other | error | error | error | error | error

#### *

`*` | number | other
--- | ------ | -----
number | multiplication | error
other | error | error

#### /

`/` | number | other
--- | ------ | -----
number | division (integral if both numbers are integers) | error
other | error | error

#### %

`%` | number | other
--- | ------ | -----
number | modulo (non integer numbers are rounded) | error
other | error | error

#### ^

`^` | number | other
--- | ------ | -----
number | power | error
other | error | error

### Collection and Array Operator

#### <<

`<<` | all
---- | ---
array | Append object in right hand side to array in left hand side
other | error

#### [ ]

The slice operator returns elements of an array, a hash or a resource collection using an index or a range (array and resource collection) or a key (hash). A range is specified using `x..y` where x and y are optional (no x means from the start of the array or collection, no y means to the end of the array or collection). Note that retrieving elements of a resource collection creates a new resource collection consisting of these elements.

`[ ]` | number | string | range | other
----- | ------ | ------ | ----- | -----
res collection | Creates new collection consisting of the element at given index. | error | Creates a new collection consisting of the element in the given range (`x..y` where x and y are optional) | error
array | value at given index | error | Creates a new array consisting of the element in the given range (`x..y` where x and y are optional) | error
hash | error | value associated with given key if any, `null` otherwise | error | error
string | Create string composed of character at given index. | error | Create string made of characters in the given range. Range bounds may have negative values (from last or from beginning). | error
other | error | error | error | error

#### [ ]=

The slice assign operator replaces an element of an array, hash or resource collection or a range of an array or resource collection with given elements.

`[ ]=` | number | string | range | other
------ | ------ | ------ | ----- | -----
res collection | Replaces resource at given index. Right hand side must be a resource collection. | error | Replace elements in the given range with elements of right hand side resource collection. | error
array | Replace value at given index | error | Replace elements in the given range with elements of the given array. Right hand side must be an array. | error
hash | error | Replace/set value associated with given key | error | error
other | error | error | error | error

### Regular expression-Include Operators

#### =~

`=~` | string | array | other
---- | ------ | ----- | -----
string | `true` if regular expression given in right operand matches string given in left operand | error | error
array | `true` if array contains string | `true` if array contains array | `true` if array contains value
hash | `true` if hash has that key | error | error
other | error | error | error

The right hand side of a regular expression comparison may use the symbol `/` to delineate the pattern. The ending `/` may be followed by the following options:

* `i` for case insensitive matching
* `m` for multi-line string matching
* `x` for extended syntax support (whitespaces in the pattern are ignored)

##### Examples

~~~ ruby
"foo" =~ "foo" # true
"foo" =~ /foo/ # true
"foo" =~ /FOO/i #true
~~~

#### !~

`a !~ b` is equivalent to `!(a =~ b)`

### Relational and Equality Operators

#### ==, !=

Equality comparison is done recursively if values are arrays or hashes.

`==` | all
---- | ---
all | `true` if operands have same value, `false` otherwise

#### <, <=, >, >=

`<` | number | string | date/time | res collection | array | other
--- | ------ | ------ | --------- | -------------- | ----- | -----
number | less than | error | error | error | error | error
string | error | lexicographical less than | error | error | error | error
date/time | error | error | less than | error | error | error
res collection | error | error | error | `@a < @b`: `true` if all elements of `@a` are also elements of `@b` | error | error
array | error | error | error | error | `$a < $b`: `true` if all elements of `$a` are also elements of `$b` | error
other | error | error | error | error | error | error

Note:  `>`, `<=`, and `>=`  are omitted for brevity (greater than, lesser or equal than, greater or equal than, respectively).

### Logical Operators

#### &

'Bitwise and'. Applied to resource collections (or arrays) it returns all elements that appear in both resource collections (or arrays).

`&` | `false` | `null` | `true` | array | res collection | other
----|---------|--------|--------|-------|----------------|-------
`false` | `false` | `false` | `false` | `false` | `false` | `false`
`null` | `false` | `false` | `false` | `false` | `false` | `false`
`true` | `false` | `false` | `true` | `true` | `true` | `true`
array | error | error | error | intersection of the two arrays | error | error
res collection | error | error | error | error | new collection with common hrefs _or_ error if collections are of different types | error
other | error | error | error | error | error | error

#### &&

'Logical and'. Returns the right hand side operand if the left hand side is neither `false` nor `null` (otherwise returns left hand side operand). In the following table "(1)" and "(2)" refer the position of that particular argument in the expression.

`&&` | `false` | `null` | `true` | other (1)
-----|---------|--------|--------|-----------
`false` | `false` | `false` | `false` | `false`
`null` | `null` | `null` | `null` | `null`
`true` | `false` | `null` | `true` | (1)
other (2) | `false` | `null` | `true` | (2)

#### |

'Bitwise or'. Applied to resource collections (or arrays), returns all elements that appear in either resource collection (or array).

!!info*Note:* This operator differs from the `+` operator when applied to collection in that it will produce only one instance of each element in each collection even if the same element appears in both.

<code>&#124;</code> | `false` | `null` | `true` | other
--------------------|---------|--------|--------|-------
`false` | `false` | `false` | `true` | `true`
`null` | `false` | `false` | `true` | `true`
`true` | `true` | `true` | `true` | `true`
other | error | error | error | error

#### ||

'Logical or'. Returns the left hand side operand if it is neither `false` nor `null` (otherwise returns right hand side operand). In the following table "(1)" and "(2)" refer the position of that particular argument in the expression.

<code>&#124;&#124;</code> | `false` | `null` | `true` | other (2)
--------------------------|---------|--------|--------|-----------
`false` | `false` | `null` | `true` | (2)
`null` | `false` | `null` | `true` | (2)
`true` | `true` | `true` | `true` | `true`
other (1) | (1) | (1) | (1) | (1)

### Unary Operators

#### -

`-` is the unary minus operator:

`-` | value    
--- | ---
number | opposite value
other | error

#### !

`!` is the logical not operator. Note that it applies to all types (negating a non boolean value returns `true` if it is either `false` or `null`, `false` otherwise):

`!` | value
--- | ---   
`false` | `true`
`null` | `true`
other | `false`
