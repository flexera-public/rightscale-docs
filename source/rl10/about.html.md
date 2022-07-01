---
title: About RightLink 10
alias: rl/about.html
description: RightLink version 10 (RL10) is a new version of RightScale's server agent that connects servers managed through RightScale to the RightScale cloud management platform.
---
## What is RightLink 10

RightLink version 10 (RL10) is a new version of RightScale's server agent that connects servers managed through RightScale to the RightScale cloud management platform.

# Features

* Very simple and fast enablement of already running instances using existing images as well as official OS images.
* Support for RightScripts stored in source-controlled repositories (git or svn)
* HTTPS-only communication with the RightScale platform
* Proxy for API 1.5 allowing local scripts to make requests to the RightScale platform with ease

## Use-Cases

RightLink 10 targets the following use-cases:

* **"Enable-running"**: You have an already running instance and want to add RightScale functionality, such as monitoring, alerts, managed login, operational scripts.
* **"Install-at-boot"**: You have an existing image that you would like to provision and manage via RightScale without modifying the image (similar to automatically enabling a running instance at boot).
* **"Install-on-image"**: You want to create new images with RightScale functionality "baked-in", resulting in the highest reliability and fastest boot time possible.
