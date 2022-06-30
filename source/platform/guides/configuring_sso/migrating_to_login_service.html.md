---
title: Migrating to Login Service
description: Instructions for migrating to the new RightScale Login Service.
---

## Overview

In September 2015, RightScale updated our SAML support in order to enhance the
availability and usability of our platform and enable us to develop advanced
provisioning features.

We continue to support our legacy SAML implementation for the time being,
but request our existing SAML users to migrate to the new implementation at the
earliest opportunity; contact your RightScale account manager if you require
information about the end-of-support or end-of-life dates for our legacy
implementation.

### Benefits of Login Service

From the user-experience perspective, our new SAML implementation varies from
the old in the following ways:

1. Users can visit a single URL ([login.rightscale.com](https://login.rightscale.com)) to
   log in regardless of which RightScale cluster(s) their accounts are located in.
2. A new user-conversion flow provides a seamless experience for users who
   initially signed up for RightScale with an email and password. If a SAML
   assertion's email address matches that of an existing RightScale user,
   the user will be prompted to confirm her identity by entering her password.
   SAML will then be automatically enabled for future logins with no additional action.
3. The SAML IdP can include a [default RelayState](/platform/saml/rightscale_saml_relay_states.html) to indicate where to
   send the user after login.
4. After login, users are prompted to select an account rather than being sent to the last-used account.

## Migration Instructions

Migration is a simple two-step procedure that you can perform at any time without
disrupting your users.

### Change IdP settings

Visit your IdP software and find the existing trust relationship with RightScale's
SP. Edit the trust relationship and update the following settings, which have changed
in our new SAML implementation:

- Entity ID
- Assertion Consumer Service URL
- x509 certificate

For the new values of these settings, consult our [guide to configuring SSO](/platform/guides/configuring_sso/#overview-saml-2.0-settings).

### Change RightScale Settings

Login to RightScale and visit the Single Sign-On tab of the Enterprise Settings menu:

    ![Enterprise Settings](/img/platform-settings-enterprise-sso.png)

Click the pencil icon to edit your existing IdP trust relationship. On the edit
page, *uncheck* the "Legacy PingOne integration" checkbox:

    ![Edit Identity Provider](/img/platform-settings-enterprise-sso-edit.png)

Save your changes. Click the small blue "play" button to perform a test SAML
exchange and verify that everything is working well:

    ![Test Identity Provider Integration](/img/platform-settings-enterprise-sso-actions.png)
