---
title: Understand Network Protocols and Ports Used by RightScale
layout: cm_layout
description: A helpful table listing the Network Protocols used by RightScale.
---

## Network Protocols Used by RightScale

| **Number** | **Traffic Type** | Network Protocol | Description of Service | Traffic Direction |
| ---------- | ---------------- | ---------------- | ---------------------- | ----------------- |
| 1 | Monitoring | collectd (udp/3011) | **Graphical Monitoring**<br>Performance and utilization metrics. Monitoring data is sent from the instance to RightScale. | **Egress**<br>Cloud to RightScale |
| 2 | NTP | NTP (udp/123) | **Network Time Synchronization**<br>Cloud-instance system clock sync; avoids data loss and consistency issues. | **Egress**<br>Cloud to RightScale |
| 3 | Design Assets & Packages | HTTP(S) | **RightScale Mirror Service**<br>Chef cookbook and RightScript attachment downloads (HTTPS);<br>OS package downloads (HTTP) | **Egress**<br>Cloud to RightScale |
| 4 | RightNet | HTTPS | **RightNet Routers**<br>Communication between RightScale Dashboard and RightLink management agent that's used for instance management. | **Egress**<br>Cloud to RightScale |
| 5 | Instance API Traffic | HTTPS | **RightScale API Endpoint (for Cloud)**<br>API requests from the instance. Examples include attaching volumes and taking snapshots. | **Egress**<br>Cloud to RightScale |
| 6 | User API Traffic | HTTPS | **RightScale API Endpoint (for User)**<br>Customer facing API traffic for automation and management tasks. | User to RightScale |
| 7 | User UI Access | HTTPS | **RightScale Cloud Management Dashboard**<br>Customer access to the RightScale Dashboard web interface. | User to RightScale |
| 8 | Cookbook Scraping | HTTP(S), SSH | **Repositories**<br>Access to the customers chef repository, from the Metadata scraper. | **Ingress**<br>RightScale to Customer Network |
| 9 | Cloud Controller API(s) | HTTP(S) | **Cloud API Endpoint**<br>API requests from RightScale's Cloud Gateway to the private cloud's API endpoint. **(For OpenStack)** | **Ingress**<br>RightScale to Cloud |
| 10 | wstunnel | HTTPS | **RightScale Cloud Appliance for vSphere (RCA-V)**<br>API requests from RightScale to RCA-V (RightScale Cloud Appliance for vSphere).<br>Tunneled over WebSockets in order to avoid making inbound connections to the customer datacenter.<br>**(For VMware vSphere)** | **Egress**<br>Cloud to RightScale |
