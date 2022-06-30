---
title: MultiCloud Images
layout: cm_layout
alias: cm/dashboard/design/multicloud_images/multicloud_images.html
description: In the RightScale Cloud Management Dashboard, a MultiCloud Image (MCI) is a RightScale component that functions as a map or pointer to machine images in specific clouds.
---

## About MultiCloud Images

A **MultiCloud Image** (MCI) is a RightScale component that functions as a map or pointer to machine images in specific clouds. Each ServerTemplate must reference a single MultiCloud Image that defines which image should be used when a server is launched in a particular cloud.

![cm-multicloud-image-overview.png](/img/cm-multicloud-image-overview.png)

!!info*Note:* The example diagram above only shows one MCI for the ServerTemplate. However, there could be multiple MCIs per ServerTemplate.

Visit the [MultiCloud Images - Actions and Procedures](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html) page for step-by-step instructions on common tasks related to MultiCloud Images.

When you add a server to a deployment, the corresponding ServerTemplate's MultiCloud Images determine which clouds you can use. You will only be able to deploy a server in a cloud that your chosen ServerTemplate MCI supports. In the example above, the selected MCI for this ServerTemplate will only let you deploy a server in the Amazon "US-West" or "US-East" regions. To deploy a server in the Amazon "EU" region, you must use a ServerTemplate with an MCI that supports that region. Fortunately, if you are using published ServerTemplates from RightScale, each template is tested with multiple MCIs. Under the ServerTemplate's Images tab, you can see a list of supported MCIs.

![cm-multiple-mcis-listed.png](/img/cm-multiple-mcis-listed.png)

You can either use the default MCI or select a different one from the list. In this way, a ServerTemplate and its scripts define the functionality of a server (e.g., PHP application server) while the MCI defines which clouds or AWS regions are supported. The screenshot above highlights how MCIs are used to extend a ServerTemplate's multi-cloud support. For example, you can use the same ServerTemplate to configure a 32-bit small server running CentOS 5.6 in Amazon US-East, or a 64-bit xlarge server running Ubuntu 10.04 in the AWS US-West region.

When you add a server to a deployment using a ServerTemplate, you must first specify which cloud to deploy to. For example, if a ServerTemplate is using MultiCloud Images that only have references to images in the Amazon US-East and AWS US-West regions, you cannot use that ServerTemplate to create a server in the "EU" region. Based on the cloud selected (e.g., us-east), the server inherits the appropriate image for that region. If a ServerTemplate has only *one* MultiCloud Image and that MultiCloud Image only has a reference to *one* cloud or Amazon EC2 region, then you can only create a server for that cloud or region.

Once a server is added, it inherits the image specified for that region by the MultiCloud Image. Later, you can manually edit the server's configuration and select a different MCI or even choose a different AMI not referenced by one of the MCIs. The MultiCloud Image is only used to choose the appropriate image when a server is created from a ServerTemplate.

In a MultiCloud Image, you can only specify a single image for each cloud. For example, you cannot specify both a 32-bit and 64-bit image in the "us-east" cloud so you can launch both small and large instance types with the same MCI. However, you could add multiple MCIs to a ServerTemplate that would support both 32-bit and 64-bit images in multiple clouds, as shown in the graphic above.

Also, while the OSs and versions of the images that you specify in a single MultiCloud Image for a cloud do not have to match, as a best practice, we recommend you use the same image OS and version in each MCI across all clouds when possible. It will be easier to manage a MultiCloud Image if it references the same image (e.g., RightImage_CentOS_5.6_x64_v5.7) across all clouds as shown in the diagram above. In addition, we recommend that you name your MultiCloud Image based on its underlying images (e.g. RightImage_Ubuntu_10.04_x64_v5.7).

### MultiCloud Marketplace

MultiCloud Images are located in the MultiCloud Marketplace just like other RightScale components (ServerTemplates, RightScripts, and macros). Similar to RightScripts, when you import a ServerTemplate, its MultiCloud Images are imported to your account (unless they already exist in your account). You can also import a MultiCloud Image from the MultiCloud Marketplace by itself.

### Sharing

You can share MultiCloud Images via account groups as with other RightScale components. Similar to RightScripts, when you publish a ServerTemplate to the MultiCloud Marketplace, its MultiCloud Image is also exported to the MultiCloud Marketplace (unless it is already published).

!!info*Note:* If you share a MultiCloud Image, make sure its referenced images are accessible to your users. For example, if sharing a custom Amazon Machine Image (AMI), you must either make it publicly available or share it with the appropriate Amazon accounts so the image will be accessible to a user when a server is launched.

### Version Control

Similarly to other RightScale components such as ServerTemplates and RightScripts, MultiCloud Images support version control. As a best practice, you should always use a committed MultiCloud Image revision for production-ready ServerTemplates. You can also perform a [Diff and Merge](/cm/rs101/version_control_(diff_and_merge).html) for MultiCloud Images, as with RightScripts and ServerTemplates.

## Further Reading

* [MultiCloud Images - Actions and Procedures](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html)

## Related FAQs

* [What's inside of a RightImage?](/faq/What_is_inside_of_a_RightImage.html)
* [Why is the Image (AMI) unavailable?](http://support.rightscale.com/06-FAQs/Why_is_the_Amazon_Machine_Image_(AMI)_unavailable%3F/index.html)
