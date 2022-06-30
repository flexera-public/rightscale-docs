---
title: What is the EC2 User Data field and how can I use it?
category: aws
description:  RightScale automatically passes the following basic information as a single string of user data when launching an Amazon Web Services (AWS) EC2 server instance from the Dashboard.
---

## Background Information

You need to understand how to use the EC2 User Data field in your server or array properties.

* * *

## Answer

RightScale automatically passes the following basic information as a single string of user data when launching an Amazon Web Services (AWS) EC2 server instance from the Dashboard:

~~~
RS_server=my.rightscale.com& RS_EIP=174.129.123.46& RS_api_url=https://my.rightscale.com/api/inst/ec2_instances/6ef2e6ef2e6ef2e6ef2e6ef2e& RS_sketchy=sketchy1-3.rightscale.com& RS_token=4ccd4ccd4ccd4ccd
~~~

In addition to the data that RightScale automatically passes to your EC2 server instance upon launch, you can choose to pass additional user data to your instance, using the EC2 User Data field in your server or array properties. Entering additional user data in this field is not common or typically recommended, since it is best to pass such data as input parameters via RightScripts or Chef recipes. However, this field is provided for special cases, such as when you are using an image that requires EC2 user data, or need to use EC2 user data for a specialized purpose.

**To pass additional user data to an EC2 server or array prior to launching it**

To pass additional user data to an _inactive_ EC2 server or array (you cannot pass EC2 user data to a running instance), click the **Edit** button on the server or array's **Info** tab. On the Server Details screen, expand the Advanced Options section and, in the "EC2 User Data" field, enter additional user data as needed. **Be sure to separate multiple parameter values using ampersands (&), using the HTTP GET request syntax**. (If you use commas instead of ampersands to separate values, your value list will be interpreted as one long text string.)

**Note**: When viewing saved user data in the Dashboard, RightScale replaces the the ampersands with commas to improve readability.

RightScale passes the specified user data to the server or array instance(s) upon launch. There is a 16 KB maximum limit on the total amount of user data (including the basic data that RightScale automatically supplies) that can be passed for a server instance. When you provide additional user data, it is prepended to the RightScale default data above. So if you provided user data in the Dashboard as:

~~~
MY_TEST=mycustomdatahere& MY_TEST2=more of my custom data here
~~~

When the instance is launched, the user data passed will look like the following:

~~~
MY_TEST=mycustomdatahere& MY_TEST2=more of my custom data here& RS_server=my.rightscale.com& RS_EIP=174.129.251.168& RS_api_url=https://my.rightscale.com/api/inst/ec2_instances/6ef2e6ef2e6ef2e6ef2e6ef2e& RS_sketchy=sketchy1-8.rightscale.com& RS_token=4ccd4ccd4ccd4ccd
~~~

RightScale will always be able to extract RightScale-specific values from the user data as long as you don't include RS_ in your data.

You can retrieve the user data on an instance as follows:

~~~
curl http://169.254.169.254/
~~~

This returns a list of metadata versions:

~~~
1.0
2007-01-19
2007-03-01
2007-08-29
2007-10-10
2007-12-15
2008-02-01
2008-09-01
2009-04-04
2011-01-01
2011-05-01
~~~

Then you can retrieve the data by fetching a specific version (latest is usually recommended)

~~~
curl http://169.254.169.254/2008-02-01/user-data
~~~

### External Links

[Instance Metadata](http://docs.amazonwebservices.com/AWSEC2/latest/DeveloperGuide/index.html?AESDG-chapter-instancedata.html)
