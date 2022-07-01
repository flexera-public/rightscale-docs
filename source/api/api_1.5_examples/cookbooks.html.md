---
title: Cookbooks
layout: general.slim
---

## Follow Cookbook

Follow a cookbook that has been imported into an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

When a cookbook is being followed, the new or updated versions of that cookbook that are fetched into the repositories section will automatically get imported into your account. You can only follow cookbooks that are in the alternate namespace. For more information about alternate namespaces, see [Primary and Alternate Namespaces](/cm/dashboard/design/repositories/#primary-and-alternate-namespaces).

To get a cookbook ID, you need to perform a List Cookbooks.

**Note** : Repositories are automatically re-scraped roughly once a day.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d value=true \
    https://my.rightscale.com/api/cookbooks/7460001/follow.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.14
    Date: Fri, 06 Sep 2013 16:48:48 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 1958
    X-Request-Uuid: 96817b26fb5649ca9e153ec2f7d86f80
    Set-Cookie: rs_gbl=eNotkEuPgjAYAP8BzzaxPD5akj2ID1RWWRVFvRhpKayuPLRdReN_X032PjOHeaA9ctGpQS0kLsh9IH1Jz8i1AQzybCHFkUtMh1oUiEFb6Fu86IQIWzJCMXHaCSYkNTEDR2CaCBOAWdSxxaun0n-XmebbfeWRx5cLYVTlQYtQZQOIjVqet3yqVUm7M74IKyYjvcmhd1zhaJmFO7-3scSq0BNoGIHfisttvF4f8O2nHXx61QiLgfKzYixTmTSizL-m88nMO2XNLB2em75_hW1XRUF3dOknsazvd1scp1BrMhzvRDFPwmt9yHpF3sQdfIRJREZ-gPPA63y8l9zeS_acl7pQyHWYbT2ff0DYXdc%3D; domain=.rightscale.com; path=/; HttpOnly
    Cache-Control: no-cache
~~~

## List Cookbooks

List all cookbooks in an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

The following example will list all cookbooks that have been imported into an account from the repositories section. Cookbooks will appear in your account when you import ServerTemplates into your account from the MultiCloud MarketPlace or if you import them into your account from the repositories section. To import your own cookbooks into RightScale, you need create a repository and import cookbooks from the repository. For more information, see [Create Repository](/api/api_1.5_examples/repositories.html).

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/cookbooks.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <cookbooks>
      <cookbook>
        <links>
          <link rel="self" href="/api/cookbooks/580488001"/>
        </links>
        <updated_at>2013/09/04 17:32:00 +0000</updated_at>
        <version>2.2.1</version>
        <created_at>2013/09/03 17:11:45 +0000</created_at>
        <source_info_summary>RightScale</source_info_summary>
        <state>normal</state>
        <name>yum</name>
        <namespace>alternate</namespace>
        <id>580488001</id>
        <actions>
          <action rel="freeze"/>
          <action rel="follow"/>
          <action rel="obsolete"/>
        </actions>
      </cookbook>
      <cookbook>
        <links>
          <link rel="self" href="/api/cookbooks/580486001"/>
        </links>
        <updated_at>2013/09/04 17:31:59 +0000</updated_at>
        <version>1.9.3</version>
        <created_at>2013/09/03 17:11:44 +0000</created_at>
        <source_info_summary>RightScale</source_info_summary>
        <state>normal</state>
        <name>apt</name>
        <namespace>alternate</namespace>
        <id>580486001</id>
        <actions>
          <action rel="freeze"/>
          <action rel="follow"/>
          <action rel="obsolete"/>
        </actions>
      </cookbook>
    . . .
~~~

## Show Cookbook

Show the information of a single cookbook that has been imported into an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

The following example will show a cookbook in your account. To get a cookbook ID, [List Cookbooks](/api/api_1.5_examples/cookbooks.html) and locate the cookbook you would like to display.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/cookbooks/7370041.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <cookbook>
      <links>
        <link rel="self" href="/api/cookbooks/7350001"/>
        <link rel="repository" href="/api/repositories/1211"/>
      </links>
      <updated_at>2010/11/11 21:20:55 +0000</updated_at>
      <version>0.3.14</version>
      <created_at>2010/11/11 21:20:55 +0000</created_at>
      <source_info_summary>GitHub - rightscale/cookbooks_public_windows - 4a2b6f7e9b</source_info_summary>
      <state>normal</state>
      <name>blog_engine</name>
      <namespace>alternate</namespace>
      <id>7350001</id>
      <actions>
        <action rel="freeze"/>
        <action rel="follow"/>
        <action rel="obsolete"/>
      </actions>
    </cookbook>
~~~
