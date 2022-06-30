---
title: Configuring cross-project images in Google Compute Engine (GCE)
layout: google_layout_page
description: Configuring cross-project images in Google Compute Engine (GCE)
---

## Adding images from other projects

!!info*Note* The service account registered with this account must have read image permissions from the google project sharing the image, reference: [https://cloud.google.com/compute/docs/images/sharing-images-across-projects](https://cloud.google.com/compute/docs/images/sharing-images-across-projects)

1. Go to **Settings** > **Account Settings** > **Clouds.**

2. Click pencil icon next to google cloud
  ![gce-add-shared-project-images-1.png](/img/gce-add-shared-project-images-1.png)

3. Enter the name of a Google Project ID like `my-example-project` and press `enter`. You can add multiple projects.
  ![google-cloud-shared-project-images.png](/img/google-cloud-shared-project-images.png)

4. Once you press `enter`, your project will appear as below.
  ![google-cloud-shared-project-images-added.png](/img/google-cloud-shared-project-images-added.png)

5. If you click on the Google Cloud name hyperlink, you can now see the shared projects listed.
  ![google-cloud-shared-project-images-list.png](/img/google-cloud-shared-project-images-list.png)
  
6. Once a project is added, RightScale will poll images from that project and make them available in the Images list for Google. Once you see an image in the list, you can use it to launch within RightScale.

