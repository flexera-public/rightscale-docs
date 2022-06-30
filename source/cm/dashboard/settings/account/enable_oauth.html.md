---
title: Enable OAuth
layout: cm_layout
description: Steps to enable OAuth on a RightScale account. With OAuth enabled, you can make authenticated API 1.0 and 1.5 requests without the need of a password.
---
## Overview

With OAuth enabled, you can make authenticated API 1.0 and 1.5 requests without the need of a password. This creates a token that can be passed with every API call and can be disabled at any time from the the **API Credentials** tab under Account Settings.

## Steps

Follow the steps below to enable OAuth:

1. Make sure you're in the account you want to enable with OAuth.
2. Go to **Settings** > **Account Settings** > **API Credentials**.
3. In **Status** , click **enable**.
4. Obtain the API refresh token in order to make API requests without logging in. It's important that this token is protected.  

!!info*Note:* The hostname of the "Token Enpoint (API 1.5)" may vary between RightScale accounts depending on the geographical region in which each account is hosted. Make sure to use the correct endpoint for your account when making API request, both OAuth and otherwise.

## Token Lifecycle and Permission Model

The token displayed on this page is an account-specific token; you have a separate token for every RightScale account and they can be enabled or disabled (revoked)
independently. **However**: tokens are not *scoped* to an account, meaning that the refresh token for any account can be used to access resources belonging to
other accounts.

Additional OAuth scoping features (to specific accounts and/or actions) are under development; when we deploy these features, all existing tokens will remain unscoped
to avoid backward compatibility issues.

## Additional Notes

* Anyone who possesses a valid token can log into the enabled account via the API and perform API requests on your behalf, with all of your permissions. Please protect this token appropriately.
* The OAuth API feature allows users with Single Sign-On enabled to access the API without a username/password combination.
* "Enable" enables OAuth for your account and generates a valid token. This token does not expire until it is "disabled" which will make the previous token invalid. The next time it is "enabled," a new token will be generated.

## See also

* [OAuth API 1.5 Example](/api/api_1.5_examples/oauth.html)
