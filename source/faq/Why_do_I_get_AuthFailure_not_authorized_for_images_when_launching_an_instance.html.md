---
title: Why do I get AuthFailure not authorized for images when launching an instance?
category: general
description: When launching a server or an instance, the server won't launch and always resulted in an error.
---

## Background Information

When launching a server or an instance, the server won't launch and always resulted in an error. You get a red banner showing the following error

~~~
400: AuthFailure: Not authorized for images:.....
~~~

![not_authorized_for_images.png](/img/not_authorized_for_images.png)

* * *

## Answer

Basically this is an error coming from the cloud stating that you can't use the image because it is no longer publicly available. Cloud providers are known to deprecate images overtime and this is usually expected. If you click the link beside the `Image`, you will see that the image state is `deregistered`. 

![image_deregistered.png](/img/image_deregistered.png)

In this case, the solution is to [update the MCI](../cm/dashboard/design/multicloud_images/multicloud_images_actions.html) and use a different image.
