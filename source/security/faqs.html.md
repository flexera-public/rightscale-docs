---
title: Security FAQs
layout: security_layout
descriptions: View Frequently Asked Questions regarding the RightScale security features and practices.
---

Frequently Asked Questions Regarding Local Security...

## Can I meet PCI Requirement 4.1 (data security over public networks) in the Cloud?

### Background

Payment Card Industry (PCI), Data Security Standards (DSS), or simply PCI - DSS requirement 4.1 states:

 "Use strong cryptography and security protocols (for example, SSL/TLS, IPSEC, SSH, etc.) to safeguard sensitive cardholder data during transmission over open, public networks."

Per the PCI Navigation Guide on Req 4.1:

 "Sensitive information must be encrypted during transmission over public networks, because it is easy and common for a malicious individual to intercept and/or divert data while in transit."

### Answer

Based on the Req 4.1 information stated above, if the traffic between the Load Balancer (LB) and the application server (AppSrv) is over a "private" network, it does *not* need to be encrypted. This would apply to the AppSrv to DB server connection as well. Here are the three main justifications for this stance:

* Amazon gives assurance that instances cannot sniff traffic from other instances. This was evaluated as part of their PCI Level 1 certification process, since they achieved compliance, reliance on this control is acceptable.
* LB to AppSrv uses the private IP space (i.e., 10net) and packets are thus not routable across the Internet, and thus cannot end up there by accident.
* Security groups and host firewalls can restrict traffic to/from specific IP/Port combinations.

!!warning*Important!* It should be noted that the "private network" scenario would be applicable to any cloud provider that could "prove" the privacy of the communication between the instances. This should be globally applicable, but as of the writing of this FAQ (Jan 2012), AWS was the only one to have a Quality Security Assessor (QSA) attest to the adequacy of the privacy of the network communication.

## Does RightScale support AWS Multi-Factor Authentication?

### Background

RightScale is a separate platform than the clouds it manages, and thus has its own Authentication and Authorization mechanisms. However, we do support Multi-Factor Authentication through our support of SAML and identity federation.

### Answer

RightScale currently does not support AWS MFA as an authentication mechanism in the RightScale dashboard.

However, the RightScale Cloud Management Platform supports the following end-user authentication mechanisms:

* Username and password (password length/complexity and lockout policies are enforced).
* Single Sign-On using SAML or OpenID.
* OAuth 2.0 refresh token (for API access only).

By leveraging SAML, RightScale can integrate with customer identity platforms such as Active Directory (ADDS and ADFS) or third-party identity platforms such as Okta, Ping, OneLogin, and others.

Two-factor authentication for access to RightScale can be implemented in a federated manner through any of the above identity management platforms or via OpenID.

You may leverage IP whitelisting capabilities in the RightScale platform to limit access to RightScale Cloud Management based on user IP address. Whitelisting policies apply to both the RightScale UI and API.

A session timeout is in place, and inactive sessions are invalidated after a period of inactivity. The session timeout is two hours for inactive sessions, and this timeout applies to both UI and API sessions. See [User and Account Management](/cm/administrators_guide/user_and_account_management.html).

**Note for Amazon Web Services**

There are two cases for using AWS MFA on an AWS account:

1. When logging into the AWS Console (not the RghtScale dashboard)
2. When accessing the AWS API

