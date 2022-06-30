---
title: Instance Types
layout: general.slim
---

## List Instance Types

List the Instance Types for the specified cloud.

_Reminder_: Cloud resources must be obtained via an API query, not through navigation in the Dashboard UI. (For example, anything under **Clouds** > **_CloudName_** > **_CloudResource_** > **Instance Types** )

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    CLOUD="2112"
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/clouds/$CLOUD/instance_types.xml
~~~

#### Sample Output

**Notes:**

- Truncated XML output without headers included (to save space).
- Instance type ID's in **bold**

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <instance_types>
      <instance_type>
        <cpu_count>1</cpu_count>
        <cpu_speed>1000</cpu_speed>
        <local_disks></local_disks>
        <memory>1024</memory>
        <links>
          <link href="/api/clouds/2112/instance_types/8E7KP200RBRU5" rel="self"/>
          <link href="/api/clouds/2112" rel="cloud"/>
        </links>
        <cpu_architecture></cpu_architecture>
        <description>Medium Instance - Local</description>
        <resource_uid>1714ab5b-15b8-4c06-8141-ae2b7e45b083</resource_uid>
        <local_disk_size></local_disk_size>
        <name>Medium Instance</name>
        <actions></actions>
      </instance_type>
    . . .
      <instance_type>
        <cpu_count>1</cpu_count>
        <cpu_speed>500</cpu_speed>
        <local_disks></local_disks>
        <memory>512</memory>
        <links>
          <link href="/api/clouds/2112/instance_types/9F6N6MA39F7E9" rel="self"/>
          <link href="/api/clouds/2112" rel="cloud"/>
        </links>
        <cpu_architecture></cpu_architecture>
        <description>Small Instance - Local</description>
        <resource_uid>d5d44986-3464-4457-a0f0-7a7ef0b7e677</resource_uid>
        <local_disk_size></local_disk_size>
        <name>Small Instance</name>
        <actions></actions>
      </instance_type>
    </instance_types>
~~~

### right_api_client

#### Example Call

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
    cloud_id = '2112' # Set the Cloud ID I want to list Instance Types for
    instance_types = @client.clouds(:id => cloud_id).show.instance_types.index # Get the instance types
    pp instance_types # Print the instance types
~~~

#### Sample Output

~~~
    [#<RightApi::ResourceDetail resource_type="instance_type", name="Medium Instance", resource_uid="1814ab5b-15b8-4c06-8141-ae2b2e45b083">,
     #<RightApi::ResourceDetail resource_type="instance_type", name="Small Instance", resource_uid="d3d44986-346b-4457-a0f0-7a7ef0b7e677">]
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $cloudID = "2112" # Set the cloudID you want to determine instance types for
    $listInstanceTypesRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/clouds/$cloudID/instance_types.xml")
    $listInstanceTypesRequest.Method = "GET"
    $listInstanceTypesRequest.CookieContainer = $cookieContainer
    $listInstanceTypesRequest.Headers.Add("X-API-Version", "1.5");
    [System.Net.WebResponse] $listInstanceTypesResponse = $listInstanceTypesRequest.GetResponse()
    $listInstanceTypesResponseStream = $listInstanceTypesResponse.GetResponseStream()
    $listInstanceTypesResponseStreamReader = New-Object System.IO.StreamReader -argumentList $listInstanceTypesResponseStream
    [string]$listInstanceTypesResponseString = $listInstanceTypesResponseStreamReader.ReadToEnd()
    write-host $listInstanceTypesResponseString
~~~

#### Sample Output

From Google Compute Engine (output truncated for brevity sake)

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <instance_types>
      <instance_type>
        <local_disks>0</local_disks>
        <cpu_speed></cpu_speed>
        <cpu_count>1</cpu_count>
        <links>
          <link rel="self" href="/api/clouds/2175/instance_types/F5PNK9DSAS9UI"/>
          <link rel="cloud" href="/api/clouds/2175"/>
        </links>
        <memory>614</memory>
        <description>1 vCPU (shared physical core) and 0.6 GB RAM</description>
        <actions></actions>
        <local_disk_size>0</local_disk_size>
        <cpu_architecture></cpu_architecture>
        <name>f1-micro</name>
        <resource_uid>f1-micro</resource_uid>
      </instance_type>
      <instance_type>
        <local_disks>0</local_disks>
        <cpu_speed></cpu_speed>
        <cpu_count>1</cpu_count>
        <links>
          <link rel="self" href="/api/clouds/2175/instance_types/7F3E5V67F4V4C"/>
          <link rel="cloud" href="/api/clouds/2175"/>
        </links>
        <memory>1740</memory>
        <description>1 vCPU (shared physical core) and 1.7 GB RAM</description>
        <actions></actions>
        <local_disk_size>0</local_disk_size>
        <cpu_architecture></cpu_architecture>
        <name>g1-small</name>
        <resource_uid>g1-small</resource_uid>
      </instance_type>
      <instance_type>
        <local_disks>0</local_disks>
        <cpu_speed></cpu_speed>
        <cpu_count>2</cpu_count>
        <links>
          <link rel="self" href="/api/clouds/2175/instance_types/5GLK0LU78E0HE"/>
          <link rel="cloud" href="/api/clouds/2175"/>
        </links>
        <memory>1843</memory>
        <description>2 vCPUs, 1.8 GB RAM</description>
        <actions></actions>
        <local_disk_size>0</local_disk_size>
        <cpu_architecture></cpu_architecture>
        <name>n1-highcpu-2</name>
        <resource_uid>n1-highcpu-2</resource_uid>
      </instance_type>
      <instance_type>
        <local_disks>0</local_disks>
        <cpu_speed></cpu_speed>
        <cpu_count>2</cpu_count>
        <links>
          <link rel="self" href="/api/clouds/2175/instance_types/3210TSONJMGF5"/>
          <link rel="cloud" href="/api/clouds/2175"/>
        </links>
        <memory>1843</memory>
        <description>2 vCPUs, 1.8 GB RAM, 1 scratch disk (870 GB)</description>
        <actions></actions>
        <local_disk_size>0</local_disk_size>
        <cpu_architecture></cpu_architecture>
        <name>n1-highcpu-2-d</name>
        <resource_uid>n1-highcpu-2-d</resource_uid>
      </instance_type>

    . . . output omitted . . .

      <instance_type>
        <local_disks>0</local_disks>
        <cpu_speed></cpu_speed>
        <cpu_count>8</cpu_count>
        <links>
          <link rel="self" href="/api/clouds/2175/instance_types/41ABCD84KF1RM"/>
          <link rel="cloud" href="/api/clouds/2175"/>
        </links>
        <memory>30720</memory>
        <description>8 vCPUs, 30 GB RAM, 2 scratch disks (1770 GB, 1770 GB)</description>
        <actions></actions>
        <local_disk_size>0</local_disk_size>
        <cpu_architecture></cpu_architecture>
        <name>n1-standard-8-d</name>
        <resource_uid>n1-standard-8-d</resource_uid>
      </instance_type>
    </instance_types>
~~~
