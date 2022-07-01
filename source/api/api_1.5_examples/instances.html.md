---
title: Instances
layout: general.slim
---

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

## Multi-Run Executable

Runs a RightScript or Chef Recipe on multiple active RightScale Servers.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Basic Example

**Note** :

- This is similar to [Run Executable](/api/api_1.5_examples/instances.html), but instead of running on a single active running server, this script updates multiple active servers, which is beneficial for running a script or recipe on server arrays.
- When specifying RightScale input(s), you must declare both the name and value.
- The example below runs a recipe.

~~~
    #!/bin/sh -e
    cloud_id="3"
    curl -i -H X_API_Version:1.5 -b mycookie -X POST \
     -d recipe_name="sys_firewall::setup_rule" \
     -d inputs[][name]="sys_firewall/rule/enable" \
     -d inputs[][value]="text:enable" \
     -d inputs[][name]="sys_firewall/rule/ip_address" \
     -d inputs[][value]="text:any" \
     -d inputs[][name]="sys_firewall/rule/port" \
     -d inputs[][value]="text:22"\
     -d inputs[][name]="sys_firewall/rule" \
     -d inputs[][value]="text:tcp" \
    https://my.rightscale.com/api/clouds/$cloud_id/instances/multi_run_executable.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 202 Accepted
    Server: nginx/1.0.14
    Date: Fri, 15 Mar 2013 18:02:56 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 202 Accepted
    Location: /api/clouds/3/instances/6A5PGI1SG74RN/live/tasks/ae-160056990003
    X-Runtime: 2862
    X-Request-Uuid: bf9159a6497440f3be3ec6c7e0f16a3e
    Set-Cookie:
    Cache-Control: no-cache
~~~

### Right_api_client

#### Basic Example

**Note:**

- This example runs an executable on multiple instances, even if they are outside of a Server Array
- This is similar to [Run Executable](/api/api_1.5_examples/instances.html), but instead of running on a single active running server, this script updates multiple active servers.
- By default, the executable will be run on every instance specified in the cloud unless additional filters are given.
- When specifying RightScale input(s), you must declare both the name and value.
- To run this script, you must know your Cloud ID as well as the Chef recipe name or Rightscript HREF, which are both obtainable from the Rightscale dashboard or using other API 1.5 calls.

~~~
    ## Example that runs a Rightscript on all cloud instances in a single cloud with a single input
    ## Also stores the returned task object as 'task,' which in turn can be used to check summary/status

    task = @client.clouds.index(:id => 3).show.instances.multi_run_executable(:right_script_href => '/api/right_scripts/500272003', :inputs => {'INPUT1' => "text:TestValue1"})

    ## Same command, only runs a Chef recipe by name instead of a Rightscript by HREF

    task = @client.clouds.index(:id => 3).show.instances.multi_run_executable(:recipe_name => 'sys_firewall::setup_rule', :inputs => {'INPUT1' => "text:TestValue1"})
~~~

#### Advanced Examples

#### Filtering for Specific Instances

This example is similar to the above example, however many people may not wish to run the recipe or Rightscript on every instance in a single cloud. The below example allows you to run the recipe or Rightscript on specific instances defined with filters, such as:

- In a specific cloud
- Within a specific Deployment
- Contains a specific string in it's Nickname
~~~
    ## Uses deployment_href and name filters to specify only instances within a Deployment that contain a specific string in their name

    @client.clouds.index(:id => 3).show.instances.multi_run_executable(:filter => ['deployment_href==/api/deployments/434815003','name==#2'], :right_script_href => '/api/right_scripts/500272003', :inputs => {'INPUT1' => "text:TestValue1"})
~~~

#### Sample Output

**Note:**

- Sample output below comes from interactive Ruby shell (IRB) and uses sample script and server IDs. Your script HREF and server ID would be different in your own output.
- Sample output includes commands issued from example above.

