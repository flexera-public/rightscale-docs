---
title: Why do I get a 403 error when using s3cmd?
category: aws
description: s3cmd requires your AWS access key and secret access key in order to authenticate to S3. This article describes how to do this from the command line.
---

## Background Information

When using s3cmd on a server instance you get a "403 Forbidden" error

* * *

## Answer

s3cmd requires your AWS access key and secret access key in order to authenticate to S3.&nbsp; You can do this from the command line:

~~~
export AWS_ACCESS_KEY_ID=key  
export AWS_SECRET_ACCESS_KEY=key
~~~

You can obtain your key information from your AWS account at aws.amazon.com.

#### See also

- [How can I export AWS environment variables to the shell?](/faq/clouds/aws/How_can_I_export_AWS_environment_variables_to_the_shell.html)
