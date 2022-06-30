---
title: Why is my DNSMadeEasy registration failing when my username and password are correct?
category: general
description: The DNSMadeEasy API requires special characters to be converted into hex before it will be accepted.
---

## Background

When using one of our scripts for registering an IP with a record, or using a chef recipe that does the same, (e.g., sys_dns::do_set_private), you may see an error like the following:

~~~
    04:21:08: Setting the run_list to ["sys_dns::do_set_private"] from JSON
    04:21:08: Starting Chef Run (Version 0.9.14.4)
    04:21:08: ======== sys_dns::do_set_private : START ========
    *ERROR> 04:21:08: sys_dns[Setting Host] (/var/cache/rightscale/cookbooks/518a303fa5da2edff695ecfaa081c1684a8d3d70/cookbooks/sys_dns/recipes/do_set_private.rb:10:in `from_file') had an error:
    Error setting the DNS, curl exited with code: 0, id=8174263, address:10.28.2.73, output:error-auth
~~~

Even if your username and password may be correct. If your password contains special characters, then you will find your solution below. If it does not, you will want to double-check your username and password to ensure that it matches what you are using to log into the DNSMadeEasy console.

## Answer

The reason behind this is that the DNSMadeEasy API requires special characters to be converted into hex before it will be accepted. So, for example, let's say your password is `rf@#er`, the hexidecimal password you would enter would be:

`rf%40%23er`

Which, when combined with the connection string, will look something like the following:

~~~
    https://cp.dnsmadeeasy.com/servlet/updateip?username=test@example.com&password=rf%40%23er&id=1007,1008,1009&ip=12.13.14.15
~~~

If you use the hexi-fied password with our **DNS_PASSWORD** input, or plug it into a credential and then use that with the input, then it should automatically put that in place, and should work properly from there.

You can find a hex conversion chart, here:

[https://www.asciitable.com/](https://www.asciitable.com/)

You will just need to use the Hx column to get the appropriate HEX value for the characters you are using. You can also use a HEX converter, as with the following page:

[http://www.string-functions.com/string-hex.aspx](http://www.string-functions.com/string-hex.aspx)

### See Also

* [http://www.dnsmadeeasy.com/integration/dynamicdns/](http://www.dnsmadeeasy.com/integration/dynamicdns/)
* [https://www.asciitable.com/](https://www.asciitable.com/)  
* [http://www.string-functions.com/string-hex.aspx](http://www.string-functions.com/string-hex.aspx)
