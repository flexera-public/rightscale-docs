---
title: Server Array
layout: general.slim
---

## Create Server Array

Create a Server Array in a specified deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Calls

#### Single Cloud and Datacenter

The following example will create a server array for a single cloud using a single default datacenter/zone. The script below should be copied and pasted into a Bash script file and made executable if needed (chmod +x /path/to/script.sh). You will want to replace the Deployment ID, ServerTemplate ID, Cloud ID, Instance Type ID, and MCI (MultiCloud Image) ID with the IDs from your own account.

**Note** : A "\" character has been added to allow a single curl command to continue for several lines in the editor. This is for readability sake. The shell will interpret the script's curl command as a single line.

~~~
    #!/bin/sh -e
    DEPLOYMENT="310625001" # Deployment to add Server Array to
    ST="246686001" # Set the ServerTemplate the Server Array will be based on
    CLOUD="232" # Specify the Cloud to add the Server Array to
    ITYPE="80" # Set the Instance Type for this Sever Array, this cloud, ...
    MCI="240699001" # Set MultiCloud Image (MCI)

    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d server_array[name]=my_array_server \
    -d server_array[description]=my_app_server_description \
    -d server_array[deployment_href]=/api/deployments/$DEPLOYMENT \
    -d server_array[array_type]=alert \
    -d server_array[state]=disabled \
    -d server_array[instance][server_template_href]=/api/server_templates/$ST \
    -d server_array[instance][cloud_href]=/api/clouds/$CLOUD \
    -d server_array[instance][multi_cloud_image_href]=/api/multi_cloud_images/$MCI \
    -d server_array[elasticity_params][alert_specific_params][decision_threshold]=51 \
    -d server_array[elasticity_params][bounds][min_count]=2 \
    -d server_array[elasticity_params][bounds][max_count]=3 \
    -d server_array[elasticity_params][pacing][resize_calm_time]=5 \
    -d server_array[elasticity_params][pacing][resize_down_by]=1 \
    -d server_array[elasticity_params][pacing][resize_up_by]=1 \
    https://my.rightscale.com/api/server_arrays
~~~

#### Multiple Datacenters within a Single Cloud

The following example will create a server array for a single cloud using two datacenters for the server allocation policy. Each datacenter will accept a max of 3 instances with a 50% weight, and the total max for the array is 6 instances. The script below should be copied and pasted into a Bash script file and made executable if needed (chmod +x /path/to/script.sh). You will want to replace the Deployment ID, ServerTemplate ID, Cloud ID, Instance Type ID, MCI (MultiCloud Image) ID and Datacenter IDs with the IDs from your own account.

**Note** : A "\" character has been added to allow a single curl command to continue for several lines in the editor. This is for readability sake. The shell will interpret the script's curl command as a single line.

~~~
    #!/bin/sh -e

    DEPLOYMENT="310625001"  # Deployment to add Server Array to
    ST="246686001"          # Set the ServerTemplate the Server Array will be based on
    CLOUD="232"            # Specify the Cloud to add the Server Array to
    ITYPE="80"             # Set the Instance Type for this Sever Array, this cloud, ...
    MCI="240699001"         # Set MultiCloud Image (MCI)
    DC1="9GFSQIVUU642M" # Set first datacenter for server allocation policy, see datacenters in API 1.5 reference for more info
    DC2="2MNLNDTP253CB" # Set second datacenter for server allocation policy, see datacenters in API 1.5 reference for more info

    curl -v -i -H "X-API-VERSION:1.5" -b myCookie -X POST \
    -d "server_array[name]=Test Array Multi-Datacenter" \
    -d "server_array[description]=Testing Multiple datacenters in an array via API 1.5" \
    -d "server_array[deployment_href]=/api/deployments/$DEPLOYMENT" \
    -d "server_array[array_type]=alert" \
    -d "server_array[state]=disabled" \
    -d "server_array[instance][server_template_href]=/api/server_templates/$ST" \
    -d "server_array[instance][cloud_href]=/api/clouds/$CLOUD" \
    -d "server_array[instance][multi_cloud_image_href]=/api/multi_cloud_images/$MCI" \
    -d "server_array[elasticity_params][alert_specific_params][decision_threshold]=51" \
    -d "server_array[elasticity_params][bounds][min_count]=1" \
    -d "server_array[elasticity_params][bounds][max_count]=6" \
    -d "server_array[elasticity_params][pacing][resize_calm_time]=5" \
    -d "server_array[elasticity_params][pacing][resize_down_by]=1" \
    -d "server_array[elasticity_params][pacing][resize_up_by]=1" \
    -d "server_array[datacenter_policy][][datacenter_href]=/api/clouds/$CLOUD/datacenters/$DC1" \
    -d "server_array[datacenter_policy][][max]=3" \
    -d "server_array[datacenter_policy][][weight]=50.0" \
    -d "server_array[datacenter_policy][][datacenter_href]=/api/clouds/$CLOUD/datacenters/$DC2" \
    -d "server_array[datacenter_policy][][max]=3" \
    -d "server_array[datacenter_policy][][weight]=50.0" \
    https://my.rightscale.com/api/server_arrays
