---
title: Why do scripts and recipes fail with a missing project ID error?
category: google
description: RightScale assets and platform currently support Google Cloud Storage's XML API v1.0. To use this API you must first designate a default project for your account.
---

## Overview

When running various Rightscripts and recipes, particularly scripts related to storage (backup/restore etc) you may notice a missing project ID error in your server's audit entries similar to this:

~~~
*RS> encoding='UTF-8'?><Error><Code>AccessDenied</Code><Message>Access
*RS> denied.</Message><Details>Missing project id</Details></Error>">
~~~

The scripts and recipes will fail and your servers may strand.

## Resolution

RightScale assets and platform currently support Google Cloud Storage's XML API v1.0. To use this API you must first designate a default project for your account.

To designate the default project, login to the Google console and define a default project by doing the following:

1. Log in to the [Storage Access](https://code.google.com/apis/console#:storage:access) pane in the Google APIs Console.
2. Make sure you are in the project you would like to use as your default project.
3. Click the **Make this my default project for interoperable storage access** button.

That is the only action needed to make new GCE accounts compatible with Rightscale and the Google storage API v1.0. Re-running or re-launching any previously failed scripts or servers should now function, and any storage related recipes or rightscripts should now function properly.

## Questions? Concerns?

Call us at **(866) 787-2253**, email us at [support@rightscale.com](mailto:support@rightscale.com) or open a support incident from the Rightscale dashboard under the **Support -> Email** link in the top right corner.
