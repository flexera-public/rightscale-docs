---
title: Best Practices for ServerTemplate Development
description: The list below highlights some general best practices for developing custom ServerTemplates in RightScale. Many of the points will be described in more detail in other sections of the guide.
---

## Overview

The list below highlights some general best practices for developing custom ServerTemplates. Many of the points will be described in more detail in other sections of the guide.

* No change is best! As a general rule, you should only modify a script in a ServerTemplate if the change is absolutely necessary. If you modify a ServerTemplate you introduce changes that have not been tested. Many ServerTemplate SLAs become void if it's modified from the original state.
* Before you attempt to create a ServerTemplate from scratch, it is recommended that you check the MultiCloud Marketplace to see if a similar ServerTemplate already exists that you can import and clone. If you already imported a ServerTemplate, make sure that you start with the most recently published revision.
* If you are creating a ServerTemplate from scratch, use one of the "Base" Linux/Windows ServerTemplates to start ServerTemplate development. Go to the MultiCloud Marketplace and search for "Base" ServerTemplates published by RightScale. Each "Base" ServerTemplate includes the bare minimum set of scripts, tags, and alerts that are necessary for launching an optimized server in the cloud that follows RightScale's best practices. These ServerTemplates automatically set up monitoring, log and audit entry aggregation, basic server alerts, tags, etc. They also include the latest set of MultiCloud Images that use the most recently published RightImages. These ServerTemplates have been thoroughly tested by RightScale across all clouds that they support.
* Make sure all inputs have helpful tooltip descriptions that are consistent and include an acceptable sample value that shows the correct syntax. Include valid data ranges, if applicable.
* Provide acceptable default values for as many of the generic inputs as possible. Keep the missing, required inputs to a minimum.
* Freeze your software repositories so that the same packages will be used each time.
* Test a ServerTemplate with each supported cloud of its MCIs to ensure that it can be used in all of the clouds that it is intended to support.
* Only commit successful changes to a ServerTemplate. (i.e. You should never commit a ServerTemplate, if it does not successfully launch a server.) Always provide helpful commit messages that will include enough detail about the changes so that other users will be able to understand what was modified.
* When you are actively developing a new ServerTemplate, you should regularly test it by using a "Test" server that references the HEAD version of a ServerTemplate so that any changes that are made to the ServerTemplate will automatically be inherited by the server, which will make it easier to test a new or modified script.
* Publish a committed revision of the ServerTemplate and privately share it with another RightScale account for testing purposes to ensure that there are no account-specific dependencies.
* Only use static, committed revisions of a ServerTemplate in production environments; HEAD versions of a ServerTemplate should never be used to launch production servers.
