---
title: Servers
layout: general.slim
---

## Create Server

Create a server in the specified cloud, deployment, from the given ServerTemplate, MCI, etc.


_**Reminder**_: Not all clouds support all cloud resources. For example, don't include a security group in your Create Server example if the cloud you are working with does not support security groups.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

**Note** : A "\" character has been added to allow a single curl command to continue for several lines in the editor. This is for readability sake. The shell will interpret the script's curl command as a single line.

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Deployment to add Server to
    CLOUD="2112" # Specify Cloud to add Server to
    ST="250769001" # Set the ServerTemplate the Server will be based on
    SG="DEU7O32167MJ4" # Set the Security Group
    MCI="240802001" # Set MultiCloud Image (MCI)
    ITYPE="9F6N6MA39F7E9" # Set the Instance Type for this Sever, this cloud, ...
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d server[name]=my_app_server \
    -d server[description]=my_app_server_description \
    -d server[deployment_href]=/api/deployments/$DEPLOYMENT \
    -d server[instance][cloud_href]=/api/clouds/$CLOUD \
    -d server[instance][server_template_href]=/api/server_templates/$ST \
    -d server[instance][multi_cloud_image_href]=/api/multi_cloud_images/$MCI \
    -d server[instance][instance_type_href]=/api/clouds/$CLOUD/instance_types/$ITYPE \
    -d server[instance][security_group_hrefs][]=/api/clouds/$CLOUD/security_groups/$SG \
    https://my.rightscale.com/api/servers
~~~

#### Sample Output

**Note** : There is no XML/JSON content, just headers.

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Mon, 19 Nov 2012 22:07:48 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/servers/589477001
    X-Runtime: 2676
    X-Request-Uuid: d3f28e8cb11c45c5862800201d350fa4
    Set-Cookie:
    Cache-Control: no-cache
~~~

## Delete Server

Delete a server based on the specified server ID.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER="532922001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X DELETE https://my.rightscale.com/api/servers/$SERVER
~~~

#### Sample Output

**Notes** :

- There is no XML/JSON content, just headers.
- You cannot delete a running Server, or a "next" server. (HTTP 422 and "ActionNotAllowed: The server has a current instance.")

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Fri, 12 Oct 2012 16:25:00 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 1390
    X-Request-Uuid: 6c1eb0c8c21b4835ad425d1bb6fb2b59
    Set-Cookie: _session_id=92ede080c999a3e5734035f582d11b0e; path=/; Secure; HttpOnly
    Cache-Control: no-cache
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
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    server_id = '626129001'
    pp @client.servers(:id => server_id).destroy
~~~

#### Sample Output

nil

If the "destroy" method was not prefaced with "pp" (pretty print), then no output is returned, the action (delete/destroy) is executed with no output.

_Note_: Similar to the http/curl example, you cannot delete a running or "next" server. In the above right_api_client call you will receive a message similar to:

