---
title: Clouds
layout: general.slim
---

## List Clouds

List all Clouds known by the current account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/clouds.xml
~~~

#### Sample Output

- **Note** : The sample output below does not include XML headers, and is truncated for readability sake.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <clouds>
    <cloud>
        <links>
          <link href="/api/clouds/2175" rel="self"/>
          <link href="/api/clouds/2175/datacenters" rel="datacenters"/>
          <link href="/api/clouds/2175/instance_types" rel="instance_types"/>
          <link href="/api/clouds/2175/security_groups" rel="security_groups"/>
          <link href="/api/clouds/2175/instances" rel="instances"/>
          <link href="/api/clouds/2175/images" rel="images"/>
          <link href="/api/clouds/2175/volume_attachments" rel="volume_attachments"/>
          <link href="/api/clouds/2175/recurring_volume_attachments" rel="recurring_volume_attachments"/>
          <link href="/api/clouds/2175/volumes" rel="volumes"/>
        </links>
        <cloud_type>google</cloud_type>
        <description>Google Cloud, including Google Compute Engine, Google Cloud Storage, etc.</description>
        <name>Google</name>
      </cloud>
    <cloud>
        <links>
          <link href="/api/clouds/2178" rel="self"/>
          <link href="/api/clouds/2178/instance_types" rel="instance_types"/>
          <link href="/api/clouds/2178/instances" rel="instances"/>
          <link href="/api/clouds/2178/images" rel="images"/>
          <link href="/api/clouds/2178/volume_attachments" rel="volume_attachments"/>
          <link href="/api/clouds/2178/recurring_volume_attachments" rel="recurring_volume_attachments"/>
          <link href="/api/clouds/2178/volume_snapshots" rel="volume_snapshots"/>
          <link href="/api/clouds/2178/volumes" rel="volumes"/>
        </links>
        <cloud_type>azure</cloud_type>
        <description>Azure West US</description>
        <name>Azure West US</name>
      </cloud>
    . . .
    </clouds>
~~~

**Additional Notes:**

- Several clouds/cloud ID's are included. Google Compute Engine (2175), and Windows Azure classic (2178)
- **Tip** : To determine the Cloud ID from within the Dash:
  - Click on **Clouds** > _CloudName_
  - Click on or hover over any of the cloud's supported resources. Note the number after the ".../clouds/< CloudID >/..." for the goto URL (typically displayed in the lower left of a browser if you hover over the resource).
  - _Important!_ Although you can obtain the Cloud ID from the Dashboard, you cannot obtain any of the cloud resources from the UI. You must query for them using the API.

### right_api_client

#### Example Call

~~~
    require 'rubygems'
    require 'pp' # Require pretty print Ruby gem
    require 'right_api_client' # RightScale API client gem

    user = 'greg.doe@example.com' # Set user email address for using the Dashboard
    acct = '1234' # Set the account ID
    pass = 'SomePassword' # Set the password for the user. Create client object so you can use the API.
    @client = RightApi::Client.new(:email => user, :password => pass, :account_id => acct)
    #
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    pp @client.clouds.index
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="cloud", name="SoftLayer">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Google">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure West US">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure East US">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure East Asia">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure Southeast Asia">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure West Europe">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Azure North Europe">,
     #<RightApi::ResourceDetail resource_type="cloud", name="Openstack Juno">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $listCloudsRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds.xml")
    $listCloudsRequest.Method = "GET"
    $listCloudsRequest.CookieContainer = $cookieContainer
    $listCloudsRequest.Headers.Add("X_API_VERSION", "1.5");
    [System.Net.WebResponse] $listCloudsResponse = $listCloudsRequest.GetResponse()
    $listCloudsResponseStream = $listCloudsResponse.GetResponseStream()
    $listCloudsResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listCloudsResponseStream
    [string]$listCloudsResponseString = $listCloudsResponseStreamReader.ReadToEnd()
    write-host $listCloudsResponseString
~~~

