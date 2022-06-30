---
title: Enable Single Sign-On with OpenID
category: general
description: Single Sign-On functionality on RightScale enables companies to use their OpenID-enabled identity provider to authenticate users on the RightScale Dashboard.
---

## Overview

Single Sign-On functionality on RightScale enables companies to use their OpenID-enabled identity provider to authenticate users on the RightScale Dashboard.  

## Getting Started

With all accounts, you have the option of enabling OpenID Single Sign-On for your users. In the Cloud Management (CM) Dashboard under **Settings > User Settings > Authentication** you can set your authentication method to **Use single sign-on**. Then, you enter the SSO identifier which will be used for your Single Sign-On login. Provide your RightScale password before you save your Single Sign-On Identifier.

## Enabling Single Sign-On for an Existing User

As an existing user, you can enable Single Sign-On by linking your account to an identity provider such as an email address, your company's Internet domain name, or the URL of your company's OpenID provider. You will then be prompted to login through your identity provider. After enabling Single Sign-On as an existing user, you are directed to your identity provider, which asks for your login information. After signing in through your identity provider, you are asked for your permission to be authenticated through RightScale. After allowing RightScale to acquire this information, you are directed back to the RightScale UI, where you receive confirmation that your RightScale user has been linked to an OpenID identity.

## Enabling Single Sign-On for a New User in an Enterprise Plan

As an account admin, you can invite accounts as Single Sign-On enabled users. In **Settings > Organization > Invitations**, an "OpenID" icon displays after you input a user whose email address matches your OpenID enabled domain. When you send the invitation, the user's account will be Single Sign-On enabled after accepting the invitation. Once the recipient accepts the invitation by clicking on the link in the invitation email, they will be asked to perform OpenID and a RightScale user is automatically created for them. Your OpenID provider must verify that their email address is the same as the email address to which the invitation was sent or RightScale will refuse to grant permissions. This process provides a tight binding between the invitation and the user's identity, but it can cause trouble if you habitually use email aliases. **Ensure that you invite OpenID enabled users using their canonical email address** as reported by your provider, not an alias or nickname.

## Logging into the RightScale Dashboard using Single Sign-On

With a Single Sign-On enabled account, your login screen provides you with two options: you can login the traditional way with your RightScale information (email address and password), or you can login using Single Sign-On. If you choose **Use single sign-on**, please specify your OpenID Identifier.

After logging in, you are authenticated and automatically directed to the RightScale Dashboard.

**Note**: RightScale creates an informational cookie on your machine with the Identifier you provide. This way, you will not need to enter your Identifier every time you login using Single Sign-On. However, you should remember your Identifier in order to login from different machines.

### See also

* [http://openid.net/](http://openid.net/)
* [Getting Started with SAML](/platform/saml.html)
