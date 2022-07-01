---
title: CAT Resources
description: This page contains a reference that explains what RightScale Cloud Management API 1.5 resources are available in Self-Service and how to use them.
version_number: "20160622"
versions:
  - name: 20161221
    link: /ss/reference/cat/v20161221/ss_CAT_resources.html
  - name: 20160622
    link: /ss/reference/cat/v20160622/ss_CAT_resources.html
  - name: 20131202
    link: /ss/reference/cat/v20131202/ss_CAT_resources.html
---

## Overview

This page contains a reference that explains what RightScale Cloud Management API 1.5 resources are available in Self-Service and how to use them.

### Referencing Cloud Management API 1.5

Generally speaking, Self-Service leverages resources in CM API 1.5 in the CAT language. Eventually, all such resources will be supported in CAT. However, some resources in CM API 1.5 would be onerous to use in CAT, so we are building special handling for some resources and some attributes.

### Using hrefs

Note that many resources in CAT use hrefs for attributes. Hrefs in RightScale are unique keys that point to a specific resource. Although most hrefs are formatted similar to a URL, they are not actually accessible URLs in RightScale and should be considered simply a primary key that is a string.

When using hrefs in CAT, it is important to note that CAT uses the same hrefs that are used by the API - *which are usually different than the actual href in your browser.* For example, if you were to navigate to the "us-east-1b" datacenter in your browser, you would see a URL similar to:

```
https://us-3.rightscale.com/acct/12345/clouds/1/datacenters/201889003
```

However, the proper href to use (via the API), is:

~~~
/api/clouds/1/datacenters/5K443K2CF8NS6
~~~

So, remember when using hrefs in CAT that you must use the API hrefs, which are frequently *only* available through the API.

### Attribute hrefs and Names using the find function

For many API resources, the API takes an href for an attribute. For example, note that the `Volumes.create` call in CM API 1.5 takes the parameter `datacenter_href`. In order to streamline the CAT authoring process, the CAT parser can use the `name` of the datacenter instead of its `href`. To use the name, simply omit the `_href` from the attribute.

So, for example, to use the AWS US-East availability zone "us-east-1b", you can either use the `name` of the datacenter, like this:

```ruby
resource "my_server", type: "server" do
  datacenter "us-east-1b"
  ...
end
```

Or you could use the `href` of the datacenter, like this:

~~~ ruby
resource "my_server", type: "server" do
  datacenter_href "/api/clouds/1/datacenters/5K443K2CF8NS6"
  ...
end
~~~

## Resources

Please reference the following table for which Resources are currently available in CAT and any special notes about their use. For more information about fields or valid values, including which are *required* for a given resource, please use the CM API 1.5 reference documentation.

### Field Inclusion

By default, all fields of a resource are sent in the API request to provision the resource. In the case that a field's value evaluates to the `null` keyword, it will not be included in the API request. This can be useful if you conditionally want to include fields in a resource, and have them be dependent on some user provided value. For example, one may decide to only include the `ssh_key` for a server if the user chose for it to be included by doing something akin to the following:

~~~ ruby
parameter "ssh_on" do
  label "Enable SSH"
  type "string"
  default "Yes"
  allowed_values "Yes", "No"
end

resource "my_server", type: "server" do
  name "my_server"
  ssh_key switch(equals?($ssh_on, "Yes"), "default", null)
end
~~~

In the above example, the `ssh_key` field will only be included on the resource if the user launching the app leaves the "Enable SSH" field set to "Yes".

### Common Attributes

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
name | yes | no |
description | no | no |

### credential

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
value | yes | no |