~~~
/usr/lib64/ruby/gems/1.8/gems/right_api_client-1.5.9/lib/right_api_client/client.rb:215:in `do_delete': Error: HTTP Code: 422, Response body: ActionNotAllowed: The server has a current instance. (RightApi::Exceptions::ApiException)
~~~

## Launch Server

Launch a Server that has already been added to a deployment, in a particular cloud, etc.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER="532922001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/servers/$SERVER/launch.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Fri, 19 Oct 2012 22:52:28 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/clouds/232/instances/3R397M9BPGB5J
    X-Runtime: 10360
    X-Request-Uuid: b41d5bd4a4cd4f338bc6542417806e7a
    Set-Cookie: _session_id=4af33099ee4f9e2eb0f169ecb928d5b4; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

## List all Servers in a Deployment

List all Servers in a given Deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/deployments/$DEPLOYMENT/servers.xml
~~~

#### Sample Output

**Note** :

- Truncated XML output without headers included (to save space).
- Only one server in this example deployment (or _all_ additional servers would have been displayed).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <servers>
      <server>
        <updated_at>2012/10/09 21:42:04 +0000</updated_at>
        <links>
          <link href="/api/servers/527725001" rel="self"/>
          <link href="/api/deployments/306795001" rel="deployment"/>
          <link href="/api/clouds/2112/instances/2BFJC99QC8FJA" rel="current_instance"/>
          <link href="/api/clouds/2112/instances/B469CS55K5VRQ" rel="next_instance"/>
          <link href="/api/servers/527725001/alert_specs" rel="alert_specs"/>
        </links>
        <description></description>
        <created_at>2012/10/09 21:41:34 +0000</created_at>
        <name>Base ServerTemplate for Linux (v12.11.0-LTS)</name>
        <actions>
          <action rel="terminate"/>
        </actions>
        <state>operational</state>
      </server>
    </servers>
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
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    deployment_id = '306795001' # Set the Deployment ID I want to show Servers for
    pp @client.deployments(:id => deployment_id).show.servers.index
~~~

#### Sample Output

The following reveals 7 servers in the specified deployment.

~~~
    [#<RightApi::ResourceDetail resource_type="server", name="Base ServerTemplate for Linux (v12.11.0-LTS)">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_app_server1">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_app_server2">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_db_server1">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_db_server2">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_load_balancer1">,
    #<RightApi::ResourceDetail resource_type="server", name="Bethany_load_balancer2">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $DEPLOYMENT="366638001" # Set the Deployment ID to list Servers for

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments/$DEPLOYMENT/servers.xml")
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

_Note_: Two servers are listed in the sample output. One is inactive, the other is operational. The operational servers highlights (in **bold** ) both the Current and Next Instance IDs. These IDs are often needed for other API calls (such as List Current or Next Inputs).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <servers>
      <server>
        <state>inactive</state>
        <updated_at>2013/10/09 22:38:22 +0000</updated_at>
        <created_at>2013/10/09 21:06:18 +0000</created_at>
        <links>
          <link rel="self" href="/api/servers/931047001"/>
          <link rel="deployment" href="/api/deployments/366638001"/>
          <link rel="next_instance" href="/api/clouds/2175/instances/FULA6ROBR8RR4"/>
          <link rel="alert_specs" href="/api/servers/931047001/alert_specs"/>
          <link rel="alerts" href="/api/servers/931047001/alerts"/>
        </links>
        <description></description>
        <actions>
          <action rel="launch"/>
          <action rel="clone"/>
        </actions>
        <name>Base ServerTemplate for Linux (RSB) (v13.5)</name>
      </server>
      <server>
        <state>operational</state>
        <updated_at>2013/10/09 21:25:54 +0000</updated_at>
        <created_at>2013/10/09 21:23:59 +0000</created_at>
        <links>
          <link rel="self" href="/api/servers/931067001"/>
          <link rel="deployment" href="/api/deployments/366638001"/>
          <link rel="current_instance" href="/api/clouds/2175/instances/34NM8MNFGPE45"/>
          <link rel="next_instance" href="/api/clouds/2175/instances/3PLSU71PF2BJS"/>
          <link rel="alert_specs" href="/api/servers/931067001/alert_specs"/>
          <link rel="alerts" href="/api/servers/931067001/alerts"/>
        </links>
        <description></description>
        <actions>
          <action rel="terminate"/>
          <action rel="clone"/>
        </actions>
        <name>Base ServerTemplate for Linux (RSB) (v13.5.0-LTS)</name>
      </server>
    </servers>
~~~

## List Servers

List all Servers owned by the current account.

**_Warning!_** Some API calls can be "expensive" (resource intensive) depending on the number of cloud assets. Listing all servers can take time and may not be recommended for accounts with many servers.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/servers.xml
~~~

**Tip** : If you save XML output of your 'ListServers' script to a file, you can then run a single command to get the number of Servers for that account. For example:

~~~
    $ ./ListServers > ListServers.xml # Output of the example ListServers script saved to ListServers.xml
    $ grep "<server>" ListServers.xml | wc -l # Find each <server> XML block, and then count how many lines there are
    482 # 482 servers found in this example
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space). Shows only first and last server for the account.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <servers>
      <server>
        <updated_at>2010/11/10 05:47:08 +0000</updated_at>
        <links>
          <link href="/api/servers/710980" rel="self"/>
          <link href="/api/deployments/28185" rel="deployment"/>
          <link href="/api/clouds/232/instances/2PL2523DPV4ES" rel="next_instance"/>
          <link href="/api/servers/710990/alert_specs" rel="alert_specs"/>
        </links>
        <description></description>
        <created_at>2009/12/01 21:51:31 +0000</created_at>
        <name>PHP FrontEnd (Chef) -2</name>
        <actions>
          <action rel="launch"/>
        </actions>
        <state>inactive</state>
      </server>
    . . .
      <server>
        <updated_at>2012/10/10 17:46:12 +0000</updated_at>
        <links>
          <link href="/api/servers/529811001" rel="self"/>
          <link href="/api/deployments/89627" rel="deployment"/>
          <link href="/api/clouds/1859/instances/EQPVQSTLQC6KQ" rel="current_instance"/>
          <link href="/api/clouds/1859/instances/6N7C6A3D98EMO" rel="next_instance"/>
          <link href="/api/servers/529911001/alert_specs" rel="alert_specs"/>
        </links>
        <description></description>
        <created_at>2012/10/10 17:43:42 +0000</created_at>
        <name>Greg Doe Test 1</name>
        <actions>
          <action rel="terminate"/>
        </actions>
        <state>operational</state>
      </server>
    </servers>
~~~

#### Supplemental

#### Show only Servers in a Specific Deployment

The following supplemental example includes a "filter" such that only servers from the specified deployment are listed.

**Important!** When using a filter (or view) the computation is done on the server side. This results in a lighter response (less content) returned to the client. The server essentially fetches all content and returns it to the client.

~~~
    #!/bin/sh -e
    DEPLOYMENT="316795001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -d filter[]="deployment_href==/api/deployments/$DEPLOYMENT" -X GET https://my.rightscale.com/api/servers.xml
~~~

#### Show only Load Balancers in a specific Deployment

The following supplemental example is similar to the previous, but it includes an additional filter. Not only does it _only_ show servers in a specific deployment (as opposed to all servers in the cloud you authenticated with) but it restricts the response to servers that have "balancer" in their name.

**Important!** When using more than one filter they are logically ANDed. In our example, this mean servers in the specified deployment AND their name has the string "balancer" in it. Note that a partial match is allowed with the name filter, hence a complicated regular expression with wildcards is not needed. (e.g. \*balancer\*)

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Deployment ID to list servers from
    curl -i -H X_API_VERSION:1.5 -b mycookie \ # Invoke curl, specify version and authentication cookie
    -d filter[]="deployment_href==/api/deployments/$DEPLOYMENT" \
    -d filter[]="name==balancer" \ # ONLY show servers that have "balancer" in their name
    -X GET https://my.rightscale.com/api/servers.xml
~~~

### right_api_client

#### Example Call

**_Warning!_** Some API calls can be "expensive" (resource intensive) depending on the number of cloud assets. Listing all servers can take time and may not be recommended for accounts with many servers.

~~~
    require 'rubygems'
    require 'pp' # Pretty print Ruby gem
    require 'right_api_client' # RightScale API Client gem
                                          # Create client object. Effectively authenticate to use the RS API.
    @client = RightApi::Client.new(:email => 'greg.doe@example.com', :password => 'SecurePasswd', :account_id => '1234')
    pp @client.servers.index # Print/output all Servers in this account
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="server", name="PHP FrontEnd (Chef Alpha) -2">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_load_balancer1">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_load_balancer2">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_app_server1">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_app_server2">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_db_server1">,
     #<RightApi::ResourceDetail resource_type="server", name="Bethany_db_server2">,
     #<RightApi::ResourceDetail resource_type="server", name="Base ServerTemplate for Linux (v13.1)">,
     #<RightApi::ResourceDetail resource_type="server", name="Base ServerTemplate for Linux (RSB) (v13.1)">,
     #<RightApi::ResourceDetail resource_type="server", name="Azure West US">,
     #<RightApi::ResourceDetail resource_type="server", name="Google">,
     #<RightApi::ResourceDetail resource_type="server", name="Resat API 1.5 server">,
     #<RightApi::ResourceDetail resource_type="server", name="Storage Toolbox (v13.1.1)">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

The following will show all servers within the account (not just servers in a deployment).

~~~
    #get cookie container from authentication $cookieContainer

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/servers.xml")
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

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <servers>
      <server>
        <state>inactive</state>
        <updated_at>2010/11/10 05:47:08 +0000</updated_at>
        <created_at>2009/11/17 23:45:16 +0000</created_at>
        <links>
          <link rel="self" href="/api/servers/708440"/>
          <link rel="deployment" href="/api/deployments/31226"/>
          <link rel="next_instance" href="/api/clouds/232/instances/6JV1EEKB421BH"/>
          <link rel="alert_specs" href="/api/servers/708440/alert_specs"/>
          <link rel="alerts" href="/api/servers/708440/alerts"/>
        </links>
        <description></description>
        <actions>
          <action rel="launch"/>
          <action rel="clone"/>
        </actions>
        <name>PHP FrontEnd</name>
      </server>

    . . . output truncated . . .

      <server>
        <state>inactive</state>
        <updated_at>2013/10/08 23:05:33 +0000</updated_at>
        <created_at>2013/10/08 22:50:16 +0000</created_at>
        <links>
          <link rel="self" href="/api/servers/930342001"/>
          <link rel="deployment" href="/api/deployments/96308"/>
          <link rel="next_instance" href="/api/clouds/2160/instances/8EL23Q5CAC6SP"/>
          <link rel="alert_specs" href="/api/servers/930342001/alert_specs"/>
          <link rel="alerts" href="/api/servers/930342001/alerts"/>
        </links>
        <description></description>
        <actions>
          <action rel="launch"/>
          <action rel="clone"/>
        </actions>
        <name>Base ServerTemplate for Linux (RSB) (v13.2.1) v1</name>
      </server>
      <server>
        <state>operational</state>
        <updated_at>2013/10/10 21:52:33 +0000</updated_at>
        <created_at>2013/10/10 21:51:35 +0000</created_at>
        <links>
          <link rel="self" href="/api/servers/932206001"/>
          <link rel="deployment" href="/api/deployments/42060"/>
          <link rel="current_instance" href="/api/clouds/2175/instances/19TO4SE9LC1BS"/>
          <link rel="next_instance" href="/api/clouds/2175/instances/12RRDHIJ68ABF"/>
          <link rel="alert_specs" href="/api/servers/932206001/alert_specs"/>
          <link rel="alerts" href="/api/servers/932206001/alerts"/>
        </links>
        <description></description>
        <actions>
          <action rel="terminate"/>
          <action rel="clone"/>
        </actions>
        <name>Base ServerTemplate for Linux (RSB) (v13.5.0-LTS)</name>
      </server>
    </servers>
~~~

## Show Server

Show the information on a single server.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

~~~
    #!/bin/sh -e
    SERVER="527725001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/servers/$SERVER.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <server>
      <updated_at>2012/10/09 21:42:04 +0000</updated_at>
      <links>
        <link href="/api/servers/527725001" rel="self"/>
        <link href="/api/deployments/306795001" rel="deployment"/>
        <link href="/api/clouds/2112/instances/2BFJC99QC8FJA" rel="current_instance"/>
        <link href="/api/clouds/2112/instances/B469CS55K5VRQ" rel="next_instance"/>
        <link href="/api/servers/527725001/alert_specs" rel="alert_specs"/>
      </links>
      <description></description>
      <created_at>2012/10/09 21:41:34 +0000</created_at>
      <name>Base ServerTemplate for Linux (v12.11.0-LTS)</name>
      <actions>
        <action rel="terminate"/>
      </actions>
      <state>operational</state>
    </server>
~~~

**Note** : If your server ID is incorrect, you will receive:

- HTTP 422 Unprocessable Entity
- ResourceNotFound: Couldn't find Server with ID=123456789

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
    server_id = '527725001'
    pp @client.servers(:id => server_id).show
~~~

#### Sample Output

~~~
    #<RightApi::ResourceDetail resource_type="server", name="Base ServerTemplate for Linux (v12.11.0-LTS)">
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $SERVER='761004' # Set the Server ID. Obtain via the API or Dashboard navigation and the URL.

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/servers/$SERVER.xml")
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

Same as the bash/curl output.

## Terminate Server

Terminate the running instance of a server.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER="532922001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/servers/$SERVER/terminate
~~~

#### Sample Output

**Note** : There is no XML/JSON content from a Terminate Server (or instance).

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Fri, 12 Oct 2012 16:18:49 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 463
    X-Request-Uuid: cbb45a90192a4e75b8580e8f0ff5674f
    Set-Cookie: _session_id=92ede080c999a3e5734035f582d11b0e; path=/; Secure; HttpOnly
    Cache-Control: no-cache
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
    # Setup and authenticate above. Set and use additional variables below, display output, etc.
    #
    server_id = '626129001'
    @client.servers(:id => server_id).show.terminate
~~~

#### Sample Output

The specified server is terminated, but no output. (_Note_: Even if the example script above used "puts" or "pp" to display output, none is returned.)
