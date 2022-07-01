---
title: SQS Queues
layout: cm_layout
description: SQS Cloud Service is intended to represent a single queue and its corresponding properties, permissions, and messages.
---

## Overview

SQS Cloud Service is intended to represent a single queue and its corresponding properties, permissions, and messages. It is an Amazon web service that provides a distributed queue messaging service. It allows for the movement of data between distributed components of applications that perform different tasks without losing messages or requiring each component to be continuously available.

The RightScale Cloud Management dashboard makes creating and managing AWS SQS queues very simple. Follow this tutorial to configure a queue.

## Prerequisites

* An account with AWS and SQS services enabled with RightScale

## Steps

### Create a New Queue

* Navigate to **Clouds** > *AWS Region* > **SQS Queues**
* Select **Create Queue**
* Fill out the following details
  * **Create New Queue** - The name should contain no spaces and contain a maximum of 80 characters

![cm-sqs-queue-create-new-queue.png](/img/cm-sqs-queue-create-new-queue.png)

* Once the Queue is created, you will receive a "Queue Created Successfully!" message displays the Queue ID and URL. You will also be given the option to add another queue or close the display. Once the Queue has been added, navigate to it and open it.

### Review Queue Info

When you click on a queue, you will be taken to the SQS Queue Info tab. This page shows the available messages in the queue, messages that are being delivered, and the messages that are delayed. General displays the URL, Amazon Resource Name (ARN), as well as the date the queue was created and last modified. Settings allows you to edit how long the message will display before it timing out, how long the message will retain in the queue, how large the message size will be, and how long the message will delay before sending.

### Create Messages for a Queue

Next to the Info tab is the Messages tab. From this tab you can create and manage messages in the queue. To create a new message,

* Click **Create Message**
* Enter your Message and click **Create Message**
* Once the message is created, a message displays with the body of the message and the Message ID. To view further information about the message, click the message created in the queue and the message ID, size, MD5 of the Body, account ID of the sender, the date sent, the date received, and the received count displays.

![cm-sqs-queue-messages.png](/img/cm-sqs-queue-messages.png)

### Manage Permissions of a Queue

The Permissions tab of a queue allows you to manage which RightScale users can view the messages of a queue. You can specify which users can receive, delete, send, or view various other aspects of the queue.
