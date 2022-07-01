---
title: Sample API Requests and Responses
description: This page lists sample request headers, request bodies, response headers, and response bodies for API call to the Self-Service API.
---

!!warning*Warning:* Please reference the [API documentation](../guides/ss_api_guide.html) for up-to-date API documentation.

This page lists sample request headers, request bodies, response headers, and response bodies for API call to the [Self-Service API](/api)

!!info*Note:* Although not shown below, all request headers also contain authentication information, such as cookies or oauth headers.

## AccountPreference
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "acc_1_AccountPreferenceFunctionalTests__20150418222452207217",
  "value": "a_value",
  "group_name": "a_group"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:02 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/catalog/accounts/60073/account_preferences/acc_1_AccountPreferenceFunctionalTests__20150418222452207217",
  "x_request_uuid": "c1c29eba-e619-11e4-8891-add2303a55da",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:07 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "c4cee172-e619-11e4-8e39-559e3e164a08",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:03 GMT",
  "content_type": "application/vnd.rightscale.self_service.account_preference",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "c2484fb0-e619-11e4-890d-d3231ecf4fc1",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "name": "primary_color_border",
    "href": "/api/catalog/accounts/60073/account_preferences/primary_color_border",
    "kind": "self_service#account_preference",
    "value": "#476189",
    "group_name": "portal_customization",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-07-31T19:29:36.513+00:00",
      "updated_at": "2014-07-31T19:29:36.513+00:00"
    }
  },
  {
    "name": "primary_color_border",
    "href": "/api/catalog/accounts/60073/account_preferences/primary_color_border",
    "kind": "self_service#account_preference",
    "value": "#0f4e07",
    "group_name": "portal_customization",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2015-04-08T04:24:25.499+00:00",
      "updated_at": "2015-04-08T04:24:25.499+00:00"
    }
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:03 GMT",
  "content_type": "application/vnd.rightscale.self_service.account_preference",
  "content_length": "461",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "c20427b8-e619-11e4-957f-43d37728d7f8",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "name": "acc_1_AccountPreferenceFunctionalTests__20150418222452207217",
  "href": "/api/catalog/accounts/60073/account_preferences/acc_1_AccountPreferenceFunctionalTests__20150418222452207217",
  "kind": "self_service#account_preference",
  "value": "a_value",
  "group_name": "a_group",
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-18T22:25:02.761+00:00",
    "updated_at": "2015-04-18T22:25:02.761+00:00"
  }
}
~~~
## Application
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "app_7a_ApplicationFunctionalTests__20150418222452207217",
  "short_description": "description for ApplicationFunctionalTests__20150418222452207217",
  "compiled_cat": "{\"name\":\"QA_CAT_test_for_SS_API_RL\",\"rs_ca_ver\":20131202,\"short_description\":\"CAT for SS_API testing\",\"long_description\":\"A CAT for SS_API testing\",\"parameters\":{},\"mappings\":{},\"conditions\":{},\"resources\":{},\"outputs\":{\"toggle_out\":{\"label\":\"The_output\",\"index\":1}},\"operations\":{\"do_nothing\":{\"definition\":\"do_nothing\",\"description\":\"custom operation that does nothing\"},\"write_to_output\":{\"definition\":\"empty_def_a\",\"description\":\"generates a output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output\"}},\"write_to_output_again\":{\"definition\":\"empty_def_b\",\"description\":\"generates a difference output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output_again\"}},\"start\":{\"definition\":\"stop_start\"},\"stop\":{\"definition\":\"stop_start\"}},\"definitions\":{\"do_nothing\":{\"arguments\":[],\"returns\":[],\"source\":\"define do_nothing() do\\n\\tsleep(15)\\nend\\n\"},\"empty_def_a\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_a() do\\nend\\n\"},\"empty_def_b\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_b() do\\nend\\n\"},\"stop_start\":{\"arguments\":[],\"returns\":[],\"source\":\"define stop_start() do\\n  # Do nothing\\nend\\n\"}},\"namespaces\":[],\"required_parameters\":[],\"source\":\"name \\\"QA_CAT_test_for_SS_API_RL\\\"\\nrs_ca_ver 20131202\\nshort_description \\\"CAT for SS_API testing\\\"\\nlong_description \\\"A CAT for SS_API testing\\\"\\n\\n#########\\n# Parameters\\n#########\\n\\n#########\\n# Mappings\\n#########\\n\\n#########\\n# Resources\\n#########\\n\\n#########\\n# Operations\\n#########\\n\\noutput \\\"toggle_out\\\" do\\n label \\\"The_output\\\"\\nend\\n\\noperation \\\"do_nothing\\\" do\\n  description \\\"custom operation that does nothing\\\"\\n  definition \\\"do_nothing\\\"\\nend\\n\\n# The following two Custom_Operations are used in ScheduledOperation\\n# functional tests\\noperation \\\"write_to_output\\\" do\\n  description \\\"generates a output for the CloudApp\\\"\\n  definition \\\"empty_def_a\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output'\\n  }\\n  end\\nend\\n\\noperation \\\"write_to_output_again\\\" do\\n  description \\\"generates a difference output for the CloudApp\\\"\\n  definition \\\"empty_def_b\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output_again'\\n  } \\n  end\\nend\\n\\n\\noperation \\\"start\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\noperation \\\"stop\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\n#########\\n# Definitions\\n#########\\n\\ndefine do_nothing() do\\n\\tsleep(15)\\nend\\n\\ndefine empty_def_a() do\\nend\\n\\ndefine empty_def_b() do\\nend\\n\\ndefine stop_start() do\\n  # Do nothing\\nend\\n\"}\n",
  "schedules[]": [
    {
      "name": "schedule_1_ApplicationFunctionalTests__20150418222452207217",
      "description": null,
      "created_from": "/api/designer/collections/60073/schedules/5532d9d173656c7f15150000",
      "start_recurrence": {
        "hour": 8,
        "minute": 0,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": 18,
        "minute": 0,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      }
    }
  ],
  "long_description": "a long description for ApplicationFunctionalTests__20150418222452207217",
  "schedule_required": true
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:14 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/catalog/catalogs/60073/applications/5532d9ca73656c7ec5480000",
  "x_request_uuid": "c8ace6ae-e619-11e4-9057-fa2f4696e524",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "multipart/form-data"
}
~~~
#### Request Querystring
~~~
ids=5532d9f673656c7ec54e0000,5532d9f273656c7ec0540000
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:49:38 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_457454400.6794732237370781",
  "content_length": "421",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<457454400.23725180112572408>",
  "x_request_uuid": "3184bd0c-e61d-11e4-82f7-36ccd20bd137",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_457454400.6794732237370781
Content-ID: <457111800.14048652709952425>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532d9f673656c7ec54e0000"


--Boundary_457454400.6794732237370781
Content-ID: <457447800.21360393285272772>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532d9f273656c7ec0540000"


--Boundary_457454400.6794732237370781--

~~~
### download

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
api_version=1.0
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:26:06 GMT",
  "content_type": "application/octet-stream",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "content_disposition": "attachment; filename=\"app_1_ApplicationFunctionalTests__20150418222452207217\"",
  "x_request_uuid": "e80853c6-e619-11e4-83bd-a1f7b2e0a481",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
name "QA_CAT_test_for_SS_API_RL"
rs_ca_ver 20131202
short_description "CAT for SS_API testing"
long_description "A CAT for SS_API testing"

#########
# Parameters
#########

#########
# Mappings
#########

#########
# Resources
#########

#########
# Operations
#########

output "toggle_out" do
 label "The_output"
end

operation "do_nothing" do
  description "custom operation that does nothing"
  definition "do_nothing"
end

# The following two Custom_Operations are used in ScheduledOperation
# functional tests
operation "write_to_output" do
  description "generates a output for the CloudApp"
  definition "empty_def_a"
  output_mappings do {
    $toggle_out => 'wrote_to_output'
  }
  end
end

operation "write_to_output_again" do
  description "generates a difference output for the CloudApp"
  definition "empty_def_b"
  output_mappings do {
    $toggle_out => 'wrote_to_output_again'
  }
  end
end


operation "start" do
  definition "stop_start"
end

operation "stop" do
  definition "stop_start"
end

#########
# Definitions
#########

define do_nothing() do
	sleep(15)
end

define empty_def_a() do
end

define empty_def_b() do
end

define stop_start() do
  # Do nothing
end

