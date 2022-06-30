---
title: Configuring OneLogin
description: Procedure for connecting OneLogin to the RightScale Cloud Management Platform.
---

## Creating a trust relationship in OneLogin

1. First, log in to OneLogin's website and click the "New App" button on the upper right of the screen.
1. In the upper left Search box type "RightScale" and click on the application called "RightScale" for SAML2.0.
1. Click the "Save" button and you will be navigated to the Info tab of the connector's detailed view.
1. Click the "Configuration" tab and enter
1. Next, click the "Configuration" tab and the value you wish to send to RightScale as your RelayState. Refer to the [RightScale SAML RelayStates](../../saml/rightscale_saml_relay_states.html) page to determine a suitable value.
1. Finally, click "Save" and then click the "SSO" tab. Keep this page open since you will need this information to continue on to [Step 2: Create a Trust Relationship in RightScale](index.html#step-2:-create-a-trust-relationship-in-rightscale).

## Creating a trust relationship in RightScale

1. In a new tab in your browser, navigate to the account you wish to administer in RightScale.
1. In the blue nav menu at the top of the screen, select "Settings" and navigate to "Single Sign-on" under the "Enterprise" section. (If you do not see this option, then you do not have the "enterprise_manager" role for the current account.)
1. On the resulting page, you should see a list of existing SAML Identity Providers near the top and, above the list, you should see a "New" button. Click the "New" button.
1. In the resulting form, enter the following values:

    | Input Name | Value |
    | ---------- | ----- |
    | *Display Name* | Your choice, e.g. `OneLogin` |
    | *Login Method* | Leave "Allow RightScale-initiated SSO using a discovery hint" unchecked |
    | *SAML SSO Endpoint* | Copy and paste the value from "SAML 2.0 Endpoint (HTTP)" on the screen open in your other tab |
    | *SAML EntityID* | Copy and paste the value from "Issuer URL" on the screen open in your other tab |
    | *SAML Signing Certificate* | On the screen open in your other tab, click "View Details" under X.509 Certificate and at the new screen download the certificate and upload it here |

1. Click the "Save" button and you will be returned to the Identity Provider list page. You should see your newly created IdP in this list.
1. Next, click the button to the right to test your IdP configuration. You should be redirected to your IdP where you can log in and complete the SSO login. You should see a page which says "SAML Consume Test Success" and shows some various information about your login.
1. Finally, if you wish to have users provisioned via SSO then you will need to [Enable authority for your new IdP over the SAML-asserted email domains](../../saml/registering_idp_authority.html).

This concludes configuration of your SAML Identity Provider in RightScale. Please continue on to [Step 3: Test IdP-Initiated Single Sign-On](index.html#detailed-instructions-step-3--test-idp-initiated-single-sign-on).
