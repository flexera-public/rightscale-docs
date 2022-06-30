---
title: Security Groups
layout: general.slim
---

## Create Security Group

Create a Security Group in the specified cloud.

_Note_:

- Not all clouds support Security Groups
- Requires "security_manager" privileges on the account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="1234" # Must provide the Cloud ID because security groups are cloud specific.
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d security_group[name]="Security Group for API Sandbox" \
    -d security_group[description]="Standard Security Group for use in my API Sandbox" \
    https://my.rightscale.com/api/clouds/$CLOUD/security_groups
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Fri, 26 Oct 2012 00:05:37 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/clouds/2112/security_groups/4ISBSPCJCG3CS
    X-Runtime: 1180
    X-Request-Uuid: 4d60bcdd36e64220a06a9c0680f5f043
    Set-Cookie: rs_gbl=eNotkMmOgkBURf-l1pLwGKSKpBeK3IAIguK0MVYBtswoiLbh3xuS3t3FPWdxPuiCVJS90QgFD6R-UPMI70hVNFa6EaoZUkGUQeAJEZURugX9WcJCxCQachBGmAMIBY4IUr8EEUTCU4wZ9Lo6_GdBgYHt7chMnwJJSrZ0ygh0A_N0pf_kU20-d6v0qSUnW1es6_oezE6LYh7La5-YlEvodhc71OH3vmM2brnXjEM7vnBWpWlZmEq1YW53t9k7WB-3LxsmZSbtGRziiEbYPv5OE--cVYywiTfWeVpWm-DcTrOXL7uKJeVenlLf2hTfK7_VilV1dY3F0mu_hiKvociFsaLJ6z4KdN0fMj1bpw%3D%3D; domain=.rightscale.com; path=/; HttpOnly
    Set-Cookie: _session_id=6312c855c21ba86436aeb4deb83a45a2; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

**Note** : Requires "security_manager" privileges on the account, or an HTTP 403 Forbidden is returned.

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    $cloudId='2175' # Set the Cloud ID

    $postURL = "https://my.rightscale.com/api/clouds/$cloudId/security_groups"
    $stringToPost = "security_group[name]=Security Group for API Sandbox&"+
    "security_group[description]=Standard Security Group for use in my API Sandbox"
    $bytesToPost = [System.Text.Encoding]::UTF8.GetBytes($stringToPost)

    $webRequest = [System.Net.WebRequest]::Create($postURL)
    $webRequest.Method = "POST"
    $webRequest.Headers.Add("X_API_VERSION","1.5")
    $webRequest.CookieContainer = $cookieContainer # recieved from authentication.ps1

    $requestStream = $webRequest.GetRequestStream()
    $requestStream.Write($bytesToPost, 0, $bytesToPost.Length)
    $requestStream.Close()

    [System.Net.WebResponse]$response = $webRequest.GetResponse()
    $responseStream = $response.GetResponseStream()
    $responseStreamReader = New-Object System.IO.StreamReader -ArgumentList $responseStream
    [string]$responseString = $responseStreamReader.ReadToEnd()

    $responseString
~~~

#### Sample Output

HTTP 201 (created)

## Create Security Group Rules by CIDR IPS

Add a security group rule to an existing security group, allowing SSH access (port 22) from any source IP.

**Note** : You cannot specify multiple port ranges in one API call. That is, had the example below specified a start/end port of 80, 22, and lastly 443, the security group rule would have been created, but only for port 443. Essentially, the last port range specified wins out. This applies when adding by source_type=group _or_ source_type=cidr_ips. You may however run the script below again, specifying a start_port and end_port of 80 to add the ability to browse, or 443 to permit SSL, etc.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112" # Set the Cloud ID
    SG="4ISBSPCJCG3CS" # Set security group to which the rules should apply
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d security_group_rule[protocol]=tcp \
    -d security_group_rule[cidr_ips]='0.0.0.0/0' \ # Open up for all IP addresses
    -d security_group_rule[protocol_details][start_port]=22 \ # Enable SSH (port 22)
    -d security_group_rule[protocol_details][end_port]=22 \ # Must set the start and end ports
    -d security_group_rule[source_type]=cidr_ips \ # Create by CIDR IP
    https://my.rightscale.com/api/clouds/$CLOUD/security_groups/$SG/security_group_rules
~~~

#### Sample Output

No content, just header information.

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Fri, 26 Oct 2012 19:06:09 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/security_group_rules/358924001
    X-Runtime: 1036
    X-Request-Uuid: d4499e418f2a420594ac4b0ad4d3d387
    Set-Cookie:
    Cache-Control: no-cache
~~~

## Create Security Group Rules by Group

Add a security group rule to an existing security group, allowing port 80 browsing for servers belonging to the security group specified (which is the group itself in our example).

