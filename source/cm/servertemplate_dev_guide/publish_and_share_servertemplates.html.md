---
title: Publish and Share ServerTemplates
description: Best practices for publishing and sharing your RightScale ServerTemplates. 
---

## Overview

When you're ready to publish your ServerTemplate so that you can either privately share it with another RightScale account or make it publicly available for all RightScale accounts to use, you should follow some of the best practice guidelines below.

See the [Publishing and Sharing](/cm/pas/) guide.

## Best Practices

* Publish and share committed revisions of ServerTemplates. Although you can privately share a HEAD version of a ServerTemplate, it is not recommended and should only be done in unique use cases by advanced users.
* Provide a detailed ServerTemplate description. The description should include:
  * 1-3 sentences that describe the overall purpose of the ServerTemplate and how it's intended to be used.
  * List current cloud support.
  * Prerequisites
  * Assumptions or dependencies. (i.e. Is the ServerTemplate designed to work with another ServerTemplate?)
* Provide helpful support information. When you publish a ServerTemplate, you will be asked to provide "Support" information, which should explain where a user can go to find technical information about how to use the ServerTemplate. Be sure to include links to setup tutorials, runbooks, and instructions for how a user can get help or submit feedback. RightScale is not responsible for supporting or troubleshooting custom built ServerTemplates that are developed and published by other users.
* Deprecate any previously published versions/revisions of the ServerTemplate so that only the most recently published version will be visible in the MultiCloud Marketplace.
