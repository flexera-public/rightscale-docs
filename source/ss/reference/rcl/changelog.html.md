---
title: Cloud Workflow Changelog
description: Change log for the Cloud Workflow language
---

## Version 2

Released June 2016

### Breaking Changes

* The `rs` namespace has been renamed to `rs_cm` to make it clear this namespace refers to Cloud Management.

    RCL v1:
    ~~~ ruby
    rs.clouds.get(href: "/api/clouds/1234").instances()
    ~~~
    RCL v2:
    ~~~ ruby
    rs_cm.clouds.get(href: "/api/clouds/1234").instances()
    ~~~

* The `create` action in RCL no longer follows up with a get action. However, the built-in provision strategies handle this so that resource collections will include updated fields after a successful provision.

    RCL v1:
    ~~~ ruby
    @server = rs.servers.create(server: $server_hash)
    $server = to_object($server)
    ~~~
    RCL v2:
    ~~~ ruby
    @server = rs_cm.servers.create(server: $server_hash)
    @server = @server.get()
    $server = to_object(@server)
    ~~~
    
* Redirects in HTTP functions include the headers only if the redirected URL is in the same domain as the original URL.  **No RCL change required**.  Remote HTTP server **must** return same `Host` header if you require HTTP request headers to pass through a redirect before hitting the appropriate endpoint and getting the response.*
    
* Errors that happen during HTTP activities are now returned as a string. **No RCL change required**.
* The `resource_href` field in `$_errors` is now `resource_hrefs`, containing an array of hrefs.

    RCL v1:
    ~~~ ruby
    [ { resource_href: “/account/71/instances/123” , action: “run_executable”, …}, {..} ]
    ~~~
    RCL v2:
    ~~~ ruby
	[ { resource_hrefs: “/account/71/instances/123” , action: “run_executable”, …}, {..} ]
    ~~~
    
* Arguments to `cancel_task` and `abort_task` expressions are no longer accepted. These expressions can only be used to act on the task executing it. Previously it was possible to cancel or abort a different task.

    RCL v1:
    ~~~ ruby
	define handle_update_error() do
	    cancel_task task_name
	end
    ~~~
    RCL v2:
    ~~~ ruby
	define handle_update_error() do
	    cancel_task
	end
    ~~~
    
* Fixed binary argument evaluation `&&` and `||`. Previously we would evaluate the second argument even if the first argument was evaluated to a negative value for a `&&` expression. Now, `if arg1 && arg2` will not evaluate `arg2` if `arg1` was evaluated to false. **No RCL change required**.
* Fixed assignment expression validation. If a resource collection was assigned to a variable, it previously caused a runtime error "Resource collection assigned to variable". We will now return a parse time error if possible. **No RCL change required**.
* Arguments to `call` expressions are now validated to ensure they are the proper type. **No RCL change required**.
* In a resource action, when a datetime value is returned from an external API in the response, we only convert string values that are in RFC3339 format. Other formats are returned unmodified as string values. **No RCL change required**.
* The `filter` parameter for `index` resource actions should be an array. If it is not an array, it is effectively the same as not passing the parameter at all. Previous versions allowed string values for the parameter.

    RCL v1:
    ~~~ ruby
    rs.servers.get(filter: "name==front_end")
    ~~~
    RCL v2:
    ~~~ ruby
	rs_cm.servers.get(filter: ["name==front_end"])
    ~~~
    

### New Features

* Introduced the notion of [custom provision functions](v2/index.html#resources-custom-provisioning) on resource declarations.
* Resource actions that return collections can be assigned to a variable
* Activities that act on multiple hrefs now run concurrently (with a limit on maximum concurrent requests). This also includes index on cloud sub resources where we do an index on every available cloud.
* The error messages for activity failures are improved. All error messages now include problem, summary, and resolution.

### Enhancements

* The `wait_task` expression will embed the functionality of `expect_task` in it, i.e. `wait_task` will wait for the task to be created if the task wasn't already created.

### Additional Notes

* The array or collection resulting from a bulk action will now be in a predictable order.

## Version 1

Released December 2013

* [First release](v1/index.html)