_Note_: You cannot specify multiple port ranges in one API call. That is, had the example below specified a start/end port of 80, 22, and lastly 443, the security group rule would have been created, but only for port 443. Essentially, the last port range specified wins out. This applies when adding by source_type=group _or_ source_type=cidr_ips.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112"
    SG="4ISGEDCJCG3CS"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d security_group_rule[protocol]=tcp \
    -d security_group_rule[protocol_details][start_port]=80 \
    -d security_group_rule[protocol_details][end_port]=80 \
    -d security_group_rule[source_type]=group \
    -d security_group_rule[group_owner]=test \
    -d security_group_rule[group_name]="SG for API Sandbox" \
    https://my.rightscale.com/api/clouds/$CLOUD/security_groups/$SG/security_group_rules
~~~

#### Sample Output

No content, just header information.

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Fri, 26 Oct 2012 18:20:37 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/security_group_rules/358914001
    X-Runtime: 1487
    X-Request-Uuid: 376ddf887be44d3abf6c82d83b9486e7
    Set-Cookie: rs_gbl=eNotkElugzAAAP_iM0jYDrGN1AsVaahZQqsIxKViMUuaBYKBkIi_F6TeZ-YwL5AAA1wmoIC8A8YL9J24A4NQSmYFyAwYEOsQEX2LiQLqfIFhijHbIKrCguYqhAKpdAuRChGGmGks1fTNkpPi36WIru5SB1y3oqNw6tvjWeCoSZ00GVPceIHdbIuSn4hVm5IODTKhDG3ytR_i0qso4doUnqyDGwyfWWFPO-Fn3Ov0vLJ3Un18Y8yvLB7xdS_DJz1OMI5Y7Pj-_VKW3rtf_9JLEIo2d4TmnpkrZfPDgkPWFmfJfYFIGGu7D1Ixz-3L1qvHyCTj23rksR5JsuzWX-UyBc7zH--1W2o%3D; domain=.rightscale.com; path=/; HttpOnly
    Cache-Control: no-cache
~~~

## List Security Groups

List all Security Groups for the specified cloud.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/clouds/$CLOUD/security_groups.xml
~~~

**Tip** : Get the Cloud ID from the API (see _List Clouds_) and parse the output or from within the RightScale Dashboard:

- Login and navigate to: **Clouds** > _CloudName_
- Click on or hover over any of the cloud's supported resources. Note the number after the ".../clouds/< CloudID >/..." for the goto URL (typically displayed in the lower left of a browser if you hover over the resource).
- **Important!** Although you can obtain the Cloud ID from the Dashboard UI, you cannot obtain cloud resource information that way. (For example, Security Groups, Instance Types, Instances, etc. IDs for cloud resources must be retrieved via the API.)

#### Sample Output

**Note** : XML format without the return headers.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <security_groups>
      <security_group>
        <links>
          <link href="/api/clouds/2112/security_groups/DEU7O32167MJ4" rel="self"/>
          <link href="/api/clouds/2112" rel="cloud"/>
          <link href="/api/clouds/2112/security_groups/DEU7O32167MJ4/security_group_rules" rel="security_group_rules"/>
        </links>
        <resource_uid>77df9203-2e72-4cae-95e4-87ae2237f856</resource_uid>
        <name>default</name>
        <actions></actions>
      </security_group>
      <security_group>
        <links>
          <link href="/api/clouds/2112/security_groups/1ISPTV2CHIRVV" rel="self"/>
          <link href="/api/clouds/2112" rel="cloud"/>
          <link href="/api/clouds/2112/security_groups/1ISPTV2CHIRVV/security_group_rules" rel="security_group_rules"/>
        </links>
        <resource_uid>e375de13-a08f-4432-9fff-d52ce40c3f2d</resource_uid>
        <name>Port_8000</name>
        <actions></actions>
      </security_group>
    </security_groups>
~~~

### right_api_client

#### Sample Call

~~~
    require 'rubygems'
    require 'pp' # Require pretty print Ruby gem
    require 'right_api_client' # RightScale API client gem

    user = 'greg.doe@example.com' # Set user email address for using the Dashboard
    acct = '1234' # Set the account ID
    pass = 'SomeSecurePassword' # Set the password for the user. Create client object so you can use the API.
    @client = RightApi::Client.new(:email => user, :password => pass, :account_id => acct)
    #
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    cloud_id = '2112' # Set the Cloud ID I want to list Security Groups for
    instance_types = @client.clouds(:id => cloud_id).show.security_groups.index # Get the Security Groups
    pp instance_types # Print the Security Groups
~~~

#### Example Output

