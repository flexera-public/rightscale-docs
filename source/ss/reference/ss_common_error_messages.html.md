---
title: Common Error Messages
description: This page lists some common error messages that you may experience while uploading or running a CAT, along with common causes and resolutions.
---

This page lists some common error messages that you may experience while uploading or running a CAT, along with common causes and resolutions. If you don't find your error message here, please [send us feedback](mailto:feedback@rightscale.com) so we can consider adding it.

Error Message Text | Common Causes | Resolution
-------------------|---------------|------------
Any "internal error" | An issue with the RightScale system | [Contact support](mailto:support@rightscale.com) immediately with all pertinent information: account number, CloudApp link, exact error message
"activity did not complete" | Usually indicates an issue with the RightScale system | [Contact support](mailto:support@rightscale.com) immediately with all pertinent information: account number, CloudApp link, exact error message
"operation [operation name] aborted" | The RightScale system aborted the operation due to it exceeding internal limits. This can occur if you have a long running operation (many days) that continually makes "decisions", such as waiting for a server to be in a certain state | Try reducing the number of long-running concurrent tasks in your Cloud Workflow definition. Also, if you are using the `sleep` function, try increasing the sleep time so that fewer decisions are created
422: ResourceNotFound: Instance not found. | There was an error launching the instance in Cloud Management, but the `launch()` operation actually succeeded so Self-Service is unaware of the underlying error. | Navigate to the deployment in CloudManagement and locate the offending resource. Audit entries may contain some details, or attempting to launch the resource should present the error.
Any "422" error | Indicates an error from the cloud provider when taking an API action. These messages are usually followed by the error message from the cloud provider (such as availability zone/instance capacity limits, exceeded quotas, etc). | Attempt to understand the error returned by the cloud and mitigate it.
"instance stranded in booting" or "Instance in array stranded" | When attempting to launch the server/array using the `provision()` operation, the server/array stranded, causing `provision` to "clean up" the server/array by terminating it and destroying it, and then raise an error. | Navigate to the associated deployment in CM and use the Audit Entries tab to locate the server that stranded and the audit entry that describes the problem.

RightScale support is always available to help understand and debug these issues. If you'd like Support, [email support@rightscale.com](mailto:support@rightscale.com)  with all pertinent information: account number, CloudApp link, exact error message.
