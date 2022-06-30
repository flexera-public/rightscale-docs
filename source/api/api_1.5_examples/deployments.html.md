---
title: Deployments
layout: general.slim
---

## Create Deployment

Create a new deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d deployment[name]="Deployment for API Sandbox" \
    -d deployment[description]="Sandbox for miscellaneous API tests" \
    https://my.rightscale.com/api/deployments.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Thu, 25 Oct 2012 18:33:36 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/deployments/314837001
    X-Runtime: 292
    X-Request-Uuid: ecf7f1ed401b48a4b98de27d894389db
    Set-Cookie: _session_id=b8112ab3a540a2cf0a81ce64be2c3e38; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $deploymentName = "Deployment for API Sandbox"
    $deploymentDescription = "Sandbox for Miscellaneous API Tests"
    $postString = "deployment[name]=""$deploymentName""&deployment[description]=$deploymentDescription"
    $postBytes = [System.Text.Encoding]::UTF8.GetBytes($postString)
    $createDeploymentRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments.xml")
    $createDeploymentRequest.Method = "POST"
    $createDeploymentRequest.CookieContainer = $cookieContainer
    $createDeploymentRequest.Headers.Add("X_API_VERSION", "1.5");

    $createDeploymentRequestStream = $createDeploymentRequest.GetRequestStream()
    $createDeploymentRequestStream.Write($postBytes, 0, $postBytes.Length)
    $createDeploymentRequestStream.Close()
    [System.Net.WebResponse] $createDeploymentResponse = $createDeploymentRequest.GetResponse()
    $createDeploymentResponseStream = $createDeploymentResponse.GetResponseStream()
    $createDeploymentResponseStreamReader = New-Object System.IO.StreamReader -argumentList $createDeploymentResponseStream
    [string]$createDeploymentResponseString = $createDeploymentResponseStreamReader.ReadToEnd()
~~~

#### Sample Output

~~~
    IsMutuallyAuthenticated : False
    Cookies : {}
    Headers : {Transfer-Encoding, Connection, Status, X-Runtime...}
    SupportsHeaders : True
    ContentLength : -1
    ContentEncoding :
    ContentType : text/html; charset=utf-8
    CharacterSet : utf-8
    Server : nginx/1.0.15
    LastModified : 2/21/2013 12:54:34 PM
    StatusCode : Created
    StatusDescription : Created
    ProtocolVersion : 1.1
    ResponseUri : https://my.rightscale.com/api/deployments.xml
    Method : POST
    IsFromCache : False
~~~

## Delete Deployment

Delete a deployment. Also known as "destroy" a deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    DEPLOYMENT="314866001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X DELETE https://my.rightscale.com/api/deployments/$DEPLOYMENT
~~~

#### Sample Output

There is no XML/JSON content, just headers output. (HTTP 204 No Content)

**Notes** :

- You cannot delete a locked deployment. (HTTP 422 Unprocessible Entity and "ActionNotAllowed: The deployment is locked" returned.)
- You cannot delete a deployment with operational servers. (HTTP 422 and "ActionNotAllowed: This deployment cannot be deleted because it contains running servers and/or active arrays.")
- _Warning!_ You _can_ delete a deployment that has non-operational servers in it (as long as its not locked). The servers will be deleted too.

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $deploymentID = "365623001"
    $deleteDeploymentsRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments/$deploymentID")
    $deleteDeploymentsRequest.Method = "DELETE"
    $deleteDeploymentsRequest.CookieContainer = $cookieContainer
    $deleteDeploymentsRequest.Headers.Add("X_API_VERSION", "1.5");
    [System.Net.WebResponse] $deleteDeploymentsResponse = $deleteDeploymentsRequest.GetResponse()
    $deleteDeploymentsResponseStream = $deleteDeploymentsResponse.GetResponseStream()
    $deleteDeploymentsResponseStreamReader = New-Object System.IO.StreamReader -argumentList $deleteDeploymentsResponseStream
    [string]$deleteDeploymentsResponseString = $deleteDeploymentsResponseStreamReader.ReadToEnd()
    $deleteDeploymentsResponse
