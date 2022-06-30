---
title: RightScale Security Program
layout: security_layout
description: RightScale Cloud Portfolio Management is a software-as-a-service (SaaS) platform that is used to manage cloud applications.
---

## Overview of the RightScale Security and Compliance Program

RightScale Cloud Portfolio Management is a software-as-a-service (SaaS) platform that is used to manage cloud applications. The RightScale platform is hosted at cloud providers and other hosting facilities. The RightScale platform stores various types of metadata about your cloud applications (referred to as Customer-Specific RightScale Data), but **does not store data that is created and managed by your cloud applications** (herein referred to as Customer Application Data).

Because RightScale operates as a SaaS solution, our software, infrastructure, and security processes have been designed from the ground up with a multi-layered, defense-in-depth approach. The RightScale Security and Compliance Program is based on the ISO 27001 Information Security Management System (ISMS). We have defined policies that govern our security policies and processes and continually update our security program to be consistent with applicable legal, industry, and regulatory requirements for services that we provide to you under contractual agreement.

RightScale complies with industry standard application security guidelines that include a dedicated security engineering team and include regular reviews of application source code and IT infrastructure to detect, validate, and remediate any security vulnerabilities.

This document will provide an overview of these security measures as well as links to additional documents that provide details on specific areas.

## Physical and Environmental Security

### RightScale Hosting Facilities

The cloud providers used by RightScale manage the physical security and basic IT infrastructure operations for the RightScale platform, including your Customer-Specific RightScale Data. All hosting facilities used by RightScale have met a minimum of SSAE 18/SOC 1 certification.

Our hosting facilities provide industry-standard controls including:

* Fire suppression
* Data center cooling
* Data center power
* Multiple layers of physical access control
* Video monitoring of equipment locations

### Cloud Providers for Your Cloud Applications

You deploy your applications in the cloud providers of your choice. You should obtain all physical security and access-control verification information directly from that cloud provider. Typically, physical floor layouts and network infrastructure designs are not disclosed by cloud providers, and are therefore not available to RightScale or to our customers. However, RightScale can support you in further discussions with cloud providers on specific physical or logical access controls.

### RightScale Offices

No customer-specific systems or data reside within the corporate network or office facilities of RightScale. RightScale does implement physical security on RightScale offices as part of our comprehensive security procedures.

RightScale corporate headquarters are subject to physical perimeter access controls. The outer perimeter doors of the facility are locked and require badge card access for entry during working hours. After hours, badge card and lock PIN are required for entry. All access is logged. RightScale uses video surveillance of the exterior and lobby at RightScale headquarters. Videos are archived for at least 30 days. Satellite offices also are subject to multi-level perimeter controls.

## RightScale Access Controls

RightScale delivers both professional services and managed services, and our employees have significant training and expertise for the type of data, systems, and information assets that they design, architect, implement, manage, support, and interact with.

RightScale personnel who need to access components of the RightScale production systems, production management tools, or customer accounts must request access. RightScale follows an established on-boarding process to ensure that the appropriate level of access is assigned and maintained. RightScale has established levels of access that are appropriate for each role. All requests are reviewed and approved by the manager. RightScale follows a least-privilege policy that grants employees the minimum level of access required to complete their duties. RightScale follows an established off-boarding process through RightScale human resources that revokes all access rights upon termination.

All required employee access to customer accounts is limited to access levels commensurate for supporting our customers. These access levels are enforced by the RightScale platform, and the privilege to obtain any global roles is extended only to those employees whose job responsibilities include customer support. RightScale employee global roles are used for purposes of supporting our customers and, as such, these global roles are by default excluded from any customer-applied whitelisting. If RightScale personnel needs any additional access to a customer account, customers must explicitly invite them. For a small number of employees who require higher levels of access to maintain the RightScale platform itself, additional processes, approvals, and training procedures apply.

### Roles and Responsibilities

