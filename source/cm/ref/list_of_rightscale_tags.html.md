---
title: List of RightScale Tags
layout: cm_layout
description: This is a list of tags that are used by RightScale for various processes and purposes, mostly for tracking by RightScale or daemon operation.
---
## Overview

This is a list of tags that are used by RightScale for various processes and purposes, mostly for tracking by RightScale or daemon operation. If you have questions about these tags, please contact _[support@rightscale.com](mailto:support@rightscale.com)_ with your questions. If you are unsure of a tag's proper usage, please do not add it to the instance without consulting support first.

Additionally, you can also manage cloud tags through RightScale. For more information, see [Use EC2 Tags in RightScale](/cm/rs101/tagging.html#how-rightscale-tags-and-cloud-tags-are-related).

## Tag Syntax

With these tags, the format for these tags is

**Namespace:Predicate=value**

## List of Tags

### Tags for Servers or Server Arrays

These tags are used by servers or server arrays:

| **Namespace** | **Predicate** | **Value** | **Description / Example** |
| ------------- | ------------- | --------- | ------------------------- |
| rs\_agent | http\_proxy | <_ip_>:<_port_> | **Description:**<br>Equivalent to setting `RS_http_proxy` userdata.<br>Signals to RightLink init scripts that they, and the RightLink agent, should proxy all HTTP traffic.<br>Setting is made available to child processes via `http_proxy` and `HTTP_PROXY` environment variables. With rightlink 6.3.2 and later, a user and password may also be included in the proxy url.<br>**Example:**<br>rs\_agent:http\_proxy=10.0.0.0:80<br>With RL 6.3.2...<br>rs\_agent:http\_proxy=`http://myuser:mypass@10.0.0.1:8080` |
| rs\_agent | http\_proxy\_user | <_user_> _or_ cred:<_credential_> | **Description:**<br>Allows setting the user to use along with the rs\_agent:http\_proxy and rs\_agent:http\_proxy\_password tags.<br>Its value can be either a plain text user or a reference to a [Credential].<br>It must be specified along with rs\_agent:http\_proxy\_password and may only be specified when rs\_agent:http\_proxy is specified as well.<br>**Example:**<br>rs\_agent:http\_proxy\_user=myuser<br>rs\_agent:http\_proxy\_user=cred:MY\_USER |
| rs\_agent | http\_proxy\_password | cred:<_credential_> | **Description:**<br>Allows setting the password to use along with the rs\_agent:http\_proxy and rs\_agent:http\_proxy\_user tags.<br>Its value can be a reference to a [Credential] which allows hiding the sensitive password value when viewing server or server array tags.<br>It must be specified along with rs\_agent:http\_proxy\_user and may only specified when rs\_agent:http\_proxy is specified as well.<br>**Example:**<br>rs\_agent:http\_proxy\_password=cred:MY\_PASS |
| rs\_agent | http\_no\_proxy | <_ip or host_> | **Description:**<br>Equivalent to setting `RS_http_no_proxy` userdata.  <br>Signals the RightLink agent that the listed hosts are exceptions to the proxy setting and should be contacted directly.<br>Setting is made available to child processes via `no_proxy` environment variable.<br>**Example:**<br>**Single IP Address:**  <br>rs\_agent:http\_no\_proxy=10.114.114.33<br>**Multiple IP Addresses:**<br>rs\_agent:http\_no\_proxy=10.114.114.33,10.11.11.3,10.1.1.3 |
| rs\_launch | type | auto | **Description:**<br>Automatically set on newly created server arrays.<br>Indicates to RightLink that the instance should be shutdown if it hasn't gone operational in less than 45 minutes.<br>Write a recipe that removes the tag to disable this behavior (or remove from dash if one off)<br>**Example:**<br>rs\_launch:type=auto |
| report | \* | \* | **Description:**<br>Use on servers and/or deployments to display custom information when generating a report.<br>**Example:**<br>report:type=staging |

[Credential]: /cm/dashboard/design/credentials/

### Tags for RightLink 6 and older

These tags are used for troubleshooting. They should only be used when advised by support.

| **Namespace** | **Predicate** | **Value** | **Description / Example** |
| ------------- | ------------- | --------- | ------------------------- |
| rs\_agent\_dev | log\_level | <_level_> | **Description:**<br>_RightLink 5.7 and older:_ Only DEBUG log level is supported, which is turned on when ANY rs\_agent\_dev tag happens to be set. This tag sets the debug level of both Chef recipes and the RightLink agent. Please note that a restart of the RightLink agent (service restart rightlink) is required for the tag to take effect if the tag was not set prior to boot.<br>_RightLink 5.8 and newer:_ This tag will affect the log level of Chef recipes and RightScripts only and not the RightLink agent itself. The tag is also now reread in every time Chef recipes or RightScripts are run. All log levels (FATAL, ERROR, WARN, INFO, and DEBUG) are supported. To set the log level of the RightLink agent itself you must now use the rs\_log\_level command line utility.<br>**Example:**<br>rs\_agent\_dev:log\_level=DEBUG |
| rs\_agent\_dev | break\_point | <_cookbook_>::<_recipe_> | **Description:**<br>Stop the boot run list before running the specified recipe.<br>**Example:**<br>rs\_agent\_dev:break\_point=db\_mysql::set\_up |
| rs\_agent\_dev | download\_cookbooks\_once | true, false | **Description:**<br>Download the cookbook repo only on launch -- don't reload every converge.<br>**Example:**<br>rs\_agent\_dev:download\_cookbooks\_once=true |
| rs\_agent\_dev | patch\_url | \* | **Description:**<br>Equivalent to setting RS\_patch\_url userdata.<br>**Example:**<br>rs\_agent\_dev:patch\_url=http://example.com |

### Tags for Instances

**Note** _: All rs\_\* tags are related to RightScale-oriented processes, and should only be used with RightScale published templates or images._

| **Namespace** | **Predicate** | **Value** | **Description / Example** |
| ------------- | ------------- | --------- | ------------------------- |
| server | uuid | <_RS\_UUID_> | **Description:**<br>Used for Load Balancer registration with APP<br>(lb\_\*::default sets it)<br>**Example:**<br>server:uuid=01-0KV5O1OPVDAF |
| server | private\_ip\__N_ | <_ip_> | **Description:**<br>_N_ is the interface order (starting with zero) as discovered by RightLink. Used for identifying a server's private IP addresses. Also used by iptables for opening ports to specific IPs to servers within the same subnet.  <br>(rightscale::default sets it)<br>**Example:**<br>server:private\_ip\_1=10.0.0.0 |
| server | public\_ip\__N_ | <_ip_> | **Description:**<br>_N_ is the interface order (starting with zero) as discovered by RightLink. Used for identifying a server's public IP addresses.<br>**Example:**<br>server:public\_ip\_1=<_Your\_Public\_IP_> |
| appserver | active | true | **Description:**<br>Used by database for opening port 3306 to all appservers<br>**Example:**<br>appserver:active=true |
| appserver | listen\_ip | #{node[:<_app_>][:<_ip_>]} | **Description:**<br>Use to supply the listening IP<br>**Example:**<br>appserver:listen\_ip=#{node[:app\_test][:10.0.0.0]} |
| appserver | listen\_port | #{node[:<_app_>][:<_port_>]} | **Description:**<br>Use to supply the listening port<br>**Example:**<br>appserver:listen\_port=#{node[:app\_test][:5984]} |
| memcached\_server | active | true | **Description:**<br>Indicates this server is an active Memcached server and available to service requests.<br>**Example:**<br>memcached\_server:active=tru |
| memcached\_server | cluster | #{node[:memcached][:<_cluster\_id_>]} | **Description:**<br>Indicates the Memcached cluster the server is part of.<br>**Example:**<br>memcached\_server:cluster=#{node[:memcached] [:3]} |
| memcached\_server | port | #{node[:memcached][:_tcp\_port_]} | **Description:**<br>Indicates the port Memcached is listening on.<br>**Example:**<br>memcached\_server:port=#{node[:memcached] [:16059]} |
| rs\_monitoring | state | active | **Description:**<br>Indicates that the state of the monitoring in the instance is active and configured with a server id corresponding to the instance's UUID.<br>**Example:**<br>rs\_monitoring:state=active |
| rs\_monitoring | security\_updates\_available | true | **Description:**<br>Indicates that security updates are available for the server and the rightscale::do\_security\_updates Chef recipe can be used to install the security updates. Once the updates are installed, this tag will be removed by the collectd plugin when it checks for updates the next time.<br>**Example:**<br>rs\_monitoring:security\_updates\_available=true |
| rs\_monitoring | reboot\_required | true | **Description:**<br>Indicates that a reboot is required for the installed security updates to take effect. This tag is removed once the server is rebooted and all security updates are applied.<br>**Example:**<br>rs\_monitoring:reboot\_required=true |
| rs\_login | state | user *or* active | **Description:**<br>Indicates that the instance has fetched and activated a login policy and is ready to receive push updates. The value determines how login works: with `user`, the instance is using [Managed SSH Login](/rl10/reference/rl10_managed_ssh_login.html) with RightLink 10.5.0 or higher so either the default login or custom login name should be used; and with `active`, the login name will just be `rightscale`.<br>**Example:**<br>rs\_login:state=user |
| loadbalancer | lb | <_pool\_name_> | **Description:**<br>Used for Load Balancer registration with APP. Also used by appserver for opening port 8000 to all LBs<br>(lb\_\*::default sets it)<br>**Example:**<br>loadbalancer:lb=default |
| loadbalancer | app | <_pool\_name_> | **Description:**<br>Used for App Server registration with LB. Also used for LB to request opening port 8000<br>(app\_\*::default sets it)<br>**Example:**<br>loadbalancer:app=default |
| loadbalancer | backend\_ip | <_ip_>:<_port_> | **Description:**<br>Used for Load Balancer registration with APP<br>**Example:**<br>loadbalancer:backend\_ip=10.0.0.0:5984 |
| database | active | true | **Description:**<br>Used by appserver to request opening port 3306<br>(db\_\*::default sets it)<br>**Example:**<br>database:active=true |
| rs\_dbrepl | slave\_instance\_uuid | #{node[:rightscale][:<_instance\_uuid_>]} | **Description:**<br>This tags the server as a slave database. This tag identifies this server as a DB slave.<br>**Example:**<br>rs\_dbrepl:slave\_instance\_uuid=#{node[:rightscale][:03-57EM7IF1DH892]} |
| rs\_decommissioning | delay | medium *or* long| **Description:**<br>This tag is used to extend the default time of 50 minutes for auto-terminating or auto-stopping instances stuck in decommissioning. 'medium' extends the time to 1 hour and 50 minutes. 'long' extends the time to 3 hours and 50 minutes <br>**Example:**<br>rs\_decommissioning:delay=long |
| rs_docker | host | JSON-encoded list of docker host information | The host tag has a value that is a JSON encoded list with the Docker engine ID, total memory, and number of CPUs. A RightScale instance will have this tag if it has the RightLink 10 Docker integration running. Here is an example of the host tag: `rs_docker:host=["XFFA:LPC3:7PJX:AEA5:DATR:ADDZ:AQGT:5N6S:WKK7:WNSI:6GI3:LZDE",3700,1]`. |
| rs_docker | c-<container-id> | JSON-encoded list of container information | The container tag has a predicate starting with `c-` and followed by the Docker container ID and the value is a JSON encoded list with the Docker container name, Docker image ID, committed memory, and CPU allocation. When the RightLink 10 Docker integration is running, a RightScale instance will have a container tag for each Docker container that is currently running on it. Here is an example of a container tag: `rs_docker:c-860f61b2621568556442b1c13eafba0f0f01f4654c4e86407982cd8dfbf4e65b=["/naughty_morse","eb4a127a1188a3e274eb38f079c5e11680b942927956a38b9b6b6c6736e14fd2",0,0]`.
| rs_docker | i-<imaged-id> | JSON-encoded list of image information | The image tag has a predicate starting with `i-` and followed by the Docker image ID and the value is a JSON encoded list with the Docker image name. When the RightLink 10 Docker integration is running, a RightScale instance will have an image tag for each Docker image that has been downloaded to it. Here is an example of an image tag: `rs_docker:i-eb4a127a1188a3e274eb38f079c5e11680b942927956a38b9b6b6c6736e14fd2=["nginx:latest"]`.|

For more information on RightScale's docker integration, see [RightLink 10 Docker Support](/rl10/reference/rl10_docker_support.html)

### Tags for EBS Backup

| **Namespace** | **Predicate** | **Value** | **Description / Example** |
| ------------- | ------------- | --------- | ------------------------- |
| rs\_backup | lineage | \* | **Description:**<br>Lineage name of the backups<br>**Example:**<br>rs\_backup:lineage |
| rs\_backup | stripe\_id | <_#_> | **Description:**<br>Unique identifier for a striped backup (all snapshots of the same backup will share this stripe\_id)<br>**Example:**<br>rs\_backup:stripe\_id=20090930214316 |
| rs\_backup | timestamp | <_#_> | **Description:**<br>UTC since epoch in seconds<br>**Example:**<br>rs\_backup:timestamp=1377706990 |
| rs\_backup | committed | true | **Description:**<br>Some contents if there was an API call to "commit" that snapshot<br>**Example:**<br>rs\_backup:committed=true |
| rs\_backup | count | <_#_> | **Description:**<br>Number of snapshots in the backup<br>**Example:**<br>rs\_backup:count=9 |
| rs\_backup | device | /dev/sdc | **Description:**<br>Indicates the device the snapshot was taken from.<br>**Example:**<br>rs\_backup:device=/dev/sdc |
| rs\_backup | position | <_#_> | **Description:**<br>Indicates the position in the stripe set the snapshot was taken from.<br>**Example:**<br>rs\_backup:position=5 |

If you have any questions about these tags, please contact support at _[support@rightscale.com](mailto:support@rightscale.com)._ We ask that you do not implement tags unless you are sure of their actions and results from adding those tags. Any tags needed for monitoring or logging will be added automatically by their respective scripts.
