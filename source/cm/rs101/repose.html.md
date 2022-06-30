---
title: Repose
layout: cm_layout
description: Repose is a RightScale mirroring service that automatically mirrors Chef cookbook source-code repositories referenced in RightScale RepoPaths.
---

## What is Repose?

A RightScale mirroring service that automatically mirrors Chef cookbook source-code repositories referenced in RightScale RepoPaths.

## Overview

RightScale developed Repose as a more reliable solution for launching Servers that leverage executable code hosted on third-party repositories such as [GitHub](https://github.com/). Successful server launches are no longer dependent on the availability of these third-party repositories.

## RightImage Version Considerations

You should take the following version considerations into account when using Repose. The version of a server's underlying RightImage will determine whether it supports Repose.

* **Version 5.6 and newer RightImages** \* - Servers launched with Version 5.6 and later RightImages will always pull cookbooks directly from the RightScale mirror. They will never pull cookbooks directly from your repositories. The mirror is automatically refreshed daily, or you can manually trigger a refresh at any time by clicking "Refetch" on a cookbook repo's Info tab.
* **Version 5.5 and older RightImages** - For instances using legacy RightImages (e.g. Version 5.5), cookbooks are pulled directly from your public/private repositories and not from Repose.  

\* If you are starting RightImage-5.6-based servers in a virtual private cloud (VPC) or behind a firewall, you must allow outgoing HTTPS traffic from your servers to _repose1.rightscale.com_ (which has multiple IP addresses for redundancy purposes).
