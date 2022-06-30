---
title: Configuring PingOne
description: Procedure for connecting PingOne/PingConnect to the RightScale Cloud Management Platform.
---

## Creating a trust relationship in PingOne

1. First, log in to PingIdentity's PingOne admin UI and click the "Applications" button on screen's top nav menu. This will take you to a page which displays the applications that your organization has configured in PingOne.
1. On the Applications page scroll down and click the "Add Application" dropdown button and select "Search Application Catalog".
1. On the "Application Catalog" page, search for "RightScale", select the "RightScale SAML" Application, and click "Setup".
1. On the next screen few screens, there is no need to modify any of the settings and you can go ahead and click "Continue to Next Step"
1. Once you get to the "Attribute Mapping" screen, you can map your Attribute Values to the Application Attributes [i.e. Email, First Name, Last Name].  Once completed, click "Continue to Next Step"
1. Review the Application Name and Description, then click "Save & Publish".
1. Now, if you type the name you gave to your RightScale application in the Search dialogue, you should see it displayed. If you wish to test your IdP setup at the end of this guide, you will need to add the new application your own user (the same user which is associated with your RightScale login email that has the 'enterprise_admin' role.) at this time. Please refer to PingOne's documentation for how to do this.
1. At the very end of the row for your RightScale application, click the black triangle button to display the details of your application's settings. Leave this tab open in your browser and continue on to [Step 2: Create a Trust Relationship in RightScale](index.html#step-2:-create-a-trust-relationship-in-rightscale).

## Creating a trust relationship in RightScale

1. In a new tab in your browser, navigate to the account you wish to administer in RightScale.
1. In the blue nav menu at the top of the screen, select "Settings" and navigate to "Single Sign-on" under the "Enterprise" section. (If you do not see this option, then you do not have the "enterprise_manager" role for the current account.)
1. On the resulting page, you should see a list of existing SAML Identity Providers near the top and, above the list, you should see a "New" button. Click the "New" button.
1. In the resulting form, enter the following values:

    | Input Name | Value |
    | ---------- | ----- |
    | *Display Name* | Your choice, e.g. `PingOne` |
    | *Login Method* | Leave "Allow RightScale-initiated SSO using a discovery hint" unchecked |
    | *SAML SSO Endpoint* | `https://sso.connect.pingidentity.com/sso/idp/SSO.saml2?saasid=<SAASID VALUE>&idpid=<IDPID VALUE>` <br /> *** Replace `<IDPID VALUE>` AND `<SAASID VALUE>` with the values from "Initiate Single Sign-On (SSO) URL" on tab opened in the previous section.<br /><br /><i>For Example: <br /> <i>`https://sso.connect.pingidentity.com/sso/idp/SSO.saml2?saasid=f44d0603-8fa6-42e7-ad5b-f92e330e6282&idpid=55aeabcc-e1fc-49cf-9acd-ab361728521a`</i> |
    | *SAML EntityID* | Enter the value for "Issuer" on tab opened in the previous section |
    | *SAML Signing Certificate* | On the tab opened in the previous section, click and download the "Download" link for "Certificate" and upload here |

1. Click the "Save" button and you will be returned to the Identity Provider list page. You should see your newly created IdP in this list.
1. Next, click the button to the right to test your IdP configuration. You should be redirected to your IdP where you can log in and complete the SSO login. If you didn't assign the application created when configuring PingOne to your PingOne user, then you will need to do so before completing this step.
1. Finally, if you wish to have users provisioned via SSO then you will need to [Enable authority for your new IdP over the SAML-asserted email domains](../../saml/registering_idp_authority.html).

This concludes configuration of your SAML Identity Provider in RightScale. Please continue on to [Step 3: Test IdP-Initiated Single Sign-On](index.html#detailed-instructions-step-3--test-idp-initiated-single-sign-on).
