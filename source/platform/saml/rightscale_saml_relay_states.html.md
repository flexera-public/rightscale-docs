---
title: RightScale SAML RelayStates
description: A RightScale SAML RelayState is an optional parameter of SAML requests and responses that can be used to provide a hint about where the user wants to go after she completes single sign-on.
---

## Overview

RelayState is an optional parameter of SAML requests and responses that can be used to provide a hint about where the user wants to go after she completes single sign-on.

### Relay State for SP-Initiated Login

When RightScale initiates SAML, we may include a `RelayState` parameter if the user was attempting to reach a specific page or area within our platform. For example: a user might receive an email containing a deep link to a page within our platform; if she clicks the link, we will redirect her to your IdP with a RelayState set to that URL, so that she is redirected back to the page she was trying to reach after she completes single sign-on.

As specified in the SAML 2.0 standard, when your IdP receives `RelayState` as part of a request, it should always include the same RelayState in its response. This enables us to seamlessly redirect your user to the page she was trying to reach after we have authenticated her.

!!info *Note:* RightScale may initiate SAML for deep links even if you have opted not to provide a [discovery hint](/platform/saml.html#sp-initiated-login) for your IdP. For an optimal user experience, please ensure that your IdP handles RelayState correctly.

### Relay State for IdP-Initiated Login

Most IdPs allow you to specify a default RelayState when you configure the trust relationship with RightScale's SP. If a user performs IdP-initiated login, your IdP will include this RelayState in order to direct RightScale to send the user to a specific area of our product. Setting a default relay state allows you to control the post-login landing page for your users.

Some IdPs support an app dashboard feature and may allow you to configure several icons for the RightScale app that send different relay states. You can use this functionality to facilitate one-click access to different parts of our platform, or to send users to a different landing page depending on their business role.

## Valid RelayState Values

RightScale's SP recognizes the following relay states:

| RelayState                         | Action                                        |
| ----------                         | ------                                        |
| (blank/absent)                     | Go to recent Cloud Management (CM) account    |
| urn:rightscale:product:ca          | Go to Optima dashboard                        |
| urn:rightscale:product:cm          | Go to CM account selector                     |
| urn:rightscale:product:ss          | Go to Self Service project selector           |
| urn:rightscale:product:cm#recent   | Go to recent CM account                       |
| urn:rightscale:product:cm:recent   | Same as above (for IdPs that hate #)          |
| https://\*.rightscale.com/\*       | Redirect to requested page                    |

!!info *Note:* When configuring a default RelayState for your IdP, we recommended that you use a URN and not a hardcoded URL. Our user-interface URLs may change over time as our application evolves, but the URNs are guaranteed to redirect users to the specified app's landing page.
