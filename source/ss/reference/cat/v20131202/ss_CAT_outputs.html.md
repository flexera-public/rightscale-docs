---
title: CAT Outputs
description: This page provides a reference for the Outputs that are available for various resources with Self-Service.
version_number: "20131202"
alias: ss/reference/ss_CAT_outputs.html
versions:
  - name: 20161221
    link: /ss/reference/cat/v20161221/ss_CAT_outputs.html
  - name: 20160622
    link: /ss/reference/cat/v20160622/ss_CAT_outputs.html
  - name: 20131202
    link: /ss/reference/cat/v20131202/ss_CAT_outputs.html
---

## Overview

This page provides a reference for the Outputs that are available for various resources with Self-Service.

## Example

Here is an example of using an output to display the instance type of a Server:

~~~ ruby
output "instance_type" do
  label "Instance type"
  category "Cloud"
  default_value @my_server.instance_type
  description "Instance type that is running"
end
~~~

All resources contain an `href` Output which is the API href for the resource.

## Available Outputs

### Credential

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
value | Attribute: value |

### IP Address

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
address | Attribute: address |

### IP Address Binding

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
ip_address | Link: IpAddress: address |
instance | Link: Instance: name |

### Server

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
state | Attribute: state | 'queued', 'bidding', 'stranded'
cloud | Attribute: CurrentInstance: Link: Cloud: name |
instance_type | Attribute: CurrentInstance: Link: InstanceType: Attribute: name |
datacenter | Attribute: CurrentInstance: Link: Datacenter: name |
image | Attribute: CurrentInstance: Link: Image: name |
image | Attribute: CurrentInstance: Link: Image: name |
public_ip_address | Attribute: CurrentInstance: public_ip_addresses: Array.first | Since a server may have multiple public IPs, this shows only the first
private_ip_address | Attribute: CurrentInstance: private_ip_addresses: Array.first | Since a server may have multiple private IPs, this shows only the first

### Instance

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
state | Attribute: state |  this list may not be complete - please notify us if you see other states
cloud | Link: Cloud: name |
instance_type | Link: InstanceType: name |
datacenter | Link: Datacenter: name |
image | Link: Image: name |
public_ip_address | Attribute: public_ip_addresses: Array.first | Since a server may have multiple public IPs, this shows only the first
private_ip_address | Attribute: private_ip_addresses: Array: first | Since a server may have multiple private IPs, this shows only the first

### Network

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
instance_tenancy | Attribute: instance_tenancy |
cidr_block | Attribute: cidr_block |
is_default | Attribute: is_default |
resource_uid | Attribute: resource_uid |

### Network Gateway

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
resource_uid | Attribute: resource_uid |
state | Attribute: state |
description | Attribute: description |
type | Attribute: type |

### Network Option Group

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
resource_uid | Attribute: resource_uid |
description | Attribute: description |
type | Attribute: type |
options | Attribute: options |

### Network Option Group Attachment

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
network_option_group | Attribute: network_option_group |
resource_uid | Attribute: resource_uid |

### Placement Group

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
resource_uid | Attribute: resource_uid |
state | Attribute: state |

### Resource Group

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
resource_uid | Attribute: resource_uid |
state | Attribute: state |

### Route

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
description | Attribute: description |
destination_cidr_block | Attribute: destination_cidr_block |
next_hop_type | Attribute: next_hop_type |
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
resource_uid | Attribute: resource_uid |
state | Attribute: state |

### Route Table

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
created_at | Attribute: created_at |
updated_at | Attribute: updated_at |
resource_uid | Attribute: resource_uid |

### Security Group

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
cloud | Link: Cloud: name |
description | Attribute: description |
resource_uid | Attribute: resource_uid |

### Security Group Rule

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
cidr_ips | Attribute: cidr_ips |
cloud | Link: Cloud: name |
description | Attribute: description |
direction | Attribute: direction |
end_port | Attribute: end_port |
group_name | Attribute: group_name |
group_owner | Attribute: group_owner |
group_uid | Attribute: group_uid |
icmp_code | Attribute: icmp_code |
icmp_type | Attribute: icmp_type |
protocol | Attribute: protocol |
source_type | Attribute: source_type |
start_port | Attribute: start_port |
resource_uid | Attribute: resource_uid |  

### Server Array

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
state | Attribute: state | enabled, disabled
instances_count | Attribute: instances_count | enabled, disabled
cloud | Attribute: NextInstance: Link: Cloud: name | enabled, disabled
datacenter | Link: Datacenter: name | enabled, disabled

### Ssh Key

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
resource_uid | Attribute: resource_uid |

### Subnet

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
description | Attribute: description |
cidr_block | Attribute: cidr_block |
is_default | Attribute: is_default |
resource_uid | Attribute: resource_uid |
visibility | Attribute: visibility |
state | Attribute: state |

### Volume

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
size | Attribute: size |
status | Attribute: status |
cloud | Link: Cloud: name |
datacenter | Link: Datacenter: name |
volume_type | Attribute: volume_type: name |

### Volume Attachment

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
volume | Link: Volume: name |
instance | Link: Instance: name |
state | Attribute: state | "queued", "failed", "attaching", "attached", "detaching", "detached"

### Volume Snapshot

Output Name | Semantic to Derive Value | Notes
----------- | ------------------------ | -----
name | Attribute: name |
size | Attribute: size |
state | Attribute: state | 'pending', 'available', 'in-use', 'deleting', 'deleted'
cloud | Link: Cloud: name |
volume | Link: Volume: name |