~~~

#### Sample Output

**Note** : There is no XML/JSON content, just headers.

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.15
    Date: Mon, 19 Nov 2012 19:21:24 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/server_arrays/214996001
    X-Runtime: 528
    X-Request-Uuid: 14936a5d6bd24baaae0d22ff7b16cede
    Set-Cookie: rs_gbl=eNotkMuOgjAARf-la0n6AEpJZuEDFRRREZUVYdo62lhnUDqCxn8fTGZ3F_ecxXmCEvhAt6AHxA34T2Bu8gp8x3UxevVAzYGPiEOIgz3P7oGT6N4cUkcghC2CKbQQkthisOwWJogI5EmG7M5Xy3_WhfDNdnowGGfrH6VOKy2nw3k_XB3xdHefOkMaMa74YtKqx8LoUdXMImuQsVDBRT_kjTA2PrpV69XnUlOSXw9BoArdFttZss0y_jWA5rRMw-R3P5e5utBDXc7S8-RhNpjmh1E8ni_jrTbL82eUX4pxEB_tza7ScRKktyYhgu0y676vyiYKJDNcqPDjnaR5Jyk5_zaXGviUOfbr9QfiEVxu; domain=.rightscale.com; path=/; HttpOnly
    Cache-Control: no-cache
~~~

## Delete Server Array

Deletes a Server Array based on its server array ID.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER_ARRAY="214835001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X DELETE https://my.rightscale.com/api/server_arrays/$SERVER_ARRAY
~~~

#### Sample Output

**Notes** : There is no XML/JSON content, just headers.

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

## Launch Server Array

Launch a Server Array that has already been added to a deployment.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER_ARRAY="532922001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/server_arrays/$SERVER_ARRAY/launch.xml
~~~

#### Sample Output

**Note** : There is no XML/JSON content, just headers.HTTP/1.1 201 Created

~~~
    Server: nginx/1.0.15
    Date: Fri, 16 Nov 2012 22:55:48 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/clouds/232/instances/480QO2LAL7NDL
    X-Runtime: 10239
    X-Request-Uuid: df5dca35268644749112a077f774bf15
    Set-Cookie: rs_gbl=eNotkElvgkAYQP_Ld3aSGWZBSHpARKmCNWpRvJhhWGoFFxYFjf-9mvT-3ju8B0gwoeigB3EF5gOaKinB5EJo5NmDWoFJKKcEC870HuzjFx3FRGEqBaKYEkRIoiFDkxQZPMIyNlhf9fuvXp38u4Tqb_eVh3RoV1k4pcElu1vBCuf79W6Q2Id5_FuuZROo6TzUiT1j56j2B7vGkSW9FoEab9LthqMVknFyPRanLRmXwqGT9lR5YfHZacXC71Zfo6vLpNjwg9u103yfD9vJGk0yT7heTceX0pkv8IylP-HWWhYHzz6LwS36vjmaxfwR9iNhJcLPs1Kie_XxXtK-l0ilTs2xBlM3OHs-_wCus1xi; domain=.rightscale.com; path=/; HttpOnly
    Cache-Control: no-cache
~~~

## List Server Arrays

List all Server Arrays owned by the current account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/server_arrays.xml
~~~

#### Sample Output

**Note:**

