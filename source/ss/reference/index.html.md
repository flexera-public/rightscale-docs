---
title: Reference
description: These RightScale Self-Service reference guides cover CATs, the RightScale Cloud Workflow Language, API documentation, and troubleshooting.
---

Self-Service applications are defined using a Cloud Application Template which contains both _declarative_ syntax to describe the configuration of the required resources and the _imperative_ Cloud Workflow language that describes the behavior of the application. There are number of supported RightScale Resources that can be used in the template, each of which has certain properties which can be displayed to users via the use of Outputs.

[[Cloud Application Templates
The Cloud Application Template, or *CAT*, is the file format that is used to describe every application in the Self-Service Catalog. It has an associated language that is declarative and is used to describe the various inputs, outputs, resources, and operations available for the application. A CAT file can contain any number of _Resources_ -- such as Servers, Arrays, SecurityGroups -- and also defines the _Outputs_ that are shown to the users of Self-Service.
* [CAT Language](cat/v20161221/index.html)
* [Supported CAT Resources](cat/v20161221/ss_CAT_resources.html)
* [Supported CAT Outputs](cat/v20161221/ss_CAT_outputs.html)
* [CAT Plugins](cat/v20161221/ss_plugins.html)
* [Changelog](cat/changelog.html)
]]

[[RightScale Cloud Workflow
While the CAT language is used to declaratively _describe_ the resources that make up an application, the Cloud Workflow Language describes the operations that define the _behavior_ of the application. This fully-featured language is focused on operating cloud-based workloads and includes a number of _Functions_ and _Operators_.
* [RightScale Cloud Workflow language](rcl/v2/index.html)
* [Cloud Workflow Functions](rcl/v2/ss_RCL_functions.html)
* [Cloud Workflow Operators](rcl/v2/ss_RCL_operators.html)
* [Changelog](rcl/changelog.html)
]]

[[API Documentation
Self-Service API reference documentation is available in three different modules. See the main RightScale API Overview page for more information.
* [RightScale API Overview](/api/)
* [Self-Service API Guide](/ss/guides/ss_api_guide.html)
* [API Sample Requests & Responses](ss_api_sample_request_responses.html)
]]

[[Troubleshooting
Learning a new language usually entails quite a bit of troubleshooting. [Common errors](ss_common_error_messages.html) are documented and should be a primary source of reference during CAT file development.
]]