Roles and responsibilities of all staff are documented as related to information assets and security.

### RightScale Cost Optimization Team Role Permissions and Use of Customer Billing Data
RightScale has implemented a cost optimizer role designed specifically for the purpose of allowing RightScale Cost Optimization team members to perform a Cost Optimization Assessment or provide Cost Optimization Services at a customer’s request. The cost optimizer role has limited permissions that provide the RightScale employee with access levels commensurate with what is required to perform Cost Optimization Assessments and Services. This role is extended only to those employees whose job responsibilities include Cost Optimization Assessments and Services support.

RightScale Cost Optimization team members designated with the cost optimizer role will be able to:
* View billing information and details of cloud resource usage and costs.
* View cost and other information in cloud accounts connected to RightScale.
* View RightScale Optima recommendations.
* Flag recommendations to be “ignored.”
* Customize recommendation rule settings.
* Set up cost reports and budget alerts.

RightScale Cost Optimization team members cannot:
* Make any changes to cloud resources.
* Execute on any recommendations.
* Make any changes to Billing Centers.

Billing data is used only for the purpose of:
* Providing access for RightScale Optima to deliver analytics and recommendations.
* Permitting RightScale Cost Optimization team members to perform Cost Optimization

Assessments and Services.
* Research for delivering support or improving the product.
* Providing summary statistics of aggregated and anonymized customer billing data.

### Background Checks

RightScale has a documented process for performing background checks. RightScale uses a third party to conduct background checks, as permitted by law, as part of the recruitment and new-hire process.

### Password Policy

RightScale has a documented password policy for all employees. Passwords must meet complexity and length requirements and cannot be reused. Employees are required to secure all computers with a screensaver and password. Employees are required to secure mobile devices using full-disk encryption and other applicable technologies.

