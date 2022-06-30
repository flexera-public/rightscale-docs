---
title: RightScale Components Relationship Diagram
layout: cm_layout
description: This diagram illustrates the basic relationships between the primary components of the RightScale Cloud Management Platform.
---

The following diagram summarizes the basic relationship between the main RightScale components.

![cm-component-relationships.png](/img/cm-component-relationships.png)

Diagram highlights:

* RightScale components (e.g. RightScripts, ServerTemplates, etc.) exist within a RightScale account and serve no purpose outside of the RightScale platform. (i.e. You cannot use a ServerTemplate to launch a cloud server without using the RightScale Dashboard or API.)
* A ServerTemplate consists of several reusable components that exist independently from the ServerTemplate itself. They are all reusable components so multiple ServerTemplates can use the same scripts (RightScripts and Chef recipes) and MultiCloud Images (MCIs). But, it's the combination of a ServerTemplate's scripts and inputs that affect the functionality and character of a launched server. For example, is the ServerTemplate designed to launch a MySQL database server or a dedicated PHP application server? The scripts that run on a server at boot time control its real-world functionality. By themselves, ServerTemplates and RightScripts are cloud-agnostic and can be used to launch and configure servers in any cloud. However, it's the MultiCloud Image that controls which underlying cloud infrastructures are supported. Remember, in order to successfully launch a server in a cloud, a bootable machine image must exist in the cloud itself. The MCI serves as an "image mapper" that automatically selects the appropriate image based on which cloud you're trying to launch a server on. Although an MCI is technically a RightScale-specific component, the images that it references must exist in the clouds themselves. So, although the ServerTemplate and its RightScripts are cloud-agnostic, the template's MCIs dictate which clouds are supported. For example, you can only use a ServerTemplate to create/define a server in one of the clouds that an MCI supports. Therefore, if none of the MCIs that are used by the ServerTemplate reference an image in the AWS US-West region (cloud), you cannot successfully launch a server in that cloud.
* Once you've created/defined a server using ServerTemplates, it's considered an "Inactive" server because it's simply meta-data at this point; it does not point to a real and equivalent instance in the cloud.
* When a Server is launched from the RightScale Dashboard/API, it becomes an "active" definition and serves as a pointer to an instantiated running server (instance) in the selected cloud infrastructure.
* A deployment may or may not have a server array associated with it for horizontal scaling. It's an optional configuration. A deployment can have multiple server arrays. However, each server array must be associated with a specific deployment.
* A server inherits a majority of its configurations from its ServerTemplate. It's important to note that a server's scripts are strictly defined by its ServerTemplate. Unlike inputs and alert specification, you cannot add a script at the server level.
* A macro can be run to instantly create certain RightScale components and select cloud resources on-demand (if supported). Currently, you can only create cloud resources in AWS.