~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:49:39 GMT",
  "content_type": "application/vnd.rightscale.self_service.application",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "31c66e14-e61d-11e4-8ccd-15c22f99633c",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#application",
    "id": "53dc48412b5b92e482000005",
    "name": "TEST - RCL OOE",
    "href": "/api/catalog/catalogs/60073/applications/53dc48412b5b92e482000005",
    "short_description": "Test for the OOE in RCL.",
    "parameters": [

    ],
    "required_parameters": [

    ],
    "schedules": [

    ],
    "template_info": {
      "href": "/designer/collections/60073/templates/53a863c1eaa2cc9d17000001",
      "name": "TEST - RCL OOE"
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-08-02T02:09:05.738+00:00",
      "updated_at": "2014-08-02T02:09:41.365+00:00"
    }
  },
  {
    "kind": "self_service#application",
    "id": "53dc455d2b5b92e482000001",
    "name": "Development All-in-One",
    "href": "/api/catalog/catalogs/60073/applications/53dc455d2b5b92e482000001",
    "short_description": "All-in-One Server for development purposes.",
    "long_description": "Development server with basic Puppet setup",
    "parameters": [
      {
        "name": "puppet_base_class",
        "description": null,
        "type": "string",
        "default": null,
        "operations": null,
        "ui": {
          "label": "Puppet Base Class",
          "category": "Puppet",
          "index": 1
        },
        "validation": {
          "no_echo": null,
          "min_length": null,
          "max_length": null,
          "min_value": null,
          "max_value": null,
          "allowed_pattern": null,
          "allowed_values": [
            "node_staging::all_in_one_nginx"
          ],
          "constraint_description": null
        }
      },
      {
        "name": "puppet_environment",
        "description": null,
        "type": "string",
        "default": "staging",
        "operations": null,
        "ui": {
          "label": "Puppet Environment",
          "category": "Puppet",
          "index": 2
        },
        "validation": {
          "no_echo": null,
          "min_length": null,
          "max_length": null,
          "min_value": null,
          "max_value": null,
          "allowed_pattern": null,
          "allowed_values": [
            "staging",
            "production"
          ],
          "constraint_description": null
        }
      },
      {
        "name": "puppet_node",
        "description": null,
        "type": "string",
        "default": null,
        "operations": null,
        "ui": {
          "label": "Puppet Node",
          "category": "Puppet",
          "index": 3
        },
        "validation": {
          "no_echo": null,
          "min_length": null,
          "max_length": null,
          "min_value": null,
          "max_value": null,
          "allowed_pattern": null,
          "allowed_values": [

          ],
          "constraint_description": null
        }
      }
    ],
    "required_parameters": [
      "puppet_base_class",
      "puppet_environment",
      "puppet_node"
    ],
    "schedules": [

    ],
    "template_info": {
      "href": "/designer/collections/60073/templates/53dc45552b5b92ace8000001",
      "name": "Development All-in-One"
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-08-02T01:56:45.089+00:00",
      "updated_at": "2014-08-02T01:57:04.982+00:00"
    }
  }
]
~~~
### launch

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "schedule_name": "schedule_4_ApplicationFunctionalTests__20150418222452207217",
  "end_date": "3017-07-24T00:00:00+00:00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:26:15 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "location": "/api/manager/projects/60073/executions/5532da0473656c7641000000",
  "x_request_uuid": "eb635ed0-e619-11e4-9437-b0621548d0a9",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:49:38 GMT",
  "content_type": "application/vnd.rightscale.self_service.application",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "3137a418-e61d-11e4-9c2d-1facc30a66ce",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#application",
  "id": "5532d9ca73656c7ec5480000",
  "name": "[u]app_1_ApplicationFunctionalTests__20150418222452207217",
  "href": "/api/catalog/catalogs/60073/applications/5532d9ca73656c7ec5480000",
  "short_description": "a_new_short_description",
  "long_description": "a_new_long_description",
  "parameters": [

  ],
  "required_parameters": [

  ],
  "schedules": [
    {
      "name": "updated_schedule_1_ApplicationFunctionalTests__20150418222452207217",
      "description": "",
      "start_recurrence": {
        "hour": 8,
        "minute": 0,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": 18,
        "minute": 0,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "created_from": "/api/designer/collections/60073/schedules/5532df8073656c7f080d0000"
    }
  ],
  "template_info": {
    "href": null,
    "name": "QA_CAT_test_for_SS_API_RL"
  },
  "compiled_cat": "{\"name\":\"QA_CAT_test_for_SS_API_RL\",\"rs_ca_ver\":20131202,\"short_description\":\"CAT for SS_API testing\",\"long_description\":\"A CAT for SS_API testing\",\"parameters\":{},\"mappings\":{},\"conditions\":{},\"resources\":{},\"outputs\":{\"toggle_out\":{\"label\":\"The_output\",\"index\":1}},\"operations\":{\"do_nothing\":{\"definition\":\"do_nothing\",\"description\":\"custom operation that does nothing\"},\"write_to_output\":{\"definition\":\"empty_def_a\",\"description\":\"generates a output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output\"}},\"write_to_output_again\":{\"definition\":\"empty_def_b\",\"description\":\"generates a difference output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output_again\"}},\"start\":{\"definition\":\"stop_start\"},\"stop\":{\"definition\":\"stop_start\"}},\"definitions\":{\"do_nothing\":{\"arguments\":[],\"returns\":[],\"source\":\"define do_nothing() do\\n\\tsleep(15)\\nend\\n\"},\"empty_def_a\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_a() do\\nend\\n\"},\"empty_def_b\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_b() do\\nend\\n\"},\"stop_start\":{\"arguments\":[],\"returns\":[],\"source\":\"define stop_start() do\\n  # Do nothing\\nend\\n\"}},\"namespaces\":[],\"required_parameters\":[],\"source\":\"name \\\"QA_CAT_test_for_SS_API_RL\\\"\\nrs_ca_ver 20131202\\nshort_description \\\"CAT for SS_API testing\\\"\\nlong_description \\\"A CAT for SS_API testing\\\"\\n\\n#########\\n# Parameters\\n#########\\n\\n#########\\n# Mappings\\n#########\\n\\n#########\\n# Resources\\n#########\\n\\n#########\\n# Operations\\n#########\\n\\noutput \\\"toggle_out\\\" do\\n label \\\"The_output\\\"\\nend\\n\\noperation \\\"do_nothing\\\" do\\n  description \\\"custom operation that does nothing\\\"\\n  definition \\\"do_nothing\\\"\\nend\\n\\n# The following two Custom_Operations are used in ScheduledOperation\\n# functional tests\\noperation \\\"write_to_output\\\" do\\n  description \\\"generates a output for the CloudApp\\\"\\n  definition \\\"empty_def_a\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output'\\n  }\\n  end\\nend\\n\\noperation \\\"write_to_output_again\\\" do\\n  description \\\"generates a difference output for the CloudApp\\\"\\n  definition \\\"empty_def_b\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output_again'\\n  } \\n  end\\nend\\n\\n\\noperation \\\"start\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\noperation \\\"stop\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\n#########\\n# Definitions\\n#########\\n\\ndefine do_nothing() do\\n\\tsleep(15)\\nend\\n\\ndefine empty_def_a() do\\nend\\n\\ndefine empty_def_b() do\\nend\\n\\ndefine stop_start() do\\n  # Do nothing\\nend\\n\"}\n",
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-18T22:25:14.342+00:00",
    "updated_at": "2015-04-18T22:49:37.377+00:00"
  }
}
~~~
### update

#### Request Method
`PUT`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "[u]app_1_ApplicationFunctionalTests__20150418222452207217"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:49:33 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "2e61c0d4-e61d-11e4-9752-36c34ed82d03",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
## Execution
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "exe_SS-1765_ExecutionFunctionalTests__20150418222452207217",
  "template_href": "/api/designer/collections/60073/templates/55328d7973656c7f0c2e0000",
  "schedules[]": [
    {
      "name": "exe_SS-1765_sch_1_ExecutionFunctionalTests__20150418222452207217",
      "start_recurrence": {
        "hour": "23",
        "minute": "4",
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": "23",
        "minute": "4",
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      }
    },
    {
      "name": "exe_SS-1765_sch_2_ExecutionFunctionalTests__20150418222452207217",
      "start_recurrence": {
        "hour": "23",
        "minute": "4",
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": "23",
        "minute": "4",
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      }
    }
  ],
  "schedule_required": true,
  "current_schedule": "exe_SS-1765_sch_1_ExecutionFunctionalTests__20150418222452207217"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:02:34 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/manager/projects/60073/executions/5532e28773656c21ca593a01",
  "x_request_uuid": "fc7c82b4-e61e-11e4-933a-d4f859d9ad4d",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:02:16 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_760010800.17032726819131705",
  "content_length": "422",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<760010800.7775564528141465>",
  "x_request_uuid": "56ae5494-e627-11e4-882f-0e88e8805c77",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_760010800.17032726819131705
Content-ID: <759987600.4003622811310279>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532e29673656c21ca653a01"


--Boundary_760010800.17032726819131705
Content-ID: <760001200.1640445715714619>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532e28e73656c21ca5f3a01"


--Boundary_760010800.17032726819131705--

~~~
### download

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
api_version=1.0
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:34:45 GMT",
  "content_type": "application/octet-stream",
  "content_length": "68",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_disposition": "attachment; filename=\"exe_1_ExecutionFunctionalTests__20150418222452207217\"",
  "x_request_uuid": "7ee99062-e623-11e4-87f1-0f4bffdd6740",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