~~~
    ## IRB Output from Rightscript run with one input.

    irb(main):025:0> task = @client.clouds.index(:id => 3).show.instances.multi_run_executable(:right_script_href => '/api/right_scripts/500272003', :inputs => {'INPUT1' => "text:TestValue1"})
    => #<RightApi::Resource resource_type="task">

    ## IRB Output from Chef recipe run

    irb(main):017:0> task = @client.clouds.index(:id => 3).show.instances.multi_run_executable(:recipe_name => 'sys_firewall::setup_rule', :inputs => {'INPUT1' => "text:TestValue1"})
    => {"links"=>[], "summary"=>"0%: Multi run executable action for instances through API.", "actions"=>[]}

    ## Follows up on the task status

    irb(main):029:0> task.show.summary
    => "completed: Multi run executable action for instances through API."
~~~

Navigating to any affected instance, then clicking on the **Audit Entries** tab will also give you status of the script/recipe run from the right_api_client or Curl command, as seen here:

![api_right_api_client_multi_run_output.png](/img/api_right_api_client_multi_run_output.png)

## Run Executable

Runs a RightScript or Chef Recipe on an active RightScale Server.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Basic Example

**Note:**

- This is similar to [Multi-Run Executable](/api/api_1.5_examples/instances.html), but instead of running on a multiple active servers, this script updates only one server.
- This can only be executed on a RightScale Server with an active instance (the INSTANCEID variable is the instance ID which can be retrieved from a call such as [List Servers](/api/api_1.5_examples/servers.html)).
- When specifying RightScale input(s), you must declare both the name and value.
- The example below runs a RightScript.

~~~
    #!/bin/sh -e
    CLOUD="232"
    INSTANCEID="9AOF4L3DC3IV4" # Instance ID of the running instance. Obtain from the API
    RIGHTSCRIPT="416366" # RightScript ID to run. Can get this from the API or the UI/URL.
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d right_script_href=/api/right_scripts/$RIGHTSCRIPT \
    -d inputs[][name]="DNS_DOMAIN_ID" \
    -d inputs[][value]="text:9623906" \
    -d inputs[][name]="DNS_RECORD_ID" \
    -d inputs[][value]="text:ExampleRightAPI" \
    -d inputs[][name]="DNS_RECORD_IP" \
    -d inputs[][value]="text:public" \
    https://my.rightscale.com/api/clouds/$CLOUD/instances/$INSTANCEID/run_executable
~~~

#### Sample Output

~~~
    HTTP/1.1 202 Accepted
    Server: nginx/1.0.15
    Date: Fri, 21 Dec 2012 00:05:26 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 202 Accepted
    Location: /api/clouds/232/instances/9AOF4L3DC3IV4/live/tasks/ae-110022913001
    X-Runtime: 2959
    X-Request-Uuid: 31b3ee03337143b596fd70f457f47f82
    Set-Cookie:
    Cache-Control: no-cache
~~~

#### Advanced Example

This example from [rs_api_examples](https://github.com/flaccid/rs_api_examples) demonstrates running a recipe (also supports usage of API 1.0 from the CLI).

~~~
    #!/bin/bash -e

    # rs-run-recipe.sh <server_or_instance_id> <recipe_name> [[extra curl post params]]

    # e.g. rs-run-recipe.sh 516031001 "rightscale::default" "server[ignore_lock]=true"
    #
    # For API 1.5:
    # rs_api_version=1.5 rs_cloud_id=1869 rs-run-recipe.sh 1SR4O53A7PLFA "rightscale::setup_timezone" "inputs[][name]=rightscale/timezone" "inputs[][value]=text:Australia/Sydney"

    [[! $1]] && echo 'No server_id ID provided, exiting.' && exit 1
    [[! $2]] && echo 'No recipe name provided, exiting.' && exit 1

    . "$HOME/.rightscale/rs_api_config.sh"
    . "$HOME/.rightscale/rs_api_creds.sh"

    server_id="$1"
    recipe="$2"
    shift; shift
    for arg in "$@"; do
    	args+=(-d "$arg")
    done

    # needs all common public cloud IDs inserted or substitute with API call if possible
    case "$rs_cloud_id" in
      1)
        rs_cloud="AWS US-East"
      ;;
      1869)
        rs_cloud="Softlayer"
      ;;
      *)
        rs_cloud="$rs_cloud_id"
      ;;
    esac

    case $rs_api_version in
    	*1.0*)
        api_url="https://my.rightscale.com/api/acct/$rs_api_account_id/servers/$server_id/current/run_executable"
        echo "Running Chef recipe [$recipe] on Server [$server_id]."
        echo "[API $rs_api_version] POST: $api_url"
        api_result=$(curl -s -S -i -X POST -b "$rs_api_cookie" -H X-API-VERSION:"$rs_api_version" -d server[recipe]="$recipe" "${args[@]}" "$api_url")
        case "$api_result" in
          *Status:\ 201*)
            echo "$api_result" | awk '/^Location:/ { print $2 }'
          ;;
          *)
            echo "FAILED: $api_result"
          ;;
        esac
    	;;
      *1.5*)
        instance_id="$server_id"
        api_url="https://my.rightscale.com/api/clouds/$rs_cloud_id/instances/$instance_id/run_executable"
        echo "Running Chef recipe [$recipe] on Instance [$server_id] in cloud [$rs_cloud]."
        echo "[API $rs_api_version] POST: $api_url"
        api_result=$(curl -s -S -i -X POST -b "$rs_api_cookie" -H X-API-VERSION:"$rs_api_version" -d recipe_name="$recipe" "${args[@]}" "$api_url")
        case "$api_result" in
          *Status:\ 202\ Accepted*)
            echo "$api_result" | awk '/^Location:/ { print $2 }'
          ;;
          *)
            echo "FAILED: $api_result"
          ;;
        esac
    	;;
    esac
