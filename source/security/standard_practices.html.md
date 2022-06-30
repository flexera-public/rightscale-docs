---
title: Standard Practices
layout: security_layout
description: View RightScale's standard security practices covering information types, protecting data in transit, data protection, encryption, and data retention.
---

## Information Handling

### Information Types

RightScale provides infrastructure management of IaaS and PaaS cloud resources. On behalf of our clients, we store and have access to potentially sensitive data, such as:

* Cloud credentials
* ServerTemplates
* RightScripts
* System build parameters and input values  

The data we maintain about our customers is typically considered intellectual property (I.P.) and is protected as such. RightScale will not divulge or share any customer I.P. without prior consent with third parties outside of our Cloud hosting partners, which are fundamental to service operations. RightScale will work with customers to ensure that best practices of specific asset classifications and generic Cloud security are implemented and, if required, independently verified.

### Protecting Data in Transit

The RightScale application uses private network connections provided by the cloud providers for all intra-cloud communications between the server instances in that cloud. All daemons listen on, and communicate over, the private interfaces. In addition, security groups are configured to restrict public traffic to use only allowed ports. All communication between customers and the RightScale application use either SSL or TLS to encrypt the transport. Where transport level encryption is not an efficient mechanism, application level encryption of the payload is performed.

When SSL/TLS is used to secure the transport, we use 2048 bit X.509 certificates, configured to reject weak ciphers and protocols. The Cloud controllers' server certificates are validated according to OpenSSL's built-in policy and trusted roots.

### Data Protection in Database

RightScale uses database column encryption to ensure the confidentiality and integrity of secrets we store on behalf of our customers. Sensitive columns are encrypted at the application layer with AES256-GCM, using the PKCS#5 passphrase-based KDF for key derivation.

We derive a unique key for every encrypted value; keys are never reused across rows or columns. The key for an individual value in our database is a function of several things: a 256-bit master secret, the name of the table and of the column being encrypted, and a row-specific pseudo-random salt. Initialization vectors are freshly generated every time a message is encrypted.

We never reuse a master secret across trust boundaries. For example, when we move the contents of a database from our production environment into our staging environment to perform performance or regression testing, we re-encrypt all of the records using a different master secret that only resides on machines in our staging environment. Besides re-encrypting, our sanitization procedure does many other things such as anonymizing email addresses, postal addresses, names, and other personal or proprietary information in the database. In addition, the sanitization process removes credentials except from a set of white-listed RightScale-specific accounts (i.e., all customer related credentials are removed).

A specific point about cloud credentials is that they are masked on display/read. Thus they cannot be read, but they can be changed by users with appropriate permissions (roles).

#### Encrypted Objects

The following objects are protected by the database encryption just described:

* Credential design objects: Name, Description, and Value
* The private key material of any RightScale managed SSH key
* The private key material of any EC2 SSH Key
* Cookbook repo credentials
* Workflow repo credentials
* Any stored OAuth secret
* User password verifier (we store a verifier, not the actual password)
* Cloud credentials (those used to access the cloud endpoint API)
  * For AWS this is the Access Key ID, Secret Access Key, account number, EC2 cert, and EC2 key
  * For other clouds, the specific credentials used to access the API endpoint
* Content of gateway events and event failures (e.g., the raw responses from cloud list calls)
* Admin password that is set for the instance at launch. This value MAY or MAY NOT exist, it depends on the features of the specific cloud.

### Non-database Data Protection for Non-Cloud systems

Critical data that is on non-cloud systems and not stored in databases is protected using one of the following mechanisms:

* Full Disk Encryption
* File/Folder level encryption
* PEM file with passphrase

### Data Retention

Customer information is kept for its useful life. The type of data determines the retention period. For example, when users change their password, the validator that was previously stored is no longer available, and cannot be recovered. RightScale will honor any requests to terminate, return or securely delete any client-specific intellectual property assets as required. The details of this policy are documented in the Data Retention Policy.

## Securing Cloud API Endpoints

### Use SSL/TLS

!!info*Note:* The terms Secure Socket Layer (SSL) and Transport Layer Security (TLS) are often used interchangeably. In fact, SSL v3.1 is equivalent to TLS v1.0

1. Use SSL (actually TLS v1.2 or greater) on the API endpoint.
  * Do not use SSL v2, as it has know weaknesses
  * SSL v3 and TLS v1 have recently been shown to have potential flaws, thus the use of TLS v1.2 or above is encouraged
    * *Caveat*: While this is true, the reality is that until OpenSSL GA's a version that supports TLS greather than version 1.0, it is not always practical. Support for TLS v1.2 is encouraged. If you cannot support TLS v1.2, then support of SSLv3 and TLS1.0 is acceptable with a road map item to TLS v1.2 when possible.
