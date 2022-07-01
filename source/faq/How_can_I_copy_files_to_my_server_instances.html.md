---
title: How can I copy files to my server instances?
category: general
description: There are three general methods to copy some files to your RightScale server instances.
---

## Background Information

What is the best way to copy some files to your server instances?

* * *

## Answer

There are three general methods:

1. Use any SFTP or SCP client, e.g. on Microsoft Windows, [WinSCP](http://winscp.net/) has many more advanced features but does require a setup using Puttygen to create a .ppk (private key file). You can also use scp on the command line client on any computer that has it (e.g. Linux/Unix/Mac)
2. Attach your files to a boot or operational script, which loads the files to S3.&nbsp; They can be installed very easily with a simple script such as:

    ~~~
    #!/bin/sh -e
    cp "$RS_ATTACH_DIR/filename" /path/where/you/want/filename
    ~~~

3. Upload the files to S3 into a bucket and then you can download them using s3cmd, wget, or the [RightAWS RubyGem](http://rubygems.org/gems/right_aws).

## Also See

[How to Transfer Files from EC2 to Desktop Using WinSCP](http://support.rightscale.com/06-FAQs/How_to_Transfer_Files_from_EC2_to_Desktop_Using_WinSCP)