### instance

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
network | no | yes | The network will be used to filter all network-specific resources, such as subnets and security groups
datacenter | no | yes |
image | yes | yes |
instance_type | no | yes |
kernel_image | no | yes |
optimized | no | no |
ramdisk_image | no | yes |
security_groups | no | yes | *when using hrefs, use `security_group_hrefs`
ssh_key | no* | yes* | *required for some clouds, such as AWS
subnets | no | yes* | *when using hrefs, use `subnet_hrefs`
user_data | no | no |
volume_attachments | no | yes | *when using hrefs, use `volume_attachment_hrefs`
cloud_specific_attributes | no | no | Hash, see [CM API 1.5 Reference](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#create) for fields
associate_public_ip_address | no | no |
ip_forwarding_enabled | no | no |
placement_group | no | yes |

### ip_address

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
domain | no | no | AWS only. Valid values `ec2_classic`, `vpc`
network | yes | yes |

### ip_address_binding

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
instance | yes | yes |
public_ip_address | no* | yes | *not required if protocol, public_port, and private_port are set
public_port | no* | no | *not required if public_ip_address is set, otherwise required
private_port | no* | no | *not required if public_ip_address is set, otherwise required
protocol | no* | no | *not required if public_ip_address is set, otherwise required

### network

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
instance | yes | no |
cidr_block | yes | no |

### network_gateway

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
type | yes | no |
network | yes | yes | This field is used only to make an update call

### network_option_group

All[common attributes](#resources -common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
type | yes | no |
options | no | no

### network_option_group_attachment

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
network | yes | yes |
network_option_group | no | yes |

### placement_group

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |

### resource_group

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |

### route

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
destination_cidr_block | yes | no |
next_hop_network_gateway | no | yes | Must either include next_hop_network_gatway or next_hop_instance
next_hop_instance | no | yes | Must either include next_hop_network_gatway or next_hop_instance
route_table | yes | yes |

### route_table

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
network | yes | yes |

### security_group

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
network | no | yes |

### security_group_rule

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
protocol | yes | no | One of `tcp`, `udp`, `icmp`, or `all`
source_type | yes | no | May be a CIDR block or another SecurityGroup
security_group | no | yes | SecurityGroup to add rule to
direction | no | no | One of `ingress` or `egress`
cidr_ips | no | no | Required if `source_type` is `cidr_ips`
group_name | no | no | Required if `source_type` is `group`
group_owner | no | no | Required if `source_type` is `group`
protocol_details | no | no | Hash, see [CM API 1.5 Reference](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#create)
priority | no | no | (Azure only) Rules are evaluated based in priority order until a matching rule is found. Once a rule is found, no further rules are evaluated. The lower the value, the higher the priority. If left blank, RightScale will set a high priority with a gap of 100 from the previous priority.
action | yes | no | (Azure only -- not required for other clouds) Whether to allow or deny if rule matches. Valid values are 'allow' and 'deny'.

### server

All [common attributes](#resources-common-attributes). Additionally, all [instance](#resources-instance) attributes, plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
inputs | no | no |
multi_cloud_image | no | yes |
server_template | yes | yes |

### server_array

All [common attributes](#resources-common-attributes). Additionally, all [server](#resources-server) attributes, plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes|
server_template | yes | yes |
ssh_key | no* | yes* | *required for some clouds, such as AWS
array_type | yes | no |
datacenter_policy | no | no | Hash, see [CM API 1.5 Reference](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#create) for fields
elasticity_params | yes | no | Hash, see [CM API 1.5 Reference](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#create) for fields
state | yes* | no |  during provisioning

### ssh_key

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
name | yes | no |

### subnet

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
network | yes | yes |
cidr_block | yes | no |
cloud | yes | yes
datacenter | no | yes

### volume

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
datacenter | yes* | yes | *Required for all clouds except OpenStack
image | no | yes | Only supported in OpenStack
iops | no | no | Not available on all clouds
parent_volume_snapshot | no | yes |
placement_group | no* | yes | *Required for Azure Resource Manager
size | no* | no | The size of a Volume to be created in gigabytes (GB). Some Volume Types have predefined sizes and do not allow selecting a custom size on Volume creation.
volume_type | no | yes |

### volume_attachment

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
device | no | no |
instance | yes | yes |
volume | yes | yes |

### volume_snapshot

All [common attributes](#resources-common-attributes), plus:

Field Name | Required | Accepts _href | Notes
-----------|----------|---------------|-------
cloud | yes | yes |
parent_volume | no | yes |