name "Exe CAT"
rs_ca_ver 20131202
short_description "A short desc."

~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:29:47 GMT",
  "content_type": "application/vnd.rightscale.self_service.execution",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "c9678e60-e622-11e4-8ed2-7e67c7fdd7a6",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#execution",
    "id": "53cd4db24853aae026000001",
    "name": "ROL - test",
    "href": "/api/manager/projects/60073/executions/53cd4db24853aae026000001",
    "description": "Test all operations are called",
    "status": "running",
    "cost": {
      "value": "0.00",
      "unit": "$",
      "updated_at": "2015-02-03T18:10:04.023+00:00"
    },
    "deployment": "/api/deployments/461576093",
    "deployment_url": "https://moo-93.test.rightscale.com/acct/60073/deployments/461576093",
    "configuration_options": [

    ],
    "outputs": [

    ],
    "available_operations": [
      {
        "name": "provision",
        "description": "Tip all the boxes",
        "parameters": [

        ]
      },
      {
        "name": "decommission",
        "description": "Tip all the boxes",
        "parameters": [

        ]
      },
      {
        "name": "disable",
        "description": "Tip all the boxes",
        "parameters": [

        ]
      },
      {
        "name": "Something custom",
        "description": "Launch a bunch of tasks",
        "parameters": [

        ]
      },
      {
        "name": "terminate",
        "description": "Terminate CloudApp, destroy all cloud resources created by the CloudApp",
        "parameters": [

        ]
      }
    ],
    "available_actions": [
      "stop",
      "terminate"
    ],
    "running_operations": [

    ],
    "api_resources": [

    ],
    "latest_notifications": [

    ],
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "scheduled": false,
    "timestamps": {
      "created_at": "2014-07-21T17:28:18.688+00:00",
      "launched_at": "2014-07-21T17:28:18.967+00:00",
      "terminated_at": null
    },
    "links": {
      "running_operations": {
        "href": "/api/manager/projects/60073/operations?filter[]=execution_id==53cd4db24853aae026000001&filter[]=status==running"
      },
      "latest_notifications": {
        "href": "/api/manager/projects/60073/notifications?filter[]=execution_id==53cd4db24853aae026000001"
      }
    },
    "launched_from_summary": {
      "type": "source",
      "value": "source"
    },
    "schedule_required": false,
    "schedules": [

    ]
  },
  {
    "kind": "self_service#execution",
    "id": "53e00cea9ac911523500004a",
    "name": "vvb test launch from designer, after publish",
    "href": "/api/manager/projects/60073/executions/53e00cea9ac911523500004a",
    "description": "Creates all the available CAT resources",
    "status": "canceling_operations",
    "cost": {
      "value": "0.00",
      "unit": "$",
      "updated_at": "2015-02-03T18:16:55.139+00:00"
    },
    "deployment": "/api/deployments/460071093",
    "deployment_url": "https://moo-93.test.rightscale.com/acct/60073/deployments/460071093",
    "configuration_options": [
      {
        "name": "cloud",
        "type": "string",
        "value": "AWS West Coast"
      },
      {
        "name": "instance_size",
        "type": "string",
        "value": "2x cores, 3.5GB RAM"
      },
      {
        "name": "operating_system",
        "type": "string",
        "value": "Ubuntu 12.04"
      }
    ],
    "outputs": [

    ],
    "available_operations": [

    ],
    "available_actions": [

    ],
    "running_operations": [

    ],
    "api_resources": [
      {
        "name": "qa_resource_volume",
        "type": "volumes",
        "value": {
          "href": "/api/clouds/6/volumes/EH8MPRIQ8L1RQ",
          "details": {
            "created_at": "2014/08/04 22:45:10 +0000",
            "status": "available",
            "links": [
              {
                "rel": "cloud",
                "href": "/api/clouds/6"
              },
              {
                "rel": "datacenter",
                "href": "/api/clouds/6/datacenters/4IQCN3H56DF94"
              },
              {
                "rel": "volume_type",
                "href": "/api/clouds/6/volume_types/C820GQAKIPQII"
              },
              {
                "rel": "volume_snapshots",
                "href": "/api/clouds/6/volumes/EH8MPRIQ8L1RQ/volume_snapshots"
              },
              {
                "rel": "recurring_volume_attachments",
                "href": "/api/clouds/6/volumes/EH8MPRIQ8L1RQ/recurring_volume_attachments"
              }
            ],
            "volume_type": {
              "created_at": "2012/11/30 03:56:06 +0000",
              "links": [
                {
                  "rel": "self",
                  "href": "/api/clouds/6/volume_types/C820GQAKIPQII"
                },
                {
                  "rel": "cloud",
                  "href": "/api/clouds/6"
                }
              ],
              "resource_uid": "standard",
              "size": "",
              "updated_at": "2014/07/25 00:46:36 +0000",
              "name": "standard",
              "actions": [

              ],
              "description": "Standard volume"
            },
            "resource_uid": "vol-0d9b0f08",
            "size": 1,
            "updated_at": "2014/08/04 22:45:12 +0000",
            "name": "qa_resource_volume",
            "actions": [

            ],
            "description": null
          }
        }
      }
    ],
    "latest_notifications": [

    ],
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "scheduled": false,
    "timestamps": {
      "created_at": "2014-08-04T22:44:58.723+00:00",
      "launched_at": "2014-08-04T22:44:58.919+00:00",
      "terminated_at": null
    },
    "links": {
      "running_operations": {
        "href": "/api/manager/projects/60073/operations?filter[]=execution_id==53e00cea9ac911523500004a&filter[]=status==running"
      },
      "latest_notifications": {
        "href": "/api/manager/projects/60073/notifications?filter[]=execution_id==53e00cea9ac911523500004a"
      }
    },
    "launched_from_summary": {
      "type": "template",
      "value": {
        "name": "SMOKE_TEST_QA_volume_only",
        "href": "/designer/collections/60073/templates/53e00a502b5b920e73000001"
      }
    },
    "schedule_required": false,
    "schedules": [

    ]
  }
]
~~~
### launch

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:38:41 GMT",
  "content_length": "54",
  "connection": "keep-alive",
  "status": "202 Accepted",
  "context_type": "text/plain",
  "x_request_uuid": "0a94b45c-e624-11e4-8eb1-b3b6925f74db",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
