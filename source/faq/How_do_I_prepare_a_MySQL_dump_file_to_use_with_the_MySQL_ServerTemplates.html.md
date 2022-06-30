---
title: How do I prepare a MySQL dump file to use with the MySQL ServerTemplates?
category: general
description: The steps below explain how to create a MySQL dump file, which can then be used to initialize databases using RightScale's MySQL ServerTemplates.
---

## Background Information

The easiest way to run a MySQL database on a cloud instance is to use RightScale's MySQL ServerTemplates. The MySQL Database Setups tutorials assume that you already have a MySQL dump file that you can use to set up your database in the cloud. If you do not have a MySQL dump file, use the following instructions to create one.

## Answer

The steps below explain how to create a MySQL dump file, which can then be used to initialize databases using RightScale's MySQL ServerTemplates.

You may create and compress your MySQL dump files by following these steps:

1. From the command line on the machine where MySQL is installed (locally or in an SSH session), run:

    ~~~
    mysqldump -uusername -ppassword \<database name> --opt > myDBDump
    ~~~

2. Then, you can check the output file with a text editor to verify the integrity of the data.

3. Next, in order to streamline the data-transfer process, use _gzip_ to compress the dump file:

    ~~~
    gzip -c myDBDump
    ~~~

4. Then, you will need to upload the `myDBDump.gz` file to an S3 bucket. When you create your MySQL database on the database server, you will run a script ("DB Create MySQL EBS Stripe volume") that will create and attach volumes that will be used to store your MySQL data.

Alternatively, you may combine the above steps into a single command; however, do not forget to upload the generated dump file to an S3 bucket when you are finished creating it.

~~~
mysqldump -uusername -ppassword databasename | gzip -c > myDBDump.gz
~~~
