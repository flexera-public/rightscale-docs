---
title: Publications
layout: general.slim
---

## Import Publications

Imports the given publication and its metadate to this account. When imported, the API call will return a <Location> header with the relative URI of the imported ServerTemplate. Only non-HEAD revisions that are shared with the account can be imported.

 <dl> </dl>

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

**Prerequisite:** Example requires a publication ID for the asset that you wish to import. This publication ID can be found by using the API [List Publications](/api/api_1.5_examples/publications.html) tutorial **.** The return data from the 'List Publications' API call will contain a 'links' section, which should contain a 'self' URI with the ID in it. For example, in the return data below, **177563** is the publication ID:

~~~
    <links>
          <link rel="self" href="/api/publications/177563"/>
          <link rel="lineage" href="/api/publication_lineages/14092"/>
        </links>
~~~

_**Important!**_ Do _NOT_ attempt to import publication using the lineage ID as this will not work! Only importing by the publication ID is currently supported.

#### Example Call

~~~
    #!/bin/sh -e
    # Replace "PUBLICATION" variable below with publication ID (use "list publications" API call if needed to gather ID)
    PUBLICATION="45"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/publications/$PUBLICATIONS/import.xml
~~~

#### Sample Output

**Note** :

- Truncated XML output with limited headers included.
- There is only one example listed in the output to save space.
- <Location> header returned shows relative URI to the imported ServerTemplate

~~~
     < HTTP/1.1 201 Created
    HTTP/1.1 201 Created
    * Server nginx/1.0.14 is not blacklisted
    < Server: nginx/1.0.14
    Server: nginx/1.0.14
    < Date: Tue, 29 Oct 2013 21:05:52 GMT
    Date: Tue, 29 Oct 2013 21:05:52 GMT
    < Content-Type: text/html; charset=utf-8
    Content-Type: text/html; charset=utf-8
    < Transfer-Encoding: chunked
    Transfer-Encoding: chunked
    < Connection: keep-alive
    Connection: keep-alive
    < Status: 201 Created
    Status: 201 Created
    < X-Runtime: 28076
    X-Runtime: 28076
    < Set-Cookie:
    Set-Cookie:
    < Cache-Control: no-cache
    Cache-Control: no-cache
    < Location: /api/server_templates/324064001
    Location: /api/server_templates/324064001
    < X-Request-Uuid: af69d2a3d7a64146b31b6a2a8ba66326
    X-Request-Uuid: af69d2a3d7a64146b31b6a2a8ba66326
~~~

## List Publications

List all Publications of an account. Note that only non-HEAD revisions are listed.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/publications.xml
~~~

#### Sample Output

**Note** :

- Truncated XML output without headers included.
- There is only one example listed in the output to save space.

~~~
    <publication>
        <links>
          <link rel="self" href="/api/publications/43984"/>
          <link rel="lineage" href="/api/publication_lineages/14092"/>
        </links>
        <publisher>RightScale</publisher>
        <created_at>2012/11/15 20:05:43 +0000</created_at>
        <commit_message>
          <text>Updated description to include Rackspace NextGen.</text>
          <time>2012/11/15 19:52:36 +0000</time>
          <user>lopaka@rightscale.com</user>
        </commit_message>
        <actions>
          <action rel="import"/>
        </actions>
        <content_type>ServerTemplate</content_type>
        <description>This ServerTemplate is on the Infinity Lineage. For the latest LTS version, see the [12-LTS Release](http://www.rightscale.com/library/server_templates/LAMP-All-In-One-Trial-with-MyS/lineage/15403)  
    For a description of the Infinity and LTS lineages, see [ServerTemplate Release Methodology](/cm/rs101/servertemplate_release_and_lineage_methodology.html)

    Launches a complete LAMP (Linux, Apache, MySQL, PHP) stack on a single server in any of the supported cloud infrastructures. It includes default values for all required inputs so you can launch a server in less than 15 minutes. This ServerTemplate is designed for demonstration purposes only and is not recommended for production use.  

    If you want to launch a LAMP stack with your own application code and database, please see: [LAMP All-In-One with MySQL 5.5](http://www.rightscale.com/library/server_templates/LAMP-All-In-One-with-MySQL-5-5/lineage/14093)

    __Related ServerTemplates:__  
    [PHP App Server](http://www.rightscale.com/library/server_templates/PHP-App-Server/lineage/2288)  
    [Database Manager for MySQL 5.5](http://www.rightscale.com/library/server_templates/Database-Manager-for-MySQL-5-5/lineage/13699)
    __Release Notes:__  
    [LAMP All-In-One with MySQL 5.5 Release Notes](http://support.rightscale.com/18-Release_Notes/ServerTemplates_and_RightImages/v13.1#LAMP_All-In-One_with_MySQL_5.5_\(v13.1\))

    __Application versions:__
    * Apache 2.2.3
    * MySQL 5.5.20
    * PHP 5.3.6

    __Supported compute clouds:__
    * Amazon Web Services EC2
    * Citrix CloudStack (2.2 and Acton)
    * Google Compute Engine
    * OpenStack
    * RackSpace
    * SoftLayer
    * Windows Azure

    __Supported backup clouds:__
    * Amazon Web Services S3
    * Azure Storage
    * Google Cloud Storage
    * RackSpace CloudFiles
    * SoftLayer Object Storage

    __Supported MultiCloud Images:__
    * CentOS 6 - Amazon, Google, CloudStack, OpenStack, RackSpace, Rackspace NextGen, SoftLayer, Windows Azure
    * Ubuntu 12.04 - Amazon, Google, CloudStack, OpenStack, RackSpace, Rackspace NextGen, SoftLayer, Windows Azure
    * RHEL 6 - Amazon
    </description>
        <name>LAMP All-In-One with MySQL 5.5 (v13.1.1)</name>
        <updated_at>2012/11/15 20:05:01 +0000</updated_at>
        <revision>77</revision>
        <revision_notes>Added support for RackSpace and AWS Sydney.</revision_notes>
      </publication>
~~~

## Show Publications

Show information about a single Publication. Note that only non-HEAD revisions are shown.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    PUBLICATION="45"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/publications/$PUBLICATIONS.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <publication>
      <links>
        <link rel="self" href="/api/publications/45"/>
        <link rel="lineage" href="/api/publication_lineages/2335"/>
      </links>
      <publisher>RightScale</publisher>
      <created_at>2009/10/28 04:13:24 +0000</created_at>
      <commit_message>
        <text>Initial version</text>
        <time>2008/10/02 04:05:47 +0000</time>
        <user></user>
      </commit_message>
      <actions>
        <action rel="import"/>
      </actions>
      <content_type>ServerTemplate</content_type>
      <description>Combined Load Balancer and Rails application in one box.&#13;
    The site is configured for HTTP traffic only (not SSL) and with mongrel_cluster.</description>
      <name>Rails FrontEnd v1</name>
      <updated_at>2010/04/15 04:39:28 +0000</updated_at>
      <revision>1</revision>
      <revision_notes>Initial version</revision_notes>
    </publication>
~~~
