---
title: Custom dimensions in Optima cost reporting
layout: optima_layout
description: Describes the custom dimensions in Optima and how they are configured
---

## Overview

Cost dimensions allow you to slice and dice your cost information to provide insights on spend and potential savings. This page describes custom cost dimensions, but there are also [RightScale-generated dimensions](rightscale_dimensions.html) and [bill-based dimensions](bill_data_dimensions.html).

Custom dimensions are dimensions that are specific to your organization. Today, only resource tag/label-based dimensions are supported.

## Resource tags/labels

Any resource tags (labels in Google) in your bill data can be enabled as custom dimensions. For Google and Microsoft Azure, all resource tags/labels are available in the bill data by default. For Amazon Web Services, resource tags must be [configured as user-defined cost allocation tags](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/custom-tags.html) in order for them to be available in the bill and be used as custom dimensions in Optima.

To configure a tag/label as a custom dimension, please email [support@rightscale.com](mailto:support@rightscale.com) with a list of the tags/labels that you would like configured. This will be user-controlled in the future.
