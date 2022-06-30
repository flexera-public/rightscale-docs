---
title: Google Cloud Platform
layout: google_layout_page
description: Google Cloud Platform can be managed alongside other clouds using RightScale
alias: clouds/google/google_about.html
---

## Overview

RightScale allows you to discover, provision, take action, and create policies across a wide variety of Google Cloud Platform (GCP) cloud services, including compute, storage, network, database, middleware, and application services.

Many cloud services are supported out-of-the-box in RightScale while others leverage a plugin. Plugins describe the API of a service provider for the RightScale platform, including defining the parameters which must be specified to interact with the service, the structure of resources in the service, and how RightScale can create and interact with those resources. RightScale continually creates new plugins for cloud services which are shared in a [public repository on GitHub](https://github.com/rightscale/rightscale-plugins). RightScale partners or customers can [create their own plugins](/ss/reference/cat/v20161221/ss_plugins.html).  

There are four approaches that you can leverage to manage cloud services in RightScale:

* Native integration - no plugin is required
* Out-of-the-box plugin - plugin is provided by RightScale. ([GitHub repo](https://github.com/rightscale/rightscale-plugins))
* Custom plugin - [create a plugin](/ss/reference/cat/v20161221/ss_plugins.html) for other cloud services
* http/https - use the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions)

## Supported Google Cloud Platform (GCP) Services

Below is a list of services supported for GCP. Other services can be supported through [custom plugins](/ss/reference/cat/v20161221/ss_plugins.html) or the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions).

| **Google Services** | **How Supported** | **Link to Plugin** |
| ----------- | ----------- | --------------------- |
| GCE | Native and Plugin | [Google Compute Engine](https://github.com/rightscale/rightscale-plugins/blob/master/google/gce) |
| Persistent Disks | Native |  |
| Networks | Native |  |
| Cloud DNS | Plugin | [GCP Cloud DNS](https://github.com/rightscale/rightscale-plugins/blob/master/google/google_cloud_dns) |
| GKE | Plugin | [GKE](https://github.com/rightscale/rightscale-plugins/blob/master/google/gke) |
| Cloud SQL Database | Plugin | [GCP Cloud SQL](https://github.com/rightscale/rightscale-plugins/blob/master/google/google_cloud_sql) |
| Bigtable | Plugin | [GCP Bigtable](https://github.com/rightscale/rightscale-plugins/blob/master/google/google_bigtable) |
| Any other GCP services | Custom plugin or http/https support | &nbsp; |

## Contact Information

### Google

* **Corporate website:**  [http://cloud.google.com/products/compute-engine.html](http://cloud.google.com/products/compute-engine.html)

### RightScale

* **Sales** - For information about your account specifics, contact your account manager *or* email [sales@rightscale.com](mailto:sales@rightscale.com)
* **Support** - Report any bugs related to RightScale, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).
