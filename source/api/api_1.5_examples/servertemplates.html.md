---
title: ServerTemplates
layout: general.slim
---

## Clone a ServerTemplate

Clone a specific ServerTemplate, provide a name for the new ServerTemplate.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    ST="252299001" # STID to clone. Obtain via the Dashboard or using the API to List STs.
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d server_template[name]="HAProxy Clone" \ # Specify the new name of the cloned ServerTemplate
    -d server_template[description]="ST Clone via API" \ # Specify new description
    -X POST https://my.rightscale.com/api/server_templates/$ST/clone
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Tue, 06 Nov 2012 18:36:46 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/server_templates/270391001
    X-Runtime: 6107
    X-Request-Uuid: 57692eb0a7594ccc900d03021874f50b
    Set-Cookie:
    Cache-Control: no-cache
~~~

To view the cloned ServerTemplate in the Dashboard:

- Navigate to Design > ServerTemplates
- Enter the nickname you specified and apply the filter

## List ServerTemplates

List ServerTemplates available to the account.

**Note** : A revision of zero means its a Head revision.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

**Note** : Depending on the account, this can be a fairly expensive (resource intensive) call. Note the _Supplmental_ section which results in a lighter response.

~~~
    #!/bin/sh
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/server_templates.xml
~~~

#### Sample Output

**Note:**

- HTTP headers not displayed (to save space).
- Output is also truncated to save space.

~~~
    <server_template>
        <actions>
          <action rel="commit"/>
          <action rel="clone"/>
        </actions>
        <links>
          <link rel="self" href="/api/server_templates/13"/>
          <link rel="multi_cloud_images" href="/api/server_templates/13/multi_cloud_images"/>
          <link rel="default_multi_cloud_image" href="/api/multi_cloud_images/7239"/>
          <link rel="inputs" href="/api/server_templates/13/inputs"/>
          <link rel="alert_specs" href="/api/server_templates/13/alert_specs"/>
        </links>
        <description>rightgrid_photo_worker(daemon), v1 (based on FC6V2_6)&#13;it is the first really gem version</description>
        <name>rightgrid_photo_worker</name>
        <revision>0</revision>
      </server_template>
    . . .
    <server_template>
        <actions>
          <action rel="commit"/>
          <action rel="clone"/>
        </actions>
        <links>
          <link rel="self" href="/api/server_templates/20003"/>
          <link rel="multi_cloud_images" href="/api/server_templates/20003/multi_cloud_images"/>
          <link rel="default_multi_cloud_image" href="/api/multi_cloud_images/49"/>
          <link rel="inputs" href="/api/server_templates/20003/inputs"/>
          <link rel="alert_specs" href="/api/server_templates/20003/alert_specs"/>
        </links>
        <description>Development sandbox for Chef recipes.
    This does not use right_net in anyway.</description>
        <name>caryp - Chef-Solo</name>
        <revision>0</revision>
      </server_template>
    . . .
~~~

#### Supplemental

Using a filter to show only ServerTemplates with "MySQL" in their name.

~~~
    #!/bin/sh
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d filter[]="name==MySQL" \
    -X GET https://my.rightscale.com/api/server_templates.xml
~~~

Additional filter to return only ServerTemplates with "MySQL" in their name **and** "LTS" (lineage reference) in their description.

~~~
    #!/bin/sh
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d filter[]="name==MySQL" \
    -d filter[]="description==LTS" \
    -X GET https://my.rightscale.com/api/server_templates.xml
~~~

### right_api_client

#### Example Call

_Note_: As with many API calls, depending on the account this can be an expensive (resource intensive) operation.

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
    pp @client.server_templates.index
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="server_template", name="Transcoding worker">,
     #<RightApi::ResourceDetail resource_type="server_template", name="rightgrid_photo_worker">,
     #<RightApi::ResourceDetail resource_type="server_template", name="MySQL Master Server">,
     #<RightApi::ResourceDetail resource_type="server_template", name="Base ServerTemplate for Linux (v13.1) v1">,
     #<RightApi::ResourceDetail resource_type="server_template", name="Base ServerTemplate for Linux (v13.1) v2">,
     #<RightApi::ResourceDetail resource_type="server_template", name="Base ServerTemplate for Linux (v13.1) v2">,
     #<RightApi::ResourceDetail resource_type="server_template", name="Base ServerTemplate for Linux (RSB) (v13.2)">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/server_templates.xml")
    $webRequest.Method = "GET"
    $webRequest.CookieContainer = $cookieContainer
    $webRequest.Headers.Add("X_API_VERSION", "1.5");

    [System.Net.WebResponse] $webResponse = $webRequest.GetResponse()
    $responseStream = $webResponse.GetResponseStream()
    $responseStreamReader = New-Object System.IO.StreamReader -argumentList $responseStream
    [string]$responseString = $responseStreamReader.ReadToEnd()
    $responseString
~~~

#### Sample Output

Same as bash/curl example above.

## List ServerTemplates and MCI Associations

List all ServerTemplates and their associated MultiCloud Image associations for the current account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

_Warning_: Depending on the account and cloud resources involved, this can be an expensive (resource intensive) call.

~~~
    #!/bin/sh
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/server_template_multi_cloud_images.xml
~~~

#### Sample Output

_Note_: HTTP headers not displayed. Output truncated.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <server_template_multi_cloud_images>
      <server_template_multi_cloud_image>
        <created_at>2010/04/15 04:23:36 +0000</created_at>
        <actions></actions>
        <links>
          <link rel="self" href="/api/server_template_multi_cloud_images/1"/>
          <link rel="server_template" href="/api/server_templates/2"/>
          <link rel="multi_cloud_image" href="/api/multi_cloud_images/7099"/>
        </links>
        <is_default>true</is_default>
        <updated_at>2010/04/15 04:23:36 +0000</updated_at>
      </server_template_multi_cloud_image>
      <server_template_multi_cloud_image>
        <created_at>2010/04/15 04:23:36 +0000</created_at>
        <actions></actions>
        <links>
          <link rel="self" href="/api/server_template_multi_cloud_images/6"/>
          <link rel="server_template" href="/api/server_templates/13"/>
          <link rel="multi_cloud_image" href="/api/multi_cloud_images/7239"/>
        </links>
        <is_default>true</is_default>
        <updated_at>2010/04/15 04:23:36 +0000</updated_at>
      </server_template_multi_cloud_image>
    . . .
      <server_template_multi_cloud_image>
        <created_at>2012/11/06 11:30:54 +0000</created_at>
        <actions></actions>
        <links>
          <link rel="self" href="/api/server_template_multi_cloud_images/560983001"/>
          <link rel="server_template" href="/api/server_templates/270338001"/>
          <link rel="multi_cloud_image" href="/api/multi_cloud_images/212121001"/>
        </links>
        <is_default>true</is_default>
        <updated_at>2012/11/06 11:30:54 +0000</updated_at>
      </server_template_multi_cloud_image>
    </server_template_multi_cloud_images>
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/server_template_multi_cloud_images.xml")
    $webRequest.Method = "GET"
    $webRequest.CookieContainer = $cookieContainer
    $webRequest.Headers.Add("X_API_VERSION", "1.5");

    [System.Net.WebResponse] $webResponse = $webRequest.GetResponse()
    $responseStream = $webResponse.GetResponseStream()
    $responseStreamReader = New-Object System.IO.StreamReader -argumentList $responseStream
    [string]$responseString = $responseStreamReader.ReadToEnd()
    $responseString
~~~

#### Sample Output

Same as bash/curl output
