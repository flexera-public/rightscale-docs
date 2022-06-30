---
title: Locking
layout: cm_layout
description: The ability to 'lock' a component inside the RightScale platform is a helpful management feature that provides another way of protecting a component from accidental or unapproved user actions.
---

## What is Locking?

The ability to 'lock' a component inside the RightScale platform is a helpful management feature that provides another way of protecting a component from accidental or unapproved user actions. Currently you can only lock deployments and servers. When a component is locked/unlocked, the action is reported in the change log (Changes tab) with a date/timestamp, and an audit entry is created and displayed in the Events pane. The person who locked/unlocked the component is also identified (by his or her email address) for security reasons.

As a best practice, you should always lock a deployment that contains operational production servers, which prevents a server from being deleted and removed from a deployment.

## Locking a Deployment

When you lock a deployment, you cannot delete the deployment or any of its servers. However, you will still be able to manage all other aspects of your deployment such as launching or terminating servers, as well as editing server and deployment configurations. If you are defining a mission-critical deployment it is recommended that you lock the deployment once it is deployed. You can also lock a single (running) server at the server level to prevent that server from being terminated, re-launched, bundled, etc.

**Note**: When you lock a deployment, the individual servers inside the deployment are not locked. Each server must be locked individually.

## Locking a Server

Similar to deployments, you can also 'lock' a single server to protect it from certain user actions. For example, when an individual server is locked, it cannot be manually moved, terminated, rebooted, or re-launched. However, automated, alert-based actions will remain active (e.g. sending email notifications, running scripts). You will also still be able to clone and SSH into the server. You can only lock running (active) servers.

## See also

* [Lock or Unlock a Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#lock-or-unlock-a-deployment)
* [Lock or Unlock a Server](/cm/dashboard/manage/instances_and_servers/instances_and_servers_actions.html#lock-a-server)
* [Lock down an entire Deployment](/cm/dashboard/manage/deployments/deployments_concepts.html#lock-down-an-entire-deployment)
