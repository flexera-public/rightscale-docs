---
title: Why do I get a Google Cloud Account Auth Error - Parameter account[creds][public_image_accounts] is mandatory?
category: general
description: GCE cloud account error during auth with Parameter account[creds][public_image_accounts] is mandatory.
---

## Background Information
I'm trying to fix the Google Cloud account on my RightScale account, but whenever I re-authenticate I get this error `ParameterError: Parameter 'account[creds][public_image_accounts] is mandatory`. What could be the issue?

## Answer

Please check if there's any issue with your GCE billing as this is usually the main cause. 

Sometimes the error can also be due to the following: 

!!info*Note:*In the connect [GCP to RightScale guide](/clouds/google/getting_started/google_connect_gce_to_rightscale.html#adding-images-from-other-projects), there is a note that the GCP cloud account should have read permission to the shared project image before it can use it.

The link to GCP document also has detailed steps on how to enable read permission on the shared project images.
