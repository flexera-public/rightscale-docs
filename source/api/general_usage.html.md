---
title: General RightScale API Usage Information
layout: general.slim
description: Provides introductory and general usage information on the RightScale APIs including Cloud Management, Self-Service, Optima, and Cloud Pricing.
---

## Endpoints

Each API has an endpoint URL that must be used to target the desired API. These endpoints are listed below:

API | Endpoint URL(s) | Notes
--- | --------------- | -----
Cloud Management |  `https://us-3.rightscale.com` <br> `https://us-4.rightscale.com` | If the specified account is not in the specified shard, you will receive an error from the API
Self-Service | `https://selfservice-3.rightscale.com` <br> `https://selfservice-4.rightscale.com` | If the specified account is not in the specified shard, you will receive an error from the API
Optima | `https://analytics.rightscale.com`
Cloud Pricing | `https://pricing.rightscale.com`
Policies | `https://governance-3.rightscale.com/api/governance` <br> `https://governance-4.rightscale.com/api/governance` | If the specified account is not in the specified shard, you will receive an redirect from the API
Governance IAM | `https://governance.rightscale.com`
Credential Management API 1.0 | `https://cloud-3.rightscale.com/cloud` <br> `https://cloud-4.rightscale.com/cloud` <br> `https://cloud-10.rightscale.com/cloud`



## Response Data Format

Most RightScale APIs support only JSON response format -- all APIs default to a JSON response. The following table lists the response formats supported by each API:

API | Supported formats
--- | -----------------
Cloud Management 1.5 | `application/json` and `application/xml`
Cloud Management 1.6 | `application/json`
Self-Service 1.0 | `application/json`
Optima 1.0 | `application/json`
Cloud Pricing 1.0 | `application/json`
Policies 1.0 | `application/json`
Governance IAM 2.0 | `application/json`
Credential Management API 1.0 | `application/json`



To specify an alternate response format, apply the standard Accept headers (`Accept: application/xml`) or use the format extension on the URL (i.e., .json or .xml suffix).

## Common Headers

All RightScale APIs require that the API version be specified in the http header `X-Api-Version` or `Api-Version`. Note that each API may support different version numbers and some APIs may support multiple version numbers. The following table lists all of the supported versions for each API:

Product Name | Supported Versions | Required Header
------------ | ------------------ | ---------------
Cloud Management | 1.5 <br> 1.6 | X-Api-Version
Self-Service | 1.0 | X-Api-Version
Optima | 1.0 | X-Api-Version
Cloud Pricing | 1.0 | X-Api-Version
Policies | 1.0 | Api-Version
Governance IAM | 2.0 | X-Api-Version
Credential Management API | 1.0 | Api-Version 

## Authentication

Each API requires authentication to the core Cloud Management API. The Self-Service API also requires an additional step before API calls can be made.

### Authenticating to Cloud Management API 1.5

#### Username-Password Based Authentication

