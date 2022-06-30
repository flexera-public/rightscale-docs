---
title: Configuring Single Sign-On (SSO)
description: RightScale can act as a SAML 2.0 Service Provider (SP), enabling Single Sign-On (SSO) for enterprise by initiating a login from a SAML Identity Provider (IdP) of your choice.
---

## Overview

RightScale can act as a SAML 2.0 Service Provider (SP), enabling Single Sign-On (SSO) for enterprise by initiating a login from a SAML Identity Provider (IdP) of your choice.

To take advantage of SAML SSO, you will first create a trust relationship between RightScale and your Identity Provider (ADFS, AzureAD, Okta, OneLogin, PingOne, Google, etc). To do this, you must be an Enterprise Manager for your organization in RightScale and must have administrative privileges in your organization's Identity Provider.

This page provides the essential settings that you need to configure a trust relationship, gives a broad overview of the procedure, and links to vendor-specific guides for various brands of IdP software.

For a more general discussion of RightScale's SAML capabilities, refer to our [SAML documentation](../../saml.html).

### Service Provider Metadata

The RightScale metadata URL is [https://login.rightscale.com/login/saml2/metadata](https://login.rightscale.com/login/saml2/metadata)

Provide this URL to your IdP if it supports metadata-based configuration of SP trust relationships. The metadata contains the settings below in addition to information about requested attributes, NameID format and other details.

You may still need to configure attribute mappings by hand; see [Step 2](#detailed-instructions-step-2--set-up-attribute-mappings) below.

### SAML 2.0 Settings

If your IdP requires manual setup, you can use the values here to describe RightScale's SP. You will additionally need to configure attribute mappings; see [Step 2](#detailed-instructions-step-2--set-up-attribute-mappings) below.

| Setting          | Value                                                             |
| ---------------- | ----------------------------------------------------------------- |
| Entity ID        | https://login.rightscale.com/login/saml2/metadata                 |
| ACS URL          | https://login.rightscale.com/login/saml2/consume                  |
| X509 Certificate | [click to download](/platform/saml/login.rightscale.com-2022.pem)  Fingerprint=*7B:80:9A:F3:A3:8A:DA:31:FA:36:E7:FF:30:A5:5F:B9:25:0D:39:29* |

Some IdPs, especially web-based SaaS products, have additional compatibility settings which are less critical but sometimes cause problems if misconfigured:

| Setting                       | Value                                                                              |
| ------------------            | ---------------------------------------------------------------------------------- |
| Default Relay State           | optional; see [supported values](/platform/saml/rightscale_saml_relay_states.html) |
| Signature / Digest Algorithm  | RSA_SHA1 / SHA1                                                                    |
| Request Compression           | Yes _or_ No (changeable via setting in RightScale UI)                              |
| Signed Requests               | Yes                                                                                |
| Encrypted Requests            | No                                                                                 |
| Signed Assertions             | Yes                                                                                |
| Encrypted Assertions          | Yes _or_ No (RightScale accepts either)                                            |


## Detailed Instructions

### Step 1: Setup trust relationship between IdP and RightScale

First, configure your Identity Provider to respond to authentication requests from RightScale. If your IdP vendor has an "app dashboard," then you will also end up with a button that your users can employ to perform IdP-initiated login to RightScale.

If you are unfamiliar with your IdP's administration functions, consult one of the vendor-specific guides below.

| Identity Provider | Guide                                                                                                                              |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| ADFS              | [Configuring a RightScale trust relationship in ADFS](configuring_adfs_idp.html#creating-a-trust-relationship-in-adfs)             |
| AzureAD     | [Configuring a RightScale trust relationship in AzureAD](configuring_azuread_idp_arm.html#creating-a-trust-relationship-in-azuread)    |
| Okta              | [Configuring a RightScale trust relationship in Okta](configuring_okta_idp.html#creating-a-trust-relationship-in-okta)             |
| OneLogin          | [Configuring a RightScale trust relationship in OneLogin](configuring_onelogin_idp.html#creating-a-trust-relationship-in-onelogin) |
| PingOne           | [Configuring a RightScale trust relationship in PingOne](configuring_pingone_idp.html#creating-a-trust-relationship-in-pingone)    |
| Google            | [Configuring a RightScale trust relationship in Google](configuring_google_idp.html#creating-a-trust-relationship-in-google)    |

### Step 2: Set up attribute mappings

The SAML Name ID is a string that uniquely identifies an authentication principal; it is a core part of SAML assertions and is always required in addition to the three attribues. RightScale is agnostic to the Name ID format used by your IdP, but we recommend choosing a time-invariant Name ID such as an LDAP DN, Active Directory `objectSid`, or numeric user ID. Choosing a value that can change over time may cause odd behavior.

!!info *Note:* We perform case-sensitive matching of Name IDs; please ensure that your IdP uses consistent character case when sending SAML assertions.

In addition, we require three user metadata attributes ("claims") in the SAML assertion.  RightScale accepts either the short-form or the long-form name of each attribute.

| Short Name     | Long Name                                                          |
| -------------- | ---------                                                          |
| email          | http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress |
| surname        | http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname      |
| givenname      | http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname    |


### Step 3: Test IdP-Initiated Single Sign-On

Please refer to your Identity Provider's documentation for how to initiate an SSO login. You should be able to assign the application created in Step 1 within your IdP to your test user and then initiate the SSO by clicking the app's button or the equivalent in your IdP.

That's it! Congratulations on successfully configuring your SSO in RightScale.

### Step 4: (Optional) Configure LDAP Group Sync

You can integrate your Directory service further into RightScale by configuring group sync between your Directory Service and RightScale.

For further details, please visit the [LDAP Group Sync tool page here](/gov/reference/gov_ldap_group_sync.html).
