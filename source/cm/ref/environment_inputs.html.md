---
title: Environment Inputs
layout: cm_layout
description: A description of the selectable pre-defined Environment Variables in the RightScale Cloud Management Platform including examples.
---

## Selectable Environment Variables

There are several pre-defined Environment Inputs (sometimes referred to loosely as simply "environment variables") at your disposal when writing or editing any RightScripts.

When editing inputs (Inputs tab), the following cloud-specific and RightScale-specific environment variables can be chosen when the 'Env' input type is selected. Once you've selected which environment variable you're going to use (e.g. RS_SKETCHY), you will also need to select from which Server (e.g. ebs-db1) the environment variable will be retrieved. You will be able to select any Server in the current Deployment regardless of whether the Server is active/inactive.

![cm-environment-variables.png](/img/cm-environment-variables.png)

The following list defines each EC2 and RightScale pre-defined variable. When applicable, the name, description, view from the dashboard and an example are included for each variable.

### Amazon (EC2):

#### EC2_AMI_ID

Amazon Machine Image ID number. This is a unique identifier for each image that Amazon publishes. RightScale uses base AMIs to build RightImages<sup>TM</sup>, which can be easily configured to meet your needs. We maintain our own mirrors with RightImages, etc.

From the Dashboard (Ec2 Info) you will see this EC2_AMI_ID value within parenthesis as part of the "Image" name.

Example: `ami-d8a347b1`

#### EC2_AKI_ID

Amazon Kernel Image ID. Although the kernel image is displayed and selectable within the RightScale Dashboard, the "default" is typically used by RightScale customers when building out deployments, etc.

From the Dashboard (Ec2 Info) you will see this EC2_AKI_ID value within parenthesis as part of the "Kernel Image" name.

Example: `aki-9b00e5f2`

#### EC2_ARI_ID

Amazon Ramdisk Image ID that was used when launching the instance (if applicable). Although the ramdisk image is displayed and selectable within the RightScale Dashboard, it is rarely (if ever) used by RightScale customers when building out server deployments, etc.

#### EC2_AMI_MANIFEST_PATH

The directory/file name path to the AMI Manifest XML file. Includes the base image and version number within it.

Example: `rightscale_images/CentOS5_0V3_0_0.img.manifest.xml`

#### EC2_AVAILABILITY_ZONE

The availability zone within a given EC2 Region. This information is both displayed from the Info tab and selectable (via drop-downs during the design/manage process) from within the RightScale Dashboard.

Examples: `us-east-1a, us-east-1b, us-east-1c`

#### EC2_HOSTNAME

Fully qualified hostname of the Amazon EC2 instance. This is the equivalent of the EC2_LOCAL_HOSTNAME. It is kept for backwards compatibility reasons.

Example: `domU-12-31-38-00-34-27.compute-1.internal`

#### EC2_INSTANCE_ID

This is a unique identifier for each launched instance. It is assigned by AWS. When using our RightScripts or our API, this is how you identify a specific running instance, and perform operations against it.

The RightScale Dashboard displays this value as the "AWS id" on the Server's Info tab (EC2 Info section).

Example: `i-baad23d3`

#### EC2_INSTANCE_TYPE

The type of instance. Amazon EC2 supports several instance types, that reflect the amount of CPU, memory and disk resources.

From the RightScale Dashboard, you can select several values depending on your compute and disk requirements. You can also scale up or down later in your deployment if need be. The Dashboard refers to this value as the "Instance Type".

Examples: ` m1.small, m1.large, m1.xlarge, c1.medium, c1.xlarge`

#### EC2_LOCAL_HOSTNAME

Fully qualified hostname of the Amazon EC2 instance. This is an internal hostname that is the equivalent of the output of the Unix `hostname `command on the instance, with the Amazon internal domain name appended to it. This is a fully qualified local hostname, similar to the EC2_HOSTNAME.

The RightScale Dashboard displays this value as the "Private DNS name" on the Server's Info tab.

Example: `domU-12-31-38-00-34-27.compute-1.internal`

#### EC2_PUBLIC_HOSTNAME

The fully qualified public hostname.

From the Dashboard, this is displayed as the "Public DNS name". This is public as the name implies, and the hyperlink from the info tab should render in your browser (for example, an Apache website or a Rails web application).

Example: `ec2-75-101-247-165.compute-1.amazonaws.com`

#### EC2_PUBLIC_IPV4

The publicly routable IPv4 Ip address of the instance.

Note this IP address is used in the formatting of the EC2_PUBLIC_HOSTNAME.

