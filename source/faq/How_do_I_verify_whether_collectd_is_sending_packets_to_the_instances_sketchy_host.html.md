---
title: How do I verify whether collectd is sending packets to the instance's sketchy host?
category: general
description: This article describes how to verify collectd is sending packets to the instance's sketchy host in RightScale.
---

## Background Information

Monitoring data appears to have stopped being sent from an instance to its assigned sketchy host and the RightScale Dashboard is showing NaN.

## Answer

There are many network packet sniffers available. One of the most common is [tcpdump](http://www.tcpdump.org/)&nbsp;on Linux, or [wireshark](http://www.wireshark.org) on Windows. You can use a sniffer to check if UDP packets are being sent to the assigned sketchy host of the instance, which is usually on UDP port 3011.

### Simple sniff using tcpdump

~~~
# tcpdump 'udp port 3011'
~~~

Sample output:

~~~
root@sandbox:/home# tcpdump 'udp port 3011'
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
01:27:03.365805 IP sandbox.services.rightscale.me.58617 > ec2-204-236-129-255.us-west-1.compute.amazonaws.com.3011: UDP, length 912
01:27:03.369557 IP sandbox.services.rightscale.me.58617 > ec2-204-236-129-255.us-west-1.compute.amazonaws.com.3011: UDP, length 886
01:27:03.372236 IP sandbox.services.rightscale.me.58617 > ec2-204-236-129-255.us-west-1.compute.amazonaws.com.3011: UDP, length 909
~~~

### Verbose sniff w/ packet sniffing and protcol decode using tcpdump

~~~
# tcpdump -Avv 'udp port 3011'
~~~

Sample output:

~~~
root@sandbox:/home# tcpdump -Avv 'udp port 3011'
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
01:27:53.368751 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 913)
    sandbox.services.rightscale.me.58617 > ec2-204-236-129-255.us-west-1.compute.amazonaws.com.3011: [bad udp cksum 5426!] UDP, length 885
E.....@.@.lO
.q..........}......00-35S2JAH.........M.0............
ps_count................@.......@....ps_pagefaults..............."e............ps_disk_octets...............5#.....?E-....ps_disk_ops...............E.......%..........fork_rate..............0.........M.0.....binary_heartbeat....
gauge.....binary_bit....................char_total..............U@....char_position..............D@........M.0.....cpu.....0.....cpu.... user..............2.... nice....................system..............C`... idle...............7... wait..............\.....interrupt....................softirq...................
steal....................df..........df.... root.............X..A.......B....dev................@....X..A....dev-shm........................A....var-run................@....p..A
01:27:53.369448 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 920)
~~~

### Simple sniff using wireshark

1. After starting Wireshark, click on the 'Capture Options' link on the left hand side
2. In the pop-up window that appears, click the 'Capture Filter:' button
3. In the pop-up window that appears, select the 'UDP Only' option
4. At the bottom of the pop-up window, edit the two 'Filter String' text box to say 'udp port 3011'
5. Click 'Ok' to return to the first pop-up window
6. Select the very bottom checkbox under 'Stop Capture...' and set the value to '1 minutes'
7. Click 'Start' and a new window should appear with some periodic output
8. When the capture finishes, use the 'disk' icon in the toolbar to save the capture to a file

#### Wireshark Step Sreenshots:

![faq-WireShark-Capture-OPtions.png](/img/faq-WireShark-Capture-OPtions.png)

![faq-WireShark-Options-Pop-Up.png](/img/faq-WireShark-Options-Pop-Up.png)

![faq-WireShark-Options-Pop-Up-2.png](/img/faq-WireShark-Options-Pop-Up-2.png)

![faq-WireShark-Capture-In-Progress.png](/img/faq-WireShark-Capture-In-Progress.png)