The response has been accepted and is being processed.
~~~
### multi_launch

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
ids=5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00
~~~
#### Request Body
~~~ js
{
  "ids": "5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:46:37 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_1297539800.05215494229511186",
  "content_length": "860",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<1297539800.6027376318546983>",
  "x_request_uuid": "23504bf4-e625-11e4-8e50-cefd94ae8617",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_1297539800.05215494229511186
Content-ID: <1297429200.6798423120452644>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2ae73656c4c41d22f00"

The response has been accepted and is being processed.
--Boundary_1297539800.05215494229511186
Content-ID: <1297439200.8950128211897471>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2a673656c36a39d7800"

The response has been accepted and is being processed.
--Boundary_1297539800.05215494229511186
Content-ID: <1297531200.35628007292824804>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e29f73656c36a38f7800"

The response has been accepted and is being processed.
--Boundary_1297539800.05215494229511186--

~~~
### multi_start

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
ids=5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00
~~~
#### Request Body
~~~ js
{
  "ids": "5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:50:34 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_926628600.6465429441429494",
  "content_length": "848",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<926628600.37352077888911694>",
  "x_request_uuid": "b2ad008a-e625-11e4-8457-6aad6e405dab",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_926628600.6465429441429494
Content-ID: <926432000.2761494766554078>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2ae73656c4c41d22f00"

The response has been accepted and is being processed.
--Boundary_926628600.6465429441429494
Content-ID: <926608000.9758196819952547>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2a673656c36a39d7800"

The response has been accepted and is being processed.
--Boundary_926628600.6465429441429494
Content-ID: <926616800.8101438060930268>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e29f73656c36a38f7800"

The response has been accepted and is being processed.
--Boundary_926628600.6465429441429494--

~~~
### multi_stop

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
ids=5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00
~~~
#### Request Body
~~~ js
{
  "ids": "5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:46:43 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_1301460600.6950516103108679",
  "content_length": "856",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<1301460600.2681962964717839>",
  "x_request_uuid": "28cf9328-e625-11e4-8b49-a7cc5d29e4f3",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_1301460600.6950516103108679
Content-ID: <1301429800.5143591523800465>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2ae73656c4c41d22f00"

The response has been accepted and is being processed.
--Boundary_1301460600.6950516103108679
Content-ID: <1301439600.8987164337341252>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2a673656c36a39d7800"

The response has been accepted and is being processed.
--Boundary_1301460600.6950516103108679
Content-ID: <1301451200.13285003547416674>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e29f73656c36a38f7800"

The response has been accepted and is being processed.
--Boundary_1301460600.6950516103108679--

~~~
### multi_terminate

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
ids=5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00
~~~
#### Request Body
~~~ js
{
  "ids": "5532e29f73656c36a38f7800,5532e2a673656c36a39d7800,5532e2ae73656c4c41d22f00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:43:03 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_711272400.2841751552274049",
  "content_length": "850",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<711272400.8114442844383472>",
  "x_request_uuid": "a55dad40-e624-11e4-8b85-a5148aeedd0d",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_711272400.2841751552274049
Content-ID: <711137600.13982069061227753>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2ae73656c4c41d22f00"

The response has been accepted and is being processed.
--Boundary_711272400.2841751552274049
Content-ID: <711238000.15120869560407957>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e2a673656c36a39d7800"

The response has been accepted and is being processed.
--Boundary_711272400.2841751552274049
Content-ID: <711256600.3124736925184499>
Content-Type: text/plain
Status: 202
Context-Type: text/plain
Content-Disposition: form-data; name="5532e29f73656c36a38f7800"

The response has been accepted and is being processed.
--Boundary_711272400.2841751552274049--

~~~
### patch

#### Request Method
`PATCH`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "ends_at": "3018-07-24T00:00:00.000+00:00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:54:43 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "48aa9a0c-e626-11e4-8671-a86e41c0d01b",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:54:50 GMT",
  "content_type": "application/vnd.rightscale.self_service.execution",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "4cf9f9a4-e626-11e4-905f-76d9fa646698",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#execution",
  "id": "5532e2d873656c4ce8f52a02",
  "name": "exe_SS-1765_ExecutionFunctionalTests__20150418222452207217",
  "href": "/api/manager/projects/60073/executions/5532e2d873656c4ce8f52a02",
  "status": "running",
  "cost": {
    "value": "0.00",
    "unit": "$",
    "updated_at": "2015-04-18T23:07:45.940+00:00"
  },
  "deployment": "/api/deployments/506647093",
  "deployment_url": "https://moo-93.test.rightscale.com/acct/60073/deployments/506647093",
  "configuration_options": [

  ],
  "outputs": [

  ],
  "available_operations": [
    {
      "name": "custom_operation",
      "description": null,
      "parameters": [
        {
          "name": "number_param",
          "description": null,
          "type": "number",
          "default": 3,
          "operations": null,
          "ui": {
            "label": "Constrained number",
            "category": null,
            "index": 1
          },
          "validation": {
            "no_echo": null,
            "min_length": null,
            "max_length": null,
            "min_value": 2,
            "max_value": 5,
            "allowed_pattern": null,
            "allowed_values": [
              1,
              3,
              5,
              7
            ],
            "constraint_description": "Must be >=2, <=4, and in [1, 3, 7] (must be 3)."
          }
        },
        {
          "name": "string_param_values",
          "description": null,
          "type": "string",
          "default": "aaa",
          "operations": null,
          "ui": {
            "label": "Value-constrained string",
            "category": null,
            "index": 2
          },
          "validation": {
            "no_echo": null,
            "min_length": 2,
            "max_length": 4,
            "min_value": null,
            "max_value": null,
            "allowed_pattern": null,
            "allowed_values": [
              "a",
              "aaa",
              "aaaa"
            ],
            "constraint_description": "Must be at least 2 characters, at most 4 characters, and in ['a', 'aaa', 'aaaaa'] (must be 'aaa')."
          }
        },
        {
          "name": "string_param_pattern",
          "description": null,
          "type": "string",
          "default": "aba",
          "operations": null,
          "ui": {
            "label": "Pattern-constrained string",
            "category": null,
            "index": 3
          },
          "validation": {
            "no_echo": null,
            "min_length": 2,
            "max_length": 4,
            "min_value": null,
            "max_value": null,
            "allowed_pattern": "[a-zA-Z][a-zA-Z][a-zA-Z]",
            "allowed_values": [

            ],
            "constraint_description": "Must be at least 2 characters, at most 4 characters, and be three alphabetic characters."
          }
        },
        {
          "name": "list_param",
          "description": null,
          "type": "list",
          "default": [
            "a",
            "b",
            "c"
          ],
          "operations": null,
          "ui": {
            "label": "Constrained list",
            "category": null,
            "index": 4
          },
          "validation": {
            "no_echo": null,
            "min_length": 2,
            "max_length": 4,
            "min_value": null,
            "max_value": null,
            "allowed_pattern": null,
            "allowed_values": [

            ],
            "constraint_description": "Must be at least 2 elements and at most 4 elements."
          }
        },
        {
          "name": "num_wo_allowed_values",
          "description": null,
          "type": "number",
          "default": 21,
          "operations": null,
          "ui": {
            "label": "a number",
            "category": null,
            "index": 5
          },
          "validation": {
            "no_echo": null,
            "min_length": null,
            "max_length": null,
            "min_value": null,
            "max_value": null,
            "allowed_pattern": null,
            "allowed_values": [

            ],
            "constraint_description": null
          }
        }
      ]
    },
    {
      "name": "stop",
      "description": "Stop the CloudApp",
      "parameters": [

      ]
    },
    {
      "name": "terminate",
      "description": "Terminate CloudApp, destroy all cloud resources created by the CloudApp",
      "parameters": [

      ]
    }
  ],
  "available_actions": [
    "stop",
    "terminate"
  ],
  "next_action": {
    "id": "5532eec973656c4c419b8603",
    "name": "Start",
    "action": "start",
    "next_occurrence": "2015-04-20T23:04:00.000+00:00",
    "href": "/api/manager/projects/60073/scheduled_actions/5532eec973656c4c419b8603",
    "kind": "self_service#scheduled_action"
  },
  "running_operations": [

  ],
  "api_resources": [

  ],
  "latest_notifications": [
    {
      "kind": "self_service#notification",
      "id": "5532e3c173656c4c41e32f00",
      "href": "/api/manager/projects/60073/notifications/5532e3c173656c4c41e32f00",
      "message": "running",
      "category": "status_update",
      "read": false,
      "timestamps": {
        "created_at": "2015-04-18T23:07:45.058+00:00"
      }
    },
    {
      "kind": "self_service#notification",
      "id": "5532e3c073656c4c41e22f00",
      "href": "/api/manager/projects/60073/notifications/5532e3c073656c4c41e22f00",
      "message": "enabling",
      "category": "status_update",
      "read": false,
      "timestamps": {
        "created_at": "2015-04-18T23:07:44.233+00:00"
      }
    },
    {
      "kind": "self_service#notification",
      "id": "5532e3bf73656c4c41e12f00",
      "href": "/api/manager/projects/60073/notifications/5532e3bf73656c4c41e12f00",
      "message": "Operation \"launch\" completed",
      "category": "info",
      "read": false,
      "timestamps": {
        "created_at": "2015-04-18T23:07:43.742+00:00"
      }
    },
    {
      "kind": "self_service#notification",
      "id": "5532e2d873656c4ce8032b02",
      "href": "/api/manager/projects/60073/notifications/5532e2d873656c4ce8032b02",
      "message": "launching",
      "category": "status_update",
      "read": false,
      "timestamps": {
        "created_at": "2015-04-18T23:03:52.661+00:00"
      }
    }
  ],
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "scheduled": true,
  "timestamps": {
    "created_at": "2015-04-18T23:03:52.399+00:00",
    "launched_at": "2015-04-18T23:03:52.560+00:00",
    "terminated_at": null
  },
  "links": {
    "running_operations": {
      "href": "/api/manager/projects/60073/operations?filter[]=execution_id==5532e2d873656c4ce8f52a02&filter[]=status==running"
    },
    "latest_notifications": {
      "href": "/api/manager/projects/60073/notifications?filter[]=execution_id==5532e2d873656c4ce8f52a02"
    }
  },
  "launched_from_summary": {
    "type": "template",
    "value": {
      "name": "SS-441",
      "href": "/api/designer/collections/60073/templates/55328d7973656c7f0c2e0000"
    }
  },
  "schedule_required": true,
  "current_schedule": "exe_SS-1765_sch_2_ExecutionFunctionalTests__20150418222452207217",
  "schedules": [
    {
      "name": "exe_SS-1765_sch_1_ExecutionFunctionalTests__20150418222452207217",
      "description": null,
      "start_recurrence": {
        "hour": 23,
        "minute": 4,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": 23,
        "minute": 4,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "created_from": null
    },
    {
      "name": "exe_SS-1765_sch_2_ExecutionFunctionalTests__20150418222452207217",
      "description": null,
      "start_recurrence": {
        "hour": 23,
        "minute": 4,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "stop_recurrence": {
        "hour": 23,
        "minute": 4,
        "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      },
      "created_from": null
    }
  ]
}
~~~
### start

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:34:44 GMT",
  "content_length": "54",
  "connection": "keep-alive",
  "status": "202 Accepted",
  "context_type": "text/plain",
  "x_request_uuid": "7dc619a8-e623-11e4-8e91-d2093b453a2d",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
The response has been accepted and is being processed.
~~~
### stop

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:26:20 GMT",
  "content_length": "54",
  "connection": "keep-alive",
  "status": "202 Accepted",
  "context_type": "text/plain",
  "x_request_uuid": "efa9ce66-e619-11e4-96fd-3a32ca6644f9",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
The response has been accepted and is being processed.
~~~
### terminate

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:49:49 GMT",
  "content_length": "54",
  "connection": "keep-alive",
  "status": "202 Accepted",
  "context_type": "text/plain",
  "x_request_uuid": "36e4262a-e61d-11e4-9ecf-9e70f5c429e2",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
The response has been accepted and is being processed.
~~~
## Notification
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:07:14 GMT",
  "content_type": "application/vnd.rightscale.self_service.notification",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "087ed4d2-e628-11e4-9d92-b6be8c8a21f9",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#notification",
    "id": "5532f1b073656c24c9c53f01",
    "href": "/api/manager/projects/60073/notifications/5532f1b073656c24c9c53f01",
    "message": "running",
    "category": "status_update",
    "read": false,
    "timestamps": {
      "created_at": "2015-04-19T00:07:12.183+00:00"
    },
    "links": {
      "execution": {
        "id": "5532f1ae73656c24c9c03f01",
        "name": "exe_",
        "href": "/api/manager/projects/60073/executions/5532f1ae73656c24c9c03f01"
      }
    }
  },
  {
    "kind": "self_service#notification",
    "id": "5532f1af73656c24c9c43f01",
    "href": "/api/manager/projects/60073/notifications/5532f1af73656c24c9c43f01",
    "message": "enabling",
    "category": "status_update",
    "read": false,
    "timestamps": {
      "created_at": "2015-04-19T00:07:11.379+00:00"
    },
    "links": {
      "execution": {
        "id": "5532f1ae73656c24c9c03f01",
        "name": "exe_",
        "href": "/api/manager/projects/60073/executions/5532f1ae73656c24c9c03f01"
      }
    }
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:07:16 GMT",
  "content_type": "application/vnd.rightscale.self_service.notification",
  "content_length": "407",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "098ee9c0-e628-11e4-99b8-9c0e483c2bf9",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#notification",
  "id": "5532f1b073656c24c9c53f01",
  "href": "/api/manager/projects/60073/notifications/5532f1b073656c24c9c53f01",
  "message": "running",
  "category": "status_update",
  "read": false,
  "timestamps": {
    "created_at": "2015-04-19T00:07:12.183+00:00"
  },
  "links": {
    "execution": {
      "id": "5532f1ae73656c24c9c03f01",
      "name": "exe_",
      "href": "/api/manager/projects/60073/executions/5532f1ae73656c24c9c03f01"
    }
  }
}
~~~
## NotificationRule
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "source": "/api/manager/projects/60073/executions/5532f2a373656c4f1bab3000",
  "min_severity": "error",
  "target": "me"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:19 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/catalog/accounts/60073/notification_rules/5532f2a773656c7ebb3a0000",
  "x_request_uuid": "9a9e3f92-e628-11e4-987f-406cb3b9db79",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "source": "/api/manager/projects/60073/executions",
  "target": "me"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:49 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "aca684d8-e628-11e4-9552-e4d931339697",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Querystring
~~~
source=%2Fapi%2Fmanager%2Fprojects%2F60073%2Fexecutions%2F5532f2a373656c4f1bab3000&targets=me
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:44 GMT",
  "content_type": "application/vnd.rightscale.self_service.notification_rule",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "a9ab5808-e628-11e4-9bed-4da0e07de1ac",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#notification_rule",
    "id": "5464fd8d32ca2be85e000001",
    "href": "/api/catalog/accounts/60073/notification_rules/5464fd8d32ca2be85e000001",
    "source": "/api/manager/projects/60073/executions?filter[]=created_by==50463",
    "category": "lifecycle",
    "min_severity": "info",
    "target": "50463",
    "priority": 2,
    "timestamps": {
      "created_at": "2014-11-13T18:50:53.364+00:00",
      "updated_at": "2014-11-13T18:50:53.364+00:00"
    }
  },
  {
    "kind": "self_service#notification_rule",
    "id": "550cc8d373656c2ec0090000",
    "href": "/api/catalog/accounts/60073/notification_rules/550cc8d373656c2ec0090000",
    "source": "/api/manager/projects/60073/executions/550cc88373656c280c0ccc09",
    "category": "lifecycle",
    "min_severity": "info",
    "target": "50463",
    "priority": 3,
    "timestamps": {
      "created_at": "2015-03-21T01:26:43.617+00:00",
      "updated_at": "2015-03-21T01:26:43.617+00:00"
    }
  }
]
~~~
### multi_delete

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "multipart/form-data"
}
~~~
#### Request Body
~~~ js
{
  "1": {
    "id": "5532f2b673656c7ec5520000"
  },
  "2": {
    "id": "5532f2be73656c7ecb460000"
  }
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:52 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_411595200.5790261327584576",
  "content_length": "374",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<411595200.7608177794605483>",
  "x_request_uuid": "adfc61fe-e628-11e4-9aa5-f9cc2ee1b2c7",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_411595200.5790261327584576
Content-ID: <411577800.05895758115919103>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="2"


--Boundary_411595200.5790261327584576
Content-ID: <411587800.0785214166178052>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="1"


--Boundary_411595200.5790261327584576--

~~~
### patch

#### Request Method
`PATCH`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "min_severity": "error"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:45 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "aa432d18-e628-11e4-871a-d0c84c3de48c",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:11:19 GMT",
  "content_type": "application/vnd.rightscale.self_service.notification_rule",
  "content_length": "410",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "9ae10f48-e628-11e4-91c7-04bf6485560c",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#notification_rule",
  "id": "5532f2a773656c7ebb3a0000",
  "href": "/api/catalog/accounts/60073/notification_rules/5532f2a773656c7ebb3a0000",
  "source": "/api/manager/projects/60073/executions/5532f2a373656c4f1bab3000",
  "category": "lifecycle",
  "min_severity": "error",
  "target": "50463",
  "priority": 3,
  "timestamps": {
    "created_at": "2015-04-19T00:11:19.562+00:00",
    "updated_at": "2015-04-19T00:11:19.562+00:00"
  }
}
~~~
## Operation
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "do_nothing",
  "execution_id": "5532e2b773656c21ca733a01"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 23:30:14 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/manager/projects/60073/operations/5532e90573656c4c41f5cd01",
  "x_request_uuid": "dc92d8f0-e622-11e4-9089-c0afcde3d675",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:37:24 GMT",
  "content_type": "application/vnd.rightscale.self_service.operation",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "3f0a18b4-e62c-11e4-85fd-97f8cb92cf16",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#operation",
    "id": "552d7e6073656c31d3ed2900",
    "name": "launch",
    "href": "/api/manager/projects/60073/operations/552d7e6073656c31d3ed2900",
    "status": {
      "tasks": [
        {
          "name": "/root",
          "label": "executing",
          "status": {
            "percent": 0,
            "summary": "Handling error: [raised]This is an error"
          }
        }
      ],
      "summary": "failed",
      "percent": 0
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2015-04-14T20:53:52.127+00:00",
      "finished_at": "2015-04-14T20:53:57.674+00:00"
    },
    "links": {
      "execution": {
        "id": "552d7e5e73656c31d3e82900",
        "name": "QA_Rspec_Admin_Notification- Launched by another 1 1429044724",
        "href": "/api/manager/projects/60073/executions/552d7e5e73656c31d3e82900"
      }
    }
  },
  {
    "kind": "self_service#operation",
    "id": "552d7e2973656c08e2976800",
    "name": "launch",
    "href": "/api/manager/projects/60073/operations/552d7e2973656c08e2976800",
    "status": {
      "tasks": [
        {
          "name": "/root",
          "label": "executing",
          "status": {
            "percent": 0,
            "summary": "Handling error: [raised]This is an error"
          }
        }
      ],
      "summary": "failed",
      "percent": 0
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2015-04-14T20:52:57.730+00:00",
      "finished_at": "2015-04-14T20:53:03.384+00:00"
    },
    "links": {
      "execution": {
        "id": "552d7e2873656c08e2926800",
        "name": "QA_Rspec_Admin_Notification- Self Launch 1 1429044724",
        "href": "/api/manager/projects/60073/executions/552d7e2873656c08e2926800"
      }
    }
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:38:59 GMT",
  "content_type": "application/vnd.rightscale.self_service.operation",
  "content_length": "703",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "77efdaf6-e62c-11e4-9759-8707fb36c7f6",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#operation",
  "id": "5532f78573656c24c92e3703",
  "name": "auto_terminate",
  "href": "/api/manager/projects/60073/operations/5532f78573656c24c92e3703",
  "status": {
    "tasks": [
      {
        "name": "/root",
        "label": "executing",
        "status": {
          "percent": 100,
          "summary": ""
        }
      }
    ],
    "summary": "completed",
    "percent": 100
  },
  "configuration_options": [

  ],
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-19T00:32:05.945+00:00",
    "finished_at": "2015-04-19T00:32:23.102+00:00"
  },
  "links": {
    "execution": {
      "id": "5532f78073656c4f1b48f801",
      "name": "exe_2_OperationFunctionalTests__20150418222452207217",
      "href": "/api/manager/projects/60073/executions/5532f78073656c4f1b48f801"
    }
  }
}
~~~
## Schedule
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "(UTC) start in 4 minutes, stop in a couple more ApplicationFunctionalTests__20150418222452207217",
  "start_recurrence": {
    "hour": "22",
    "minute": "30",
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
  },
  "stop_recurrence": {
    "hour": "22",
    "minute": "31",
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
  },
  "description": "(UTC) This schedule should terminate the app in 2 minutes"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:21 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/designer/collections/60073/schedules/5532d9d173656c7f15150000",
  "x_request_uuid": "cd070cb6-e619-11e4-8ecf-cb5cf119bdb1",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:44:02 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_520161800.682314626083182",
  "content_length": "416",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<520161800.6490807025122708>",
  "x_request_uuid": "2c71d7b8-e62d-11e4-9091-bff120932acf",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_520161800.682314626083182
