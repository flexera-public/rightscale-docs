---
title: How do I shrink an EBS-backed HVM Windows AMI?
category: aws
description: This is a multi-step process involving some use of the AWS console, so we recommend having both the RightScale Dashboard and AWS console open in separate tabs in your browser.
---

## Answer

This is a multi-step process involving some use of the AWS console, so we recommend having both the RightScale Dashboard and AWS console open in separate tabs in your browser.

1. Launch an instance directly from the image you want to resize, not using a ServerTemplate. Be sure to associate an SSH key for which you have the private key material handy.

2. Once the instance is running, retrieve the administrator password from the AWS Console. Additionally, identify the snapshot ID of the volume used as the root device by clicking the device name (typically /dev/sda1) in the description of the instance in the AWS Console.

3. Create a volume from the image you wish to resize using the snapshot ID obtained in the previous step, and attach this to the instance.

4. Create and attach a blank EBS volume using the desired size of the shrunk image.

5. Open an RDP session to the instance.

6. Open the Server Manager, and under the Server Summary section, scroll to Security Information. Click the Configure IE ESC setting; disable for admin. Now, go to Storage, enable the attached disk containing the image (right-click and set to online), then format and mark as active the empty disk(this should be e:).

7. To proceed, you'll need to install imagex. You can get the full WAIK suite from Microsoft, or selectively download the required tools using this application: [http://theoven.org/index.php?topic=287](http://theoven.org/index.php?topic=287)

8. Open the command prompt and cd to waik_3, as installed in the previous step.

9. Invoke imagex as follows, where C: is the root device, D: is the volume containing the image to be shrunk, and E: is the empty volume.

    ~~~
    imagex.exe /capture d:\ c:\server-image.wim "Windows Server Image"

    imagex.exe /apply c:\server-image.wim 1 e:
    ~~~

10. Close your RDP session, and stop the instance from the AWS Console.

11. Detach all volumes; reattach the smaller volume as `/dev/sda1`; the other two volumes (the original root device and the volume containing the source of the image) should be destroyed.

12. (Optional) Start the instance to confirm the new image is operational; use the EC2 tools to run sysprep and stop the instance. Otherwise, skip to the next step.

13. In the AWS console, register the image using Create Image (EBS AMI).

14. Clone the source MCI in rightscale, and replace the AMI(s) with your newly registered AMI(s).



### See also

- [How do I shrink an EBS-backed HVM Windows AMI?](http://support.rightscale.com/09-Clouds/AWS/FAQs/How_do_I_shrink_an_EBS-backed_HVM_Windows_AMI%3F)
- [Site Map - Alphabetic Index](http://support.rightscale.com/Site_Map/Site_Map_-_Alphabetic_Index)
- [AWS Site Map](http://support.rightscale.com/09-Clouds/AWS/Z_AWS_Site_Map)
