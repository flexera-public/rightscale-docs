---
title: Server Certificates - Actions
description: Common procedures for working with Server Certificates in the RightScale Cloud Management Dashboard.
---

## Create an AWS Server Certificate

### Overview

Use the procedure outlined below to create a new AWS Server Certificate by uploading a user-generated key pair.

### Prerequisites

* AWS Account
* 'actor' user role privileges
* A Certificate Signing Request (CSR) - If you need to create one, see [Create a Certificate Signing Request (CSR)](/cm/dashboard/clouds/aws/actions/server_certificates_actions.html#create-a-certificate-signing-request) below.

### Steps

1. Go to **Clouds** > **AWS Global** > **Server Certificates**.
2. Click **Upload New Certificate**.
3. Provide the following information in order to create a new Server Certificate.
  * **Name** - The name of the Server Certificate.
  * **Path** - The path where the certificate will be stored on the server. The path must begin and end with a forward slash. (e.g. /server/path/)
  * **Description** - A brief description about the certificate.
  * **Certificate body** - Copy and paste the key information in your CSR file (e.g. server.crt).
  * **Private key** - Copy and paste the key information in your Private RSA Key file (e.g. server.key).
4. Click **Upload**.

Once you've created the Server Certificate you will not be able to edit the Certificate or Private Key. If you want to use a different Certificate or Private Key, you will need to create a new Server Certificate. Each Server Certificate you create will be assigned a unique identifier (ID) and an Amazon Resource Name (ARN).

## Create a Certificate Signing Request (CSR)

### Overview

A Certificate Signing Request (CSR) is a prerequisite for creating an AWS Server Certificate. The steps below describe how to generate an RSA key pair using an SSH console of a running Linux EC2 instance. Of course, you can also generate an RSA key using other tools.

Use the procedure outlined below to create a Certificate Signing Request (CSR) by using an SSH console of a Linux instance.

### Prerequisites

* 'actor' and 'server_login' user role privileges

### Steps

#### Generate a Private Key

* Launch a Linux-based EC2 instance. Once it becomes operational, SSH into the instance.
* Type the following command; where `server.key` is the name of the private key you are going to create. You will need to enter a passphrase, which you will later remove from the key in the following step.

  ~~~
    # openssl genrsa -des3 -out server.key 1024

    Generating RSA private key, 1024 bit long modulus
    .........................................................++++++
    ........++++++
    e is 65537 (0x10001)
    Enter PEM pass phrase:
    Verifying password - Enter PEM pass phrase:
  ~~~

* Next, you will need to remove the passphrase from the key. Type the following commands: (You'll need to enter your passphrase after the second command.)

  ~~~
    # cp server.key server.key.org

    # openssl rsa -in server.key.org -out server.key
    Enter pass phrase for server.key.org:[]
    writing RSA key
  ~~~

* To view the new private key, enter the following command:

  ~~~
    # less server.key

    -----BEGIN RSA PRIVATE KEY-----                                                 
    MIICXQIBAAKBgQDW0CMhRjZNSWtDt09cnSWum1ywrpNCTUnU2eIUGCPPom4UAzc5
    EQGk/JMz2dAofn0wvaBt945C1zkfxN0bDbOH3yV7pq7u/ZtAM3uN0SAYOlVbygHh
    FOrTur+ADKvLELI6aDejMciayR79Wl0I7qqWmt5g5xPNJLBwcvPcSHz6vwIDAQAB
    AoGAJgc+0NsvLct7k8dV411mmFykshqVsz0ffvD7lvcXD+D/f8d59T5PfjfAj4NV
    2HVcEE7hodYbdzXGxRsC0ZFBYM9WI3mRzKJ/P1ej4ME6D2C0OgLwycQWmSa0hvoJ
    aet5XCPeP6TI+L7Obs63z8rTCaQ9myLmYTUmPWXDHPEZFvECQQDsKLStXkxDkAeI
    FOrTur+ADKvLELI6aDejMciayR79Wl0I7qqWmt5g5xPNJLBwcvPcSHz6vwIDAQAB
    RZX/OAKNAkEA6NxS1E4/g+YF5c6/vdxTWzxaNDXngBHW7oNdJihAQ4LjxyS28FWb
    /mgIb/CxeMuBDZ/DxbwTRhx4v4Fg5GMFewJBAKY+tYoCAt/g6VzSAlBk6aVPS6+c
    FOrTur+ADKvLELI6aDejMciayR79Wl0I7qqWmt5g5xPNJLBwcvPcSHz6vwIDAQAB
    xDNllyrNhqyS5vN7fTYUvxjcKakYY61L4LnulTBXbhquSJe6Hj0ZP/MTh/taR7DP
    dcFLS5CNlblaDmVgq1k1AkB/xHH+r7Q9dFUdQdzbYsQPRcqpFjLxoc7jGDY6yORK
    rlaq+sx2brTHWLMVsm1gEZDkbNTTwnLA6HGwcr7PGcOT
    -----END RSA PRIVATE KEY-----
  ~~~   

* Enter 'q' to exit.

#### Generate a Certificate Signing Request (CSR)

Now that you've generated the private key, you can create the CSR.

* Type the following command; where `server.key` is the name of the private key you just created.

  ~~~
    # openssl req -new -key server.key -out server.csr

  ~~~

* You will need to provide some additional information. Click 'Enter' to ignore the last two optional parameters.

  ~~~
    Country Name (2 letter code) [GB]:US
    State or Province Name (full name) [Berkshire]:California
    Locality Name (eg, city) [Newbury]:Santa Barbara
    Organization Name (eg, company) [My Company Ltd]:RightScale
    Organizational Unit Name (eg, section) []:Education
    Common Name (eg, your name or your server's hostname) []:www.rightscale.com
    Email Address []:someone@rightscale.com
    Please enter the following 'extra' attributes
    to be sent with your certificate request
    A challenge password []:
    An optional company name []:
  ~~~

* Next, you will need to generate a self-signed certificate. Type the following command to generate a temporary certificate. In the example below, it will good for 365 days.

  ~~~
    # openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
  ~~~

* To view the new certificate, enter the following command:

  ~~~
    # less server.crt

    -----BEGIN CERTIFICATE-----                                                    
    MIICwTCCAioCCQCtRiu2Yg9z4jANBgkqhkiG9w0BAQUFADCBpDELMAkGA1UEBhMC
    VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbnRhIEJhcmJhcmEx
    EzARBgNVBAoTClJpZ2h0U2NhbGUxEjAQBgNVBAsTCUVkdWNhdGlvbjEbMBkGA1UE
    AxMSd3d3LnJpZ2h0c2NhbGUuY29tMSIwIAYJKoZIhvcNAQkBFhNkZWFuQHJpZ2h0
    c2NhbGUuY29tMB4XDTExMDIyMzIwNDYxNVoXDTEyMDIyMzIwNDYxNVowgaQxCzAJ
    BgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1TYW50YSBC
    YXJiYXJhMRMwEQYDVQQKEwpSaWdodFNjYWxlMRIwEAYDVQQLEwlFZHVjYXRpb24x
    GzAZBgNVBAMTEnd3dy5yaWdodHNjYWxlLmNvbTEiMCAGCSqGSIb3DQEJARYTZGVh
    EzARBgNVBAoTClJpZ2h0U2NhbGUxEjAQBgNVBAsTCUVkdWNhdGlvbjEbMBkGA1UE
    6Waig6cMw8h6y/2Vb7hCaJillgMGekPrIayydT4L2vosxfSObJthNLihQw3c8g0c
    gUXVmXEnZAfgPQmoXfWRerARmTArVOwDxbfbJdZMjecJZA7PKN8B/aPLofNaZibN
    Vd+zIIZ9JGtWCfBa98PpfujwKLseEkVxkMhyxHsCAwEAATANBgkqhkiG9w0BAQUF
    EzARBgNVBAoTClJpZ2h0U2NhbGUxEjAQBgNVBAsTCUVkdWNhdGlvbjEbMBkGA1UE
    Suu97lR9R8f7wzzPtsiO5Oj4lCquhbYmRq0TLXM7HXUVHGOERJO+6Ma8ECIbK5jb
    8GOT9ngnbU5sh3veww1JmJD96LVilW+NheC8D1DPT5Whbfb5kw==
    -----END CERTIFICATE-----
  ~~~

* Enter 'q' to exit.
