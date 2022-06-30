---
title: Audit Entries
layout: general.slim
---

## List Audit Entries

To list out Audit Entries based on a specified start/end date and setting an upper limit on the number of entries returned.

**Note** : Listing out all audit entries is very resource intensive. Hence setting a start and end date as well as an upper limit is required.

### Curl

**Important** : When looking at the online reference information for the [start/end_date regular expressions](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#index), you'll notice that the seconds are prepended with a '+'. The plus sign does cause issues with the URL when using the curl command. Hence, the example below encodes the plus sign as a "%2B" before following it with all zeros.

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET \
    -d limit=250 \ # Set upper limit on entries returned to 250
    -d start_date='2012/10/01 00:00:00 %2B0000' \ # Note: Must encode the plus sign as a %2B
    -d end_date='2012/10/31 00:00:00 %2B0000' \ # Encode plus sign as %2B again. Start/end date = October
    https://my.rightscale.com/api/audit_entries.xml
~~~

**Note** : As mentioned earlier, audit entry operations can be resource intensive. On some clouds, the script above could take several minutes.

#### Sample Output

. . . XML headers and output is truncated . . .

**Note** : Output below contains three audit entries. _Tip_: Browser search for "summary" to find each one.

1. Launch failure
2. Array resize failure
3. Completion of a load balancer attach all recipe

~~~
    <audit_entries>
    <audit_entry>
        <detail_size>211</detail_size>
        <updated_at>2012/10/02 00:57:41 +0000</updated_at>
        <actions>
          <action rel="append"/>
        </actions>
        <user_email></user_email>
        <summary>Resize array by (+1)</summary>
        <links>
          <link href="/api/audit_entries/77767394001" rel="self"/>
          <link href="/api/server_arrays/210825001" rel="auditee"/>
          <link href="/api/audit_entries/77767394001/detail" rel="detail"/>
        </links>
      </audit_entry>
      <audit_entry>
        <detail_size>26</detail_size>
        <updated_at>2012/10/02 01:02:11 +0000</updated_at>
        <actions>
          <action rel="append"/>
        </actions>
        <user_email></user_email>
        <summary>Failed to launch</summary>
        <links>
          <link href="/api/audit_entries/77768513001" rel="self"/>
          <link href="/api/server_arrays/210825001" rel="auditee"/>
          <link href="/api/audit_entries/77768513001/detail" rel="detail"/>
        </links>
      </audit_entry>

      <audit_entry>
        <detail_size>7455</detail_size>
        <updated_at>2012/10/02 01:09:03 +0000</updated_at>
        <actions>
          <action rel="append"/>
        </actions>
        <user_email></user_email>
        <summary>completed: lb::do_attach_all</summary>
        <links>
          <link href="/api/audit_entries/77770317001" rel="self"/>
          <link href="/api/clouds/232/instances/91GK4VDL5DOEA" rel="auditee"/>
          <link href="/api/audit_entries/77770317001/detail" rel="detail"/>
        </links>
      </audit_entry>
    </audit_entries>
~~~

#### Supplemental

With the script above and basic knowledge of the shell you can create several helpful commands. For example, if the script above is AuditList:

~~~
    $ ./AuditList | grep -i "failed to launch" | wc -l # Number of servers that failed to launch in October
~~~

**Tip** : If you want to check the audit entry summary for several different patterns, you are better off saving the output to a file then running "grep" and "wc" in a pipeline to get various numbers. This will only tax API resources one time. For example:

~~~
    $ ./AuditList | grep summary > AuditList.out # API call for audit entries performed one time
    $ grep -i fail AuditList.out | wc -l # How many failures?
~~~

~~~
    $ grep terminated AuditList.out | wc -l # How many instances have been terminated?
~~~

### PowerShell

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html) and your session cookie for subsequent requests is in 'cookieContainer'.

#### Example Call

~~~
    #get cookie container from authentication $cookieContainer
    $limit = "250"
    $start_date = "2013/02/01 00:00:00 %2B0000"
    $end_date = "2013/02/21 00:00:00 %2B0000"
    $auditEntryRequest = [System.Net.WebRequest]::Create("https://my.rightscale.com/api/audit_entries.xml?limit=$limit&start_date=$start_date&end_date=$end_date")
    $auditEntryRequest.Method = "GET"
    $auditEntryRequest.CookieContainer = $cookieContainer
    $auditEntryRequest.Headers.Add("X_API_VERSION", "1.5");
    [System.Net.WebResponse] $auditEntryResponse = $auditEntryRequest.GetResponse()
    $auditEntryResponseStream = $auditEntryResponse.GetResponseStream()
    $auditEntryResponseStreamReader = New-Object System.IO.StreamReader -argumentList $auditEntryResponseStream
    [string]$auditEntryResponseString = $auditEntryResponseStreamReader.ReadToEnd()
    write-host $auditEntryResponseString
~~~

#### Sample Output

See http/curl output.
