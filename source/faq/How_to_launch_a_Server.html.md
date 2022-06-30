---
title: How to launch a Server?
category: general
description: This is a basic guide to know the flow on how to launch a Server in RightScale's Cloud Management.
---

## Background Information

The following are the steps to launch a Server quickly in RightScale's Cloud Management Platform.

## Answer

1. First, you create a Deployment
	* [Create a Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#create-a-new-deployment​)
<br>
2. Second, you add a Server in the Deployment. During the process, you will be asked to select a ServerTemplate. You may choose from the list as desired.
	* [Add a Server](/cm/dashboard/manage/deployments/deployments_actions.html#add-a-server-to-a-deployment​)
	* If you can't find the ServerTemplate that you need, you can search it via the Marketpace. Start with the Basic Linux Template below.
		* [Linux Base Template](http://www.rightscale.com/library/server_templates/RightLink-10-4-0-Linux-Base/lineage/53250)
	*  If you want to create your own Multi-Cloud Image to be used on your ServerTemplate, you may follow the guide below.
		* [Create a Multi-Cloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image)
<br>
3. After you've created the Server, then you are ready to launch it. During the launch, you might be asked to enter some input values so that your Server will have the basic config after it is up and running. So you enter the input values accordingly.
	* [Launch a Server](/cm/dashboard/manage/deployments/deployments_actions.html#launch-a-server​)
<br>
4. Once the Server is up and running, you may try to access it and setup or configure the rest of your Services.

Lastly, please go through the docs below to get familiarized with the key features of RigthScale's Cloud Management Platform.

[Dashboard User's Guide](/cm/dashboard/index.html)
