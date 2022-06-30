---
title: Configuring Okta
description: Procedure for connecting Okta to the RightScale Cloud Management Platform.
---

## Creating a trust relationship in Okta

1. First, log in to Okta's website and click the "Admin" button on the upper right corner of the screen.
1. Next, on the upper menu, click on the first level "Applications" menu option. This will take you to a page which displays the applications that your organization has configured in Okta.
1. On the Applications page click the "Add Application" button displayed on the upper right of the page, which will take you to a UI for adding a new application.
1. On this page, type "RightScale" into the Search textbox, then click the "Add" button of the Okta-verified RightScale SAML application.
1. Click "Next" on the "General Settings" tab.
1. Click "Next" on the "Provisioning" tab.
1. On the "Assign to People" tab, assign this Application to the users you want to have access to it, then click "Next". If you wish to test your IdP setup at the end of this guide, you will need to add the new application your own user (the same user which is associated with your RightScale login email that has the 'enterprise_admin' role.) at this time.
1. Select "Done" and you will be taken a detailed Application View page for the app you just created.
1. Click on the "Sign On" tab, then click the "Edit" button.
1. Enter the RelayState value you wish to send to RightScale. Refer to the [RightScale SAML RelayStates](../../saml/rightscale_saml_relay_states.html) page to determine a suitable value. When you have finished, click click the "Save" button.
1. In the middle of the page, click the "View Setup Instructions" button. Keep this page open since you will need this information to continue on to [Step 2: Create a Trust Relationship in RightScale](index.html#step-2:-create-a-trust-relationship-in-rightscale).

## Creating a trust relationship in RightScale

In this section, we will set up a trust relationship for Okta within RightScale. As a result, RightScale will know your identity provider's information, which permits your IdP to initiate logins.

!!warning *Note:* You must have the "enterprise_manager" role for the RightScale account you wish to associate with Okta.

1. In a new tab in your browser, navigate to the account you wish to administer in RightScale.
1. In the blue nav menu at the top of the screen, select "Settings" and navigate to "Single Sign-on" under the "Enterprise" section. (If you do not see this option, then you do not have the "enterprise_manager" role for the current account.)
1. On the resulting page, you should see a list of existing SAML Identity Providers near the top and, above the list, you should see a "New" button. Click the "New" button.
1. In the resulting form, enter the following values:

    | Input Name | Value |
    | ---------- | ----- |
    | *Display Name* | Your choice, e.g. `Okta` |
    | *Login Method* | Leave "Allow RightScale-initiated SSO using a discovery hint" unchecked |
    | *SAML SSO Endpoint* | Enter Okta's Value 1 from the screen open in other tab |
    | *SAML EntityID* | Enter Okta's Value 2 from the screen open in other tab |
    | *SAML Signing Certificate* | Click the button below Okta's Value 3 in the other tab to save and upload here |

1. Click the "Save" button and you will be returned to the Identity Provider list page. You should see your newly created IdP in this list.
1. Next, click the button to the right to test your IdP configuration. You should be redirected to your IdP where you can log in and complete the SSO login. If you didn't assign the application created when configuring Okta to your Okta user, then you will need to do so before completing this step.
1. Finally, if you wish to have users provisioned via SSO then you will need to [Enable authority for your new IdP over the SAML-asserted email domains](../../saml/registering_idp_authority.html).

This concludes configuration of your SAML Identity Provider in RightScale. Please continue on to [Step 3: Test IdP-Initiated Single Sign-On](index.html#detailed-instructions-step-3--test-idp-initiated-single-sign-on).
