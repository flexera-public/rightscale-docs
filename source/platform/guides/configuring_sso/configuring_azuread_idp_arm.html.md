---
title: Configuring AzureAD
description: Procedure for connecting AzureAD to the RightScale Cloud Management Platform.
---

## Creating a trust relationship in AzureAD

1. Login to <a href="https://portal.azure.com/" target="_blank">Microsoft Azure</a>
1. Select the Directory you wish to integrate with RightScale from the picker in the upper right corner.
1. Select **Azure Active Directory** from the left hand navigation pane. Note: It may be found under **More services**.
1. In the **Azure Active Directory** blade, under **Manage**, select **Enterprise Applications**.
1. Select **New Application**.
1. Under **Categories** select **All** and search for **RightScale** within the **Add an application** blade.
1. Select the **RightScale** application and give it a custom name, or accept the default, and select **Add**
1. Open the App and select **Configure single sign-on**.
1. Select the option **SAML-based Sign-On**
1. In the **Identifier** field, input `https://login.rightscale.com/login/saml2/metadata/`
1. In the **Reply URL** field, input `https://login.rightscale.com/login/saml2/consume`
1. Fill out the **User Attributes** section with the appropriate [user field mappings](index.html#detailed-instructions-step-2--set-up-attribute-mappings), if the defaults are not sufficient. 
1. Click **Save**
1. Under the **Single sign-on** tab of the application click the **Configure RightScale** link at the bottom. Scroll down to the **Quick Reference** section and copy the **Azure AD Single Sign-On Service URL** and **Azure AD SAML Entity ID** values, and download the Azure AD Signing Certificate.

<a href="https://docs.microsoft.com/en-us/azure/active-directory/active-directory-saas-rightscale-tutorial" target="_blank">Microsoft Tutorial: Azure Active Directory integration with RightScale</a>

## Creating a trust relationship in RightScale

In this section, we will set up a trust relationship for AzureAD within RightScale. As a result, RightScale will know your identity provider's information, which permits your IdP to initiate logins.

!!warning *Note:* You must have the `enterprise_manager` role for the RightScale account you wish to associate with AzureAD.

1. In a new tab in your browser, navigate to the account you wish to administer in RightScale.
1. In the blue nav menu at the top of the screen, select **Settings** and navigate to **Single Sign-on** under the **Enterprise** section. (If you do not see this option, then you do not have the `enterprise_manager` role for the current account.)
1. On the resulting page, you should see a list of existing SAML Identity Providers near the top and, above the list, you should see a **New** button. Click the **New** button.
1. In the resulting form, enter the following values:

    | Input Name | Value |
    | ---------- | ----- |
    | *Display Name* | Your choice, e.g. `MyCompany AzureAD` |
    | *Login Method* | Leave **Allow RightScale-initiated SSO using a discovery hint** unchecked for IdP initiated login |
    | *SAML SSO Endpoint* | Enter AzureADs' Single Sign-On Service URL e.g. `https://login.microsoftonline.com/xxxxx`  |
    | *SAML EntityID* | Enter AzureADs' SAML Entity ID e.g. `https://sts.windows.net/xxxxx` |
    | *SAML Signing Certificate* | Upload the x509 certificate that AzureAD uses to sign its SAML assertions |

1. Click the **Save** button and you will be returned to the Identity Provider list page. You should see your newly created IdP in this list.
1. Click the pencil button on the right to edit your SSO configuration. Check the box for **Compress SAML Requests** and click **Save**.
1. Next, click the button to the right to test your IdP configuration. You should be redirected to your IdP where you can log in and complete the SSO login.
1. Finally, if you wish to have users provisioned via SSO then you will need to [Enable authority for your new IdP over the SAML-asserted email domains](../../saml/registering_idp_authority.html).

This concludes configuration of your SAML Identity Provider in RightScale. Please continue on to [Step 3: Test IdP-Initiated Single Sign-On](index.html#detailed-instructions-step-3--test-idp-initiated-single-sign-on).
