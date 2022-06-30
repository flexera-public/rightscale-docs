---
title: Security Assertion Markup Language (SAML) 2.0
description: Describes SAML use cases and integration points within the RightScale platform.
---

!!info*This document discusses SAML concepts and use cases.* Refer to [Configuring SSO](/platform/guides/configuring_sso) for setting values and step-by-step setup instructions.

## Overview

SAML 2.0 is a single sign-on (SSO) and [federation](https://en.wikipedia.org/wiki/Federated_identity)
protocol suite that enables your organization to synchronize identity with web applications.
Once you have [configured SSO for your organization](/platform/guides/configuring_sso),
your users can log in to RightScale without choosing a password. When a user logs in with SSO, an audit entry in your
[master account](/cm/dashboard/settings/enterprise/)
captures the details.

If you are new to federated identity management, we suggest that you first read [SAML 2.0 Concepts](#saml-2-0-concepts).
If you already have experience in this area, continue reading [SAML 2.0 at RightScale](#saml-2-0-at-rightscale), below.

## SAML 2.0 at RightScale

### Creating a Mutual Trust Relationship

Before you can use SAML to provision users or access, you must configure RightScale to trust your IdP and vice-versa.

For detailed information, refer to [Configuring SSO using SAML 2.0](/platform/guides/configuring_sso).

#### Default Relay State

When configuring your IdP, you may specify a default relay state in order to determine which part of the RightScale platform your users arrive at when they perform IdP-initiated login.

For more information, refer to [SAML Relay States](/platform/saml/rightscale_saml_relay_states.html).

### Provisioning Users

All SAML assertions include a Name ID that uniquely identifies users in your organization.
RightScale is agnostic to the format of Name ID that you send to us, but we recommend a time-invariant format (such as LDAP DN or persistent UUID) instead of a value that can change over time (such as email address).  

In addition to Name ID, RightScale requires three metadata attributes (email address, surname, given name) when provisioning new users.
You should configure your IdP to send these attributes (sometimes known as "claims"); refer to [RightScale SAML Attributes](/platform/guides/configuring_sso/index.html#detailed-instructions-step-3--set-up-assertion-mapping-for-user-metadata) for specific values.

Finally, in order to provision users, RightScale must vouch that you own the email domain that your identity provider will claim.
Once your IdP is configured and the SAML test completes successfully, contact RightScale support to confirm ownership of your email domain and enable seamless provisioning of new users.

### Provisioning Access to RightScale Accounts

#### Inviting SAML-Linked Users

Once you have confirmed ownership of your email domain, the [invitations UI](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html) functions slightly differently.

When you invite someone whose email domain matches the identity provider's, RightScale creates a user and assigns permissions on the spot.
This is signified by a small grey "SSO" icon that appears next to the user's email on the send-invitations page.

SAML-linked users still receive an invitation email, but they are not obligated to go through a sign-up flow, choose a password, or perform other signup activities.
They can simply login to RightScale with SAML, using the link provided in the email, and begin using the accounts to which they were invited.

## SAML 2.0 Concepts

### Identity Provider

An Identity Provider (IdP) is a Web application operated by your organization
that performs the following functions:

1. Provides SAML attributes identifying the user attempting to interact with the SP.
2. Asserts to the SP that the user identified by those attributes is authorized by the provider to access the service.
3. Optionally provides additional attributes for the user, such as group membership information, that the SP may use for provisioning the user in the system.

You may purchase identity-as-a-service from a vendor or operate your own in-house IdP.
In either case, your IdP software provides an application portal that provides one-click access to RightScale and other Web applications.

### Service Provider

A Service Provider (SP) is a Web application, such as RightScale, that consumes
information from your IdP in order to provision users and determine their access privileges.

### Trust Relationship

Before an IdP and an SP can exchange SAML messages, an administrator must configure each of them to trust the other.

### Web Browser SSO

SAML 2.0's Web Browser SSO Profile is its principal login mechanism. For a detailed protocol description, refer to [Wikipedia](https://en.wikipedia.org/wiki/SAML_2.0#Web_Browser_SSO_Profile).

There are two variants of the Web Browser SSO flow:
- one where the user visits the SP first,
- and another where the user visits the IdP first.

#### SP-Initiated Login

If a user arrives at RightScale without being logged in, we must forward her browser to a suitable IdP in order to obtain a SAML assertion.
To determine where to send the user, we prompt her for a _discovery hint_, a DNS-like name that you have chosen at setup time to uniquely identify your IdP in our database.
We recommend using your organization's domain name as a discovery hint for your IdP.

#### IdP-Initiated Login

A more common way for an end-user to perform SSO is to login to the IdP and visit an application portal that provides a menu of SSO-accessible applications, including RightScale.
When the user clicks the RightScale menu item, her browser is directed to RightScale with a SAML assertion.

### Relay State

The relay state is a SAML parameter that conveys where users will be directed _after_ they perform single sign-on.
When performing IdP-initiated login, the IdP can add a default relay state in order to send the user to a specific place.
