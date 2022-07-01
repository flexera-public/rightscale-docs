---
title: Examples
layout: general.slim
---

## Overview

Once you have learned about the RightScale API and know how to look things up ([Reference section](http://reference.rightscale.com/api1.5/index.html)), seeing practical examples can help solidify precisely how to construct calls for various API Resources. Examples bring the learning experience full circle. Each example provided pertains to an often used API Resource. Each example includes a curl (bash/sh) example and often a Ruby (right_api_client) example.<sup>1</sup>

API examples are really designed to be used in parallel with the [API 1.5 online reference](http://reference.rightscale.com/api1.5/index.html) information. We _**strongly recommend**_ you use the online reference information at all phases of your learning curve.

- [QUICK Start for using Examples](/api/api_1.5_examples/quick_start_for_using_examples.html)
- [Tips for Using API Examples](/api/api_1.5_examples/tips_for_using_api_examples.html)
- [Authentication](/api/api_1.5_examples/authentication.html)
- [OAuth](/api/api_1.5_examples/oauth.html)
- [Accounts](/api/api_1.5_examples/accounts.html)
- [Audit Entries](/api/api_1.5_examples/audit_entries.html)
- [ChildAccounts](/api/api_1.5_examples/childaccounts.html)
- [CloudAccounts](/api/api_1.5_examples/cloudaccounts.html)
- [Clouds](/api/api_1.5_examples/clouds.html)
- [Cookbooks](/api/api_1.5_examples/cookbooks.html)
- [Deployments](/api/api_1.5_examples/deployments.html)
- [Inputs](/api/api_1.5_examples/inputs.html)
- [Instances](/api/api_1.5_examples/instances.html)
- [Instance Types](/api/api_1.5_examples/instance_types.html)
- [Permissions](/api/api_1.5_examples/permissions.html)
- [Publications](/api/api_1.5_examples/publications.html)
- [Repositories](/api/api_1.5_examples/repositories.html)
- [Security Groups](/api/api_1.5_examples/security_groups.html)
- [Servers](/api/api_1.5_examples/servers.html)
- [ServerTemplates](/api/api_1.5_examples/servertemplates.html)
- [Server Array](/api/api_1.5_examples/server_array.html)
- [Tags](/api/api_1.5_examples/tags.html)
- [Users](/api/api_1.5_examples/users.html)
- [End-to-End Examples](/api/api_1.5_examples/end-to-end_examples.html)

<sup>1 </sup>The Examples section is a work in progress. It is our plan to not only add to the number of examples, but to add to the curl examples with a REST API client (right_api_client) examples. The curl examples have the advantage of ease of use when exploring, whereas the REST API client is likely preferred by more seasoned developers. Although Ruby experience is helpful, the right_api_client examples do their best to minimize the complexity of Ruby used. Some examples also contain a *Supplemental* section. (Usually this includes a filter or view.)

## Error Handling

Error handling was completely revamped in version 1.5 and returns a detailed error message stating exactly why a request failed (i.e. parameter missing errors, resource invalid errors, cloud errors etc.). The response body will include a descriptive error message to assist you with debugging efforts, except in the event of a 500 Internal Server Error.

| HTTP Error Code | Description |
| --------------- | ----------- |
| 301 Moved Permanently | An error code that indicates that the URL has been redirected to another URL. The location for the URL will be listed in the response. |
| 400 Bad Request | Parameter or filter errors, e.g. missing a required parameter. The request should not be repeated without modifying it. |
| 401 Unauthorized | Authentication errors, e.g. wrong username/password or wrong instance token (for instance facing sessions).
| 403 Forbidden | Authorization errors, e.g. Not having sufficient user 'roles' to perform a particular action or the account might not have the required setting. This error code can also be returned with a "Session cookie is expired or invalid" message indicating that the session has expired. |
| 404 Not Found | Unknown routes, e.g. making a GET request to /api/unknown_route. |
| 405 Method Not Allowed |Method not allowed errors, e.g. making a DELETE request to /api/clouds. |
| 406 Not Acceptable | Unknown format error, e.g. making a GET request to /api/clouds.PDF. |
| 422 Unprocessable Entity | A generic error code that indicates: resource not found (e.g. GET /api/clouds/unknown_cloud), invalid resource (e.g. an error occurred during resource creation), invalid API version (e.g. setting X_API_VERSION to 0.9), or cloud errors (e.g. trying to attach a volume to a device that is already taken). |
| 500 Internal Server Error |	Unknown errors, please contact support if you get this error.
504 Gateway Timed Out | The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server specified by the URI (e.g. HTTP, FTP, LDAP) or some other auxiliary server (e.g. DNS) it needed to access in attempting to complete the request. |

**Note**: To implementors: some deployed proxies are known to
return 400 or 500 when DNS lookups time out.

### See also

* [RightScale right_api_client](https://github.com/rightscale/right_api_client) (On github) - Developed by RightScale engineering
* [RightScale API 1.5 PHP library](https://github.com/rgeyer/rs_guzzle_client/tree/master/Tests/mock/1.5) (On github) - This PHP library is *under construction*, but has many helpful examples that PHP developers will find useful. Skilled developers may find the github examples more compelling than the Examples section of this guide.
* [RSC - A Generic RightScale API Client](https://github.com/rightscale/rsc) (On github) - Provides both a command line tool and a go package for interacting with the RightScale APIs. Developed by RightScale engineering.
