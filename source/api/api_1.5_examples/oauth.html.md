---
title: OAuth
layout: general.slim
---

## Overview

OAuth-compatible authentication and authorization supports a password-less Dashboard user that can log into the API and make authenticated requests. This feature is currently in public beta. Please contact support with any issues.

With OAuth, you can make authenticated API 1.0 and 1.5 requests without needing a password and can be disabled at any time without changing your password.

## Obtaining an OAuth Grant

Follow the steps below to enable OAuth:

1. Make sure you're in the account you want to enable with OAuth.
2. Go to **Settings** > **Account Settings** > **API Credentials**.
3. In **Status** , click **enable**.
4. Obtain the API refresh token in order to make API requests without logging in. It's important that this token is protected.
5. Lastly, take note of the *Token Endpoint (API 1.5)* value as this is required when making API request.

**Note** : The hostname of the *Token Endpoint (API 1.5)* may vary between RightScale accounts depending on the geographical region in which each account is hosted. 

Example:
<br>**Token Endpoint (API 1.5):** 	https://us-3.rightscale.com/api/oauth2 

Make sure to use the correct endpoint for your account when making API request, both OAuth and otherwise.

## Curl

### Obtaining an API Access Token

**Note** : The following examples use API 1.5.

**Example Call**

~~~
    #Obtain these values from the 'Settings > Account > API Credentials' page
    #Example: API_ENDPOINT="us-3"

    my_token_endpoint="https://$API_ENDPOINT.rightscale.com/api/oauth2"
    my_refresh_token="0facab1a657fff56f3214ecf7eeeafbfe6084052"

    curl --include \
      -H "X-API-Version:1.5" \
      --request POST "$my_token_endpoint" \
      -d "grant_type=refresh_token" \
      -d "refresh_token=$my_refresh_token"
~~~

**Example Response**

~~~
    HTTP/1.1 200 OK

    Content-Type: application/json; charset=utf-8
    Cache-Control: private, max-age=0, must-revalidate
    Pragma: no-cache

    {
      "access_token":"eNotkMuOg...8vf4A2GhbCA==",
      "expires_in":7200,
      "token_type":"bearer"
    }
~~~

- Make note of the access_token to use when requesting a resource. See below for an example of how this is done.

### Making an OAuth-Authorized API Request

Once you obtain your access token, incorporate it into your API requests.

**Example Call**

~~~
    access_token="eNotkMuOg...8vf4A2GhbCA=="

    curl --include \
      -H "X-API-Version:1.5" \
      -H "Authorization: Bearer $access_token" \
      --request GET "https://$API_ENDPOINT.rightscale.com/api/deployments"
~~~

**Example Response**

~~~
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8

    {...}
~~~

## PowerShell

### Obtaining an API Access Token

**Note** : The following examples use API 1.5.

**Example Call**

~~~
<#
Example: API_ENDPOINT="us-3"
#>
    $oauthRefreshToken = "0facab1a657fff56f3214ecf7eeeafbfe6084052"
    
    $oauthUrl = "https://$API_ENDPOINT.rightscale.com/api/oauth2"
    $postString = "grant_type=refresh_token;refresh_token=$oauthRefreshToken;"
    $postBytes = [System.Text.Encoding]::UTF8.GetBytes($postString)

    $httpRequest = [System.Net.WebRequest]::Create($oauthUrl)
    $httpRequest.Method = "POST"
    $httpRequest.headers.Add("X_API_VERSION", "1.5")
    $httpRequest.ContentLength = $postbytes.Length
    $requestStream = $httpRequest.GetRequestStream()
    $requestStream.Write($postBytes, 0, $postBytes.length)

    [System.Net.WebResponse] $httpResponse = $httpRequest.GetResponse()
    $responseStream = $httpResponse.GetResponseStream()
    [System.IO.StreamReader] $streamReader = New-Object System.IO.Streamreader -ArgumentList $responseStream
    $httpResult = $streamReader.ReadToEnd()
    write-host $httpResult
~~~

**Example Response**

~~~
    write-host $httpResult

    {
      "access_token":"eNotkMuOg...8vf4A2GhbCA==",
      "expires_in":7200,
      "token_type":"bearer"
    }
~~~

- Make note of the access_token to use when requesting a resource. See below for an example of how this is done.

## Making an OAuth-Authorized API Request

Once you obtain your access token, incorporate it into your API requests.

**Example Call**

~~~
    $accessToken="eNotkMuOg...8vf4A2GhbCA=="

    $httpRequest = [System.Net.WebRequest]::Create("https://$API_ENDPOINT.rightscale.com/api/deployments")
    $httpRequest.Method = "GET"
    $httpRequest.Headers.Add("X_API_VERSION","1.5")
    $httpRequest.Headers.Add("Authorization","Bearer $accessToken")
    [system.Net.WebResponse] $httpResponse = $httpRequest.GetResponse()
    $responseStream = $httpResponse.GetResponseStream()
    [System.IO.StreamReader] $streamReader = New-Object System.IO.Streamreader-ArgumentList $responseStream
    $httpResult = $streamReader.ReadToEnd()
    write-host $httpResult
~~~

**Example Response**

~~~
    HTTP/1.1 200 OK

    Content-Type: application/json; charset=utf-8



    {...}
~~~

## Additional Notes

- Anyone who possesses a valid token can log into the enabled account via the API and perform API requests on your behalf, with all of your permissions. Please protect this token appropriately.
- The OAuth API feature allows users with Single Sign-On enabled to access the API without a username/password combination.
- "Enable" enables OAuth for your account and generates a valid token. This token does not expire until it is "disabled" which will make the previous token invalid. The next time it is "enabled," a new token will be generated.

## See also

- [Enable OAuth](/cm/dashboard/settings/account/enable_oauth.html)
