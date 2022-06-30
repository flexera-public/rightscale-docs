---
title: Container Manager
layout: cm_layout
description: Displays information about containers running on instances in this account
---

## Overview

The Container Manager shows information about containers that are currently running on instances in your account. You can easily search for images/tags to locate containers running in your account and quickly SSH in to machines to interact with them. A CPU and Memory graph is shown for each container that is running to help give you a picture of what is happening on each container.

## Details

### Enabling Container Information

In order for containers to show up in this view, the correct tags must be set on each instance that is hosting a container. The best way to set those tags is to use the [RightLink 10 container feature](/rl10/reference/rl10_docker_support.html) -- this will not only enable continuous updating of instance tags based on what is running, but will also configure each of the monitors for the containers.

### UI Description

Active Container Images - The left-hand panel shows a list of all images associated with running containers across all of your instances. For each image, you can expand the row to see all of the tags that have been detected. Selecting either the image name or an individual tag name will cause the Running Containers view to update to show matching container information. Use the `Image Filter` to filter on both image name and image tag names.

Running Containers - The right-hand panel shows all of the currently running containers on your infrastructure that use the images selected on the left. The containers are grouped by image:tag and list all of the hosts that are running containers with that image:tag combination. You can use the links for `Deployment` and `Host` to navigate directly to that page in Cloud Management or use the `SSH` link to open an `ssh://` link to the instance running the container. The graphs on the right show the CPU and Memory usage for that container -- hovering over them will provide more detailed information. You can use the `Container Filter` to filter on any of the fields in the UI, including: container name, deployment name, server name.

![Container Manager](/img/cm-container-management.png)

### Using the Container Manager

The first step when using the Container Manager is to locate and select the images for which you want to see the running containers. Only images that have a running container are displayed. You can select the image name or you can drill down to select specific tags of that image.

Once you have an image (or images) selected, the corresponding containers will show on the right panel. They are grouped by name/tag/SHA and show information about the host and deployment they are running in as well as the monitoring data that is being collected.

You can browse to the host or deployment if you would like to see more details, such as more detailed or longer timespans for the monitoring data.
