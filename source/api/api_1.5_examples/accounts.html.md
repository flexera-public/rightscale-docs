---
title: Accounts
layout: general.slim
---

## Show Account

Show information about a specified account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

**Note** : This is about the simplest API call to make. Since you have to provide the account ID to get the account ID, it of course has very little utility in the context of this stand alone example.

#### Example Call

~~~
    #!/bin/sh -e
    ACCOUNT="1234"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/accounts/$ACCOUNT.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 200 OK
    Server: nginx/1.0.15
    Date: Fri, 02 Nov 2012 20:25:35 GMT
    Content-Type: application/vnd.rightscale.account+xml;charset=utf-8
    Connection: keep-alive
    Status: 200 OK
    X-Runtime: 42
    Content-Length: 358
    X-Request-Uuid: fc3d3b6d2d864815ad976f1f2324c617
    Set-Cookie:
    Cache-Control: private, max-age=0, must-revalidate

    <?xml version="1.0" encoding="UTF-8"?>
    <account>
      <created_at>2007/01/09 06:20:08 +0000</created_at>
      <links>
        <link rel="self" href="/api/accounts/1234"/>
        <link rel="owner" href="/api/users/2"/>
        <link rel="cluster" href="/api/clusters/1"/>
      </links>
      <updated_at>2012/09/20 02:10:25 +0000</updated_at>
      <name>TEST API Account</name>
    </account>
~~~

### right_api_client

#### Example Call

~~~
    require 'rubygems'
    require 'pp' # Require pretty print Ruby gem
    require 'right_api_client' # RightScale API client gem

    user = 'greg.doe@example.com' # Set user email address for usingthe Dashboard
    acct = '1234' # Set the account ID
    pass = 'SomeSecurePassword' # Set the password for the user. Create client object so you can use the API.
    @client = RightApi::Client.new(:email => user, :password => pass, :account_id => acct)
    #
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    pp @client.accounts(:id => acct).show # Show account '1234' information
~~~

#### Sample Output

~~~
    #<RightApi::ResourceDetail resource_type="account", name="GregDoe">
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $showAccountRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/accounts/$account.xml")
    $showAccountRequest.Method = "GET"
    $showAccountRequest.CookieContainer = $cookieContainer
    $showAccountRequest.Headers.Add("X_API_VERSION", "1.5");
    [System.Net.WebResponse] $showAccountResponse = $showAccountRequest.GetResponse()
    $showAccountResponseStream = $showAccountResponse.GetResponseStream()
    $showAccountResponseStreamReader = New-Object System.IO.StreamReader -argumentList $showAccountResponseStream
    [string]$showAccountResponseString = $showAccountResponseStreamReader.ReadToEnd()
    write-host $showAccountResponseString
~~~

#### Sample Output

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <account>
      <links>
        <link href="/api/accounts/711" rel="self"/>
        <link href="/api/users/2" rel="owner"/>
        <link href="/api/clusters/1" rel="cluster"/>
      </links>
      <created_at>2007/01/09 06:20:08 +0000</created_at>
      <updated_at>2012/09/20 02:10:25 +0000</updated_at>
      <name>Greg Doe</name>
    </account>
~~~
