---
title: Image Bundler For RightLink 10
description: This RightLink 10 ServerTemplate uses Packer to create private images
---

## Overview
Since stock/official images are made available by the cloud provider or the OS developer, they can be deregistered and made unavailable at anytime at the discretion of the owner. It is advised that you create your own MultiCloud Image with your own custom image for linux or windows. This ServerTemplate will allow you to build your own images that will not be deregistered.

The [Image Bundler For RightLink 10](http://www.rightscale.com/library/server_templates/Image-Bundler-For-RightLink-10/lineage/58435) ServerTemplate contains a set of scripts to make a private image based on public image using [Packer](http://packer.io). For Windows instances RightLink 10 can be bundled with the image to allow RightLink install and enable during boot. A [tutorial](tutorial.html) on using this ServerTemplate is available.

The following features are supported:

* Uses RightScripts to automate installing and configuring Packer to build your image
* Copies public image to your cloud account
* Supports AWS, Google Compute and Azure Resource Manager
* Linux and Windows Platforms
* Can bundle cloud-init and RightLink 10 into image if necessary

!!info*Note:* Read about [Packer](http://packer.io) and it's configuration before using this ServerTemplate.

!!info*Note:* For a complete list of the ServerTemplate's features and support, view the detailed description under its <b>Info</b> tab.
