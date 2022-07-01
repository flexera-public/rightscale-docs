---
title: Inheritance of Images
layout: cm_layout
description: Similar to Inputs, Images in RightScale also conform to an inheritance hierarchy through the use of MultiCloud Images.
---

## Overview

Similar to Inputs, Images also conform to an inheritance hierarchy through the use of MultiCloud Images.

You can influence which image will be used by a Server when it's launched at the following levels:

* ServerTemplate
* Server Array
* "Next" Server

The actual image that will be used when a Server/Instance is launched will depend on where it's defined. However, once a Server has been launched and there's a running Instance in the cloud, its image cannot be changed.

## Servers

A **Server** (in a Deployment) first inherits its image from the selected MultiCloud Image (MCI) of its ServerTemplate. A ServerTemplate is published with one or more MCIs. When you add a Server to a Deployment, you must first specify into which cloud/region you want to launch an Instance. Each ServerTemplate is published with a default MCI preselected. However, when you add a Server to a Deployment you can choose a different MCI. The image of the selected MCI will automatically be selected for you based upon your cloud/region selection. ( **Note** : You can only add a Server into a cloud/region that's supported by the MCI.) You can either inherit the image that will be chosen by the selected MCI, or overwrite the selection and choose a different image. For example, you may want to use an image for testing purposes that's currently not referenced in an MCI.

Once you've defined the Server you can still edit its image settings until you decide to launch the Server and instantiate a running Instance in the cloud. Once a Server has been launched, its image cannot be changed. However, if you have a running "Current" Server, you can change the image settings for the "Next" Server, which will be applied to the next time that the Server is launched or relaunched.

![cm-images-inheritance-servers.png](/img/cm-images-inheritance-servers.png)

1. Each ServerTemplate is published with a default MCI preselected. (For example with AWS, the default image is typically a 'small' instance type with a 32-bit architecture.)
2. If you want to use a different MCI, it's recommended that you select one of the listed MCIs of that the ServerTemplate to ensure compatibility. For AWS, if you want to launch a 'large' or bigger instance type, you need to select an MCI that references 64-bit images.
3. You can also select a different image than what's available through one of the listed MCIs. Perhaps you have a custom image that you just built and you want to test it before you create an MCI for it. This option should only be used by advanced users who have a clear understanding of their chosen image.

**Important!** ServerTemplates that are published by RightScale have been thoroughly tested with all of RightScale's associated MCIs. Although you can choose to use a different MCI (other than the default) or select a different image altogether, it's important to realize that those combinations were never tested internally by RightScale. In such cases, you may or may not experience problems launching the Server. Therefore, it's recommended that you keep the "Inherit from MultiCloud Image" selection once you've selected your MCI to ensure instance type and system architecture compatibility.

## Server Arrays

A **Server Array** will also inherit its image from the ServerTemplate's MCI. Remember, you can't change the image on a running Instance. It's important to realize that the image settings at the Server Array level may not always reflect the actual images that were used to launch all of the running Instances in the array. A Server Array's configuration only controls how the next Instances will be launched; it may or may not reflect how previous Instances were launched.

![cm-images-inheritance-arrays.png](/img/cm-images-inheritance-arrays.png)

## Best Practices

It's best to let one of the MCIs that's referenced by the ServerTemplate select the appropriate image for a Server. If you choose to select a different MCI that is not referenced by the ServerTemplate or select an image from the list of available images for that cloud/region, you may experience problems launching Servers successfully with that ServerTemplate since you're probably using a ServerTemplate-Image combination that was never tested. However, the flexibility to choose different MCIs or images can prove quite useful especially for testing and development purposes.

For production environments, you should always use MCIs for image selection purposes. If you are using MCIs that you have created using your own custom images, make sure that they have been throughly tested before using them in a production environment. Similarly, you should only publish and share ServerTemplates with MCIs that have been thoroughly tested to make sure that a Server will be launched successfully regardless of which image is used.

**Note**: For AWS, the "default" MCI that's selected for ServerTemplates published by RightScale will typically select a 32-bit image along with a 'small' EC2 instance type.

## See also

* [MultiCloud Images](/cm/dashboard/design/multicloud_images/index.html)
