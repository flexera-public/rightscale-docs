---
title: Performance Optimizations
description: This page lists some performance optimizations that can be made to make CWF processes run more efficiently.
---

## Overview

The Cloud Workflow system, which is the engine behind RightScale Self-Service, is a complex system backed by several technologies offering high availablility and reliability for running orchestration tasks in the cloud. As such, there are some optimizations that can be made that may not be obvious, but can make processes run more efficiently due to how code is compiled, parsed, and run in the system.

## Optimizations

### Limit API call response sizes

When making API calls to external systems, including RightScale Self-Service and Cloud Management, try to minimize response sizes to only the information that is required for processing. This saves time when processing and storing the response in the backend.

For example, many API calls to RightScale systems allow the specification of different "views", each of which provide a different set of information in the response. Many calls also allow for "filters" in order to limit the response only to those resources that are needed.

**Ensure that all API calls being made are returning only the minimal amount of information required by leveraging filters and views in the request.**

#### Example

For example, the [Self-Service Execution index](http://reference.rightscale.com/selfservice/manager/index.html#/1.0/controller/V1::Controller::Execution) API supports 5 different views -- make sure you are using the minimal view that contains the data you need.

**Note:** At this time there is a bug such that the `Execution.show` call can not be used with the `tiny` view, instead make an `Execution.index` call using both the view and the filter to specify the execution.

The following code gets the name of the CAT that this CloudApp was created from using this approach.

~~~ruby
  $id = @@execution.id
  @execution_data = rs_ss.executions.get(ids: [$id], view: "tiny")
  $execution_json = to_object(@execution_data)
  $ss_cat_name = $execution_json["details"][0]["launched_from_summary"]["value"]["name"]  
~~~

### Work with large hashes/datasets inside of definitions

Whenever you work with large datasets, whether they are variables internal to your CAT or they are responses from an external API, do the work in a small definition isolated only to that work. This helps because sometimes the CWF system needs to save the "state" of the process, which includes any variables that are part of the CAT. If there are massive variables "in-scope" when a state save occurs, this can cause performance issues or hit limits internal to the system. If this work is done within a definition, then the variable is only in scope for a limited amount of time and there is less likelihood of a state save occuring when interacting with the variable.

#### Example

For example, if you are working with a large response from an API, create a definition to **only** do that, keeping the large response in scope for a limited time.

~~~ruby
define get_image_id() return $image_href, $image_name do
  # Big API call
  $all_images = rs_cm.images.get()

  # Very large response stored in @image - don't keep it around very long
  @image = first(select(sort(@all_images, 'name', 'desc'), {"name": "scoobydoo"}))
  $image_href = @image.href
  $image_name = @image.name
end
~~~

### With giant hashes, use JSON instead

If you have a need to work with overly large hashes for any reason (many hundreds/thousands of characters), the CWF backend is more efficient at parsing and referencing the hash if it is a JSON string and then loaded into a hash using the [`from_json`]() function. This is due to the internals of CWF, and while not intuitive, will increase performance.

~~~ruby
  # Less efficient
  $massive_hash = {"key1" => { "keysub1" => "some value", "keysub2" => "some other value"}, "key2" => ..... }

  # More efficient
  $massive_hash = from_json("{\"key1\": { \"keysub1\": \"some value\", \"keysub2\": \"some other value\"}, \"key2\": }")
~~~
