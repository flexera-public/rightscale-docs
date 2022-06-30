---
title: QUICK Start for using Examples
layout: general.slim
---

## Overview

Some who wish to explore and learn more about the RightScale API by taking advantage of the API Examples section of the guide may not have immediate access to a Linux server. Because the bulk of the examples use curl to issue HTTP requests from a basic Linux box, the outline below can help you get started in the cloud using the RightScale API.

API examples are designed to be used in parallel with the [API 1.5 online reference](http://reference.rightscale.com/api1.5/index.html) information. We _**strongly recommend**_ you use the online reference information at all phases of your learning curve.

## API Quick Start Outline

- Log into the RightScale Dashboard([https://my.rightscale.com](https://my.rightscale.com))
  - If you don't have an account, [sign up for FREE!](https://www.rightscale.com/s/create-account.php?sd=Free&t=supportal2)
- [Create a deployment](/api/api_1.5_examples/deployments.html)
- [Add a server](/api/api_1.5_examples/servers.html) to your deployment (a basic Linux server is all that is needed)
- [Launch the server](/api/api_1.5_examples/servers.html)
- [SSH into your server](/cm/dashboard/manage/instances_and_servers/instances_and_servers_actions.html#ssh-into-a-server)
- Read over the [TIPS to using the API Examples](/api/api_1.5_examples/tips_for_using_api_examples.html)
- Use the [Examples](/api/api_1.5_examples/)
  - [Authenticate](/api/api_1.5_examples/authentication.html)(do this one first!)
  - Run/use whatever examples are of interest to you...
  - _Tip_: Listing cloud assets is easier when getting started than creating or modifying them. You can create assets in the Dashboard then list them via the API to help verify operations are behaving as expected.
- [Terminate your server.](/api/api_1.5_examples/servers.html) If you are charged for server/resources used (such is the case with public clouds), when done terminate your server to avoid extra charges. (_Warning_: If you create shell scripts to test the API on your server, when you terminate the server the scripts will be lost. That is not a permanent storage solution, but only exists for the life of the server. Because the sample scripts are so short, if you do need to terminate your server you can simply copy/paste them into files stored on your local hard drive for future use.)
