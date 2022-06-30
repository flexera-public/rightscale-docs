---
title: Image Fingerprints
layout: cm_layout
description: The RightScale management platform supports both public and private cloud infrastructures. In the MultiCloud Marketplace (MCM) you will find many ServerTemplates that support multiple clouds.
---

## Overview

The RightScale management platform supports both public and private cloud infrastructures. In the MultiCloud Marketplace (MCM) you will find many ServerTemplates that support multiple clouds. (i.e. The same ServerTemplate can be used to create and launch servers in multiple public and/or private clouds.)

![cm-mcm-multicloud-support.png](/img/cm-mcm-multicloud-support.png)

You can use a ServerTemplate across multiple clouds because of its MultiCloud Images (MCIs). A ServerTemplate can be used to launch a server in a cloud if one of its MCIs contains a valid reference to the appropriate image in that cloud. In the preceding example screenshot, the ServerTemplate contains MCIs that support each of those cloud infrastructures.

### Public Clouds

For public clouds like AWS EC2, it's easy to create a compatible ServerTemplate because the underlying machine images that the MCI references can be made publicly available during the development and testing process. As a result, when a ServerTemplate is published to the MCM, its MCIs contain resolvable references to the appropriate images in each the clouds/region. Since RightScale can publish RightImages directly to the public clouds and make them available for use, we're able to publish ServerTemplates with MultiCloud Images that reference RightImages (machine images) that we know are available.

![cm-public-cloud.png](/img/cm-public-cloud.png)

### Private Clouds

Since the exact location of each image is known in advance for public clouds, fingerprinting an image is not necessary. However, creating resolvable references to images in private clouds is less predictable because the exact location of an image may not be known in advance.

The cloud administrator for each private cloud is responsible for uploading the appropriate RightImages into their cloud and making them available for use within it.

**Note**: If you are the cloud administrator, you will need to contact your RightScale Account Manager to gain access to the appropriate RightImages. If you do not have a RightScale Account Manager, please contact the sales department at [sales@rightscale.com](mailto:sales@rightscale.com).

![cm-private-cloud.png](/img/cm-private-cloud.png)

Because you can only use a ServerTemplate to create a server for a cloud that it supports, it's important that a ServerTemplate's MCIs contain resolvable references to each of the underlying machine images. If a match cannot be found, you will not be able to create a server with the selected MCI. All of the ServerTemplates published by RightScale have been thoroughly tested with each of its MCI's referenced images. For private clouds, it's important that the machine images that are referenced by those MCIs are made available in those clouds, otherwise you will not be able to use the ServerTemplate with its intended image.

## What are Fingerprints and How are they Used?

Fingerprints are used to locate matching machine images in the appropriate private cloud infrastructures. If a ServerTemplate supports a private cloud, it contains at least one MCI that references an image in that private cloud infrastructure.

A good example of a ServerTemplate that supports private clouds is one of the "Base" ServerTemplates published by RightScale. You can find them in the MultiCloud Marketplace. ( **Design** > **MultiCloud Marketplace** > **ServerTemplates** )

Go to the ServerTemplate's Images tab to see its list of MCIs. Click on one of the MCIs that support private clouds to check its referenced images.

Go to the MCI's Clouds tab to see the fingerprints that are used to find the appropriate images in the various private clouds. Click on the magnifying glass icon to view the image references. 

![cm-fingerprints.png](/img/cm-fingerprints.png)

If a fingerprint match exists for a private cloud, a link to the actual image in that particular cloud will be displayed. However, if no fingerprint match is found, it means that RightScale cannot locate the appropriate image in the private cloud. Typically, the image is not available because it was never uploaded to the private cloud.

![cm-image-map.png](/img/cm-image-map.png)

To resolve this problem, contact the private cloud's administrator and request that the appropriate image (with the matching fingerprint) be uploaded to the private cloud and made available for use. Until a fingerprint match exists for an image, you will not be able to use the ServerTemplate to create a server in that particular private cloud with its intended image.

If the image was recently uploaded, click the **Rematch** button to requery the private cloud to see if a fingerprint match can be found.
