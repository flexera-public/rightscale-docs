---
title: Cloud Computing System Architecture Diagrams
description: Example diagrams depicting typical cloud computing system architectures commonly administered and managed using the RightScale Cloud Management Dashboard.
---

## Overview

Below you will find several sample diagrams of cloud-based solution architectures that you can build with the RightScale platform using both public and/or private cloud infrastructures. Most of these architectures can be built using existing ServerTemplates that are available in the MultiCloud Marketplace.

Each application is unique and will have a custom set of requirements. The purpose of the system architecture diagrams below is to provide you with real-world examples that you can use as base reference architectures when you design your own custom system architectures in the cloud. Once you find a system architecture that is similar to what you are trying to build, you can modify and customize it accordingly to meet your own project's requirements. The diagrams are designed to demonstrate a particular concept such as disaster recovery or multicloud deployments. When you are designing your own solution architectures you should consider integrating several of the concepts described below.

Get more details and additional reference architectures in our white paper: [Build Scalable Applications in the Cloud: Reference Architecture & Best Practices](http://www.rightscale.com/lp/building-scalable-applications-in-the-cloud-white-paper.php).

## Things to Consider

There are several factors that you need to take into consideration before designing your own cloud-based systems architecture, particularly if you're considering a multi-cloud/region architecture.

* **Cost** - Before you architect your site/application and start launching servers, you should clearly understand the SLA and pricing models associated with your cloud infrastructure(s). There are different costs associated with both private and public clouds. For example, in AWS, data transferred between servers inside of the same datacenter (Availability Zone) is free, whereas communication between servers in different datacenters within the same cloud (EC2 Region) is cheaper than communication between servers in different clouds or on-premise datacenters.
* **Complexity** - Before you construct a highly customized hybrid cloud solution architecture, make sure you properly understand the actual requirements of your application, SLA, etc. Simplified architectures will always be easier to design and manage. A more complex solution should only be used if a simpler version will not suffice. For example, a system architecture that is distributed across multiple clouds (regions) introduces complexity at the architecture level and may require changes at the application level to be more latency-tolerant and/or be able to communicate with a database that's migrated to a different cloud for failover purposes.
* **Speed** - The cloud gives you more flexibility to control the speed or latency of your site/application. For example, you could launch different instance types based on your application's needs. For example, do you need an instance type that has high memory or high CPU? From a geographic point of view which cloud will provide the lowest latency for your users? Is it necessary or cost effective to use a content distribution network (CDN) or caching service? For user-intensive applications, the extra latency that results from cross-cloud/region communication may not be acceptable.
* **Cloud Portability** - Although it might be easier to use one of the cloud provider's tools or services, such as a load balancing or database service, it's important to realize that if and when you need to move that particular tier of your architecture to another cloud provider, you will need to modify your architecture accordingly. Since ServerTemplates are cloud-agnostic, you can use them to build portable cloud architectures.
* **Security** - For MultiCloud system architectures, it's important to realize that cross-cloud/region communication is performed over the public Internet and may introduce security concerns that will need to be addressed using some type of data encryption or VPN technology.

## Example Reference Diagrams

The architecture diagrams below show a progression from simple to more complex reference architectures.

### Single "All-in-one" Server

Use one of the "All-in-one" ServerTemplates, such as the LAMP (Linux, Apache, MySQL, PHP) ServerTemplate to launch a single server that contains a web server (Apache), as well as your application (PHP) and database (MySQL). You'll find a collection of simple "All-in-one" ServerTemplates in the MultiCloud Marketplace, which are useful for new RightScale users and basic demos.

![cm-system-architecture-1.png](/img/cm-system-architecture-1.png)

### Single Cloud Site Architectures

In a standard three-tier website architecture, there is at least one dedicated server in each tier of the system architecture. (Load Balancing Server, Application Server, Database Server)

#### Non-Redundant 3-Tier Architecture

If you are only testing the interactivity between each tier of your architecture, you may want to use a non-redundant system architecture to save on costs and resources. Since it is a non-redundant system architecture it is primarily used for basic test and development purposes. In the example diagram below, there are dedicated servers for each tier of the application/site. A non-redundant architecture is not recommended for production environments.

![cm-system-architecture-2.png](/img/cm-system-architecture-2.png)

#### Redundant 3-Tier Architecture

Any production environment that is launched in the cloud should also have a redundant architecture for failover and recovery purposes. Typically, you will use a Server Array for your application tier to take advantage of autoscaling in the cloud, however there may be some scenarios where your application is not designed to autoscale. In such cases, you can still create a redundant multi-tier architecture where you have redundancy at each tier of your reference architecture. In the example below, there are two load balancer servers, two application servers, as well as master and slave database servers. A redundant architecture will help protect your site/application from system downtime.

This example diagram also demonstrates the use of a striped volume set at the database tier. If your database is large and requires faster backups, you may consider using a set of striped volumes for data storage.

![cm-system-architecture-3.png](/img/cm-system-architecture-3.png)

#### Multi-Datacenter Architecture

If your cloud infrastructure supports multiple datacenters (or zones), it's recommended that you spread your system architecture across multiple datacenters to add another layer of redundancy and protection. Each datacenter in a cloud is designed to be an isolated segment inside the same geographical cloud. So if a power failure occurs in one datacenter, the other datacenters will be unaffected. For example, within a cloud/region there may be several resource pools called availability zones and datacenters. The benefit of using multiple datacenters is to protect your entire site/application from being negatively affected by some type of network/power failure, lack of available resources, or service outtage that's specific to a particular datacenter.

As a best practice you should always leverage multiple datacenters in your reference architecture if they are supported by the cloud infrastructure. In the other reference architecture diagrams below, it's also recommended that you use multiple datacenters even though it's not explicitly shown in the diagrams.

!!info*Note:* Additional cloud charges may apply for data transferred between different datacenters.

![cm-system-architecture-4.png](/img/cm-system-architecture-4.png)

#### Autoscaling Architecture

One of the key benefits of the cloud is the ability to horizontally scale (i.e. grow or shrink the number of running server resources) as the demands of your application/site change over time. With RightScale, you can use Server Arrays to set up a particular tier of your architecture to autoscale based on predefined alert conditions. Autoscaling is most commonly used for the application tier of your cloud reference architecture.

![cm-system-architecture-5.png](/img/cm-system-architecture-5.png)

#### Scalable Architecture with Membase

If you do not want to use a Master-Slave MySQL setup, you could also use Membase (Couchbase) nodes for your database tier, which is a distributed NoSQL database, which replicates data across all of the Membase nodes. If you are using the Enterprise edition you can attach volumes to each node (shown below), but the Community Edition doesn't support the use of volumes.

![cm-system-architecture-7.png](/img/cm-system-architecture-7.png)

#### Scalable Multi-Tier Architecture with Memcached

For applications/sites that require lots of reads from the database and serve a lot of static content, you might want to add a Memcached layer to your cloud system architecture to offload a read-heavy database. Memcached is an open source distributed memory object caching system that's ideal for speeding up dynamic web applications by alleviating database load. In the example diagram below, the application servers can still make writes to the database, but many commonly used objects will be retrieved from one of the Memcached servers instead of the Master-DB server.

![cm-system-architecture-6.png](/img/cm-system-architecture-6.png)

#### Scalable Queue-based Setups

**(AWS only)**

RightScale's Grid Edition provides a back-end batch processing framework that provides a more efficient solution for processing a group of jobs (work units) by taking advantage of the scalable compute capacity of cloud computing infrastructures. Create a grid application that will scale based on the number of jobs in the queue or how long a sample of jobs has been in the queue.

**Number of Jobs**

This is the most common way to scale an application for batch processing is by the number of jobs in the queue.

![cm-rightgrid-number-jobs.gif](/img/cm-rightgrid-number-jobs.gif)

**Time**

Create a grid application that will scale based on time or how long a sample of jobs has been in the queue. In this setup, a sample of 10 items in the queue will be chosen at random. The server array will scale up based on the average age of items in the queue or by the age of the oldest item in the queue.

![cm-rightgrid-time.gif](/img/cm-rightgrid-time.gif)

**Internal Hybrid Setup**

If you already have an existing grid architecture or internal compute resources that you still want to use, you can create a hybrid model which will scale-up in an AWS region, when necessary. This setup gives you the flexibility of using internal resources while also letting you take advantage of the unlimited compute resources of the cloud.

![cm-rightgrid-internal-hybrid.gif](/img/cm-rightgrid-internal-hybrid.gif)

**Alert-based and Queue-based Scalable Setup**

Since you can attach multiple server arrays to the same deployment, you can also create a dual scalable architecture where you have a scalable front-end and back-end array.

![cm-site-grid-array-diagram.png](/img/cm-site-grid-array-diagram.png)

### Hybrid Cloud Site Architectures

Another way that you can protect your site/application in the cloud is to design a hybrid cloud site architecture that leverages multiple public/private cloud infrastructures or dedicated hosted servers. One of the key benefits of the RightScale platform is cloud portability, where you can use the same assets (ServerTemplates, RightScripts, etc.) to launch identically functioning servers into multiple public/private clouds. Avoid cloud lock-in and design a solution architecture that takes advantage of multiple cloud resource pools instead of just a single cloud. Similarly, you can also design a hybrid cloud architecture where servers in a cloud can communicate with dedicated servers that are hosted in an internal/external datacenter.

#### Scalable MultiCloud Architecture

In the example below, you're using one cloud infrastructure to host your site/application, but you've also set up a Server Array for autoscaling your application tier in a different cloud infrastructure. For example, you might use your own private cloud servers before incurring any costs associated with launching servers in public cloud infrastructures. The MultiCloud Architecture diagram below gives you the flexibility of primarily hosting your application in your private cloud infrastructure but also autoscale out into a public cloud for additional server capacity, if necessary.

![cm-system-architecture-9.png](/img/cm-system-architecture-9.png)

#### Failover MultiCloud Architecture

In the example diagram below, the same ServerTemplates and scripts are used to configure and launch functional servers into either Cloud X or Y. When you are designing your cloud system architecture across multiple clouds, there are several factors that you will have to take into consideration. In the example below, there is a running Slave-DB server that's serving as a "warm" backup, but it's replicating data with the Master-DB across the public, not private IP address. Remember, only servers within the same cloud infrastructure can communicate over a private IP address. However, if there is ever a problem or failure that would require you to switch clouds, a MultiCloud Architecture would allow you to easily migrate your site/application. Notice that the other tiers of the reference architecture have already been configured and are ready to be launched if you need to migrate your production environment from Cloud X to Cloud Y. It's important to remember that the clouds could be any combination of public/private cloud infrastructures that are enabled in a RightScale account.

![cm-system-architecture-8.png](/img/cm-system-architecture-8.png)

If you want to send/receive data in a secure manner between servers in two different clouds, you can use data encryption or a VPN wrapped around the public IP address since any data transmitted between different cloud infrastructures (except if they're both private clouds) is sent over the public IP. In the diagram below, data replication across the public Internet is sent between the servers in two different clouds over a secure VPN tunnel.

![cm-system-architecture-10.png](/img/cm-system-architecture-10.png)

#### MultiCloud Disaster Recovery Architecture

One of the key benefits of the RightScale management platform is that you automatically gain a multi-cloud disaster recovery solution simply by following best practices with our ServerTemplates. Remember, no cloud is disaster-proof. Servers and services will eventually go down so it's important that your system architecture is structured to handle various different disaster recovery scenarios. For example, what would happen if there was a sudden outage in the cloud in which your production environment is currently deployed? In the traditional dedicated hosting model, you are at the mercy of your service provider because your only option is to wait for your hosting company to fix the problem and get your servers back to an operational state. But in the cloud, if you have architected your site appropriately, you have the ability to respond immediately and recover your site yourself. For example, if you have launched your production environment using RightScale's published ServerTemplates, you'll be able to use those same ServerTemplates to launch identical servers across multiple clouds. So, if there is a major service outage in a cloud, you can rebuild your production environment by launching servers into a different cloud/region.

In the diagram below, the production environment is currently hosted in Cloud X. Primary (snapshot) backups are periodically being taken of the database. However, you can also take a manual LVM backup of the database to a supported cloud storage service (e.g. Remote Object Storage (ROS) such as an Amazon S3 bucket or Google Cloud Storage container. So, if you need to perform a database migration or there is a cloud outage, you can use the LVM backup to relaunch your database server into a different cloud/region. The LVM backup can then be used to-restore your database and re-establish a redundant database setup in the cloud of your choice. (Note: The LVM backup can either be used to restore the database to a volume or locally to an instance depending on whether or not the cloud supports the use of volumes and snapshots.)

![cm-system-architecture-13.png](/img/cm-system-architecture-13.png)

#### Cloud and Dedicated Hosting Architecture

Another type of hybrid cloud solution architecture is to leverage a public/private cloud's resources along with existing servers from an internal or external datacenter. For example, perhaps your company has strict requirements around the physical location of your database server because it contains sensitive user information or proprietary data. In such cases, even though the database cannot be hosted in a cloud infrastructure the other tiers of your application or site are not subject to the same levels of restrictions. In such cases, you can use the RightScale platform to build a hybrid system architecture using a virtual private network (VPN) solution to create a tunnel for secure communication across a public IP between cloud servers and dedicated servers.

![cm-system-architecture-11.png](/img/cm-system-architecture-11.png)