~~~

#### Sample Output

(includes the command issued)

~~~
    $ rs_api_version=1.5 rs_cloud_id=1869 ./rs-run-recipe.sh 1SR4O53A7PLFA "rightscale::setup_timezone" "inputs[][name]=rightscale/timezone" "inputs[][value]=text:Australia/Sydney"
    Running Chef recipe [rightscale::setup_timezone] on Instance [1SR4O53A7PLFA] in cloud [Softlayer].
    [API 1.5] POST: https://my.rightscale.com/api/clouds/1869/instances/1SR4O53A7PLFA/run_executable
    /api/clouds/1869/instances/1SR4O53A7PLFA/live/tasks/ae-123025717001
~~~

### right_api_client

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) using right_api_client.

#### Basic Example

**Note:**

- This can only be executed on a RightScale Server with an active instance (the SERVERID variable is the server ID which can be retrieved from a call such as [List Servers](/api/api_1.5_examples/servers.html) or by viewing the dashboard URL of the server).
- The example below runs a RightScript.
- When specifying RightScale input(s), you must declare both the name and value.

~~~
    ## Sets necessary variables for right_script_href and server ID and sets input names and values
    script_href = "right_script_href=/api/right_scripts/500272003"
    serverid = 920583003
    ## replace "INPUT1/2" and "VALUE1/2" with the name/value of your input accordingly
    inputs = "&inputs[][name]=INPUT1&inputs[][value]=text:VALUE1&inputs[][name]=INPUT2&inputs[][value]=text:VALUE2"

    ## Runs the actual script/executable designated in script_href variable on the server
    task = @client.servers(:id => serverid).show.current_instance.show.run_executable(script_href + inputs)

    ## Shows the task summary, which is the same as the audit entry summary in the dashboard (failed, completed, etc.)
    task.show.summary
~~~

#### Sample Output

**Note:**

- Sample output below comes from interactive Ruby shell (IRB) and uses sample script and server IDs. Your script HREF and server ID would be different in your own output.
- task.show.summary is run 3 times to show the various "phases" of the script's execution on the server

~~~
    script_href = "right_script_href=/api/right_scripts/500272003"
    => "right_script_href=/api/right_scripts/500272003"
    serverid = 920583003
    => 920583003
    inputs = "&inputs[][name]=INPUT1&inputs[][value]=text:VALUE1"
    => "&inputs[][name]=INPUT1&inputs[][value]=text:VALUE1"
    task = @client.servers(:id => serverid).show.current_instance.show.run_executable(script_href)
    => #<RightApi::Resource resource_type="task">
    task.show.summary
    => "Querying tags"
    task.show.summary
    => "Preparing execution"
    task.show.summary
    => "completed: GB API Test"
~~~
