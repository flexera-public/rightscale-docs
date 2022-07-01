---
title: When I click on to Self Service, I am redirected in a loop to a page where I am asked to do an account selection.

category: general
description: If one select the account in SS account selection page and click submit, it redirects to the same page again.
---

## Background

From the Cloud Management dashboard, when switching to the Self-Service portal, a user will be presented with an account selection (if the user has access to multiple accounts)
If you select an account in SS account selection page and click submit, it redirects to the same page again in a loop.

## Answer

The problem is how the user was created, he/she does not have a firstname and/or lastname. This is the most common reason for getting kicked back from SS. This is also mostly seen for users that was created via API and connected via SAML SSO. 

To fix this:
- Make sure that the user have firstname and/or lastname from the source (Idp/SP) or
- Raise a ticket to support@rightscale.com to fix the issue.

**Questions? Concerns?**

Call us at **(866) 787-2253** or feel free to send in a support request from the RightScale dashboard (Support > Email).