Example: `75.101.247.165`

#### EC2_RESERVATION_ID

Displayed in the Dashboard as the "Reservation" from the Info Tab (Ec2 section).

Example: `r-ae2090c7`

#### EC2_SECURITY_GROUPS

List of all EC2 Security Groups. (Notice the plural. AWS allows multiple security groups when launching an image, whereas RightScale supports one. Hence for RightScale deployments, this will be a "list" of one.)

Examples: `default, ``staging `or` splunktest`

### RightScale (RS):

#### INSTANCE_ID

The cloud controller's unique identifier for the running instance (for an EC2 instance, the return value will match the EC2_INSTANCE_ID environment variable. Example 1874519).

#### PRIVATE_IP

The private IP of the server.

#### PUBLIC_IP

The public facing IP address for the instance.

#### DATACENTER

The cloud controller's unique identifier for the data center this instance is running in (Availability Zone for EC2).

#### RS_EIP

RightScale Elastic IP address as issued by Amazon EC2. This is a static, publicly routable IP address.

From the Dashboard, navigate to Clouds -> AWS Region -> Elastic IPs to see any allocated elastic IP addresses. (Note: They are free of charge when in use, allocated but unused IP addresses are charged by Amazon.)

Example: `75.101.242.174`

#### RS_SERVER

RightScale server name.

What RightScale customers navigate to when using the RightScale Cloud Management Platform. (e.g. `https://my.rightscale.com`)

Example: `my.rightscale.com`.

#### RS_SKETCHY

RightScale Sketchy servers. Sketchy is used to display the data assembled from the "`collectd`" monitoring daemons.

See the Deployment Monitoring tabs in the RightScale Cloud Management Dashboard to view built-in monitoring tools.

Example: `sketchy1-5.rightscale.com`.

#### RS_TOKEN

RightScale Token. 32 character alphanumeric string.

Example: `32303f49fac8fa79bb6141210a7538ef`

#### RS_SERVER_NAME\*

RightScale Server Name.

From within the RightScale Dashboard page, this value is displayed in the "Nickname" column.

Example: `GregDoes Album`

#### RS_DEPLOYMENT_NAME\*

RightScale Deployment Name.

From within the RightScale Dashboard page, this value is displayed as "Deployment <u><em>DeploymentName</em></u>". Where <u><em>DeploymentName</em></u> is an action link you can click into to view and manage details of the deployment itself.

Example: `Modified LAMP Test`

#### RS_SERVER_TEMPLATE_NAME\*

RightScale Server Template Name.

From within the RightScale Dashboard page, this value is displayed in the "Server Template" column.

Example: `LP Stack`

#### RS_INSTANCE_UUID

Universally-unique identifier for this server incarnation. Unique across all clouds, partitions, and guaranteed to change after a bundled boot or stop/start operation. Can be used as a sketchy hostname identifier.

`*  `All environment variables are directly available in the instance with the exception of RS_SERVER_NAME, RS_DEPLOYMENT_NAME and RS_SERVER_TEMPLATE_NAME. They can only be evaluated as part of a RightScript. For example, you could use a variable such as RSDEPLOYNAME in a script, then assign it the RS_DEPLOYMENT_NAME in the env dropdown list for Inputs.

#### Non-selectable Environment Variables

There are also several other environment variables that are used for internal, RightScale purposes only. The following inputs will not be identified as user-defined inputs of a script, nor will they appear as selectable 'Env' input variables when defining input parameters. These environment variables are populated by the RightLink agent immediately before executing every RightScript.

#### RS_ATTACH_DIR, ATTACH_DIR

The filesystem directory where files attached to this RightScript can be found.

#### RS_DISTRO, RS_DIST

On Linux instances, it's the name of the Linux distribution, e.g. "centos", "ubuntu", or "redhatenterpriseserver". Always lowercase with no punctuation.

#### RS_REBOOT

If defined, it indicates that this particular RightScript was successfully executed on the instance. Covers the following cases:  
 - Scripts that ran on a prior boot  
 - Scripts that ran before this image was bundled (for user-bundled images)  
 - Scripts that ran before this instance was stopped/started (on EC2)

This variable is <u>only available for boot scripts</u>; it should be undefined for all operational and decommission scripts.

#### RS_ARCH

Instance CPU architecture, e.g. "i386" or "x86_64".

## See also

- [EC2 Metadata](/clouds/aws/amazon-ec2/aws_metadata.html)
- [How can I export AWS environment variables to the Shell?](/faq/clouds/aws/How_can_I_export_AWS_environment_variables_to_the_shell.html)