2. Implement the following SSL/TLS configuration settings when selecting cipher suites:
  * Use AES, 3DES for encryption
  * Use key lengths of 2048 or greater
  * Use cipher block chaining (CBC) mode
  * Use SHA1 for digest (note that MD5 may be used within the TLS protocol, but not the SSL protocol)
    * TLS usage of MD5 does not expose the TLS protocol to any of the weaknesses of the MD5 algorithm (see [FIPS 140-2 IG](https://csrc.nist.gov/csrc/media/publications/fips/140/2/final/documents/fips1402.pdf)). However, MD5 must never be used outside of TLS protocol (e.g. for general hashing).
  * Do not provide support for NULL cipher suites
  * Support ephemeral Diffie-Hellman key exchange (do not provide support for anonymous Diffie-Hellman)
    * Use of Ephemeral Diffie-Hellman key exchange will protect confidentiality of the transmitted plaintext data even if the corresponding RSA or DSS server private key is compromised. An attacker would have to perform active man-in-the-middle attack at the time of the key exchange to be able to extract the transmitted plaintext.
3. Disable support for TLS renegotiations or support only renegotiations compliant with [RFC 5746](http://tools.ietf.org/html/rfc5746)
4. Install a valid certificate
  * Valid certificates (that is, certificates signed by a trusted Certificate Authority (CA)) can be obtained for a very low cost from providers such as GoDaddy or RapidSSL.
  * The CN (common name) attribute must match the hostname part of the URL that is being requested. In other words, the CN must match the hostname in the cloud API endpoint URL, not usually the hostname of the web server.
  * A valid certificate also helps prevent a man in the middle (MITM) attack
5. Certificate Validation Level: We recommend Extended Validation (EV) SSL Certificates for production gateways.
  * Extended Validation (EV) SSL Certificates (best): The Certification Authority (CA) checks the right of the applicant to use a specific domain name PLUS it conducts a *thorough* vetting of the organization. There is a strict set of validation guidelines that must be followed.
  * Organization Validation (OV) SSL Certificates (better): The CA checks the right of the applicant to use a specific domain name, as well as conducts some vetting of the organization.
  * Domain Validation (DV) SSL Certificates (good): The CA checks the right of the applicant to use a specific domain name. No company identity information is vetted.  
 Use an Extended Validation (EV) certificate. Domain Validation only SSL certificates are considered "low-validation" and use is discouraged. EV certificates have undergone more rigorous vetting, and are encouraged.
6. *Optional*: Cloud Provider and RightScale coordinate to determine if verification of the trust chain is required on each connection. If CN is equal to hostname, there is a reasonable assurance of identity, even if the certificate is not completely validated.
7. *Optional*: Perform SSL mutual authentication between the API endpoint and the RightScale systems.
  * Obtain the client side certificate and validate that the client possesses a valid certificate for the \*.rightscale.com domain.

### IP Source filtering

While some of our customers utilize source IP filtering, RightScale does not recommend it as a mechanism for securing the API endpoint for the following reasons:

1. Potential issues with auto scaling: If cloud providers restrict who can access the API endpoint by IP, they will need to have dynamic changes to their external firewall to accommodate the scaling of the RightScale platform itself.
2. Potential issues with fail over: If a region fails and RightScale has to fail over to a different cloud/region, the ability to manage resources in the Cloud Provider would break until they updated the whitelist.
3. Potential Compliance issues with dynamic firewall changes: Many compliance requirements require testing after any changes to firewalls. By dynamically updating the firewall access control lists, a customer may introduce gaps in the compliance program.
4. Limits the timeliness of RightScale Technical Support: Many times RightScale Professional Services, Operations, or Engineering may have to troubleshoot the connection to the customer. With IP whitelisting in place, the IP addresses used in the trouble shooting need to be added to the allowed list before any testing can occur. As a policy, RightScale support does NOT use production systems (i.e., systems that are part of the platform and would be in the access list) to initiate troubleshooting from. Only RightScale Operations has access to the production systems, not Support, Professional Services, or Engineering.
5. Validation of trusted sources can be done with SSL/TLS: Utilizing the mutual authentication capability in SSL/TLS, a Cloud Provider can be confident that they are communicating with a legitimate RightScale system.