Detailed examples for logging in to the Cloud Management API 1.5 are available on the [General RightScale API Usage Information](/api/general_usage.html) page. Calls are made to the [Sessions.create](http://reference.rightscale.com/api1.5/resources/ResourceSessions.html#create) call in CM API 1.5. A successful authentication in this manner results in a cookie or access_token being returned that can then be used for all additional API calls. Unless noted below, this token can be used across all RightScale products. this An example of this call is shown below:

~~~
myemail='me@example.com'
mypassword='mypassword'
myaccountid=1 # This can be any of your accounts

curl https://us-3.rightscale.com/api/sessions -i \
      -X POST \
      -H X-Api-Version:1.5 \
      -c /tmp/cookie.txt \
      -d email="$myemail" \
      -d password="$mypassword" \
      -d account_href=/api/accounts/$myaccountid
~~~

After the above call, the content in the cookie file at `/tmp/cookie.txt` should then be sent with every following API call.

#### Oauth Authentication

Cloud Management API 1.5 also supports other methods of login such as [using an OAuth refresh token](/api/api_1.5_examples/oauth.html). An example of this would be:

~~~
refresh_token='refresh_token_from_dash'

curl https://us-3.rightscale.com/api/oauth2 -i \
      -X POST \
      -H X-Api-Version:1.5 \
      -c /tmp/cookie.txt \
      -d grant_type="refresh_token" \
      -d refresh_token="$refresh_token"
~~~

The remaining examples assume you have logged in with username/password and only need the cookie for the other calls. If you used OAuth, you would need to get the `access_token` from the response and use that with every call with an `Authorization` header, as [described in the CM API 1.5 Examples](/api/api_1.5_examples/index.html)

### Authenticating to Self-Service API 1.0

Once you have authenticated to Cloud Management API 1.5 and have either a cookie or an access token, you can then authenticate to Self-Service. The authentication call to Self-Service simply defines which account you would like to start a new session with. Note that this **the only call** where an `X-Api-Version` header **must not** be included:

~~~
sshost='https://selfservice-3.rightscale.com'
myaccountid=1

curl $sshost/api/catalog/new_session?account_id=$myaccountid -i -b /tmp/cookie.txt
~~~

Note that you must authenticate to the correct shard, either `https://selfservice-3.rightscale.com` or `https://selfservice-4.rightscale.com`. The shard should match the shard of the account that you are trying to authenticate to.

## API Response Errors

Errors that occur in most APIs contain an error response and body which describe the nature of the error. For the **Cloud Management API 1.5**, please see the [error code descriptions](/api/api_1.5_examples/index.html#error-handling). All other APIs contain error codes and detailed reasons in the relevant API docs for the given API call.

## Filtering and Views

Most index and show requests have a list of available "views". Each view defines how many attributes and/or expanded nested relationships to include. For example, for querying instances, one can use the "inputs" view which will include expanded inputs contents of every instance in the response. There is always a "default" view, which is used if no explicit view is specified. Some resources will have a "tiny" view, which will only include the self URL link (i.e., for when one only needs to collect resource "hrefs" rather than their contents).

Collection requests can restrict the results received using a set of available filters. For example, the instances collection resource can be used to retrieve all instances that belong to a given deployment. This is done by specifying a filter that limits the result set to the instances whose deployment relationship matches a deployment href. Multiple filters can be specified in a single request, and they will be ANDed. This means that a request with multiple filters will only return resources that satisfy all of them. Each individual filter can use `==` or `<>` to match or differ on the attribute value. For example, one can filter instances that match a given template and that do not match a given name pattern. Some filters allow partial matches and some require exact value matching (the semantics of each filter are described in the API reference documentation).

The sets of views available on a resource's index and show calls are identical, it is thus possible to get the same level of information for a set of resources using index as for an individual resource using show. Some resources contain information that is not appropriate for index calls due to computational expense or sheer size. In those cases the information is exposed using separate GET actions on the individual resource. For example, the details of an audit entry cannot be retrieved using show/index, instead the detail action must be called.

Example filters:
~~~
filter[]=name==my_php_server
filter[]=deployment_href==/api/deployments/11
~~~

## Hrefs and IDs

The API makes extensive use of hrefs (links). All such hrefs are relative to the host, therefore they do not include a hostname. A sample href is `/api/servers/1678`. The reason for relative hrefs is the hostname may change over time as accounts are moved between RightScale systems located in different world regions. Thus, we do not encourage storing hostnames in client databases. In general, the API will return an appropriate redirect if an incorrect host is accessed.

All relationships are expressed using resource hrefs. The href of a resource is its unique and immutable ID in perpetuity. While hrefs are relative to the host, they are actually unique across the entire RightScale system. Therefore, there will never exist two resources on different hosts that have the same href.

Relationships and request parameters referring to other resources will always take a URL. For example, when creating a server one must specify the deployment by passing the URL.

## REST Philosophy

The RightScale APIs follows the REST (REpresentational State Transfer) paradigm, and all its common verbs and actions.  The API places great importance on consistency and organization of requests and response types. Emphasis has been placed on making resource relationships and available actions discoverable on the fly.

Every resource response includes three sections of information:

1. A list of resource attributes - Includes the name, state, and the created_at for an Instance resource. Sometimes a resource will also include the contents of a related resource to avoid having to perform an extra request to retrieve more contents. For example, some responses for an instance might include the complete contents of its inputs, instead of just a URL pointing to them. (See "views" for more details on this.) There are some attributes that can override contents inherited from other related resources. (For example an instance can override the user_data inherited from its template.)  For these inheritable attributes, the resource body will have a special section that will indicate the source of its contents.
2. A list of links - Specifies the relationships that the resource has. Each link will have a well-known relationship name, and the URI to get its relationship contents. Every resource will have at least the "self" relationship, with a URL pointing to itself. This is effectively the unique ID for the resource that will be immutable throughout the lifetime of the resource and beyond.
3. A list of actions to execute - These actions are contextual, for example, there can be a "launch" action for an instance that is stopped, but there will not be one if the instance is already running. For the moment, these actions are limited to a list of well-known names, but expect to provide more information (metadata) about them later (verb to use, URL, etc.).

Each response will return a specific RightScale "Content-Type" header specifying a MediaType structure. For example: servers will return "application/vnd.rightscale.server". The format of each resource media type is documented in the API Online Reference documentation. A MediaType is a human-readable schema definition for a given resource . There is no validator or similar concept like there could be in some XML formats. In other words a media type will define everything that could appear in a response of that type of resource. For calls that return a collection of items of a given MediaType, the content type will include a "type=collection" parameter (i.e., "application/vnd.rightscale.server; type=collection").
