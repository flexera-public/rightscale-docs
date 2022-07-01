---
title: Why is my image "Invalid" or "Unavailable"
category: general
description: If you see either of the error messages where your instance is unavailable, your account does not have a reference to valid image that can be used to successfully launch a server instance.
---

## Background Information

When viewing the Clouds tab of a MultiCloud Image to determine the underlying machine images that will be used to launch instances into each supported cloud, you may see an error message next to your image:

* "image invalid is unavailable"
* "image ami-853abc01 is unavailable"

You're not sure why you're seeing this message or the implications of trying to launch a server with an image that has this error message.

![faq-ImageInvalidUnavailable.png](/img/faq-ImageInvalidUnavailable.png).

* * *

## Answer

If you see either of the error messages where your instance is unavailable, your account does not have a reference to valid image that can be used to successfully launch a server instance. Basically, your account no longer has access to use the referenced image. You will not be able to successfully launch an instance with an "unavailable" image.

For example, perhaps the account that published the image changed its sharing preferences such that your account no longer has access to use it (e.g., making an image private again). If the image still exists and is properly registered with the cloud provider, we will list its ID in the error message (e.g., "image ami-853abc01is unavailable"). However, if RightScale cannot find the image because it's been deregistered or its underlying source files have been deleted by the image's publisher, then the "image invalid is unavailable" error message will display.

To resolve this problem, you will need to select an "available" image that your account has access to use. You may need to clone an MCI so you can make the necessary edits and so that a valid image is specified for each cloud/region.

## See also

- [MultiCloud Images](http://support.rightscale.com/15-References/Machine_Tags/MultiCloud_Images)
- [What does this message mean: "This image may not be RightScale-enabled"?](http://support.rightscale.com/06-FAQs/FAQ_0156_-_What_does_this_message_mean%3A_%22This_image_may_not_be_RightScale-enabled%22%3F/index.html)
