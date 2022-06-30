---
title: How does RightScale store my credentials?
category: vmware
description: RightScale uses database column encryption to ensure the confidentiality and integrity of sensitive data, such as cloud credentials, that are stored on behalf of RightScale's customers.
---

## Background Information

In order for your vSphere environment (or portion thereof) to be properly managed through the RightScale platform, you will need to give RightScale the necessary credentials to securely access your cloud environment. Therefore, you may be worried about how your vSphere cloud's credentials are stored in the RightScale platform in order to prevent sensitive information from being compromised.

## Answer

RightScale uses database column encryption to ensure the confidentiality and integrity of sensitive data, such as cloud credentials, that are stored on behalf of RightScale's customers. Sensitive columns are encrypted at the application layer with AES128-CBC, using the PKCS#5 passphrase-based KDF for key derivation.  See the **Data Protection in Database** section in the [Information Handling](http://support.rightscale.com/Security/2_Standard_Practices/Information_Handling/) document.
