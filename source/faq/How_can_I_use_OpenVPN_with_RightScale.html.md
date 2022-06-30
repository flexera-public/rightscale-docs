---
title: How can I use OpenVPN with RightScale?
category: general
description: This FAQ covers how to create a RightScript that will install OpenVPN client and server. There are a number of ways to use OpenVPN.
---

This FAQ covers how to create a RightScript that will install OpenVPN client and server. There are a number of ways to use OpenVPN. This specific example covers one possible scenario but there are many others. You can modify the script to suite your needs.

## Problem

1. A credit card payment processing gateway identifies client connections by an IP address that is qualified through a whitelist process. Therefore we must have a set of static IP addresses (Elastic IP's).
2. Application servers on scalable arrays cannot use static IP addresses on Amazon EC2 because they are in short supply. Rather, they use dynamic IP's. Unassigned EIPs are expensive (Amazon charges a premium for them) and while it might be possible to have 5-10 whitelisted EIP's it is not realistic to have dozens or hundreds.
3. When a user submits a checkout they need send credit card information to a payment gateway and it needs to appear to be coming from one of the whitelisted IP's.
4. All traffic must be https since this is a secure website.

## Solution

Install an Open VPN client on each app server and an Open VPN server with EIP acting as a NAT gateway. A static route on each client routes traffic to payment gateway through the VPN tunnel (tun0). Other traffic is routed normally through eth0. The VPN insures that traffic from the client to the payment gateway is routed back to the client. To the payment gateway it looks like all traffic is coming from a single public whitelisted IP address.

![faq-VPN.gif](/img/faq-VPN.gif)

### How to Set it Up

1. Create the following rightscript called Install OpenVPN.

    ~~~
    #!/bin/bash
    yum -y install openvpn
    cp $RS_ATTACH_DIR/keys.tgz /root/keys.tgz
    cd /root
    tar -zxf /root/keys.tgz
    if [$VPN_TYPE = "server"]; then
    echo "VPN Server setup"
    iptables --table nat --append POSTROUTING -s 172.31.0.0/12 --out-interface eth0 -j MASQUERADE
    echo 1 > /proc/sys/net/ipv4/ip_forward
    service iptables save
    service iptables restart
    cat > /etc/openvpn/server.conf << EOF
    dev tun
    proto udp
    port 1194
    server 172.31.0.0 255.255.255.0
    ifconfig-pool-persist ipp.txt
    key /root/server.key
    ca /root/ca.crt
    cert /root/server.crt
    keepalive 10 60
    inactive 600
    persist-tun
    duplicate-cn
    dh /root/dh1024.pem
    EOF
    fi
    if [$VPN_TYPE = "client"]; then
    echo "VPN Client setup"
    cat > /etc/openvpn/client.conf << EOF
    client
    dev tun
    proto udp
    port 1194
    resolv-retry infinite
    nobind
    remote $VPN_SERVER_IP
    keepalive 10 60
    inactive 600
    persist-tun
    persist-key
    dh /root/dh1024.pem
    ca /root/ca.crt
    cert /root/client.crt
    key /root/client.key
    EOF
    fi
    echo "Starting openvpn"
    service openvpn start
    ~~~

    Notice there are two inputs that are required - click the "identify" button to identify them. The $VPN_TYPE indicates if this instance will be a client or a server. The VPN_SERVER_IP is the actual EIP of the VPN server instance.

2. Certificates need to be generated for the client and the server.

[http://openvpn.net/index.php/open-source/documentation/howto.html#pki](http://openvpn.net/index.php/open-source/documentation/howto.html#pki)

You can ssh into a running instance you already have and run the commands after doing a yum install openvpn.&nbsp;&nbsp; You can uninstall openvpn when you are done.&nbsp;&nbsp; You can also use a linux desktop or server with openvpn installed on it.&nbsp; The keys generated need to be generated for client and server and put into a tarball (keys.tgz).&nbsp; In order to support scaling all clients and servers use the same keys and certs.&nbsp; This is secure because the servers are not ever leaving the cloud (they aren't laptops wandering around the city). You can use the secure copy (scp) command from an SSH session to copy it your local machine and then use the "attachments tab" of the rightscale script editor to upload it and attach it to the script.

3. Add the script to your existing server templates.&nbsp; You may want to create a new server template for the vpn server since it doesn't need much on it (all it really needs is this script - and possibly the monitoring tools and syslogging).&nbsp; But you can put whatever you want on it.

4. Open port 1194 for UDP&nbsp;traffic in your security group.

5. Start the vpn server instance.&nbsp;&nbsp; Be sure to set the VPN\_TYPE as: server

6. When the server is running start the vpn client instance

7. To test the vpn from one of the client app server instance you can ssh in: `ping 172.31.0.1`
    If you get a response the vpn is working.
    You can also test seting up a route. Run lynx from the instance and navigate to whatismyipaddress.com. Sscroll down and note your IP - it should be the public ip of the instance - this proves that traffic is routing to eth0 - that your instance is talking directly to the internet. To add a route through the vpn you use the command `route add -host whatismyipaddress.com dev tun0`
    Rerun the lynx browser and go to whatismyipaddress.com.&nbsp; You can scroll down and see that it thinks your IP is the IP of your NAT gateway - not the IP of your client browser.It should be the EIP of your server instances.&nbsp; The client is taking through the vpn tun0 adapter to the server.

8. You will want to add the route to the payment gateway as a boot script on your app server (clients).

**NOTES:** The clients are automatically assigned IP addresses by the VPN server. They will keep their IP addresses. The VPN server saves each client IP in ipp.txt (ifconfig-pool-persist ipp.txt directive handles this). You can setup multiple VPN servers as well, for redundancy and can even do round robin for load balancing.

If you are having issues connecting beyond the OpenVPN gateway, and are unable to communicate with servers within the private network, you may need to log into the AWS console and un-check "Change Source / Dest Check" as it looks like it may prevent routing between instances. The following screenshot shows what it looks like in a right-click context menu, within EC2 Instances:

![faq-openvpn.png](/img/faq-openvpn.png)