Content-ID: <520147600.6516434591413458>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532fa5173656c7f0c370000"


--Boundary_520161800.682314626083182
Content-ID: <520154800.1433782452032234>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="5532fa5073656c7f0c360000"


--Boundary_520161800.682314626083182--

~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:43:37 GMT",
  "content_type": "application/vnd.rightscale.self_service.schedule",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "1d715f04-e62d-11e4-827e-ef2f4063dd92",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#schedule",
    "id": "548f4dc673656c143e010000",
    "name": "jon",
    "description": "R + F allday",
    "start_recurrence": {
      "hour": 8,
      "minute": 0,
      "rule": "FREQ=WEEKLY;BYDAY=TH,FR"
    },
    "stop_recurrence": {
      "hour": 20,
      "minute": 0,
      "rule": "FREQ=WEEKLY;BYDAY=TH,FR"
    },
    "href": "/api/designer/collections/60073/schedules/548f4dc673656c143e010000",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-12-15T21:08:22.409+00:00",
      "updated_at": "2014-12-15T21:08:22.409+00:00"
    }
  },
  {
    "kind": "self_service#schedule",
    "id": "548f5fb673656c14420c0000",
    "name": "hi",
    "description": "Test",
    "start_recurrence": {
      "hour": 8,
      "minute": 0,
      "rule": "FREQ=WEEKLY;BYDAY=SU"
    },
    "stop_recurrence": {
      "hour": 17,
      "minute": 0,
      "rule": "FREQ=WEEKLY;BYDAY=SU"
    },
    "href": "/api/designer/collections/60073/schedules/548f5fb673656c14420c0000",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-12-15T22:24:54.946+00:00",
      "updated_at": "2014-12-15T22:24:54.946+00:00"
    }
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:26:09 GMT",
  "content_type": "application/vnd.rightscale.self_service.schedule",
  "content_length": "691",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "e964044a-e619-11e4-8d8b-ae4ea0831c7b",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#schedule",
  "id": "5532da0073656c7f080c0000",
  "name": "(UTC) start in 4 minutes, stop in a couple more ApplicationFunctionalTests__20150418222452207217",
  "description": "(UTC) This schedule should terminate the app in 2 minutes",
  "start_recurrence": {
    "hour": 22,
    "minute": 30,
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
  },
  "stop_recurrence": {
    "hour": 22,
    "minute": 31,
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
  },
  "href": "/api/designer/collections/60073/schedules/5532da0073656c7f080c0000",
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-18T22:26:08.789+00:00",
    "updated_at": "2015-04-18T22:26:08.789+00:00"
  }
}
~~~
### update

