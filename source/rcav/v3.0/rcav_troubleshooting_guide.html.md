---
title: RightScale Cloud Appliance for vSphere (RCA-V) - Troubleshooting Guide
description: This guide is designed to help you troubleshoot common issues that you may experience while installing and maintaining a RightScale Cloud Appliance for vSphere (RCA-V).
---

## Overview

This guide is designed to help you troubleshoot common issues that you may experience while installing and maintaining a RightScale Cloud Appliance for vSphere (RCA-V).

## Knowing Your Environment

In order to successfully navigate through issues, you must have a proper understanding of your environment. Please refer to the [RCA-V Administrator Guide](rcav_administrator.html) for details of how the RCA-V fits into your vSphere environment.

Describing it very briefly, RCA-V sits in your vSphere environment and interacts with your vCenter Server.  Key pieces of information are:

| Credentials | Checked by | Set by | Storage | Purpose | Initial value | Comment |
| ----------- | ---------- | ------ | ------- | ------- | ------------- | ------- |
| unix 'root' password | unix login | disabled | /etc/shadow | there is no root login capability, following Ubuntu best practices | disabled | Fully disabled. Recommend not enabling |
| 'admin' password | unix login & nginx basic auth | admin UI | verifiers in /etc/shadow & /etc/nginx | authenticates customer admin for SSH and HTTP access | vscale2013@@ | recommend changing this initial value using admin UI |
| 'rightscale' password | nginx basic auth | admin UI | verifier in /etc/nginx | authenticates rightscale platform (GW) for HTTP access | disabled | Note: No SSH access for this user |
| 'services' password | unix login nginx basic auth | admin UI | verifiers in /etc/shadow & /etc/nginx | authenticates RS professional services for SSH and HTTP access | disabled | Customers should enable it for RightScale services as needed |
| wstunnel token | wstunsrv and wstuncli | admin UI | plain text in /etc/defaults/wstuncli | ensures tunnel uniqueness and obfuscates access to tunnel for defense in-depth | random value | check in wstuncli, split off in admin UI |
| tenant password | RCA-V | admin UI | obfuscated in /etc/vscale.conf | authenticate individual tenants' access to the cloud | disabled | new in 1.0 |
| vCenter user/password | vCenter server | admin UI | obfuscated in /root/.vscalerc | access to vCenter for managing resources | unset |	non-admin user recommended |

When everything is working fine, the following should happen:

* When powered on, RCA-V should come up without any issues.
* RCA-V should have at least one network interface (either with public or private IP address that has a route to the Internet).
* RCA-V should be reachable via Console (using vSphere client)
* RCA-V should be reachable via SSH (from within your firewall)
* RCA-V establishes an outbound tunnel to RightScale Platform

In the Admin UI, all Status ![status icon](/img/rcav-green-status.png) should be green.

## Troubleshooting - Frequently Asked Questions

### Is my appliance running?

**Suggestion**:

1. Log in to the vSphere client.
2. Look at the RightScale Adapter VM and verify that it's running. It should have an IP address assigned to it and you should be able to ping it from behind your network firewall.

### How come I can see the IP address on the RCA-V but I can't ping it?

**Suggestion**:

1. Log in to the vSphere client.
2. Go to **Edit Settings > Options > vApp Options > Properties**
3. Make sure all fields are properly configured. In the Hardware tab, make sure your network adapter is in the correct network and that you're pinging the appliance from a device on the same network.

### Why do I get a 502 error when I try to log in to the RCA-V console?

**Suggestion**:

This could be due to couple of reasons:

* IP address may not be reachable. (See the issue in the row above.)
* The Admin backend process may not be up -- If you suspect this to be the case, you can either restart the appliance (which will restart all processes) or you can SSH into the appliance, switch to the root user (`$ sudo su`) and then run the following command: `# service vscale-admin restart`

### Why do I get a 401 error when I try to log in to the RCA-V console?

**Suggestion**:

This is likely related to an authentication issue. If you have forgotten your password, you will have to use the vSphere client to log in to the appliance as the ‘root’ user. (*Note*: The ability to SSH into the instance as the 'root' user is not allowed.)

