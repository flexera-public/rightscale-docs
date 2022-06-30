---
title: Self-Service API Guide
description: Overview of the Self-Service API including Views and Filters, Responses, and Sample Calls.
---

[[API Overview
For a general overview of the concepts used across all APIs, including **endpoints**, **authentication**, **headers**, and more, see the following information:
* [RightScale API Overview](/api/general_usage.html)
]]

## Self-Service API Overview

The Self-Service API is composed of three separate services, each of which has a specific purpose:

* [**Designer**](http://reference.rightscale.com/selfservice/designer/index.html) - the Designer API is used to validate CAT syntax, design schedules, launch CloudApps for testing purposes, and publish CloudApps to the Catalog
* [**Catalog**](http://reference.rightscale.com/selfservice/catalog/index.html) - the Catalog API is used to launch published CloudApps with all options, such as parameters, schedules, and end dates
* [**Manager**](http://reference.rightscale.com/selfservice/manager/index.html) - the Manager API is used to manage running CloudApps; including getting information, starting custom operations, terminating, and stopping and starting

Some actions are available through multiple API services/resources -- when this is the case, the actions are aliases for each other.

## Views and Filters

Views and filters can be used to change the detail of information returned or to limit which resources are returned. For details, see [the RightScale API Overview](/api/general_usage.html#filtering-and-views)

## Responses

All responses from the Self-Service API are JSON. Each resource in the API documentation contains a MediaType desription that defines what attributes are returned for a given resource. Views are used to vary the level of detail returned in a given response.

## Sample calls

This page lists sample requests and responses for most SS API calls:
* [Sample Calls](/ss/reference/ss_api_sample_request_responses.html)