~~~
    [#<RightApi::ResourceDetail resource_type="security_group", name="monkey_private_ports_open", resource_uid="318d3349-5b95-442b-be4a-b5ae3c20d527">,
     #<RightApi::ResourceDetail resource_type="security_group", name="wills_test", resource_uid="56f86e69-97f1-43d7-adfa-3ca1f579ccf6">,
     #<RightApi::ResourceDetail resource_type="security_group", name="default", resource_uid="77df9203-2e72-4cae-94e4-87ae2237f856">,
     #<RightApi::ResourceDetail resource_type="security_group", name="qa_test_group", resource_uid="8968e13b-1a64-5394-931e-3382513813cb">,
     #<RightApi::ResourceDetail resource_type="security_group", name="jg_del", resource_uid="a5b92936-bce1-4e51-8d9d-242f2dfac7e0">,
     #<RightApi::ResourceDetail resource_type="security_group", name="jg_hackTest", resource_uid="acd97974-9d2e-4692-be7e-db6d3d12b313">,
     #<RightApi::ResourceDetail resource_type="security_group", name="Port_8000", resource_uid="e375de13-a08f-4832-9fff-d52ce40c3f2d">,
     #<RightApi::ResourceDetail resource_type="security_group", name="My Test SG", resource_uid="f6c38e18-bc20-12a0-a753-1c5dadc43aeb">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $cloudId="2175"

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds/$cloudId/security_groups.xml")
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

_Note_: Output truncated for brevity sake. The second Security Group shown was created with the example call shown above.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <security_groups>
      <security_group>
        <links>
          <link rel="self" href="/api/clouds/2175/security_groups/5DVK9AHT956N6"/>
          <link rel="cloud" href="/api/clouds/2175"/>
          <link rel="security_group_rules" href="/api/clouds/2175/security_groups/5DVK9AHT956N6/security_group_rules"/>
        </links>
        <description>Internal traffic from default allowed</description>
        <actions></actions>
        <name>default</name>
        <resource_uid>default</resource_uid>
      </security_group>
      <security_group>
        <links>
          <link rel="self" href="/api/clouds/2175/security_groups/50E6OTVJ9KDHG"/>
          <link rel="cloud" href="/api/clouds/2175"/>
          <link rel="security_group_rules" href="/api/clouds/2175/security_groups/50E6OTVJ9KDHG/security_group_rules"/>
        </links>
        <description>Standard Security Group for use in my API Sandbox</description>
        <actions></actions>
        <name>Security Group for API Sandbox</name>
        <resource_uid>sg-177f7b350</resource_uid>
      </security_group>

    . . . output truncated . . .
~~~

## Show Security Group Rules

Show the security group rules for a single, specific security group.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112"
    SG="4ISBSPCJCG3CS" # Reminder, must obtain the Security Group ID via the API, not the Dashboard
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET \
    https://my.rightscale.com/api/clouds/$CLOUD/security_groups/$SG/security_group_rules.xml
~~~

#### Sample Output

_Note_: Headers not shown.

XML output below reveals:

- Port 80 and 22 opened up for CIDR IP's (based on Security Group Rules created by source_type = icdr_ips)
- Port 80 opened up for the group (based on Security Group Rules created by source_type = group)

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <security_group_rules>
      <security_group_rule>
        <group_owner>test</group_owner>
        <group_name>GD SG for API Sandbox</group_name>
        <protocol>tcp</protocol>
        <start_port>80</start_port>
        <actions></actions>
        <end_port>80</end_port>
        <links>
          <link href="/api/security_group_rules/358914001" rel="self"/>
          <link href="/api/clouds/2112/security_groups/4ISBSPCJCG3CS" rel="security_group"/>
        </links>
      </security_group_rule>
      <security_group_rule>
        <protocol>tcp</protocol>
        <start_port>22</start_port>
        <cidr_ips>0.0.0.0/0</cidr_ips>
        <actions></actions>
        <end_port>22</end_port>
        <links>
          <link href="/api/security_group_rules/358925001" rel="self"/>
          <link href="/api/clouds/2112/security_groups/4ISBSPCJCG3CS" rel="security_group"/>
        </links>
      </security_group_rule>
      <security_group_rule>
        <protocol>tcp</protocol>
        <start_port>80</start_port>
        <cidr_ips>0.0.0.0/0</cidr_ips>
        <actions></actions>
        <end_port>80</end_port>
        <links>
          <link href="/api/security_group_rules/358926001" rel="self"/>
          <link href="/api/clouds/2112/security_groups/4ISBSPCJCG3CS" rel="security_group"/>
        </links>
      </security_group_rule>
    </security_group_rules>
~~~

## Show Security Group

Show information about a single security group.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112"
    SG="1ISPSV2CHITVV"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET \
    https://my.rightscale.com/api/clouds/$CLOUD/security_groups/$SG.xml
~~~

**Note** : Although the Cloud ID can be retrieved by navigating to the correct cloud in the Dashboard, the security group ID must be retrieved from the API (as is the case with all cloud resources).

#### Sample Output

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <security_group>
      <links>
        <link href="/api/clouds/2112/security_groups/1ISPTV2CHIRVV" rel="self"/>
        <link href="/api/clouds/2112" rel="cloud"/>
        <link href="/api/clouds/2112/security_groups/1ISPTV2CHIRVV/security_group_rules" rel="security_group_rules"/>
      </links>
      <resource_uid>e375de13-a08f-4432-9fff-d52ce40c3f2d</resource_uid>
      <name>Port_8000</name>
      <actions></actions>
    </security_group>
~~~
