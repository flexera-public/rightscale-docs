---
title: ServerTemplate Release and Lineage Methodology
layout: cm_layout
description: Overview of the RightScale ServerTemplate Release and Lineage Methodology.
---

## Overview

Over the years, the methodology behind official RightScale-released ServerTemplates has changed significantly. The following table summarizes the major versions and their status.

Release Version | Timeframe | Description | State
----------------|-----------|-------------|-------
11, 11H1, 11H2 | 2010 and 2011 | The initial set of RightScale-published ServerTemplates were compatible with only AWS in most cases. They were RightScript-based and included a wide variety of functionality | No longer supported. No longer available in the MultiCloud Marketplace
v12, v12-LTS | 2012 | These ServerTemplates were Chef-based and worked on a variety of clouds. They included a wide variety of applications and configurations | No longer supported. No longer available in the MultiCloud Marketplace
v13 | 2013 | The v13 (non-LTS) ServerTemplates were an active branch of ServerTemplates into which many features were added over the release cycle. They were Chef-based and included a wide variety of applications. | No longer supported. No longer available in the MultiCloud Marketplace
v13-LTS | 2013 | The LTS version of the v13 lineage are a stable branch of the v13 ServerTemplates. They are Chef-based and contain many different applications. | End of Support Oct 30, 2015
v14 | 2014, 2015 | The v14 ServerTemplates mark a transition from our legacy RightLink agent (v6) to the new RightLink agent (v10). They also are a change in philosophy of what RightScale provides in that we only provide Base functionality that you can then build on top of. They include a mix of RightLink versions and feature support. | Supported
v15 | 2015 | The v15 ServerTemplates all include only the modern RightLink agent (v10+) and all include only Base functionality. | Supported

## ServerTemplate Philosophy

RightScale's philosophy behind engineering-supported and released ServerTemplates is to provide you with a foundation on top of which you can build your own applications and services. In the past, we released fully-featured, out-of-the-box ServerTemplates, but that approach proved to be unsustainable both for the RightScale team as well as our customers, who frequently needed customizations and modifications to get them working for their specific use cases.

## ServerTemplate Maturity

Each RightScale-published ServerTemplate is considered GA (general availability) quality unless specifically labeled “Beta”. GA quality means that it has passed our automated test suite and has undergone manual testing.

## ServerTemplate Versions

Each ServerTemplate is versioned using a 3-digit version number when it is released (see below for details).

## Understanding ServerTemplate Lineage in RightScale

Each ServerTemplate is in a lineage that starts when a ServerTemplate is created or cloned. The lineage persists across revisions of that ServerTemplate. If the ServerTemplate is cloned, a new lineage is created for the cloned ServerTemplate.

When using a ServerTemplate, if a new revision of the ServerTemplate is available in the lineage, you will be notified by a yellow sphere on the ServerTemplate page.

## RightScale ServerTemplate Lineages

### Infinity Lineage

The infinity lineage allows a ServerTemplate to maintain its lineage for its lifetime until deprecated. For example, the Base ServerTemplate for Linux will always use the same lineage, even when major changes are applied. Releases within the infinity lineage occur at roughly 2 month increments, but may occur sooner or later depending on feature availability.

!!info*Note*LTS ServerTemplates are no longer published by RightScale

## Lineages and Versioning

RightScale uses a 3-digit versioning scheme to help identify which lineage each ServerTemplate belongs to. Version numbers are in the form XX.YY.ZZ[-LTS] where:

* **XX** = the 2-digit major release number. This number is incremented in 2 cases: when an LTS release occurs or when a major architectural change occurs across the ServerTemplates.
* **YY** = minor release number. This number is incremented for every update to the ServerTemplates that introduces breaking changes (note: this means this number is never incremented inside of an LTS release)
* **ZZ** = revision number. This number applies most commonly to LTS releases and is incremented when a maintenance release is provided for an LTS asset. This number can exist for infinity releases, but is not expected to be frequently used and will not normally be shown on infinity release version numbers for the first (.0) release.
* **LTS** = Long Term Support indicator. This suffix is added to releases that are part of a LTS release. **Note** only legacy ServerTemplates will have this indicator
