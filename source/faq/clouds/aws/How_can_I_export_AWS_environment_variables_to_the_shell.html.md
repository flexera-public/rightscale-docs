---
title: How can I export AWS environment variables to the shell?
category: aws
description: The following RightScript will do this for you by creating a script in /root that will export all of the AWS environment variables as well as a key.pem and a cert.pem file.
---

## Background Information

In some instances you may want to export all of the AWS environment variables, credentials, and key files to a running instance so you don't have to set them up manually.

* * *

## Answer

The following RightScript will do this for you by creating a script in /root that will export all of the AWS environment variables as well as a key.pem and a cert.pem file. To set the environment variables simply run this RightScript (or install it as a boot script). When you ssh into the instance you will find setenv, key.pem, and cert.pem in /root. You can then use this from the command line to set the environment variables in your shell by typing:

`source /root/setenv`

You can cut and paste the script below into a new RightScript and then install it on the template as an operational or boot script.

~~~
#!/bin/bash

echo 'export AWS_ACCESS_KEY_ID='$AWS_ACCESS_KEY_ID > /root/setenv

echo 'export AWS_SECRET_ACCESS_KEY='$AWS_SECRET_ACCESS_KEY >> /root/setenv

echo 'export AWS_ACCOUNT_NUMBER='$AWS_ACCOUNT_NUMBER >> /root/setenv

echo 'export EC2_AMI_ID='$EC2_AMI_ID >> /root/setenv

echo 'export EC2_AKI_ID='$EC2_AKI_ID >> /root/setenv

echo 'export EC2_ARI_ID='$EC2_ARI_ID >> /root/setenv

echo 'export EC2_AMI_MANIFEST_PATH='$EC2_AMI_MANIFEST_PATH >> /root/setenv

echo 'export EC2_PLACEMENT_AVAILABILITY_ZONE='$EC2_PLACEMENT_AVAILABILITY_ZONE >> /root/setenv

echo 'export EC2_HOSTNAME='$EC2_HOSTNAME >> /root/setenv

echo 'export EC2_INSTANCE_ID='$EC2_INSTANCE_ID >> /root/setenv

echo 'export EC2_INSTANCE_TYPE='$EC2_INSTANCE_TYPE >> /root/setenv

echo 'export EC2_LOCAL_HOSTNAME='$EC2_LOCAL_HOSTNAME >> /root/setenv

echo 'export EC2_PUBLIC_HOSTNAME='$EC2_PUBLIC_HOSTNAME >> /root/setenv

echo 'export EC2_PUBLIC_IPV4='$EC2_PUBLIC_IPV4 >> /root/setenv

echo 'export EC2_RESERVATION_ID='$EC2_RESERVATION_ID >> /root/setenv

echo 'export EC2_SECURITY_GROUPS='$EC2_SECURITY_GROUPS >> /root/setenv

echo 'export RS_SERVER='$RS_SERVER >> /root/setenv

echo 'export RS_SKETCHY='$RS_SKETCHY >> /root/setenv

echo 'export RS_TOKEN='$RS_TOKEN >> /root/setenv

chmod 700 /root/setenv

echo "$AWS_X509_CERT" > /root/cert.pem

echo "$AWS_X509_KEY" > /root/key.pem
~~~
