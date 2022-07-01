---
title: How do I enable ICMP Echo (ping reply)?
category: general
description: In most cases with public-facing instances, it is desirable by system administrators to allow ping reply as a basic means of verifying network response.
---

In most cases with public-facing instances, it is desirable by system administrators to allow [ping reply](http://en.wikipedia.org/wiki/Ping#Echo_request) as a basic means of verifying network response.

[Create a security group](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Manage/Network_Manager/Actions/01-Networks/View_a_Network/Create_a_Security_Group) (or use an existing one) and add a permission for ICMP IPs with a type and code of -1 e.g:

![faq-AddIPs.png](/img/faq-AddIPs.png)

**Note**: You can assign the IPs as 0.0.0.0/0 to allow all IPs and networks or restrict access with the appropriate CIDR notation.

Once added, the permission will be listed in the security group as follows:&nbsp;

![faq-Allow.png](/img/faq-Allow.png)  