#### Creating a Password
A password must meet the following minimum requirements:
* Must be 8 characters or longer
* Must use both lower and uppercase letters
* Must include numbers
* Must include at least one symbol (e.g., !@#$%^&*)
* Cannot contain part of username
* Cannot be any of last 4 passwords

Other tips for making a strong, complex password:
* Avoid using repeating characters such as "aaabbbccc"
* Avoid using simple sequences such as "123" or "abc"

Password complexity is augmented with account lockout. We understand that the complexity requirements are not as stong as they potentially could be, but because we enforce account and IP lockouts, the overall controls against brute-force guessing have been extremely effective. Our lockout policy, after six failed login attempts:
* Lockout the user account for five minutes
* Lockout the IP address for one hour
* This policy is a balance between brute-force prevention and availability. 

**Note:** If you require more granular authentication controls, we highly recommend you utilize our Single Sign-On feature. 

### Account Review

Account access is reviewed at least every 90 days to ensure appropriate access.

### Remote Access

All systems that are part of the RightScale platform run a version of the Linux operating system and use SSH for remote access. All interactive login and non-interactive (file-copy) access requires public-key SSH authentication; SSH sessions are audited in the RightScale platform, and any activities performed during a session are logged via the system logging facility. Each user is assigned a unique user ID and must use sudo to perform any operations requiring elevated privileges. See the Key Management and Storage section below for additional information on our key management procedures.

### Training and Education

All employees are required to complete security awareness training as part of the onboarding process. Ongoing security updates and education are also provided.

## Business Continuity Management

The RightScale platform is architected for high availability, leveraging the capabilities of our cloud providers to maximize uptime, resilience, and data protection by deploying our platform across multiple geographic regions and data centers and through fault-tolerant software architectures.

Because RightScale CMP runs independently of your workloads and is not an active component of your applications, it is not a point of failure for
your managed workloads. If RightScale CMP suffers from an outage, your cloud workloads will continue to be available.

![security-rs-platform-overview.png](/img/security-rs-platform-overview.png)

### Disaster Recovery

The repositories and databases used by the RightScale platform are mirrored across multiple data centers in geographically distant regions. RightScale employs a partitioned (sharded) architecture and master-slave replication with “warm disaster recovery” to ensure business continuity and data recovery in the event of service interruptions at the cloud or hosting provider.

### Geographical Separation of Applications from the Management Plane

You may choose from several options for the geographic location of your RightScale accounts. RightScale can advise you on the specific location that is most appropriate for your situation. This approach enables geographical separation of your RightScale Cloud Management account and the actual cloud applications being managed.

By following this best practice of geographical separation, your RightScale Cloud Management solution can be used in case of a potential service interruption at your cloud provider or other data center to execute disaster recovery or failover processes. In addition, any service interruptions that disrupt your access to the RightScale platform will not impact your running cloud applications.

### Uptime and Maintenance Windows

RightScale provides a [service level agreement](https://www.flexera.com/media/legal/saas-service-levels.pdf) of 99.5 percent.

RightScale maintains a [status page](https://status.flexera.com/) showing the current status of all RightScale services. RightScale notifies customers of planned maintenance windows in advance. Planned maintenance windows are typically 60-90 minutes.

## Network Security

The RightScale platform is a SaaS solution hosted by RightScale at our cloud and hosting providers. The RightScale platform also leverages several components that may be run in your data centers or on your cloud instances depending on the capabilities of RightScale that you use. These include:

### RightLink

RightLink™ is an agent that is installed on your RightScale-managed cloud instances. It communicates with the RightScale platform to allow for running of scripts, monitoring, and other management functions. The latest version of the agent (RightLink 10.x) leverages HTTPS (TLS/SSL HTTPS and AES-192 encryption) and Secure WebSockets to secure communication between the agent and the RightScale platform. When used to manage a private-cloud or virtualized environment, the RightLink agent requires egress-only through the firewall to a small, fixed set of destination IP addresses. For the required outbound firewall rules, see [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).

### Monitoring Agent

RightScale leverages an optional collectd agent installed on your cloud instances for monitoring. Communication is through UDP. When used to manage private cloud or virtualized environments, the collectd agent requires egress-only through the firewall. For the required outbound firewall rules, see [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).

### RightScale Cloud Appliance for vSphere (RCA-V)

RCA-V is a virtual software appliance that enables you to manage your vSphere environments with RightScale. RCA-V is installed in your data center with access to your vSphere environment. RCA-V does not require any inbound connectivity to your network.

You must allow for egress (outbound) access from RCA-V to the RightScale platform. For the required outbound firewall rules, see [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html). This connection uses HTTPS (TLS/SSL HTTPS and AES-192 encryption) and Secure WebSockets to protect communications.

You must also allow for egress (outbound) access from your vSphere-based virtual machines that are deployed using RightScale. These instances run the RightLink agent that communicates with the RightScale platform. The required outbound connections are documented on the support site. The connections use HTTPS and Secure WebSockets to protect communications.

RCA-V requires access to your vCenter Server. It does not require admin access. See [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).

## Software Lifecycle and Change Management

The RightScale software development lifecycle and change management processes are applied to the following types of code that are associated with the RightScale platform.

**RightScale Platform Code**

This is the software that implements the functionality of the RightScale solution.

**RightScale Multi-Cloud Images<sup>TM</sup>**

These are operating system images for various cloud providers.

**RightLink Agent**

This is the software agent used to communicate between RightScale-managed instances and the RightScale platform.

**RightScale ServerTemplates<sup>TM</sup>**

These are out-of-the-box configuration management scripts created by RightScale that you may use to provision your servers. Note: The RightScale MultiCloud MarketplaceTM also includes ServerTemplates from partners or community members, which may follow different software lifecycle management processes.

### Development and Operations Process

RightScale follows established and documented processes that govern all of the asset types listed above. Key elements of this process include:

**Source Code Repository and Change Tracking**

RightScale leverages GitHub as a source code repository and management system. All changes are tracked, including the person making the change and the date of the change. All code must be tagged with the business requirement that generated the code change.

**Code Reviews**

All code is reviewed by a team lead or designated domain expert before being merged into the main branch. Code that is being merged into a release branch is subject to additional review (see below).

**QA Processes**

Testing is conducted at multiple phases in the development process, including unit testing, functional testing, integration testing, and regression testing.

**Multiple Checkpoints with Segregation of Duties**

There are several review and validation steps as code moves from development into production. Code is written by developers. Requests to merge code into a release branch can only be made by development managers, and only after QA personnel have conducted final acceptance/regression tests. The changes are independently reviewed by our production support team, who validates that the received change matches the expected change. Once validated, the production support team merges code. The operations team is responsible for deploying code changes to the production environment.

**Management of Inbound Source Code**

RightScale obtains source and binary packages for Linux operating systems directly from the source code repository of the distro maintainer (i.e., Ubuntu and CentOS). We complete a repeatable, automated “clean build” that includes security checks and then adds the RightLink agent.

RightScale obtains base Windows images directly from the individual cloud provider. RightScale adds the RightLink agent and then uses Microsoft’s Sysprep utility to prepare the final image.

After preparation, cloud images are digitally signed (when supported by the cloud provider) and uploaded to the provider via HTTPS.

RightScale ServerTemplates may also include open source software, such as Apache, MySQL, Rails, or others. RightScale maintains mirrors of the distro maintainers' package repositories to ensure consistency and availability. RightScale relies on the OS packaging system to ensure the integrity of package contents.

Packages that reside in distro maintainers' repositories are generally signed using GPG, and instances verify the package signature (and the trustworthiness of the signer) when a package is installed. RightScale also signs all packages that we publish, such as RightLink.

## Control of Production Systems

RightScale uses an independent, single-tenant, separately located instance of the RightScale solution to manage the RightScale platform. We leverage the RightScale platform’s role-based access controls to enforce segregation of duties among our employees.

All major production systems have documented runbooks to cover deployment, update, and troubleshooting processes. Extensive alerts are set up to notify and escalate in the case of issues.

**Baseline Configurations**

RightScale leverages RightScale ServerTemplates to create hardened and tested baseline configurations for use on all production servers. Permissions to change baseline configurations are strictly limited. Changes to baseline configurations require peer review and approval by the appropriate manager. No ad hoc scripts may be run on production systems. All scripts must follow the lifecycle management process and be approved by a manager.

## Identity Management

### User Authentication and Session Management

The RightScale platform supports the following end-user authentication mechanisms:

* Username and password (password length/complexity and lockout policies are enforced).
* Single Sign-On using SAML or OpenID.
* OAuth 2.0 refresh token (for API access only).

By leveraging SAML, RightScale can integrate with customer identity platforms such as Active Directory (ADDS and ADFS) or third-party identity platforms such as Okta, Ping, OneLogin, and others.

Two-factor authentication for access to RightScale can be implemented in a federated manner through any of the above identity management platforms or via OpenID.

You may leverage IP whitelisting capabilities in the RightScale platform to limit access to RightScale Cloud Management based on user IP address. Whitelisting policies apply to both the RightScale UI and API.

A session timeout is in place, and inactive sessions are invalidated after a period of inactivity. The session timeout is two hours for inactive sessions, and this timeout applies to both UI and API sessions.

See the [User and Account Management](/cm/administrators_guide/user_and_account_management.html) section of the [RightScale Administrator's Guide](/cm/administrators_guide/) for more detailed information.

### Cloud Authentication

RightScale authenticates to public and private clouds using cloud API credentials that are provided when you first register a new cloud in RightScale. Registering a cloud is restricted to RightScale users with admin privileges. The nature of the credential varies by cloud type, but generally involves a username/password (or similar) or a PKI certificate.

If you wish to restrict RightScale’s access to specific cloud functionality or enable easy revocation of access, we recommend that you create a user with the appropriate permissions in the cloud console (such as AWS IAM) and then supply that credential to RightScale.

**Public Cloud Authentication**

RightScale authenticates to public clouds by communicating with well-known API endpoints of each cloud provider and validates the API endpoint server certificates according to OpenSSL's built-in policy and trusted roots.

**Private Cloud Authentication**

Admin credentials for your private cloud are required when you initially register it with RightScale. Once a private cloud is registered, admin cloud credentials are not required.

* For non-vSphere private clouds, the admin who first registers a private cloud with RightScale defines its API endpoint(s). RightScale connects via inbound HTTPS and validates the cloud controller’s SSL certificate according to OpenSSL's built-in policy and trusted roots.
* For vSphere-based clouds, RightScale leverages Secure WebSockets to provide integrity and secrecy of outbound connections from the cloud controller to RightScale.

See the Key Management and Storage section below for information on how credentials are secured.

### Instance Authentication

When the RightLink agent starts up, it contacts the RightScale API to enroll itself and begin receiving management instructions. RightScale authenticates the agent with an OAuth 2.0 token-refresh operation. The instance authenticates the RightScale platform via standard SSL certificate validation.

Individual API requests from instances to RightScale are authenticated using a short-lived access token; instances periodically re-enroll when their tokens near expiration.

Enrollment URL, refresh token, and other data are conveyed to the instance using the cloud’s user-data capability. User data in transit to the cloud provider is protected by SSL, and the cloud provider protects the user-data at rest and ensures that it is only available to the intended instance.

## Key Management and Storage

RightScale uses database column encryption to ensure the confidentiality and integrity of secrets we store on behalf of our customers. Sensitive columns are encrypted at the application layer with AES128-CBC using the PKCS#5 passphrase-based KDF for key derivation. Additional documentation on RightScale’s information handling is available on the RightScale support site.

### Customer Secrets, Keys, and Credentials

There are five types of customer secrets that may be stored by RightScale. Any of these keys that are stored in RightScale will be encrypted as described above.

**Public SSH Keys** are used to log in to your cloud instances. Public SSH keys are securely stored in RightScale. The RightScale platform notifies your cloud instances of which public keys it should trust.

**Private SSH Keys** can be stored on your desktop or local key management systems or, at your option, in RightScale. You can configure RightScale to disallow your users from storing their private SSH keys in RightScale.

**Cloud-Based SSH Keys** are created by some clouds to provide for automation between instances. We recommend against using cloud-based SSH keys and instead recommend the use of ServerTemplates and RightScriptsTM for automation. However, if you want to use cloud-based SSH keys for automation, they will be securely stored in RightScale.

**Cloud (API) Credentials** are used to authenticate to a cloud account. These credentials are securely stored in the RightScale platform.

**Design Credentials** are used to store customer-generated credentials, keys, and other secrets needed to configure servers, such as a database password that’s needed by an application server that will be deployed to your instance. Credentials at rest are protected by RightScale database encryption and in transit by SSL. Credential values that appear in script output are filtered from the audit text before it is stored in RightScale databases, ensuring that audit entries cannot become a back channel for credential disclosure. As a best practice, RightScale recommends authoring scripts such that sensitive inputs are never written to disk, relieving you of the burden to protect credentials at rest on your own instances.

### RightScale Key Management Procedures

Keys and secrets utilized by the RightScale platform itself include private SSL keys, database encryption secrets, and credentials for RightScale’s own cloud accounts. All such keys are generated with industry-standard practices. Keys are stored only on instances that require them. Keys are rotated as needed, and access to the dedicated system that stores these secrets (as Design Credentials) is restricted to small number of personnel.

### HSM Solutions

Customers can leverage on-premises HSM solutions or cloud-based HSM solutions for key management in conjunction with RightScale. RightScale services teams can help customers to set up and configure these solutions.

## Data Security and Residency

### Data Types

**Customer-Specific RightScale Data**: This refers to customer-specific data used to manage customer cloud applications. This data is stored by the RightScale platform. This includes:

* Metadata
  * ServerTemplate definitions.
  * RightScripts and cloud workflows.
  * Deployment definitions.
  * Server definitions and inputs.
  * Network definitions.
  * Tags.
* Operational data
  * Monitoring metrics.
  * Alerts and escalations.
  * Audit entries.
  * Usage and cost activity.
* User-created images
* RightScale account/user data
  * User definitions and permissions.
  * Account settings.
  * Credentials for clouds, repository, and configuration.
  * RightScale user password verifier.
  * SSH public keys.
  * Cloud events and event failures recorded by the Gateway Service.

**Customer Application Data**: This refers to data that is created and accessed by your applications. This type of data data is stored on your cloud infrastructure or on-premises systems. This information is not stored or accessed by the RightScale platform.

**Syslog Data**: This refers to log data that is created and stored by your cloud instances. This information is not stored or accessed by the RightScale platform. You can set up your own agents on your cloud instances to collect syslog data and send to your own log aggregation or SIEM systems.

### Data Residency

**Customer-Specific RightScale Data** is stored in the RightScale cluster where your account is located and in the designated DR backup location for that cluster. There are three exceptions:

* Monitoring metrics sent to RightScale by instances are stored on a nearby collection server, generally located in the same cloud and region as the instance.
* ServerTemplate and RightScript metadata that you publish to the MultiCloud Marketplace is stored in the RightScale global cluster, located in the eastern U.S.
* Some metadata pertaining to running instances (chiefly tags, but also some presence and connectivity information) is geographically distributed for high availability.

**Customer Application Data** is stored by you with your application in a location of your choice.

### Data Protection in Transit

The RightScale application uses private network connections provided by cloud providers for all intra-cloud communications between the server instances in that cloud. All services listen on, and communicate over, private network interfaces. In addition, security groups are configured to restrict public traffic to use only allowed ports.

RightScale uses two approaches to encrypt communications that cross public networks.

Most of these communications use TLS to secure the transport. When TLS is employed, we use 2048-bit X.509 certificates for server authentication and key exchange, and a strong cipher suite for bulk encryption. Our servers are configured to reject weak ciphers and protocols.

Communications encrypted with TLS include:

* Between UI and API users and front-end services.
* Between instances and repositories or mirrors.
* Between cloud controllers and cluster services.
* Between RightScale services located in different clouds.
* Between RightLink (10.0+) and RightScale.

Monitoring data sent via UDP is not encrypted or integrity-protected due to limitations of the collectd protocol. As a compensating control, RightScale typically locates monitoring servers in the same cloud as the instances for which they collect data.

### Data Protection at Rest

Remote access to RightScale databases is limited to application servers that have a business need to connect, and are enforced by security groups.

For sensitive data that is encrypted at the application level before storage in the database, we derive a unique key for every encrypted value; keys are never reused across rows or columns. The key for an individual value in our database is a function of: a 256-bit master secret, the name of the table and of the column being encrypted, and a row-specific pseudo-random salt. Initialization vectors are freshly generated every time a message is encrypted.

Customer-specific data stored in object storage is encrypted before being sent over the network, ensuring that not even the cloud provider can recover the plaintext for stored files.

Sensitive customer data that is encrypted and stored in databases:

* Public and private cloud credentials.
* Design credentials.
* Repository credentials for cookbooks and cloud workflows.
* Users’ SSH private keys (optional; users may store private keys locally).
* Cloud events and event failures recorded by the gateway service.

Sensitive customer data that is stored as a bcrypt hash with a high work factor:

* RightScale user password verifiers.

Sensitive customer data that is encrypted and stored in cloud object stores:

* Archived audit entries (with credential values filtered out before storage)

We never store:

* RightScale user passwords.
* Private cloud admin credentials.

### Personally Identifiable Information

RightScale stores the following PII for each RightScale user: email address, first name, last name, and (optionally) phone number.

RightScale’s independent financial system and Salesforce.com CRM system contains customer account, contact, and payment details.

Customer Application Data is stored on your cloud instances or on-premises systems. This information is not stored or accessed by the RightScale platform.

### Data Backup and Retention

Backup of Customer-Specific RightScale Data

RightScale maintains certain customer specific data that is used by the platform for management of cloud applications (Customer-Specific RightScale Data). Customer-Specific RightScale Data is backed up through the following mechanisms:

| Type of Data | Storage Location | Backup Location |
| ------------ | ---------------- | --------------- |
| RightScripts | Cluster SQL DB | Master/Slave replication periodic snapshots |
| ServerTemplates | Cluster SQL DB | Master/Slave replication periodic snapshots |
| Credentials | Cluster SQL DB | Master/Slave replication periodic snapshots |
| RightScript attachments | S3 | AWS replication to multiple availability zones |
| Monitoring metrics | Special monitoring servers | Hourly to S3 |
| Metadata about instances, volumes, and other cloud resources | Cluster SQL DB | Master/Slave replication periodic snapshots |
| Usage and cost records | Cluster SQL DB; denormalized to analytics data store | Master/Slave replication periodic snapshots |
| Metadata about accounts, users, settings, and preferences | Central SQL DB; denormalized to clusters’ core DBs | Master/Slave replication periodic snapshots |
| Tags | Cluster NoSQL data store | Master/Slave replication periodic snapshots |
| Audit Entries | Cluster NoSQL data store | Multi-master replication periodic snapshots |

RightScale does not maintain any other client-related data. Data created and managed by your applications (Customer Application Data) resides on your cloud instances. You are responsible for backup of your own application data.

### Retention of Customer-Specific RightScale Data

RightScale maintains Customer-Specific RightScale Data for a minimum of 13 months.

Upon termination of a customer account, security sensitive details like cloud credentials are deleted upon request.

Other Customer-Specific RightScale Data is not guaranteed to be deleted upon account termination and may remain in RightScale production systems or rotating backups.

Prior to account termination, you may extract your data through the means described below.

### Export of Customer Data

We provide a variety of means for you to export your data in order to integrate IT systems with RightScale, maintain backups of your data, or migrate your data off of the RightScale platform.

**Data that remains outside of RightScale:**

* Your application source code.
* Chef cookbooks.

**Data exportable via API:**

* Monitoring metrics.
* Alerts and escalations.
* Audit entries for instances and cloud resources.
* Audit entries for user and account activity.
* Tags.
* Deployment metadata.
* Server metadata and inputs.
* Cloud networking information (VPC settings, routing information, etc.).
* ServerTemplate definitions.

**Data exportable via UI:**

* Usage and cost activity.
* User-created images, RightScripts, and cloud workflows.

### Physical Media Destruction

RightScale relies on its cloud providers to decommission storage devices. These providers follow industry standard practices that are designed to prevent customer data from being exposed to unauthorized individuals.

## Audit Trails of RightScale Usage

The RightScale platform tracks all user activity performed on a RightScale account via the RightScale UI or API. The audit trails include changes to RightScale-managed cloud instances and RightScale objects. No sensitive data, such as plaintext of passwords or credentials, is stored in or visible in the audit logs.

For more documentation on audit logs, see [Audit Entries](/cm/dashboard/reports/audit_entries/audit_entries.html).

RightScale also logs all user login activity and permission changes and can provide a report upon request.

## Threat Prevention and Response

### Vulnerability Scans

RightScale performs vulnerability assessments on a regular basis. We leverage both third-party assessment tools and external services, including:

* ControlScan, a <a nocheck href='https://www.pcisecuritystandards.org/assessors_and_solutions/approved_scanning_vendors'>PCI DSS Approved Scanning Vendor</a>.

* Rapid7 Nexpose, OpenVAS8, and OWASP ZAP.
* Cigital, which performed a two week long assessment that included web application and RightScale-specific API testing.

Customers may request a copy of the most recent scan from their RightScale account managers.

### Penetration Testing

RightScale leverages a third party to perform an annual penetration test on the RightScale platform. Customers may request a copy of the report from their RightScale account managers.

Customers must request permission to perform their own penetration tests by scheduling them through their RightScale account managers.

### Patch Management

RightScale leverages vulnerability disclosure channels (Bugtraq, SANS ISC, and others) to remain current on “0-day” disclosures.

Critical security patches published by an OS vendor are generally applied nightly to production systems. For high-availability software components that require testing before upgrade, the RightScale operations team deploys the patch manually, generally with a resolution time of 24-48 hours after availability of the new package.

As a defense-in-depth measure, RightScale continuously monitors the patch status of every host with respect to OS vendor security-update channels. If security updates become available, and a given host remains unpatched for more than 24 hours, an alert is raised.

Customers leveraging RightScale Multi-Cloud Images or ServerTemplates can apply these patches by rebooting or relaunching their servers or by restarting the RightLink agent. In the event of a major vulnerability, RightScale will contact affected customers to notify them that patching is required and assist with the patching procedure.

### Incident Management

RightScale has a documented incident management plan to ensure continuity of business operations, personnel, and facilities. The plan is triggered if there is any reason to believe that a server or data is compromised. This plan defines incident team members, steps to take, and reporting requirements. It also requires post-mortems and identification of any necessary remediation. Customers are notified regarding security incidents in line with contractual agreements and terms of service.

Traffic levels and request failure rates are continuously monitored. In the case of a denial-of-service attack, alerts will fire if there is sustained abnormal activity. Our operations team may respond using a number of traffic control measures, including:

* Blocking or rate limiting specific IP networks.
* Enabling TCP SYN cookies and connection-rate limiting.
* Blacklisting selected RightScale users or accounts.
* Taking message queues offline and cleansing queues of invalid messages.

## Auditability and Compliance

The RightScale Security Program (RSSP) is based on the ISO 27001 Information Security Management System (ISMS). We have defined policies that govern our security policies and processes and continually update our security program to be consistent with applicable legal, industry, and regulatory requirements for services that we provide to our clients under contractual agreements.

RightScale complies with industry standard application security guidelines that include a dedicated security engineering team and include regular reviews of application source code and IT infrastructure to detect, validate, and remediate any security vulnerabilities.

### External Security Reviews

Third-party security reviews and assessments of applications and the platform are performed at a minimum of once a year. Results of the most recent review can be provided to customers under contractual agreements.

### Certifications

RightScale certifications include:

* SSAE18 SOC1 and SOC2 Type II (Customers may request RightScale’s SSAE18 reports through their account manager).
* Pending compliance with the new EU-U.S. Privacy Shield Framework

### Compliance: PII, PCI, PHI, and Others

For customers with applications that need to comply with PII, PCI, or PHI standards, it is important to note that the RightScale platform does not store, access, transmit, or manage this sensitive data. However, the RightScale platform can be used to help you meet the requirements of compliance for **your applications** through such RightScale capabilities as visibility, enforcement of standards, access controls, and audit trails. We can [connect you with RightScale customers](http://www.rightscale.com/solutions/cloud-case-studies) who are leveraging RightScale to manage applications that follow these regulations.

Your applications and data that have compliance requirements will be located in the cloud provider of your choice. Many cloud providers offer certifications in particular regulations or standards, so you should carefully evaluate which cloud providers meet these options.

### Business Associates Agreement

Customer Application Data, including HIPAA/PHI data, is not stored, created, received, maintained, or transmitted in the RightScale system. As such we have not historically been considered a business associate or covered entity. The RightScale security team can answer any questions you may have.
