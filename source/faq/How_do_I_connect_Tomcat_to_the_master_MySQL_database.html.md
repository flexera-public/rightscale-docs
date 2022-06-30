---
title: How do I connect Tomcat to the master MySQL database?
category: general
description: Use RightScale RightScripts to connect your Apache Tomcat application to the Master MySQ database.
---

## Background Information

You need to know how to connect your Apache Tomcat application to the Master MySQ database.

* * *

## Answer

The RightScripts handle this automatically but to resolve the JNDI link 'java:comp/env/jdbc/MYSQLDB', you must do the following:

* Allow RightScale's server.xml to host primary jdbc connection
* Add "ResourceLink" element to META-INF/context.xml.&nbsp; See the following example:

    ~~~
    <?xml version=*"1.0"* encoding=*"UTF-8"*?>
    <Context>
        <ResourceLink name=*"jdbc/MYSQLDB"* global=*"jdbc/MYSQLDB"* type=*"javax.sql.Datasource"* />
    </Context>
    ~~~

* In web.xml, add the following resource ref:
  * DB Connection
  * jdbc/MYSQLDB
  * javax.sql.DataSource
  * Container