### I can log in to the RCA-V console but why is the cloud account's status red?

**Suggestion**:

There are several reasons why the status may be red instead of green:

![Cloud Status](/img/rcav-cloud-status-red.png)

A connectivity problem with the WebSocket tunnel between the RCA-V and RightScale platform could be a result of issues related to the **wstuncli** (tunnel client on the appliance) or **wstunsrv** (RightScale's tunnel server). Run the following UNIX command from a computer with Internet connectivity to make a request to the cloud's gateway controller.

~~~
$ curl -kvu 'rightscale:<your_password>' https://wstunnel10-1.rightscale.com/_token/<your_token>/gw/v1/acct/<your_tenant_name>/instance-types
~~~

If everything is working as expected you should get a JSON response with the defined instance types for the vSphere cloud. However, if you don't get a response or receive a connection error, it's probably a problem with **wstunsrv** (RightScale's tunnel server). Please inform RightScale immediately.

If there is an issue with **wstuncli** (tunnel client on the appliance), you will likely see the following response (see below) and need to restart **wstuncli**.

~~~
* Adding handle: conn: 0x7f83c3003a00
* Adding handle: send: 0
* Adding handle: recv: 0
* Curl_addHandleToPipeline: length: 1
* - Conn 0 (0x7f83c3003a00) send_pipe: 1, recv_pipe: 0
* About to connect() to wstunnel.test.rightscale.com port 443 (#0)
*   Trying 50.112.73.62...
* Connected to wstunnel.test.rightscale.com (50.112.73.62) port 443 (#0)
* TLS 1.2 connection using TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
* Server certificate: *.test.rightscale.com
* Server certificate: Go Daddy Secure Certification Authority
* Server certificate: Go Daddy Class 2 Certification Authority
* Server certificate: http://www.valicert.com/
* Server auth using Basic with user 'rightscale'
> GET /_token/your_token/gw/v1/acct/ut-tenant1/instance-types HTTP/1.1
> Authorization: Basic cmlnaHRzY2FsZTp2c2NhbGUyMDEzQEA=
> User-Agent: curl/7.30.0
> Host: wstunnel.test.rightscale.com
> Accept: */*
~~~

### How do I reset the tunnel or restart wstuncli (on the RCA-V)?

**Suggestion**:

There are two different ways to restart wstuncli.

1. (Recommended) Log in to the RCA-V console. Go to **Connectivity > RightScale Platform > RightScale Connection (wstunnel)**. Click the **Restart** button.
2. SSH in to the RCA-V instance (as 'rightscale') and switch to the 'root' user (`# sudo su`) and run the following UNIX command: `# service wstuncli restart`

### How do I register my vSphere cloud environment with RightScale?

**Suggestion**:

See [Register a vSphere Cloud with RightScale](rcav_register_vsphere_cloud.html).

### How long does it take for all of my images and instances to appear in the RightScale Cloud Management Dashboard after I've registered or added a vSphere cloud?

**Suggestion**:

Typically you should see your images and instances inside the RightScale Cloud Management Dashboard within a few minutes after adding a vSphere cloud environment to a RightScale account. Depending on the size of the cloud and the number of resources (e.g. running instances) you may need to wait 10 or more minutes before all of your resources are properly displayed in the Dashboard. If you think that it's taking longer than normal to display all of the resources, you can also manually (re)query the cloud's controller by logging in to the Dashboard and clicking the 'query' text link on the bottom of the **Clouds > Your vSphere Cloud > Instances** screen.

### How come I still do not see my images and instances even though it's been more than 10 minutes?

**Suggestion**:

If it looks like you are still not seeing your images and/or instances in the RightScale Cloud Management Dashboard even after you've manually re-queried the cloud controller (see previous row) and you have not received an error message, you may have connectivity problems (between your vSphere cloud environment and RightScale) or an incorrect cloud token.

*Check Connectivity*:

1. Log in to the RCA-V console. Go to **Connectivity > RightScale Platform > Overview**.
2. Make sure all statuses are green.

*Check Cloud Redez-vous Token*:

1. Use a command prompt from a computer with Internet connectivity and run the following command:

~~~
$ curl -kvu 'rightscale:<your_password>' https://wstunnel10-1.rightscale.com/_token/<your_token>/gw/v1/acct/<your_tenant_name>/instance-types
~~~

* If you get a successful response, it means the cloud's gateway is functioning as expected but RightScale doesn't have the correct information to connect to it. In such cases, you must make sure the cloud's gateway endpoint URL (that your RightScale account uses to connect to the vSphere cloud) is correct. For example, maybe the cloud's Rendez-vous token was changed in the RCA-V console after the cloud was registered with RightScale. In such cases, you must update the cloud's Endpoint URL in your RightScale account to match what is used in the vSphere's RCA-V. Log in to the RightScale Dashboard and go to **Settings > Administered Clouds > Your_Cloud > Edit** tab. Change the Endpoint URL accordingly. You may need to contact the person who manages the RCA-V in order to retrieve the correct cloud token.

* If the problem still persists, you must remove the cloud from your RightScale account and add it again. *Note*: Any running instances will not be terminated when you remove (disassociate) the cloud from your RightScale account. (See [Delete a Private Cloud Account from RightScale](/cm/dashboard/settings/account/delete_a_private_cloud_account_from_rightscale.html).) Once the cloud has been successfully re-added to the account with the correct Gateway URL, you will see the running instances once again in the RightScale Dashboard.

### Where are the log files for the processes running on the appliance?

**Suggestion**:

1. Log in to the RCA-V console and go to **Cloud Appliance Mgmt > System**.
2. In the Logs card you can see all of the RCA-V's log files. The key log files are:

`vscale.log`

`vscale-admin.log`

`wstuncli.log`

If you happen to login to the appliance directly (using SSH), you will find the log files in /var/log directory

### Why is my virtual machine (VM) stuck in a 'booting' state?

**Suggestion**:

There are several reasons that might cause a VM (instance) to become stranded in a 'booting' state.

* RightLink is not properly installed on the VM that was launched. Make sure you launch VMs with images that install RightLink.
* The RightLink agent fails to connect to the RightScale platform to "phone home" after the instance is running.​ Perhaps the VM does not have an outbound route to the Internet so that it can connect to RightScale. Maybe DNS is not set up properly or the public DNS server (such as 8.8.8.8) is not reachable.
* A script in the ServerTemplate's boot phase did not get executed or handled correctly.

### Why is the Cloud Controller status red (and not green)?

**Suggestion**:

When you check the status of the VMware vSphere cloud (**Settings > Account Settings > Clouds**) and the status of the Cloud Controller is red (as shown below), it means that the RightScale platform cannot properly connect to the RCA-V and/or related vSphere cloud.

![Cloud Controller Status](/img/rcav-cloud-status-controller-red.png)

There could be several issues that could cause this type of problem.

* RCA-V is not running
* RCA-V is not properly installed on the server. You may need to launch a new RCA-V server.
* The tenant (that the RightScale account was assigned) was deleted.
* vSphere environment no longer exists
* The RCA-V appliance cannot connect to the vSphere cloud's API endpoint.
  * Perhaps the network firewall permissions were changed
  * Maybe the 'RightScale' user was accidentally deleted inside the vSphere Client application or the permissions associated with the 'RightScale' role were changed and no longer satisfy the minimum set of requirements.
  * Perhaps the VMware vSphere cloud was deregistered and is no longer accessible via the RightScale platform.

See the [RCA-V Installation Guide](rcav_installation_guide.html).

### Why is the Cloud Account status red (and not green)?

**Suggestion**:

When you check the status of the VMware vSphere cloud (**Settings > Account Settings > Clouds**) and the status of the Cloud Account is red (as shown below), it means that there is a problem with your cloud's subscription.

![Cloud Controller Status](/img/rcav-cloud-status-account-red.png)

Invalid Cloud Subscription/Credentials. Please log a RightScale Support ticket or email [support@rightscale.com](mailto:support@rightscale.com).

### I get the GenericError: "SDRS recommendation not found for datastore cluster" when I launch a new Server. Why?

**Suggestion**:

The error simply means that the datastore being used does not have enough space available to launch a new Server. So you either need to clear up some space in your datastore or expand its size.

~~~
CloudExceptions::CloudException - Vscale::GenericError: SDRS recommendation not found for datastore cluster C7700_NPE_T_SCSI
~~~

See this [VMware KnowledgeBase Article](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1003412) for additional information.

### Datastore cluster can't be used as a storage for disks/snapshots

**Suggestion**:

Datastore cluster is not supported for snapshots. A volume snapshot can be created from a volume that is attached or that is not attached. An SDRS recommendation from vCenter is an operation on VMs. So there is no way to get an SDRS recommendation for an unattached volume so the datastore must be **explicit**.

If you edit the vscale.conf directly to set the Datastore Cluster, the following error will appear when committing the config which is expected:
~~~
"An error occurred: Datastore cluster can't be used as a storage for disks/snapshots. Please specify a particular datastore. (status 400)"
~~~

### Why am I getting different status, available and provisioned, when a volume is created in vSphere

**Suggestion**:

The volume state depends on the datastore location. So the following is true:

* If you create a volume on **datastore** - you'll get **available** state
* If you create a volume on **datastore cluster**, you'll get **provisioned** state

The explanation from the latter case is the volume status is set as **provisioned** because we can't create volume on a datastore cluster before getting a SDRS recommendation. The volume needs to be attach to an instance and during this process, that's where we get vSphere recommendation in placing the volume and after that, the volume state will be **available**. And after detaching the volume from an instance, it will show as unattached and available.

### Why am I getting **Time limit exceeded.** when attaching a volume. 

**Suggestion**:

* If you create a volume on **datastore cluster**, you'll get **provisioned** state
* When you attach the volume is when it creates the vmdk on the SDRS recommended datastore
* When Provisioning Mode: **eagerZeroedThick** is chosen. 

When you create a volume on an SDRS Cluster over a certain size via RCL it will exceed the timeout for the volume attach call. You will need to write some custom code in self service to bypass this. 
~~~
sub do
  provision(@volume1)
  sleep_until(@volume1.status =~ "provisioned")
  sub on_error: skip do
    provision(@volume_attachment1)
  end
  sleep_until(@volume1.status =~ "in-use")
end
~~~

### When I view a VMware instance, the private IP address is not always shown?

**Suggestion**:

The usual problem when this happens could be due to VMware Tools not working properly. Check if the instance is set to auto-update the VMware Tools and this process may be failing, leaving the VM without a running VMware Tools service. The vmware tools is an [image requirement](rcav_image_requirements.html) in order for RCA-V to retrieve the instance IP. If this is verified to be the issue, you can:
* Install/re-install the vmware tools on the instance or
* For a permanent fix, create a new vm template that has auto update disabled

### Why isn't the Volume Types tab loading in the RCA-V web UI?

**Suggestion**:

![RCA-V Volume Types Tab](/img/rcav-faqs-vol_types_tab.png)

If the Volume Types tab of the RCA-V appears to be "stuck" while loading, this is likely due to how permissions were applied to the VMware environment.  Verfiy the following:
* Ensure the correct [privileges](./rcav_prepare_vsphere_environment.html#vcenter-access-requirements-create-a-rightscale-role) were granted to the RightScaleRole 
* Ensure the RightScaleRole was [applied to the **vCenter** and propagated to child objects](./rcav_prepare_vsphere_environment.html#vcenter-access-requirements-assign-permissions-for-rightscale-to-the-vsphere-infrastructure) 

### Why aren't RightScale Instance names syncing with vSphere VM names? 

**Suggestion:** 
The RightScale to VMware name sync feature is only available on RCA-V v3.0 or newer. If you are running an earlier release then an error will be generated in the vscale log (/var/log/vscale/vscale.log), but no error will be returned to the audit entries in RightScale.  The recommended solution is to [upgrade to the v3.0 release](/rcav/v3.0/rcav_upgrade_to_3_0.html).

### Is the RCA-V patched against the Meltdown and Spectre vulnerabilities?  

**Suggestion:**
RCA-V versions `vscale-3.0-20170921-13` and older have not been patched to protect against these vulnerabilities.  The suggested action is to ssh into the appliance and apply the necessary patches to secure the system.