---
title: Why is my instance stuck in a "booting" state and no RightScripts run?
category: general
description: Servers using images that contain these versions of RightLink need a special tag in order to notify our core that they contain a legacy deamon.
---

## Background Information

The instance is stuck in booting and does not process boot scripts or decommission scripts.

* * *

## Answer

If you ssh into the instance and check /var/log/messages you might see something like this:

~~~
Aug 22 12:48:00 ip-10-167-282-852 RightLink[2230]: [status] Broker b0 is now
ready, connected brokers: [b0, b1]
Aug 22 12:48:00 ip-10-167-282-852 RightLink[2230]: SEND b0 [request]
<01fcf5b7c275ccb30d2cc1d12348fd43> /booter/declare i-77ed2c30
Aug 22 12:48:00 ip-10-167-282-852 monit[2220]: 'instance' start action done
Aug 22 12:48:30 ip-10-167-282-852 RightLink[2230]: RESEND b0 [request]
<cc7ad4dc83dba7f8d4480dc1b954aa44> /booter/declare i-77ed2c30, tries
<01fcf5b7c275ccb30d2cc1d12348fd43>
Aug 22 12:48:30 ip-10-167-282-852 RightLink[2230]: SEND b0 [request]
<d26c5dfbbfaf9f25a063a63fd0b6be75> /mapper/ping
Aug 22 12:48:31 ip-10-167-282-852 RightLink[2230]: RECV b0 [result] (2,131
bytes) <d26c5dfbbfaf9f25a063a63fd0b6be75> success
Aug 22 12:50:30 ip-10-167-282-852 RightLink[2230]: RESEND b0 [request]
<0ded6589e5b06dade327fcc78b2daf4g> /booter/declare i-77ed2c30, tries
<01fcf5b7c275ccb30d2cc1d12348fd43>, <cc7ad4dc83dba7f8d4480dc1b954aa44>
~~~

This error indicates that you are using a v5.0 - v5.5.9 RightImage<sup>TM</sup>. Due to core architectural changes that were made long after these images were published, servers using images that contain these versions of RightLink need a special tag in order to notify our core that they contain a legacy deamon. We retroactively tagged MultiCloud Images that RightScale published with this tag, however if you cloned the MultiCloud Image it's likely that you'll have to manually update it. Simply add the following tag to the MultiCloud Image and relaunch the server: **"provides:rs_agent_ver=5".** Alternatively, you can use a MultiCloud Image that that is v5.6 or higher without this problem.

You may also see the following error:

~~~
Data Fetching EC2 User-Data EIP test for settled No EIP, current IP=67.202.55.15 done...
Tuning runrightscripts for centos
Running boot RightScripts
Mon Nov 10 14:12:41 EST 2008
!!!!! ERROR PROCESSING RIGHTSCRIPTS:
!!!!! undefined method `unpack' for {}:Hash /usr/lib/ruby/1.8/base64.rb:59:in `decode64'
~~~

This error indicates that you are using a V3.0 or earlier RightImage<sup>TM</sup> that has an empty RightScript. Check any scripts that you have added and make sure that they have at least one line of code. This error does not occur in V3.1 or higher instances.
