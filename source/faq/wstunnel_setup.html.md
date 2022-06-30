---
title: How do I set up WStunnel? 
category: general
description: This page outlines the steps for configuring WStunnel. The RightScale platform supports the use of WStunnel to establish an outbound web-sockets tunnel from your environment back to the RightScale platform. This can be used to allow the RightScale platform access to on-premise cloud systems as well as other on-premise APIs.
---

## Overview

The RightScale platform supports the use of WStunnel to establish an outbound web-sockets tunnel from your environment back to the RightScale platform. This obviates the need to open inbound access to your on-premise services. Instead, only outbound port 443 to the RightScale platform needs to be open from your environment to interface with the on-premise from RightScale.

## Installing and Configuring WStunnel

Identify a server in your environment that has access to the on-premise services to which the RightScale platform needs access as well as has outbound Internet access.
Any linux server with the required access will work.

Go to [https://github.com/rightscale/wstunnel](https://github.com/rightscale/wstunnel) and copy the link to the wstunnel .tgz file.
The download link is provided in the README.

Login to the server on which wstunnel will be running and download the wstunnel package to the location of your choice on the server.

~~~
$ wget https://binaries.rightscale.com/rsbin/wstunnel/1.0/wstunnel-linux-amd64.tgz
~~~

Untar/unzip the file.

~~~
$ tar zxvf ./wstunnel-linux-amd64.tgz
~~~

Edit the wstunnel/init/wstuncli.default file as follows:
* Add a REGEXP line that matches your the URL for the on-premise service.
	* For example if your service is at https://192.168.0.2, then the following line will allows access to the service (and any other service on that 192.x.x.x network):
			`REGEXP='https://192..*'`
* Set the TOKEN to some random value that is at least 16 characters.
	* An md5 sum of a file produces a usable value.
* Change the SERVER line to point at your service IP and port.
	* For example: `SERVER=https://192.168.0.2:5000`
* Set the TUNNEL endpoint as follows:
	* If using wstunnel for **OpenStack**, then use `wss://wstunnel10-1.rightscale.com`
	* Otherwise, identify the shard for the RightScale account with which you are going to use this wstunnel.
		* This is found by going to your rightscale account and navigate to **Settings** > **Account Settings** > **API Credentials** and noting if the Token Endpoint is us-3.rightscale.com or us-4.rightscale.com.
		* If us-3 then use `wss://wstunnel1-1.rightscale.com`
		* If us-4 then use `wss://wstunnel10-1.rightscale.com`

Copy the default file to /etc/default as follows:

~~~
$ sudo cp wstunnel/init/wstuncli.default /etc/default/wstuncli
~~~

Copy the wstunnel binary to /usr/local/bin:

~~~
$ sudo cp wstunnel/wstunnel /usr/local/bin/wstunnel
~~~

### Creating and Launching an Upstart File for Ubuntu Systems
Edit wstunnel/init/wstuncli.conf and change the "exec /usr/local/bin/wstunnel" line (should be near the bottom of the file) to add "-regexp $REGEXP" as follows:
* `exec /usr/local/bin/wstunnel cli -regexp $REGEXP -token $TOKEN -tunnel $TUNNEL -server $SERVER -logfile /var/log/wstuncli.log`

Copy the configuration file to the /etc/init folder.

~~~
$ sudo cp wstunnel/init/wstuncli.conf /etc/init/
~~~

* Start the tunnel:

~~~
$ sudo initctl start wstuncli
~~~

Check /var/log/wstuncli.log for errors.
* Messages indicating "WS Opening" and "WS Ready" and "Pinger starting" indicate success.

### Creating and Launching a Systemd Service File for CentOS Systems
Create a file: /etc/systemd/system/wstuncli.service with the following contents:

~~~ 
[Unit]
Description=WStunnel start up
After=network.target

[Service]
User=root
EnvironmentFile=/etc/default/wstuncli
ExecStart=/usr/local/bin/wstunnel cli -regexp $REGEXP -token $TOKEN -tunnel $TUNNEL -server $SERVER -logfile /var/log/wstuncli.log

[Install]
WantedBy=multi-user.target
~~~


Start the tunnel:

~~~
$ sudo systemctl start wstuncli.service
~~~


Check /var/log/wstuncli.log for errors
  * Messages indicating "WS Opening" and "WS Ready" and "Pinger starting" indicate success.

Enable the tunnel to automatically start on reboots:

~~~
$ sudo systemctl enable wstuncli.service
~~~


## Troubleshooting

* If the API endpoint(s) being accessed via the tunnel are using self-signed certificates, add the `-insecure` parameter to the call to `/usr/local/wstunnel` in the Upstart or Systemd file. 

* Similarly, if using the tunnel returns an X.509 error about "IP SANs", use the `-insecure` option.