#### Request Method
`PATCH`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "name": "schedule_2_ScheduleFunctionalTests__20150418222452207217",
  "description": "description for schedule_2_ScheduleFunctionalTests__20150418222452207217",
  "start_recurrence": {
    "hour": "8",
    "minute": "0",
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
  },
  "stop_recurrence": {
    "hour": "18",
    "minute": "0",
    "rule": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
  }
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:43:42 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "20e45b0a-e62d-11e4-82e5-2b9791640f14",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
## ScheduledAction
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "execution_id": "5532faa473656c10171d0801",
  "action": "start",
  "first_occurrence": "3017-07-24T00:00:00+00:00",
  "name": "s_a_7_ScheduledActionFunctionalTests__20150418222452207217",
  "recurrence": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR",
  "timezone": "America/Los_Angeles"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 00:44:14 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/manager/projects/60073/scheduled_actions/5532fa5e73656c2701090000",
  "x_request_uuid": "340bd230-e62d-11e4-8a0c-1ceb78bbec97",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:22:37 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "906c1832-e632-11e4-918b-232e6d8361ea",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:22:39 GMT",
  "content_type": "application/vnd.rightscale.self_service.scheduled_action",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "90b838fc-e632-11e4-91e8-b76c793a04cf",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "id": "5490cc5a73656c60600e0000",
    "execution": {
      "id": "5490cc5973656c6060080000",
      "name": "ROL - test",
      "href": "/api/manager/projects/60073/executions/5490cc5973656c6060080000",
      "description": "Test params in outputs",
      "status": "terminating",
      "timestamps": {
        "created_at": "2014-12-17T00:20:41.018+00:00",
        "launched_at": "2014-12-17T00:20:41.187+00:00",
        "terminated_at": null
      }
    },
    "name": "Scheduled Start",
    "recurrence": "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR",
    "recurrence_description": "Weekly on Weekdays",
    "action": "start",
    "first_occurrence": "2014-12-17T16:45:00.000+00:00",
    "next_occurrence": "2014-12-17T16:45:00.000+00:00",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "execution_schedule": true,
    "timezone": "UTC",
    "timestamps": {
      "created_at": "2014-12-17T00:20:42.112+00:00",
      "updated_at": "2014-12-17T00:20:42.112+00:00"
    },
    "links": {
      "execution": {
        "id": "5490cc5973656c6060080000",
        "name": "ROL - test",
        "href": "/api/manager/projects/60073/executions/5490cc5973656c6060080000"
      }
    },
    "href": "/api/manager/projects/60073/scheduled_actions/5490cc5a73656c60600e0000",
    "kind": "self_service#scheduled_action"
  },
  {
    "id": "5490cc5a73656c60600f0000",
    "execution": {
      "id": "5490cc5973656c6060080000",
      "name": "ROL - test",
      "href": "/api/manager/projects/60073/executions/5490cc5973656c6060080000",
      "description": "Test params in outputs",
      "status": "terminating",
      "timestamps": {
        "created_at": "2014-12-17T00:20:41.018+00:00",
        "launched_at": "2014-12-17T00:20:41.187+00:00",
        "terminated_at": null
      }
    },
    "name": "Scheduled Stop",
    "recurrence": "FREQ=WEEKLY;BYDAY=TU,WE,TH,FR,SA",
    "recurrence_description": "Weekly on Tuesdays, Wednesdays, Thursdays, Fridays, and Saturdays",
    "action": "stop",
    "first_occurrence": "2014-12-17T16:30:00.000+00:00",
    "next_occurrence": "2015-02-04T16:30:00.000+00:00",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "execution_schedule": true,
    "timezone": "UTC",
    "timestamps": {
      "created_at": "2014-12-17T00:20:42.171+00:00",
      "updated_at": "2014-12-17T00:20:42.171+00:00"
    },
    "links": {
      "execution": {
        "id": "5490cc5973656c6060080000",
        "name": "ROL - test",
        "href": "/api/manager/projects/60073/executions/5490cc5973656c6060080000"
      }
    },
    "href": "/api/manager/projects/60073/scheduled_actions/5490cc5a73656c60600f0000",
    "kind": "self_service#scheduled_action"
  }
]
~~~
### patch

