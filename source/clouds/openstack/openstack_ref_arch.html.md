---
title: Reference Architecture
layout: openstack_layout_page
description: This page describes a sample architecture that covers the various aspects of an OpenStack cloud managed through RightScale including networking, OpenStack components, services, hardware configuration, and monitoring.
---

## Overview

Here is a sample architecture that covers the various aspects of an OpenStack cloud managed through RightScale including networking, OpenStack components, services, hardware configuration, and monitoring. Use can use this information as a guide in developing your own OpenStack architectures.

## Networking

* Neutron

## Adding OpenStack to RightScale

### Cloud Capabilities

When adding an OpenStack zone with basic networking and security groups to the RightScale Cloud Management (CM) Dashboard, the following cloud capabilities should be set:

* **Security Groups**: Enabled
* **Port Forwarding**: Disabled
* **Subnets**: Disabled
* **Multiple Subnets**: Disabled

## Components

### Keystone, Horizon, dnsmasq and MySQL Server

Runs the Cinder, Swift-Proxy, Glance, Nova-Network and Nova-Manage services. Provides image management, block storage, object storage proxy and compute management. This server has high I/O and network requirements. A RAID5 array provides improved disk I/O while still providing fault tolerance. 10Gb network configuration is recommended for the storage server to reduce instance and snapshot creation time.

#### Network

* 10Gb Private NIC
* 1-10Gb Public NIC

#### Disk Configuration

* RAID5

#### Expansion

* If block storage disk space becomes an issue, additional Cinder nodes can be added to increase space. Adding extra Glance servers can be used to reduce disk and network I/O on each Glance server.

### Swift-Object Nodes

Runs the Cinder, Swift-Proxy, Glance, Nova-Network and Nova-Manage services. Provides image management, block storage, object storage proxy and compute management. This server has high I/O and network requirements. A RAID5 array provides improved disk I/O while still providing fault tolerance. 10Gb network configuration is recommended for the storage server to reduce instance and snapshot creation time.

#### Network

* 10Gb Private NIC

#### Disk Configuration

* SSD RAID0

#### Expansion

Additional hypervisors should be added to a cluster in the event that that VMs cannot be launched due to hypervisor disk or memory capacity. Extra hypervisors can also be added to a cluster if VMs are running slow due to insufficient disk I/O.

## Example Hardware Configuration

| Component | Server | Disk Speed | Disk Size | CPU | Memory | Port Speed |
| --------- | ------ | ---------- | --------- | --- | ------ | ---------- |
| Management Server | osmanagement1 | 7.2K SATA | 500GB (2x 500GB SATA - RAID1) | Single 5310 | 8GB | 1Gb |
| Storage Server | oskvmfs1 | 15k SCSI | 3.6TB(7x 600GB 15k SCSI - RAID5) | Single 5310 | 8GB | 10Gb |
| Hypervisor | oskvm1 | SSD | 1.6TB (4x 400GB SSD - RAID0) | Dual X5650 | 48GB | 10Gb |
| Hypervisor | oskvm2 | SSD | 1.6TB (4x 400GB SSD - RAID0) | Dual X5650 | 48GB | 10Gb |

## Services

### Common

Juno source:  
 /etc/apt/sources.list.d/Juno.list  
 deb [http://ubuntu-cloud.archive.canonical.com/ubuntu](http://ubuntu-cloud.archive.canonical.com/ubuntu) precise-updates/Juno main

### Keystone

Packages:

* keystone
* python-keystone
* python-keystoneclient

Configuration Files:

* [http://privatecloudtools.s3.amazonaw...g/keystone.tgz](http://privatecloudtools.s3.amazonaws.com/OpenStack/Juno/Config/keystone.tgz)

### Nova

Packages:

* nova-api
* nova-cert
* nova-common
* nova-conductor
* nova-consoleauth
* nova-novncproxy
* nova-scheduler
* python-nova
* python-novaclient

Configuration Files:

* [http://privatecloudtools.s3.amazonaw...onfig/nova.tgz](http://privatecloudtools.s3.amazonaws.com/OpenStack/Juno/Config/nova.tgz)

### Neutron

Packages:
* python-neutron
* python-neutronclient
* neutron-common
* neutron-dhcp-agent
* neutron-l3-agent
* neutron-metadata-agent
* neutron-plugin-openvswitch
* neutron-plugin-openvswitch-agent
* neutron-server

Configuration Files:
* [http://privatecloudtools.s3.amazonaw...ig/neutron.tgz](http://privatecloudtools.s3.amazonaws.com/OpenStack/Juno/Config/neutron.tgz)

### Glance

Packages:
* glance
* glance-api
* glance-common
* glance-registry
* python-glance
* python-glanceclient

Configuration Files:
* [http://privatecloudtools.s3.amazonaw...fig/glance.tgz](http://privatecloudtools.s3.amazonaws.com/OpenStack/Juno/Config/glance.tgz)

### Cinder

Packages:
* cinder-api
* cinder-common
* cinder-scheduler
* cinder-volume
* python-cinder
* python-cinderclient

### Swift

Packages:
* python-swift
* python-swiftclient
* swift
* swift-proxy

### Nova-compute

Packages:
* nova-common
* nova-compute
* nova-compute-kvm
* python-nova
* python-novaclient

### Neutron-agent

Packages:
* python-neutron
* python-neutronclient
* neutron-common
* neutron-dhcp-agent
* neutron-l3-agent
* neutron-metadata-agent
* neutron-plugin-openvswitch
* neutron-plugin-openvswitch-agent

### Swift-object

Packages:
* python-swift
* python-swiftclient
* swift
* swift-account
* swift-container
* swift-object

## Monitoring Steps

Zenoss is recommended for OpenStack monitoring, but OpenStack monitoring is also possible with Nagios.
* For more information on Zenoss look here: [https://github.com/zenoss/ZenPacks.zenoss.OpenStackInfrastructure/blob/develop/README.mediawiki](https://github.com/zenoss/ZenPacks.zenoss.OpenStackInfrastructure/blob/develop/README.mediawiki)

