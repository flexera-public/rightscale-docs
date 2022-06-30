---
title: How do I install s3cmd?
category: aws
description: This article describes the process for installing the AWS s3cmd tool.
---

## Background

You are using a RightImage that does not have s3cmd bundled and you would like to install it.

There are two s3cmd projects, one developed in Ruby and the other in Python:

* [s3cmd.rb](http://s3.amazonaws.com/ServEdge_pub/s3sync/README_s3cmd.txt) at [S3Sync.net](http://s3sync.net/wiki.html) (Ruby)
* [S3cmd](https://github.com/s3tools/s3cmd) with [S3tools project](https://github.com/s3tools/s3cmd) (Python)

* * *

## Answer

Install the desired s3cmd.

First, run the commands, `s3cmd` and `s3cmd.rb `within the SSH Console of the Server in question to check if an s3cmd currently exists in path.  

If the command does not exist (or you want to upgrade s3cmd), [Create a New RightScript](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Design/RightScripts/Actions/Create_a_New_RightScript) from the attachment (see below).  

The script installs [S3cmd](https://github.com/s3tools/s3cmd) (python). Alternatively a script can be written to install [s3ync](http://s3.amazonaws.com/ServEdge_pub/s3sync/s3sync.tar.gz) (ruby) which includes [s3cmd.rb](http://s3.amazonaws.com/ServEdge_pub/s3sync/README_s3cmd.txt).

**Note**: You will most likely be required to configure s3cmd (see the s3cmd README), as well as set your AWS credentials in the environment (see [Credentials](/cm/dashboard/design/credentials/))