#### Request Method
`PATCH`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "next_occurrence": "3015-06-25T00:00:00+00:00"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:14:13 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "6442740a-e631-11e4-8860-7984ea184971",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:14:25 GMT",
  "content_type": "application/vnd.rightscale.self_service.scheduled_action",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "6b0fd14c-e631-11e4-84e8-a9771ea56f86",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
{
  "id": "5533017073656c52d5c16000",
  "execution": {
    "id": "5533016c73656c52d5bb6000",
    "name": "exe_SS-1783_ScheduledActionFunctionalTests__20150418222452207217",
    "href": "/api/manager/projects/60073/executions/5533016c73656c52d5bb6000",
    "status": "running",
    "timestamps": {
      "created_at": "2015-04-19T01:14:20.823+00:00",
      "launched_at": "2015-04-19T01:14:20.987+00:00",
      "terminated_at": null
    }
  },
  "name": "s_a_SS_1783_ScheduledActionFunctionalTests__20150418222452207217",
  "recurrence": "FREQ=HOURLY;BYMINUTE=16,17",
  "recurrence_description": "Hourly on the 16th and 17th minutes of the hour",
  "action": "stop",
  "first_occurrence": "2015-04-19T01:15:17.000+00:00",
  "next_occurrence": "2015-04-19T01:16:17.000+00:00",
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "execution_schedule": false,
  "timezone": "UTC",
  "timestamps": {
    "created_at": "2015-04-19T01:14:24.741+00:00",
    "updated_at": "2015-04-19T01:14:24.741+00:00"
  },
  "links": {
    "execution": {
      "id": "5533016c73656c52d5bb6000",
      "name": "exe_SS-1783_ScheduledActionFunctionalTests__20150418222452207217",
      "href": "/api/manager/projects/60073/executions/5533016c73656c52d5bb6000"
    }
  },
  "href": "/api/manager/projects/60073/scheduled_actions/5533017073656c52d5c16000",
  "kind": "self_service#scheduled_action"
}
~~~
### skip

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "count": 1
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:14:25 GMT",
  "content_type": "application/vnd.rightscale.self_service.scheduled_action",
  "content_length": "292",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "6b618082-e631-11e4-8689-fdfa01b7b838",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "id": "5533017073656c52d5c16000",
  "name": "s_a_SS_1783_ScheduledActionFunctionalTests__20150418222452207217",
  "action": "stop",
  "next_occurrence": "2015-04-19T01:17:17.000+00:00",
  "href": "/api/manager/projects/60073/scheduled_actions/5533017073656c52d5c16000",
  "kind": "self_service#scheduled_action"
}
~~~
## Template
### compile

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "source": "name \"template_TemplateFunctionalTests__20150418222452207217\"\nrs_ca_ver 20131202\nshort_description \"A super simple cat that does nothing.\""
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:27:53 GMT",
  "content_type": "application/vnd.rightscale.self_service.compiled_cat",
  "content_length": "477",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "4af5d1c0-e633-11e4-8217-788a766329d8",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "name": "template_TemplateFunctionalTests__20150418222452207217",
  "rs_ca_ver": 20131202,
  "short_description": "A super simple cat that does nothing.",
  "long_description": null,
  "parameters": {
  },
  "mappings": {
  },
  "conditions": {
  },
  "resources": {
  },
  "outputs": {
  },
  "operations": {
  },
  "definitions": {
  },
  "namespaces": [

  ],
  "required_parameters": [

  ],
  "source": "name \"template_TemplateFunctionalTests__20150418222452207217\"\nrs_ca_ver 20131202\nshort_description \"A super simple cat that does nothing.\"\n"
}
~~~
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "source": "template.rb"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:27:44 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/designer/collections/60073/templates/5533049073656c7f15190000",
  "x_request_uuid": "45bf7bde-e633-11e4-8cf3-9d776189068e",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:13 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "58c6d4f2-e633-11e4-830b-f327315747b4",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### download

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/octet-stream"
}
~~~
#### Request Querystring
~~~
api_version=1.0
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:27:49 GMT",
  "content_type": "application/octet-stream",
  "content_length": "134",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_disposition": "attachment; filename=\"template.rb\"",
  "x_request_uuid": "4aa02fd6-e633-11e4-85fc-c34b46293dc2",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
name "template_TemplateFunctionalTests__20150418222452207217"
rs_ca_ver 20131202
short_description "(QA)API test - upload of Template"
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:27:45 GMT",
  "content_type": "application/vnd.rightscale.self_service.template",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "48338d38-e633-11e4-81e5-03a768bcaae4",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "kind": "self_service#template",
    "id": "5392479332ca2bd0ca000002",
    "name": "TEST - fail on provision",
    "filename": "test_fail_provision.rb",
    "href": "/api/designer/collections/60073/templates/5392479332ca2bd0ca000002",
    "short_description": "Provision fail.",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-06-06T22:58:27.811+00:00",
      "updated_at": "2014-07-01T19:58:43.965+00:00",
      "published_at": null
    }
  },
  {
    "kind": "self_service#template",
    "id": "5395f22432ca2bfd41000001",
    "name": "PRS Mini-Moo Basic Linux Server",
    "filename": "basic_server_sappqa_mini_provision_failed.cat",
    "href": "/api/designer/collections/60073/templates/5395f22432ca2bfd41000001",
    "short_description": "![logo](http://assets.rightscale.com/69d7cf43d5f89965c1676fe604af36987aada5da/web/images/icons/home7.png) SStandalone Linux server with basic options.",
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-06-09T17:43:00.630+00:00",
      "updated_at": "2014-07-01T19:58:43.967+00:00",
      "published_at": null
    }
  }
]
~~~
### publish

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "id": "5533049073656c7f15190000"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:08 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/catalog/catalogs/60073/applications/553304a873656c7ec5530000",
  "x_request_uuid": "55fd979c-e633-11e4-839b-85c15ec742f3",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Querystring
~~~
view=expanded
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:25:13 GMT",
  "content_type": "application/vnd.rightscale.self_service.template",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "c853c178-e619-11e4-9d6f-a8c6a0847768",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
{
  "kind": "self_service#template",
  "id": "55328d4e73656c7f101d0000",
  "name": "QA_CAT_test_for_SS_API_RL",
  "filename": "QA_CAT_test.rb",
  "href": "/api/designer/collections/60073/templates/55328d4e73656c7f101d0000",
  "source": "name \"QA_CAT_test_for_SS_API_RL\"\nrs_ca_ver 20131202\nshort_description \"CAT for SS_API testing\"\nlong_description \"A CAT for SS_API testing\"\n\n#########\n# Parameters\n#########\n\n#########\n# Mappings\n#########\n\n#########\n# Resources\n#########\n\n#########\n# Operations\n#########\n\noutput \"toggle_out\" do\n label \"The_output\"\nend\n\noperation \"do_nothing\" do\n  description \"custom operation that does nothing\"\n  definition \"do_nothing\"\nend\n\n# The following two Custom_Operations are used in ScheduledOperation\n# functional tests\noperation \"write_to_output\" do\n  description \"generates a output for the CloudApp\"\n  definition \"empty_def_a\"\n  output_mappings do {\n    $toggle_out => 'wrote_to_output'\n  }\n  end\nend\n\noperation \"write_to_output_again\" do\n  description \"generates a difference output for the CloudApp\"\n  definition \"empty_def_b\"\n  output_mappings do {\n    $toggle_out => 'wrote_to_output_again'\n  } \n  end\nend\n\n\noperation \"start\" do\n  definition \"stop_start\"\nend\n\noperation \"stop\" do\n  definition \"stop_start\"\nend\n\n#########\n# Definitions\n#########\n\ndefine do_nothing() do\n\tsleep(15)\nend\n\ndefine empty_def_a() do\nend\n\ndefine empty_def_b() do\nend\n\ndefine stop_start() do\n  # Do nothing\nend\n",
  "short_description": "CAT for SS_API testing",
  "long_description": "A CAT for SS_API testing",
  "compiled_cat": "{\"name\":\"QA_CAT_test_for_SS_API_RL\",\"rs_ca_ver\":20131202,\"short_description\":\"CAT for SS_API testing\",\"long_description\":\"A CAT for SS_API testing\",\"parameters\":{},\"mappings\":{},\"conditions\":{},\"resources\":{},\"outputs\":{\"toggle_out\":{\"label\":\"The_output\",\"index\":1}},\"operations\":{\"do_nothing\":{\"definition\":\"do_nothing\",\"description\":\"custom operation that does nothing\"},\"write_to_output\":{\"definition\":\"empty_def_a\",\"description\":\"generates a output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output\"}},\"write_to_output_again\":{\"definition\":\"empty_def_b\",\"description\":\"generates a difference output for the CloudApp\",\"output_mappings\":{\"toggle_out\":\"wrote_to_output_again\"}},\"start\":{\"definition\":\"stop_start\"},\"stop\":{\"definition\":\"stop_start\"}},\"definitions\":{\"do_nothing\":{\"arguments\":[],\"returns\":[],\"source\":\"define do_nothing() do\\n\\tsleep(15)\\nend\\n\"},\"empty_def_a\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_a() do\\nend\\n\"},\"empty_def_b\":{\"arguments\":[],\"returns\":[],\"source\":\"define empty_def_b() do\\nend\\n\"},\"stop_start\":{\"arguments\":[],\"returns\":[],\"source\":\"define stop_start() do\\n  # Do nothing\\nend\\n\"}},\"namespaces\":[],\"required_parameters\":[],\"source\":\"name \\\"QA_CAT_test_for_SS_API_RL\\\"\\nrs_ca_ver 20131202\\nshort_description \\\"CAT for SS_API testing\\\"\\nlong_description \\\"A CAT for SS_API testing\\\"\\n\\n#########\\n# Parameters\\n#########\\n\\n#########\\n# Mappings\\n#########\\n\\n#########\\n# Resources\\n#########\\n\\n#########\\n# Operations\\n#########\\n\\noutput \\\"toggle_out\\\" do\\n label \\\"The_output\\\"\\nend\\n\\noperation \\\"do_nothing\\\" do\\n  description \\\"custom operation that does nothing\\\"\\n  definition \\\"do_nothing\\\"\\nend\\n\\n# The following two Custom_Operations are used in ScheduledOperation\\n# functional tests\\noperation \\\"write_to_output\\\" do\\n  description \\\"generates a output for the CloudApp\\\"\\n  definition \\\"empty_def_a\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output'\\n  }\\n  end\\nend\\n\\noperation \\\"write_to_output_again\\\" do\\n  description \\\"generates a difference output for the CloudApp\\\"\\n  definition \\\"empty_def_b\\\"\\n  output_mappings do {\\n    $toggle_out => 'wrote_to_output_again'\\n  } \\n  end\\nend\\n\\n\\noperation \\\"start\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\noperation \\\"stop\\\" do\\n  definition \\\"stop_start\\\"\\nend\\n\\n#########\\n# Definitions\\n#########\\n\\ndefine do_nothing() do\\n\\tsleep(15)\\nend\\n\\ndefine empty_def_a() do\\nend\\n\\ndefine empty_def_b() do\\nend\\n\\ndefine stop_start() do\\n  # Do nothing\\nend\\n\"}\n",
  "parameters": [

  ],
  "required_parameters": [

  ],
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-18T16:58:54.773+00:00",
    "updated_at": "2015-04-18T16:58:54.773+00:00",
    "published_at": null
  }
}
~~~
### unpublish

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "id": "5533049073656c7f15190000"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:11 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "57a98114-e633-11e4-98b5-b4d1e71ed322",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
## UserPreference
### create

