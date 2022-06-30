---
title: Managing Windows RightImages
description: Overview of using RightScale-published RightImages and Chef recipes to configure Windows servers in a RightScale Deployment.
---

## Overview

Using Windows on the cloud often means having to produce custom images, which may be required to pre-install licensed software and/or to keep instances up-to-date with security patches. To support this type of customer scenario, RightScale has created the RightLink Installer which you can use to install RightLink onto any running Windows instance so that you can bundle it and create a custom RightScale-enabled image with RightLink installed. The RightLink Installer will set up the server so that the image produced from bundling it will be runnable directly from RightScale. For more information on the RightLink Installer, see [Getting Started with RightLink](/rl10/getting_started.html).

As a general rule, you should **multi-purpose** your images and **single use case** your ServerTemplates. Hence only base machine images should be bundled. You can also include software that uses hourly license fees. All other software and configuration for the server will be performed via scripts.
