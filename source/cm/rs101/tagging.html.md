---
title: Tagging
layout: cm_layout
description: A tag or machine tag in the context of the RightScale Cloud Management Platform is a useful way of attaching useful metadata to an object/resource.
---
## What is a Tag?

A **tag** or **machine tag** is a useful way of attaching useful metadata to an object/resource. Tags are commonly used as an extra label or identifier. For example, you might want to add a tag to an EBS Snapshot or AMI so that you can find it more quickly. 

## Machine Tags vs. Raw Tags

**Note**:  Please keep in mind the differences in syntax between **machine tags** and **raw tags**. Tagging may fail due to incorrect syntax.

### Machine Tags
RightScale tagging's advanced functionality can be unlocked when a tag is comprised of three parts: namespace, predicate and value. Colons [:] are used to separate namespaces and predicates whereas equal signs [=] separate predicates and values.

Valid machine tags must be in the form of `<namespace>:<predicate>=<value>` -- all three components of the tag are **required** for machine tags. For example `it8n:enabled=true`. If you don't use this syntax, for example `it8n:enabled`, the tag will not be created and you will receive an error. 

Example: `loadbalancer:lb=www` (a load balancer server for the 'www' vhost)

* **namespace** - Namespaces must begin with any character between a-z; remaining characters may be a-z, 0-9 and underscores. Upper-case letters are invalid in the namespace.
* **predicate** - Predicates must begin with any character between a-z or A-Z; remaining characters may be a-z, A-Z, 0-9 and underscores. Predicates are case-insensitive.  A machine tag predicate may contain spaces, but cannot have a leading or trailing space.  `this:has spaces in it=true` is an example of a valid tag, where `this: has leading spaces in the predicate=true` would not be a valid tag.
* **value** - Values may contain most standard characters including spaces. Values do not have to be wrapped in quotes. (e.g. "rs_backup:lineage=somevalue")

**Example Syntax:**

    `namespace:predicate=value`

### Raw Tags

Raw tags can be created using any character `a-z` and `0-9`, but must not contain the characters `:` or `=`. For example, a valid raw tag is `it8nenabled`. An invalid example is `it8n:enabled`, the reason being that on the backend, it looks like you're trying to create an invalid machine tag, and we will give you an error.

**Example Syntax:**

    `value`
    

## RightScale's Tagging System