RightScale uses API interactions between the RightScale gateway and the AWS API endpoint, so enabling AWS MFA for AWS console access (use case #1) has no effect on RightScale operations or access. However, if a user enables AWS MFA for API access (use case #2), this will break RightScale's ability to communicate with the AWS API endpoint. The main issue is when enabling AWS MFA for API access, the tokens are short lived (36 hours max at this time). Per [http://docs.aws.amazon.com/IAM/lates...tectedAPI.html](http://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html): "MFA-protected API access is available only to services that support temporary security credentials"

Since RightScale must have long term API access, the user would have to enter new credentials every day and a half (36 hrs), which isn't practical. MFA-protected API access only controls access for IAM users. Root accounts are not bound by IAM policies, which is why AWS recommends that you create IAM users to interact with AWS service APIs rather than use root account credentials. To learn how you can use IAM in RightScale, see  [Can I use AWS Identity and Access Management (IAM) to further restrict user access?](/cm/administrators_guide/user_and_account_management.html#configure-a-rightscale-account-can-i-use-aws-identity-and-access-management--iam--to-further-restrict-user-access-)

## How can HIPAA requirements be addressed in the cloud?

### Background

The **Health Information Portability and Accountability Act (HIPAA)** is focused on protecting a patient's healthcare information. Unlike PCI, which is prescriptive in terms of controls required, HIPAA describes the goal of the controls and leaves the selection of controls up to the "covered entity" (that is, the one that needs to be compliant with HIPAA).

The "Privacy Rule" and "Security Rule" are the two main provisions of HIPAA that affect information security.

#### Privacy Rule

The HIPAA Privacy Rule regulates the use and disclosure of certain information held by "covered entities" (generally, health care clearinghouses, employer sponsored health plans, health insurers, and medical service providers that engage in certain transactions). It establishes regulations for the use and disclosure of Protected Health Information (PHI). PHI is any information held by a covered entity which concerns health status, provision of health care, or payment for health care that can be linked to an individual. This is interpreted rather broadly and includes any part of an individual's medical record or payment history.

#### Security Rule

The Security Rule complements the Privacy Rule. While the Privacy Rule pertains to all Protected Health Information (PHI) including paper and electronic, the Security Rule deals specifically with Electronic Protected Health Information (ePHI). It lays out three types of security safeguards required for compliance:

1. administrative
2. physical
3. technical

For each of these types, the Rule identifies various security standards, and for each standard, it names both required and addressable implementation specifications. Required specifications must be adopted and administered as dictated by the Rule. Addressable specifications are more flexible. Individual covered entities can evaluate their own situation and determine the best way to implement addressable specifications. Some privacy advocates have argued that this "flexibility" may provide too much latitude to covered entities.

#### Health Information Technology for Economic and Clinical Health (HITECH)

HITECH mandates that business associates (e.g. RightScale) are required to address the specific mandates of HIPAA security in the same way as covered entities. Protecting access to ePHI is the key, think crypto with client based key management.

### Answer

In a nut shell, RightScale customers need to:

* Protect ePHI when transmitting it over public networks, which typically means VPN or SSL.
  * One interesting point to note is that you typically do NOT have to encrypt data that's in transit over a private network, which means that if you are using the private cloud interface, then encryption is not *required* (it may be a good practice and reasonable, but not required). The use of a private IP range and the cloud provider guaranteeing that instances cannot sniff other instance traffic (this is a key control required form the Cloud Provider) provides adequate controls.
* Protect the data at rest. This typically means using some type of encryption.
  * Examples include Trend Micro SecureCloud, volume encryption, remote object storage encryption, etc.
  * Maintain good Key Management
  * *Note*: Encryption falls within the scope of customer responsibility
* Implement Role Based Access Control in *your* application
* Assign appropriate roles within the RightScale dashboard
  * For example, restrict the "server_login" role (and "admin")
* Implement a process to review audit logs from systems that use or contain ePHI

Customer Application Data, including HIPAA/PHI data, is not stored, created, received, maintained, or transmitted in the RightScale system. As such we have not historically been considered a business associate or covered entity. The RightScale security team can answer any questions you may have.

## Private Cloud Network Connectivity Requirements

### Background

Customers with Private Clouds want to restrict who can access its private cloud endpoint API.

!!info*Please Note:* We do not encourage the use of restrictive egress rules for public cloud instances to ensure that RightScale services function as expected. AWS users with VPC security groups configured with restrictive egress rules should consult the [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html) file and ensure that all IP addresses required for egress traffic are permitted.

### Answer

Egress and Ingress Whitelist for Private Cloud endpoints should allow all entries from our [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).