#### Request Method
`POST`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Body
~~~ js
{
  "user_id": "me",
  "user_preference_info_id": "546282e532ca2bc744000001",
  "value": "UTC-admin"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:25 GMT",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "status": "201 Created",
  "location": "/api/catalog/accounts/60073/user_preferences/553304b973656c7ec5540000",
  "x_request_uuid": "600d90fc-e633-11e4-81dd-eecb013e4828",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### destroy

#### Request Method
`DELETE`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:25 GMT",
  "connection": "keep-alive",
  "status": "204 No Content",
  "x_request_uuid": "5fb95870-e633-11e4-9552-aa4f1dbd3e63",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Request Querystring
~~~
filter%5B%5D=user_id%3D%3Dme&view=expanded
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:33 GMT",
  "content_type": "application/vnd.rightscale.self_service.user_preference",
  "transfer_encoding": "chunked",
  "connection": "keep-alive",
  "vary": "Accept-Encoding",
  "status": "200 OK",
  "x_request_uuid": "64bc11fa-e633-11e4-9e92-589af4e99b6b",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;",
  "content_encoding": "gzip"
}
~~~
#### Response Body
~~~ js
[
  {
    "id": "546a4fd032ca2b6658000005",
    "href": "/api/catalog/accounts/60073/user_preferences/546a4fd032ca2b6658000005",
    "user_id": 71654,
    "kind": "self_service#user_preference",
    "value": "UTC",
    "user_preference_info": {
      "id": "546282e532ca2bc744000001",
      "name": "time_zone",
      "display_name": "Time Zone",
      "category": "General",
      "help_text": "Used to localize dates and times in notification emails.",
      "value_type": "String",
      "default_value": "UTC",
      "href": "/api/catalog/accounts/60073/user_preference_infos/546282e532ca2bc744000001",
      "kind": "self_service#user_preference_info"
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2014-11-17T19:43:12.192+00:00",
      "updated_at": "2015-04-15T18:35:59.962+00:00"
    }
  },
  {
    "id": "553304b973656c7ec5540000",
    "href": "/api/catalog/accounts/60073/user_preferences/553304b973656c7ec5540000",
    "user_id": 50463,
    "kind": "self_service#user_preference",
    "value": "UTC-admin",
    "user_preference_info": {
      "id": "546282e532ca2bc744000001",
      "name": "time_zone",
      "display_name": "Time Zone",
      "category": "General",
      "help_text": "Used to localize dates and times in notification emails.",
      "value_type": "String",
      "default_value": "UTC",
      "href": "/api/catalog/accounts/60073/user_preference_infos/546282e532ca2bc744000001",
      "kind": "self_service#user_preference_info"
    },
    "created_by": {
      "id": "12345",
      "name": "Madison Bumgarner",
      "email": "ace@rightscale.com"
    },
    "timestamps": {
      "created_at": "2015-04-19T01:28:25.831+00:00",
      "updated_at": "2015-04-19T01:28:25.831+00:00"
    }
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:50 GMT",
  "content_type": "application/vnd.rightscale.self_service.user_preference",
  "content_length": "764",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "6eb86938-e633-11e4-843b-c4120399f7c2",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "id": "553304be73656c7ecb480000",
  "href": "/api/catalog/accounts/60073/user_preferences/553304be73656c7ecb480000",
  "user_id": 79907,
  "kind": "self_service#user_preference",
  "value": "UTC-end_usr(m)",
  "user_preference_info": {
    "id": "546282e532ca2bc744000001",
    "name": "time_zone",
    "display_name": "Time Zone",
    "category": "General",
    "help_text": "Used to localize dates and times in notification emails.",
    "value_type": "String",
    "default_value": "UTC",
    "href": "/api/catalog/accounts/60073/user_preference_infos/546282e532ca2bc744000001",
    "kind": "self_service#user_preference_info"
  },
  "created_by": {
    "id": "12345",
    "name": "Madison Bumgarner",
    "email": "ace@rightscale.com"
  },
  "timestamps": {
    "created_at": "2015-04-19T01:28:30.848+00:00",
    "updated_at": "2015-04-19T01:28:46.482+00:00"
  }
}
~~~
### update

#### Request Method
`PATCH`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "multipart/form-data"
}
~~~
#### Request Body
~~~ js
{
  "1": {
    "id": "553304b973656c7ec5540000",
    "value": "UTC-admin"
  },
  "2": {
    "id": "553304be73656c7ecb480000",
    "value": "UTC-end_usr(m)"
  }
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:46 GMT",
  "content_type": "multipart/form-data; boundary=Boundary_142056400.6483598034985488",
  "content_length": "374",
  "connection": "keep-alive",
  "status": "200 OK",
  "content_id": "<142056400.34534798841480996>",
  "x_request_uuid": "6c6b420e-e633-11e4-9836-93ea537119b0",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
--Boundary_142056400.6483598034985488
Content-ID: <141694400.0806608344679891>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="2"


--Boundary_142056400.6483598034985488
Content-ID: <141841400.15644886430687954>
Content-Type: text/plain
Status: 204
Content-Disposition: form-data; name="1"


--Boundary_142056400.6483598034985488--

~~~
## UserPreferenceInfo
### index

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sat, 18 Apr 2015 22:26:07 GMT",
  "content_type": "application/vnd.rightscale.self_service.user_preference_info",
  "content_length": "344",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "e88c06d0-e619-11e4-9407-b7be675b379b",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
[
  {
    "id": "546282e532ca2bc744000001",
    "name": "time_zone",
    "display_name": "Time Zone",
    "category": "General",
    "help_text": "Used to localize dates and times in notification emails.",
    "value_type": "String",
    "default_value": "UTC",
    "href": "/api/catalog/accounts/60073/user_preference_infos/546282e532ca2bc744000001",
    "kind": "self_service#user_preference_info"
  }
]
~~~
### show

#### Request Method
`GET`
#### Request Headers
~~~ js
{
  "X_API_VERSION": 1.0,
  "accept": "application/json"
}
~~~
#### Response Header
~~~ js
{
  "date": "Sun, 19 Apr 2015 01:28:57 GMT",
  "content_type": "application/vnd.rightscale.self_service.user_preference_info",
  "content_length": "342",
  "connection": "keep-alive",
  "status": "200 OK",
  "x_request_uuid": "7309ccfc-e633-11e4-9741-2d8069e8a354",
  "strict_transport_security": "max-age=31536000; includeSubDomains; preload;"
}
~~~
#### Response Body
~~~ js
{
  "id": "546282e532ca2bc744000001",
  "name": "time_zone",
  "display_name": "Time Zone",
  "category": "General",
  "help_text": "Used to localize dates and times in notification emails.",
  "value_type": "String",
  "default_value": "UTC",
  "href": "/api/catalog/accounts/60073/user_preference_infos/546282e532ca2bc744000001",
  "kind": "self_service#user_preference_info"
}
~~~
