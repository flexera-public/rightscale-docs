---
title: Where Does RightScale Fit in the Cloud Ecosystem?
layout: cm_layout
description: Cloud computing has quickly become a commonly used term in the computer industry. Three distinct levels of cloud computing include Software as a Service (SaaS), Platform as a Service (PaaS), and Infrastructure as a Service (IaaS).
---

Cloud computing has quickly become a commonly used term in the computer industry. However, the term is often misused or misunderstood.

Here is a breakdown of the three distinct levels of cloud computing:

* **Software as a Service (SaaS)** - Web-based services that are consumed. Examples include Gmail, Google Docs, Dropbox, etc.
* **Platform as a Service (PaaS)** - Examples include Google App Engine, Force.com, etc.
* **Infrastructure as a Service (IaaS)** - Examples include public clouds like Amazon Web Services and Google Cloud, as well as private clouds powered by OpenStack software.

It is important to understand where RightScale fits into the overall cloud computing landscape. RightScale is a cloud management platform that helps you manage cloud resources at the IaaS level.

The diagram below shows that RightScale sits between your web and grid applications and the various public/private cloud infrastructures where you launch cloud servers (instances) to host those web applications and databases.

![cm-getstarted-clouds.png](/img/cm-getstarted-clouds.png)

## A Single MultiCloud Management Tool

One of the key benefits of the RightScale Management Platform is that it is designed to be a cloud-agnostic management tool that leverages cloud resources in any of the public/private clouds that RightScale supports, assuming that you have valid cloud credentials and you have enabled your RightScale account for those clouds. Once you have provided RightScale with the necessary cloud credentials for any of your clouds, you can see them under the Clouds menu of the Dashboard.

The key benefit of using RightScale is that you do not need to learn a different tool to manage each individual cloud. RightScale allows you to learn one tool to effectively manage all of your cloud resources regardless of the underlying cloud infrastructures.