RightScale uses [Flickr-style machine tagging](https://www.flickr.com/groups/api/discuss/72157594497877875/) inside the RightScale platform. Tags are specific to a RightScale account. They are not user-specific. Tags are also global, so if you add tags to a private MultiCloud Image and later publish that image, everyone will see the tags. In order to add/edit/delete tags, you will need 'actor' privileges for that RightScale account.

Currently, you can create tags for the following objects/resources:

- [Accounts](/ca/using_account_tags.html)
- Servers
- Server Arrays
- Instances
- ServerTemplates
- Deployments
- EBS Spapshots
- EBS Volumes
- MultiCloud Images\*
- Reports

\* Tags can only be added to a MultiCloud Image by the owner of the MultiCloud Image. The owner of an EC2 Image is based on the AWS Account Number, not a RightScale account.

### How Does RightScale Use Tags?

We use tagging in our ServerTemplates by using the RightLink agent to facilitate communication between related servers. For example, instead of using DNS lookup and SSH to establish communication between application servers and load balancers, we can use tags to quickly resolve this information internally without having to make any requests to third parties.

### How Can I Use Tagging Inside the RightScale Platform?

The support for tagging and its implementations will continue to evolve over time. Currently, the primary use of tags is for filtering purposes. You can then use the Dashboard GUI or RightScale API to filter and search through tagged items.

* **RightScale Dashboard** - Add/Remove tags to RightScale objects and cloud resources under their respective show pages or Info tabs. You can add multiple tags per object/resource. You can then filter by 'tag' to quickly find all of your tagged resources.
* **RightScale API** - Similar to the Dashboard, you can use the Rightscale API to add/remove tags to a resource. You can also search tags for a resource and search for all resources (within a particular type) matching given tags. See the [API documentation for 'Tags'](http://reference.rightscale.com/api1.5/resources/ResourceTags.html) for more details.

**Note**: Tag searches are case sensitive.

### Tag Inheritance

Generally speaking, tags are only applied to the resource that is tagged. However, there are a couple of special behaviors that allow for tags to be inherited by sub-resources:

* **Server** - Tags on a Server are applied to any instance launched from that Server **at the time the server is launched**. This allows you to pre-define tags on a Server and ensure that any instance launched will have those tags applied.
* **MultiCloud Images** - Tags on MultiCloud Images (MCIs) are applied to any instance launched using that MCI **at the time the server is launched**. This allows you to set up tags on MCIs in proxy environments or other situations where you can control the MCIs more tightly than the Servers. (Actors can not modify MCIs, but can modify Servers -- Designer privilege is required for modifying MCIs).

## How RightScale Tags and Cloud Tags are Related

Many clouds provide native tagging systems for various resources in their cloud. Users with existing instances can manage all their cloud tags through RightScale so they can take full advantage of our reporting and billing features and manage those tags in RightScale without any additional work. With our powerful query interface, administrators can perform wildcard or intersection searches and return extra information about tagged resources. Users will also have the advantage of managing their tags -- either cloud tags or RightScale tags -- through either RightScale's Dashboard or the clouds' native console. The sections below describe this behavior for the various clouds.

### AWS EC2 Instance Tags

Your EC2 tags for instances will be discovered when you add your AWS credentials to the RightScale Dashboard, and will continue to sync any tags created from the EC2 console. Tags that originate in EC2 will show in RightScale with the namespace `ec2`. In order to sync tags from RightScale to EC2, create a tag with the `ec2` namespace, such as `ec2:<key>=<value>`. The discovery happens continuously and automatically. Note that EC2 does have a 10 tag limit that applies here, so keep that in mind when syncing your tags.

For more information on AWS tags, see [the AWS documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html)

#### AWS Name Sync with Instance Name

RightScale will sync EC2 instance names to RightScale Server or Instance nicknames bi-directionally with instances provisioned on AWS. When a new server is provisioned then launched from the RightScale dashboard, the server or instance nickname you entered in RightScale is over-written by the instance tag name (`ec2:Name`) from EC2 if one exists. Similarly, if you add a tag of the form `ec2:Name=<my-instance-name>` and then launch the server, the server/instance name displayed in the Dashboard will be synched with the tag value. Once the server instance is terminated, the original server/instance nickname you created in RightScale is re-established. Finally, if you begin managing a previously **existing** EC2 instance in RightScale, the server/instance name displayed in RightScale will be initially set to the value of the existing instance tag name (`ec2:Name`) in EC2.

#### Add EC2 Tags in the RightScale Dashboard
1. In the RightScale Dashboard, go to a deployment with an operational server and click on the running server.
2. From the Info tab, scroll down to to the tags field.
3. Click Edit Tags -- you will be able to remove the current tags of the instance as well as add tags.
4. When adding an EC2 tag, make sure the syntax is `name:predicate=value` and the name is `ec2`. For example: `ec2:stack=production`
5. Click Add.
6. The tag will be applied to the server and will can be viewable in the RightScale Dashboard as well as the AWS Management Console. Similarly, you can view and add RightScale and EC2 tags in the AWS Management Console that will influence your instance.

!!info*Note:*The `rs_tag` utility for RS-EC2 tag syncing is not supported at this time.

### GCE Instance Tags

Google Compute Engine supports instance tags as plain strings which are commonly used for networking-related tasks -- these tags are synced with RightScale tags as well. When a tag is discovered in GCE, it is imported into RightScale with the tag namespace of `gce`. In order for a tag in RightScale to be synced to GCE, it similarly must have the namespace `gce`. All characters following the `:` after the namespace will be synced to GCE. For example, the tag `gce:mytag` will show in GCE as `mytag`. Since GCE tags support limited characters, if you attempt to create a tag in RS starting with `gce:` and then use any disallowed characters, you will get an error message and the tag will not be created.

Note that in GCE, instance tags are used for a variety of purposes, including specifying Firewall Rules and network Routes. When modifying tags associated with an instance, take extra care in determining the network impacts of such a change.

### Azure Resource Manager (ARM) Tags

The following [RightScale Resources](../../clouds/azure_resource_manager/reference/resources.html) support tag sync to the cloud: 
- Placement Groups (Storage Accounts in ARM)
- Instances/Servers (Virtual Machines in ARM)
- Deployments (Resource Groups in ARM)

When a tag is discovered in ARM, it is imported into RightScale with the tag namespace of `azure`. Likewise, a tag in RightScale will be synced to ARM if it has the namespace `azure`. All characters following the `:` after the namespace will be synced to ARM. For example, the RightScale tag `azure:name=value` will show in ARM as `name:value` and a tag in ARM of `name:value` will show in RightScale as `azure:name=value`.

Please be aware that certain limitations exist with regards to tag length and limits on certain resources. For more information, see the [Azure Resource Manager (ARM) Tag Synchronization](../../clouds/azure_resource_manager/reference/tagging.html) documentation.