~~~

#### Sample Output

~~~
    IsMutuallyAuthenticated : False
    Cookies : {}
    Headers : {Connection, Status, X-Runtime, X-Request-Uuid...}
    SupportsHeaders : True
    ContentLength : -1
    ContentEncoding :
    ContentType :
    CharacterSet :
    Server : nginx/1.0.15
    LastModified : 2/21/2013 1:00:04 PM
    StatusCode : NoContent
    StatusDescription : No Content
    ProtocolVersion : 1.1
    ResponseUri : https://my.rightscale.com/api/deployments/365623001
    Method : DELETE
    IsFromCache : False
~~~

## List Deployments

List all Deployments of an account (also referred to as the Deployments Index).

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/deployments.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <deployments>
      <deployment>
        <links>
          <link href="/api/deployments/394" rel="self"/>
          <link href="/api/deployments/394/servers" rel="servers"/>
          <link href="/api/deployments/394/server_arrays" rel="server_arrays"/>
          <link href="/api/deployments/394/inputs" rel="inputs"/>
        </links>
        <server_tag_scope>deployment</server_tag_scope>
        <description>
    </description>
        <name>Default</name>
        <actions></actions>
      </deployment>
      <deployment>
        <links>
    . . .
~~~

~~~
    <deployment>
        <links>
          <link href="/api/deployments/306795001" rel="self"/>
          <link href="/api/deployments/306795001/servers" rel="servers"/>
          <link href="/api/deployments/306795001/server_arrays" rel="server_arrays"/>
          <link href="/api/deployments/306795001/inputs" rel="inputs"/>
        </links>
        <server_tag_scope>deployment</server_tag_scope>
        <description>Test out API 1.5. Craft examples based on http/curl and right_api_client. Greg Doe</description>
        <name>GD: API 1.5 Sandbox</name>
        <actions></actions>
      </deployment>
    </deployments>
~~~

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
    # Setup and authenticate above. Display output below.
    #
    pp @client.deployments.index
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="deployment", name="Default">,
      #<RightApi::ResourceDetail resource_type="deployment", name="RightScale Staging">,
      #<RightApi::ResourceDetail resource_type="deployment", name="GD: API 1.5 Sandbox">,
      #<RightApi::ResourceDetail resource_type="deployment", name="Cloned Resat API 1.5">,
    . . . output abbreviated here . . .
      #<RightApi::ResourceDetail resource_type="deployment", name="Resat API 1.5">,
      #<RightApi::ResourceDetail resource_type="deployment", name="Ride Deployment - 1354684326633">,
      #<RightApi::ResourceDetail resource_type="deployment", name="QA_rspec_Deployment 1354732811">,
      #<RightApi::ResourceDetail resource_type="deployment", name="Knapp">]
~~~

#### Supplemental

#### Only Show (Filter) certain Deployments

Similar to the way you can "Filter by Nickname" in the Dashboard UI, this example will only display Deployments that contain "api" in their name.

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
    pp @client.deployments.index(:filter => ['name==API']) # ONLY show deployments with "api" in the nickname
~~~

_Note_: If you run the above script (e.g. _DeploymentListFilter_) and total the number of deployments, it should match the number in the Dashboard (Manage > Deployments) if you "filter by" the same nickname.

For example:

$ ruby DeploymentListFilter | wc -l

**58**

![api_deployments.jpg](/img/api_deployments.jpg)

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $listDeploymentsRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments.xml")
    $listDeploymentsRequest.Method = "GET"
    $listDeploymentsRequest.CookieContainer = $cookieContainer
    $listDeploymentsRequest.Headers.Add("X_API_VERSION", "1.5");
    [System.Net.WebResponse] $listDeploymentsResponse = $listDeploymentsRequest.GetResponse()
    $listDeploymentsResponseStream = $listDeploymentsResponse.GetResponseStream()
    $listDeploymentsResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listDeploymentsResponseStream
    [string]$listDeploymentsResponseString = $listDeploymentsResponseStreamReader.ReadToEnd()
    write-host $listDeploymentsResponseString
~~~

#### Sample Output

See http/curl output.
