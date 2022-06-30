---
title: Configuring ADFS
description: Procedure for connecting ActiveDirectory Federation Services (ADFS) to the RightScale Cloud Management Platform.
---

## Creating a trust relationship in ADFS

1. Open the ADFS administration snap-in.
1. Right-click "Trust Relationships > Relying Party Trusts" and choose "Add Relying Party Trust."
1. On the second screen of the wizard, enter RightScale's [SP metadata URL](https://login.rightscale.com/login/saml2/metadata).
    - Review the auto-configured settings to ensure they look reasonable
    - Save the new trust relationship
1. Right-click on the new trust relationship, choose "Properties," and navigate to the "Advanced" tab
    - Change "Secure hash algorithm" to "SHA-1"
    - Click "OK" to save the changes
1. Add a new transform claim rule for the trust relationship.
    - Choose the rule type "Send LDAP attributes as claims"
    - Choose ActiveDirectory as the attribute store.
    - Configure mappings for Name ID and the three [RightScale-required attributes](../../saml) as shown in the screenshow below.

![Transform Claim Rule Mapping](/img/platform-guides-saml-adfs-rule-mapping.png)


## Creating a trust relationship in RightScale

In this section, we will set up a trust relationship for ADFS within RightScale. As a result, RightScale will know your identity provider's information, which permits your IdP to initiate logins.

!!warning *Note:* You must have the "enterprise_manager" role for the RightScale account you wish to associate with ADFS.

1. In a new tab in your browser, navigate to the account you wish to administer in RightScale.
1. In the blue nav menu at the top of the screen, select "Settings" and navigate to "Single Sign-on" under the "Enterprise" section. (If you do not see this option, then you do not have the "enterprise_manager" role for the current account.)
1. On the resulting page, you should see a list of existing SAML Identity Providers near the top and, above the list, you should see a "New" button. Click the "New" button.
1. In the resulting form, enter the following values:

    | Input Name | Value |
    | ---------- | ----- |
    | *Display Name* | Your choice, e.g. `MyCompany ADFS` |
    | *Login Method* | Leave "Allow RightScale-initiated SSO using a discovery hint" unchecked |
    | *SAML SSO Endpoint* | Enter ADFS' SAML request endpoint e.g. `https://mycompany.com/adfs/ls/`  |
    | *SAML EntityID* | Enter ADFS' entity ID e.g. `http://mycompany.com/adfs/services/trust` |
    | *SAML Signing Certificate* | Upload the x509 certificate that ADFS uses to sign its SAML assertions |

1. Click the "Save" button and you will be returned to the Identity Provider list page. You should see your newly created IdP in this list.
1. Next, click the button to the right to test your IdP configuration. You should be redirected to your IdP where you can log in and complete the SSO login. If you didn't assign the application created when configuring ADFS to your ADFS user, then you will need to do so before completing this step.
1. Finally, if you wish to have users provisioned via SSO then you will need to [Enable authority for your new IdP over the SAML-asserted email domains](../../saml/registering_idp_authority.html).

This concludes configuration of your SAML Identity Provider in RightScale. Please continue on to [Step 3: Test IdP-Initiated Single Sign-On](index.html#detailed-instructions-step-3--test-idp-initiated-single-sign-on).