- Truncated XML output without headers included (to save space).
- Only one server array is listed in this example (also to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <server_arrays>
      <server_array>
        <links>
          <link rel="self" href="/api/server_arrays/12030"/>
          <link rel="deployment" href="/api/deployments/80051"/>
          <link rel="current_instances" href="/api/server_arrays/12030/current_instances"/>
          <link rel="next_instance" href="/api/clouds/232/instances/6CNISESVS3MUL"/>
          <link rel="alert_specs" href="/api/server_arrays/12030/alert_specs"/>
        </links>
        <instances_count>0</instances_count>
        <actions>
          <action rel="launch"/>
          <action rel="clone"/>
        </actions>
        <description></description>
        <name>Windows IIS array</name>
        <elasticity_params>
          <pacing>
            <resize_calm_time>5</resize_calm_time>
            <resize_up_by>1</resize_up_by>
            <resize_down_by>1</resize_down_by>
          </pacing>
          <schedule_entries></schedule_entries>
          <alert_specific_params>
            <voters_tag_predicate>windows firefox template array</voters_tag_predicate>
            <decision_threshold>51</decision_threshold>
          </alert_specific_params>
          <bounds>
            <max_count>20</max_count>
            <min_count>0</min_count>
          </bounds>
        </elasticity_params>
        <array_type>alert</array_type>
        <state>enabled</state>
      </server_array>
~~~

#### Supplemental

#### Show only Server Arrays in a Specific Deployment

The following supplemental example includes a "filter" so only servers arrays from the specified deployment are listed.

**Important!**  When using a filter (or view) the computation is done on the server side. This results in a lighter response (less content) returned to the client. The server essentially fetches all content and returns it to the client.

~~~
    #!/bin/sh -e
    DEPLOYMENT="316795001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -d filter[]="deployment_href==/api/deployments/$DEPLOYMENT" -X GET https://my.rightscale.com/api/server_arrays.xml
~~~

#### Filter by the Server Array Name

The following example locates a specific Server Array by name.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -d filter[]="name==Base ServerTemplate for Linux" -X GET https://my.rightscale.com/api/server_arrays.xml
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
    pp @client.server_arrays.index # Output all Server Arrays owned by account '1234'
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="server_array", name="Moon Unit Rho">,
     #<RightApi::ResourceDetail resource_type="server_array", name="TS RackArray">,
    . . . truncated output . . .
     #<RightApi::ResourceDetail resource_type="server_array", name="dano cs 306 array">,
     #<RightApi::ResourceDetail resource_type="server_array", name="Base ServerTemplate for Linux (RSB) (v12.11.3-LTS)">]
~~~

## Multi-Terminate Server Array

Terminate the multiple running instance of a server array.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    SERVER_ARRAY="214837001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/server_arrays/$SERVER_ARRAY/multi_terminate
~~~

#### Sample Output

**Note** :

- There is no XML/JSON content from a Multi-Terminate Server Array (or instance).
- This call only terminates a single running Server Array.
- If you are terminating a Server Array that is enabled, servers will spin up again. Set the status to disabled if you do not want this to happen.

~~~
    HTTP/1.1 202 Accepted
    Server: nginx/1.0.15
    Date: Thu, 15 Nov 2012 22:10:28 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 202 Accepted
    Location: /api/clouds/232/instances/8NHV15LGBQEAV/live/tasks/ae-94103945001
    X-Runtime: 952
    X-Request-Uuid: bcce68a1d92141609d0d6b8f190c61cf
    Set-Cookie:
    Cache-Control: no-cache
~~~

## Show Server Array

Show the information on a single server array.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

~~~
    #!/bin/sh -e
    SERVER_ARRAY="214837001"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/server_arrays/$SERVER_ARRAY.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <server_array>
      <links>
        <link rel="self" href="/api/server_arrays/214837001"/>
        <link rel="deployment" href="/api/deployments/322064001"/>
        <link rel="current_instances" href="/api/server_arrays/214837001/current_instances"/>
        <link rel="next_instance" href="/api/clouds/2327/instances/SK5VB5HAHM3H"/>
        <link rel="alert_specs" href="/api/server_arrays/214837001/alert_specs"/>
      </links>
      <instances_count>0</instances_count>
      <actions>
        <action rel="launch"/>
        <action rel="clone"/>
      </actions>
      <description></description>
      <name>Demo PHP App</name>
      <elasticity_params>
        <pacing>
          <resize_calm_time>12</resize_calm_time>
          <resize_up_by>3</resize_up_by>
          <resize_down_by>1</resize_down_by>
        </pacing>
        <schedule_entries></schedule_entries>
        <alert_specific_params>
          <voters_tag_predicate>Demo PHP App</voters_tag_predicate>
          <decision_threshold>51</decision_threshold>
        </alert_specific_params>
        <bounds>
          <max_count>10</max_count>
          <min_count>2</min_count>
        </bounds>
      </elasticity_params>
      <array_type>alert</array_type>
      <state>disabled</state>
    </server_array>
~~~

## Update the Datacenter Policy for a Server Array

Update the Datacenter Policy for a Server Array. This example illustrates how to define Server Allocation Policy settings (max and weight) individually for different datacenters.

### right_api_client

#### Example Call

The following example sets the maximum number of instances to 7 for the us-west-1a datacenter and to 3 for the us-west-1b datacenter. The instance allocation weighting is left unchanged at 50 percent for each datacenter. Note that the datacenter_href values used in the example are entered explicitly but can easily be queried and stored in a variable using a call similar to... @client.clouds(:id => 1).show.datacenters.index[0].show.href.

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
    @client.server_arrays(:id => 244962003).show.update(:server_array => {:datacenter_policy => [{:weight=>'50.0', :datacenter_href=>'/api/clouds/3/datacenters/531RIVS8UVE2K', :max=>'7'},{:weight=>'50.0', :datacenter_href=>'/api/clouds/3/datacenters/5GQTD1L1BGD73', :max=>'3'}]})
~~~

#### Sample Output

The results of the example call above can be verified by examining the Info tab view for the server array in the dashboard as illustrated below.

![api-server-alloc.png](/img/api-server-alloc.png)
