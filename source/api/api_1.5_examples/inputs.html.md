---
title: Inputs
layout: general.slim
---

## Bulk Modify Deployment Inputs

Modify several Inputs (e.g. "bulk modify") with a single API call for a specified deployment.

**Note** : HTTP PUT method is used. If a specified input does not exist, it gets created. If it does exist, its value is set to the one provided. This example modifies inputs at the Deployment level. See the API online reference (for [Inputs > multi_update](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html#multi_update)) to construct the URL and modify at the ServerTemplate or server instance level. If you accidentally set the input value twice on the same API call, the last setting takes precedence.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

Modify the Timezone (text) input and the SVN User/Password (credential) input at the deployment level. A single API call changes all three for all servers in the specified deployment.

_Note_: The following example uses bulk modify inputs "notation 1.0". Its easy to read, but lengthier to specify. See the Supplemental section below to see the newer "notation 2.0" format.

_Important!_ Notation 1.0 will be deprecated in RightScale API 2.0 in favor of "notation 2.0" format.

Curl on a single line:

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Set the deployment to change inputs for
    curl -i -H X_API_VERSION:1.5 -b mycookie -d inputs[][name]="rightscale/timezone" -d inputs[][value]="text:US/Pacific" -d inputs[][name]="repo/default/svn_username" -d inputs[][value]="cred:GD_SVN_USERNAME" -d inputs[][name]="repo/default/svn_password" -d inputs[][value]="cred:GD_SVN_PASSWORD" -X PUT https://my.rightscale.com/api/deployments/$DEPLOYMENT/inputs/multi_update
~~~

Same script but with curl split into multiple lines and basic in-line comments for readability sake:

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Set the deployment to change inputs for
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d inputs[][name]="rightscale/timezone" \
    -d inputs[][value]="text:US/Pacific" \ # Change TZ (text) input value
    -d inputs[][name]="repo/default/svn_username" \
    -d inputs[][value]="cred:GD_SVN_USERNAME" \ # Change SVN Username (credential) value
    -d inputs[][name]="repo/default/svn_password" \
    -d inputs[][value]="cred:GD_SVN_PASSWORD" \ # Change the SVN Password (credential) value
    -X PUT https://my.rightscale.com/api/deployments/$DEPLOYMENT/inputs/multi_update
~~~

#### Sample Output

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Wed, 07 Nov 2012 16:53:34 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 62
    X-Request-Uuid: 87119d96c03842869fcd36dc6b8131dd
    Set-Cookie:
    Cache-Control: no-cache
~~~

**Note** : Navigate or refresh your browser from **_YourDeployment_ > Inputs** tab. Each input value should be changed, and painted "blue" designating the input was set at the deployment level.

#### Supplemental

The equivalent example using the more streamlined "notation 2.0" follows.

_Important!_ Notation 1.0 will be deprecated in RightScale API 2.0 in favor of the following "notation 2.0" format.

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Set the deployment to change inputs for
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d inputs[rightscale/timezone]="text:US/Pacific", \
    -d inputs[repo/default/svn_username]="cred:GD_SVN_USERNAME", \
    -d inputs[repo/default/svn_password]="cred:GD_SVN_PASSWORD" \
    -X PUT https://my.rightscale.com/api/deployments/$DEPLOYMENT/inputs/multi_update
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

The following example modifies several Inputs (APPLICATION_LISTENER_PORT, ZIP_FILE_NAME and OPT_APP_POOL_NAME) for Deployment with ID 306795001.

~~~
    $deploymentID = "306795001" # Set the actual ID of the deployment to be modified
    $stringToPut = "inputs[][name]=APPLICATION_LISTENER_PORT&" # One of several Inputs to be modified
    $stringToPut += "inputs[][value]=text:80&" # Set to 80
    $stringToPut += "inputs[][name]=ZIP_FILE_NAME&"
    $stringToPut += "inputs[][value]=text:thisisazipfile.zip&" # Set to a zip file name
    $stringToPut += "inputs[][name]=OPT_APP_POOL_NAME&"
    $stringToPut += "inputs[][value]=text:ASP.NET v4.0" # Set to ASP.NET v4.0
    $inputWebRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments/$deploymentID/inputs/multi_update?$stringToPut")
    $inputWebRequest.Method = "PUT"
    $inputWebRequest.Headers.Add("X_API_VERSION","1.5")
    $inputWebRequest.CookieContainer = $cookieContainer
    $inputWebRequest.ServicePoint.Expect100Continue = $false
    $inputRequestStream = $inputWebRequest.GetRequestStream()
    $inputRequestStream.Close()
    [System.Net.WebResponse]$inputResponse = $inputWebRequest.GetResponse()
    $inputResponseStream = $inputResponse.GetResponseStream()
    $inputResponseStreamReader = New-Object System.IO.StreamReader -ArgumentList $inputResponseStream
    $inputResponse
    #this is the cookie container for subsequent requests: $cookieContainer
~~~

#### Sample Output

See http/curl output.

## List Inputs for Current and Next Instance

List all the Inputs for both the "current" and "next" instance. Capture the inputs to an XML file for later comparison.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

**Note** : Two invokations of the API. XML output saved in a file named _<ThisScriptName>_Current.xml and <_ThisScriptName_>_Next.xml_

~~~
    #!/bin/sh -e
    CLOUD="2112"
    CURRENT="734PUMJGR7QNF" # Set Current instance ID. Get from the API, listing/showing a Server or Instance.
    NEXT="B469CS55K5VRQ" # Set the Next instance ID. Also obtained from the API.
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -X GET https://my.rightscale.com/api/clouds/$CLOUD/instances/$CURRENT/inputs.xml > $0_Current.xml
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -X GET https://my.rightscale.com/api/clouds/$CLOUD/instances/$NEXT/inputs.xml > $0_Next.xml
~~~

#### Sample Output

**Note** : The example script above saves all output to an XML file. A sample output file is shown below (without HTTP headers).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <inputs>
      <input>
        <value>text:any</value>
        <name>sys_firewall/rule/ip_address</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>rightscale/process_match_list</name>
      </input>
      <input>
        <value>text:tcp</value>
        <name>sys_firewall/rule/protocol</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>logging/remote_server</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>rightscale/process_list</name>
      </input>
      <input>
        <value>text:time.rightscale.com, ec2-us-east.time.rightscale.com, ec2-us-wes
    t.time.rightscale.com</value>
        <name>sys_ntp/servers</name>
      </input>
      <input>
        <value>text:enable</value>
        <name>sys_firewall/rule/enable</name>
      </input>
      <input>
        <value>text:</value>
        <name>sys_firewall/rule/port</name>
      </input>
      <input>
        <value>text:/mnt/ephemeral/swapfile</value>
        <name>sys/swap_file</name>
      </input>
      <input>
        <value>text:0.5</value>
        <name>sys/swap_size</name>
      </input>
      <input>
        <value>text:UTC</value>
        <name>rightscale/timezone</name>
      </input>
      <input>
        <value>text:enabled</value>
        <name>sys_firewall/enabled</name>
      </input>
    </inputs>
~~~

#### Supplemental

Some might find running a simple diff command on the Current and Next XML output files helpful. The following will display differences in the Inputs for the Current and Next server instances.

$ diff Current.xml Next.xml # Where "Current" and "Next" are the actual full file names to be compared.

Note that this will report differences in the date, runtime, cookie and request. Perhaps not elegant, but that can be easily stripped away with the following command pipeline. What is left are legitimate input differences.

$ diff Current.xml Next.xml | grep -v Date | grep -v Runtime | grep -v Cookie | grep -v Request

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call - Current

~~~
    #get cookie container from authentication $cookieContainer

    $CLOUD = '2175' # Set the Cloud ID
    $CURRENT = '34NM8MNFGPE45' # Set Current instance ID. Get from the API,listing/showing a Server or Instance.
                               # For example, See the "List All Servers in a Deployment" example.

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds/$CLOUD/instances/$CURRENT/inputs.xml")
    $webRequest.Method = "GET"
    $webRequest.CookieContainer = $cookieContainer
    $webRequest.Headers.Add("X_API_VERSION", "1.5");

    [System.Net.WebResponse] $listInstanceTypesResponse = $webRequest.GetResponse()
    $listInstanceTypesResponseStream = $listInstanceTypesResponse.GetResponseStream()
    $listInstanceTypesResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listInstanceTypesResponseStream
    [string]$listInstanceTypesResponseString = $listInstanceTypesResponseStreamReader.ReadToEnd()
    write-host $listInstanceTypesResponseStrin
~~~

#### Sample Output - Current

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <inputs>
      <input>
        <value>text:UTC</value>
        <name>SYS_TZINFO</name>
      </input>
      <input>
        <value>env:RS_INSTANCE_UUID</value>
        <name>SERVER_UUID</name>
      </input>
      <input>
        <value>env:RS_SKETCHY</value>
        <name>SKETCHY</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>MON_PROCESSMATCH</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>MON_PROCESSES</name>
      </input>
      <input>
        <value>text:disable</value>
        <name>SECURITY_UPDATES</name>
      </input>
    </inputs>
~~~

#### Example Call - Next

~~~
    #get cookie container from authentication $cookieContainer

    $CLOUD = '2175' # Set the Cloud ID.
    $NEXT ='3PLSU71PF2BJS' # Set the Next instance ID. Also obtained from the API. See the List All Servers in a Deployment.

    $webRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds/$CLOUD/instances/$NEXT/inputs.xml")
    $webRequest.Method = "GET"
    $webRequest.CookieContainer = $cookieContainer
    $webRequest.Headers.Add("X_API_VERSION", "1.5");

    [System.Net.WebResponse] $listInstanceTypesResponse = $webRequest.GetResponse()
    $listInstanceTypesResponseStream = $listInstanceTypesResponse.GetResponseStream()
    $listInstanceTypesResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listInstanceTypesResponseStream
    [string]$listInstanceTypesResponseString = $listInstanceTypesResponseStreamReader.ReadToEnd()
    write-host $listInstanceTypesResponseString
~~~

#### Sample Output - Next

Note that the Next Instance Input values have been altered from the Current Instance (previous example). See **sshd** and **crond** in bold below.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <inputs>
      <input>
        <value>env:RS_SKETCHY</value>
        <name>SKETCHY</name>
      </input>
      <input>
        <value>env:RS_INSTANCE_UUID</value>
        <name>SERVER_UUID</name>
      </input>
      <input>
        <value>ignore:$ignore</value>
        <name>MON_PROCESSMATCH</name>
      </input>
      <input>
        <value>text:sshd crond</value>
        <name>MON_PROCESSES</name>
      </input>
      <input>
        <value>text:disable</value>
        <name>SECURITY_UPDATES</name>
      </input>
      <input>
        <value>text:UTC</value>
        <name>SYS_TZINFO</name>
      </input>
    </inputs>
~~~

## List Inputs for Deployment

List all inputs for a specified deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    DEPLOYMENT="306795001" # Set the Deployment you want to see inputs for
    curl -i -H X-API-Version:1.5 -b mycookie \
    -X GET https://my.rightscale.com/api/deployments/$DEPLOYMENT/inputs.xml
~~~

#### Sample Output

**Note** : HTTP headers not shown. Response output is truncated.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <inputs>
      <input>
        <value>text:</value>
        <name>repo/default/storage_account_provider</name>
      </input>
      <input>
        <value>text:</value>
        <name>db/dns/slave/id</name>
      </input>
    . . .
      <input>
        <value>cred:GD_SVN_USERNAME</value>
        <name>repo/default/svn_username</name>
      </input>
      <input>
        <value>text:</value>
        <name>db/dns/master/id</name>
      </input>
      <input>
        <value>text:</value>
        <name>sys_dns/password</name>
      </input>
      <input>
        <value>text:</value>
        <name>db_mysql/version</name>
      </input>
    </inputs>
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $deploymentID = "306795001" # Set deployment ID to list Inputs for
    $listInputsRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/deployments/$deploymentID/inputs.xml")
    $listInputsRequest.Method = "GET"
    $listInputsRequest.CookieContainer = $cookieContainer
    $listInputsRequest.Headers.Add("X-API-Version", "1.5");
    [System.Net.WebResponse] $listInputsResponse = $listInputsRequest.GetResponse()
    $listInputsResponseStream = $listInputsResponse.GetResponseStream()
    $listInputsResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listInputsResponseStream
    [string]$listInputsResponseString = $listInputsResponseStreamReader.ReadToEnd()
    write-host $listInputsResponseString
~~~

#### Sample Output

See http/curl output.

## Modify Next Instance Input

Change a server level input (for the "next" instance) value. In our example, the SYS_FIREWALL category input named "sys_firewall/rule/port" gets changed to 8080.

**Note** : HTTP PUT method is used. If a specified input does not exist, it gets created. If it does exist, its value is set to the one provided.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112" # Set the Cloud ID
    INSTANCE="B469CS55K5VRQ" # Set the NEXT Instance ID
    PORT="8080" # New port number/value for the text input
    curl -i -H X-API-Version:1.5 -b mycookie \
    -d inputs[][name]="sys_firewall/rule/port" \ # Input name to modify
    -d inputs[][value]="text:$PORT" \ # text value to set the input to (8080)
    -X PUT https://my.rightscale.com/api/clouds/$CLOUD/instances/$INSTANCE/inputs/multi_update
~~~

#### Sample Output

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Wed, 07 Nov 2012 01:34:17 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 822
    X-Request-Uuid: d09e5755c5cd4ad1ae7e2ce3f1da7cfb
    Set-Cookie: rs_gbl=eNo1kE1vgjAAQP9LzzShFWgh2UGHGRoYgqBzl6W0gDI-EiwNaPzvg8Pu773DewIGHNBMQAPiDpwnGO55DxxCKXlpQHLgoJWJsYl1k2jgJmY4wzYqOLMgplYGEcoxpFTkkNi2wRgmvGBizsn837Xx4s51oFbhNnokm9KvizaX9bUJ3c_zvt03GGW6GpU4NlFi0RjXSfBRu2uXw-rE1l566qdDpFOz3Zx95HVVsirDUg7r6wFug0tpwazUebElVP0ImapR_N6_-8Ro9o-q9N2vPso9y5WFruiVHGJiw53RMjSFXR_FtpvuvLC6VeNjuij-PhjxJnhbjozLEcZ5N7RynoJerz9L-1y7; domain=.rightscale.com; path=/; HttpOnly
    Cache-Control: no-cache
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    $cloudID = "2112" # Set the ID of the deployment to be modified
    $instanceID = "B469CS55K5VRQ" # Set the ID of the next instance whose next inputs are being
    $port = "8080" # Set the new port value to 8080
    $stringToPut = "inputs[][name]=sys_firewall/rule/port&"
    $stringToPut += "inputs[][value]=text:$port"
    $inputWebRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds/$cloudID/instances/$instanceID/inputs/multi_update")
    $inputWebRequest.Method = "PUT"
    $inputWebRequest.Headers.Add("X-API-Version","1.5")
    $inputWebRequest.CookieContainer = $cookieContainer
    $inputWebRequest.ServicePoint.Expect100Continue = $false
    $inputRequestStream = $inputWebRequest.GetRequestStream()
    $inputRequestStream.Close()
    [System.Net.WebResponse]$inputResponse = $inputWebRequest.GetResponse()
    $inputResponseStream = $inputResponse.GetResponseStream()
    $inputResponseStreamReader = New-Object System.IO.StreamReader -ArgumentList $inputResponseStream
    $inputResponse
    #this is the cookie container for subsequent requests: $cookieContainer
~~~

#### Sample Output

See http/curl output.
