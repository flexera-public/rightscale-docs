---
title: Cloning
layout: cm_layout
description: Using the RightScale Cloud Management Dashboard you can clone Deployments, ServerTemplates, RightScripts, MultiCloud Images, and Alert Escalations.
---

## Overview

One of the most useful things you can do in the RightScale Dashboard is clone a RightScale component. Currently, you can clone the following:

* Deployment
* Server
* ServerTemplate
* RightScript
* MultiCloud Image
* Alert Escalation

When you clone an object, you are creating an exact duplicate of the object that has its own lineage. If you clone a deployment that contains running servers, the cloned deployment will not have running servers or launch duplicate servers. Instead the new deployment will simply contain the equivalent servers that can be launched at any time. It is the same when you clone a running server. You are simply making an equivalent copy of the server that you can launch any time.

There's a concept called Input Hierarchy that affects cloned objects or resources. Understanding this concept will help one to know what happens to the input values defined on Server or on a Deployment when it is cloned or when a Server is moved to a different Deployment. For example, if a Server is cloned in the same Deployment, the input values defined for that Server will be retained whether they were defined in the Deployment or Server level. However, if the Server is moved to a different Deployment, input values for the Server may not all be retained specially if the input values where defined in the Deployment level. So one needs to check all the input values on the Server whether they are still there or not. See reference for Inheritance of Inputs below to understand more on this.

* [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html#inheritance-of-inputs)

A cloned object is a completely separate object with no linking to the original object that it was cloned from. When you clone ServerTemplates, RightScripts, and MultiCloud Images that support version control, you create an editable HEAD version of the component based on the version/revision that you are currently viewing in the Revision History timeline bar when you click **Clone**. Typically, you import committed revisions of components from the MultiCloud Marketplace that are static and uneditable. Therefore, if you need to customize it, you will need to clone it to create an editable version.

**Note**: You cannot clone a server array.

## See also

* [Clone a Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#clone-a-deployment)
* [Clone a ServerTemplate](/api/api_1.5_examples/servertemplates.html#clone-a-servertemplate)
* [Clone a RightScript](/cm/dashboard/design/rightscripts/rightscripts_actions.html#clone-a-rightscript)
* [Clone a MultiCloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#clone-a-multicloud-image)
* [Clone an Alert Escalation](/cm/dashboard/design/alert_escalations/alert_escalations_actions.html#clone-an-alert-escalations)
