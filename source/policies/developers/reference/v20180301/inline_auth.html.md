---
title: Policy Template Inline Authorization
description: This page outlines the legacy auth block in the policy template language.
version_number: "20180301"
alias: [policies/reference/inline_auth.html, policies/reference/v20180301/inline_auth.html]
versions:
  - name: "20180301"
    link: /policies/reference/v20180301/inline_auth.html
---


## Inline Authorization

!!warning*Note*Inline authorization is deprecated and has been replaced by the [credentials](/policies/reference/policy_template_language.html#authorization) declaration. The credentials declaration defers handling of authentication/authorization against external APIs to a centralized credentials store. It is highly recommended to always the `credentials` declaration for several reasons. First, credential values read-only and more secure. Second, it centralizes authentication against external APIs and makes the same credentials available across the entire suite of Flexera products.

For inline authorization, the `auth` you can define how to authenticate against an API inline in the code itself. `auth` declarations can be references when describing a datasource in the exact same manner `credentials` references can. Secrets for this method must be stored in the "Cloud Management" dashboard under "Design -> Credentials". A variety of authorization schemes are supported. The syntax of the `auth` definition is:


``` text
auth <name>, type: <type> do
   <property> <term>
   <property> <term>
   ...
end
```

Where:

* `<name>` is the name of the auth reference.
* `<type>` is the type of the scheme.

The properties used to define a scheme depends on its type. See the [Authorization Reference](#authorization-reference) section for a description of
the available authorization schemes and their properties.

Example:

```ruby
auth "aws_us_east_1", type: "aws" do
  version    4
  service    "ec2"
  region     "us-east-1"
  access_key cred("AWS_ACCESS_KEY_ID")
  secret_key cred("AWS_SECRET_ACCESS_KEY")
end
```


## Authorization Reference

The following table lists all the authorization schemes supported by the Policy Template Language. For each scheme the table lists the corresponding properties. Required properties are marked with `(*)`.

### AWS

AWS authentication provides ways to authenticate against arbitrary AWS services.
Service and region can be omitted or set to "inferred" to let the signer determine them automatically from the request URL, allowing a single auth definition to work across multiple AWS services and their regions.


| Scheme | Properties                                              | Example                         |
|--------+---------------------------------------------------------+---------------------------------|
| `aws`  | `version`: Signature version, must be 3 or 4 (default). | `4`                             |
|        | `service`: AWS canonical service name.                  | `"ec2"`                         |
|        | `region`: AWS canonical region name.                    | `"us-east-1"`                   |
|        | `access_key(*)`: AWS access key ID.                     | `cred("AWS_ACCESS_KEY_ID")`     |
|        | `secret_key(*)`: AWS secret access key.                 | `cred("AWS_SECRET_ACCESS_KEY")` |

Example code block:

```ruby
auth "my_aws_auth", type: "aws" do
  version 4
  service "ec2"
  region "us-east-1"
  access_key "AKIAFOOBARBAZ"
  secret_key cred("AWS_SECRET_ACCESS_KEY")
end
```

### AWS STS

AWS STS authentication provides ways to authenticate against arbitrary AWS services using the [AWS Security Token Service](https://docs.aws.amazon.com/STS/latest/APIReference/Welcome.html).
Service and region can be omitted or set to "inferred" to let the signer determine them automatically from the request URL, allowing a single auth definition to work across multiple AWS services and their regions.

| Scheme    | Properties                                                                                       | Example                                    |
|-----------+--------------------------------------------------------------------------------------------------+--------------------------------------------|
| `aws_sts` | `version`: Signature version, must be 3 or 4 (default).                                          | `4`                                        |
|           | `service`: AWS canonical service name.                                                           | `"s3"`                                     |
|           | `region`: AWS canonical region name.                                                             | `"us-east-1"`                              |
|           | `access_key(*)`: AWS access key ID.                                                              | `cred("AWS_ACCESS_KEY_ID")`                |
|           | `secret_key(*)`: AWS secret access key.                                                          | `cred("AWS_SECRET_ACCESS_KEY")`            |
|           | `role_arn(*)`: Amazon Resource Name (ARN) of the role to assume.                                 | `"arn:aws:iam::031a1f6c8,:role/test-role"` |
|           | `role_session_name(*)`: Identifier for the assumed role session.                                 | `"open_buckets_policy"`                    |
|           | `policy_json`: Restrictive IAM policy in JSON format.                                            | `"{Version: "2012-10-17"...}"`             |
|           | `external_id`: Unique identifier that might be required when assuming a role in another account. | `"c4202e1830"`                             |

Example code block:

```ruby
auth "my_aws_auth", type: "aws" do
  version 4
  service 's3'
  access_key cred('AWS_ACCESS_KEY_ID')
  secret_key cred('AWS_SECRET_ACCESS_KEY')
  role_arn 'arn:aws:iam::031a1f6c8,:role/test-role'
  role_session_name 'open_buckets_policy'
  policy_json <<-EOS
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "*"
      }
    ]
  }
  EOS
  external_id 'unique_id_assigned_by_example_corp'
end
```

### Basic

Basic authentication performs [basic HTTP authentication](https://tools.ietf.org/html/rfc2617) using a `Authorization: Basic` header.

| Scheme   | Properties                                         | Example                         |
|----------+----------------------------------------------------+---------------------------------|
| `basic`  | `username(*)`: Username for basic authentication.  | `"myuser"` |
|          | `password(*)`: Password for basic authentication.  | `cred("MY_API_PASSWORD")` |

Example code block:
```ruby
auth "my_basic_auth", type: "basic" do
  username "user"
  password cred("THE_PASSWORD")
end
```

### NTLM

NTLM authentication performs [NTLM v2 HTTP authentication](https://en.wikipedia.org/wiki/NT_LAN_Manager).

| Scheme   | Properties                                         | Example                         |
|----------+----------------------------------------------------+---------------------------------|
| `ntlm`   | `username(*)`: Username for basic authentication.  | `"myuser"` |
|          | `password(*)`: Password for basic authentication.  | `cred("MY_API_PASSWORD")` |

Example code block:
```ruby
auth "my_ntlm_auth", type: "auth" do
  username "user"
  password cred("THE_PASSWORD")
end
```

### API Key

API Key authentication authenticates using an static API Key. It can set a header or query parameter on an http request depending on configuration options.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
| `api_key`  | `key(*)`: API Key. | `cred("MY_SECRET_KEY")` |
|            | `location(*)`: Location of auth field. "header" or "query". | `"header"` |
|            | `field(*)`: Header or query param field to set. | `"Authorization"` |
|            | `type(*)`: Type of authorization header, prefixes the key value. | `"Bearer"` |

Example code block:
```ruby
auth "my_api_key_auth", type: "api_key" do
  location "header"
  field "Authorization"
  type "Bearer"
  key cred("MY_API_KEY")
end
```

### JWT

JWT authenticates using a [Java web token](https://jwt.io/) retrieved from a login endpoint. Either basic auth or an
API key can be used to retrieve the JWT. Set the basic_auth_username and basic_auth_password fields
to use basic auth or the api_key field to use an API key. It is an error to specify
both. If neither is specified then the request to retrieve the token is not signed.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
|  `jwt` | `token_url(*)`: URL from which to retrieve the token. Either basic_auth or API key will be used.| `"https://web.url/login"` |
|        | `additional_headers`: Additional headers to send with the request to retrieve the jwt token.| `additional_headers do {<br> "API-Version": "1.0"<br> "X-Account": "700"<br> }` |
|        | `api_key`: API Key, if used. | `cred("MY_SECRET_KEY")` |
|        | `location`: Location of authorization if API Key is used. Allowed values: "header", "query". | `"header"` |
|        | `field`: Header or query param field to set if API Key is used. | `"Authorization"` |
|        | `type`: Type of authorization header, prefixes the key value, if API Key is used | `"Bearer"` |
|        | `basic_auth_username`: Username for basic authentication, if used. | `"myuser"` |
|        | `basic_auth_password`: Password for basic authentication, if used. | `cred("MY_API_PASSWORD")` |

Example code block:
```ruby
auth "my_jwt_auth", type: "jwt" do
  api_key cred("MY_API_KEY")
  token_url "https://web.url/login"
  location "header"
  field "Authorization"
  type "Bearer"
  additional_headers do {
    "X-Account": to_s(rs_project_id),
    "User-Agent": $user_agent_from_param,
    "Accept": "text/plain"
  } end
end
```

### OAuth2

OAuth2 authenticates using a OAuth2 access token retrieved from a login endpoint. OAuth endpoints can be authenticated using [Client Credentials](https://tools.ietf.org/html/rfc6749#section-1.3.4), a [Refresh Token](https://tools.ietf.org/html/rfc6749#section-1.5), or JWT token set in the Bearer field.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
|  `oauth2` | `token_url(*)`: OAuth 2 endpoint.| `"https://web.url/login/oauth2"` |
|           | `grant type(*)`: "client_credentials" or "jwt_bearer" or "refresh_token"| `grant type:"client_crendentials"` do<br>params...<br>end|


#### OAuth2 Client Credentials

OAuth2 client credentials can use either a client_id/client_secret combo which client_id and client_secret form parameters, or a client_user, client_password combo which sets a basic authentication header. Client credential authentication can be used to authenticate against various Azure APIs.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
| `client_credentials` | `client_id`: Client ID sent as form parameter, if used. | `"abc123"` |
|                      | `client_secret`: Client Secret sent as form parameter, if used | `cred("OAUTH2_SECRET")` |
|                      | `client_user`: Username for basic authentication, if used. | `"myuser"` |
|                      | `client_password`: Password for basic authentication, if used. | `cred("MY_API_PASSWORD")` |
|                      | `additional_headers`: Additional headers to send with authentication request.| `additional_headers do {<br> "API-Version": "1.0"<br> "X-Account": "700"<br> }` |
|                      | `additional_params`: Additional form params to send with authentication request.| `additional_params do {<br> "resource": "https://management.azure.com/"<br> }` |
|                      | `scopes`: List of scopes used to create access token. | `["api:read", "api:write"]` |


Example code block:
```ruby
auth "my_oauth2_client_credentials_auth", type: "oauth2" do
  token_url $token_url
  grant type: "client_credentials" do
    additional_headers do {
      "X-Account" => "60073"
    } end
    additional_params do {
      "please" => "yes"
    } end
    client_id "123"
    client_secret cred("JWT_CLIENT_SECRET")
  end
end
```

Example Azure ARM [client credentials](https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-oauth-code):
```ruby
parameter "tenant" do
  type "string"
  label "Tenant"
  description "ARM Tenant ID"
  default "mytenantname.onmicrosoft.com"
end

auth "azure_arm", type: "oauth2" do
  token_url join(["https://login.windows.net/",$tenant,"/oauth2/token"],"")
  grant type: "client_credentials" do
    additional_params do {
      "resource":  "https://management.azure.com/"
    } end
    client_id cred("ARM_CLIENT_ID")
    client_secret cred("ARM_CLIENT_SECRET")
  end
end
```

#### OAuth2 Refresh Token

OAuth2 refresh token fetches access token using a refresh token and client credentials set via a basic auth header.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
| `refresh_token` | `token(*)`: Refresh token to use. | `cred("MY_REFRESH_TOKEN")` |
|                 | `client_user`: Client user for basic authentication. | `"abc123"` |
|                 | `client_password`: Client password for basic authentication. | `cred("CLIENT_PASSWORD")` |
|                 | `additional_headers`: Additional headers to send with authentication request.| `additional_headers do {<br> "API-Version": "br> "X-Account": "700"<br> }` |
|                 | `scopes`: List of scopes used to create access token. | `["api:read", "api:write"]` |

Example code block:
```ruby
auth "my_oauth2_refresh", type: "oauth2" do
  token_url "https://us-3.rightscale.com/api/oauth2"
  grant type: "refresh_token" do
    additional_headers do {
      "X-Account": to_s(inc(1, 2))
    } end
    client $my_basic_auth
    token cred("MY_TOKEN")
    scopes "read", "write", "update", "delete"
  end
end
```

#### OAuth2 JWT Bearer

OAuth2 JWT Bearer crafts and signs [Java web tokens](https://jwt.io/) and sets the resulting token in `Authorization: Bearer` header.

| Scheme     | Properties | Example                 |
|------------+------------+-------------------------|
| `jwt_bearer` | `iss(*)`: Issuer of token | `"1234@developer.gserviceaccount.com"` |
|              | `signing_key(*)`: Key used to sign JWT token | `cred("MY_SIGNING_KEY")` |
|              | `sub`: Subject of token | `"1234@developer.gserviceaccount.com"` |
|              | `aud`: Intended audience, defaults to token_url | `"myuser"` |
|              | `alg`: Crytographic algorithm used. | `"RS256"` |
|              | `max_minutes`: Max minutes before refreshing token. | `60` |
|              | `additional_headers`: Additional headers to send with authentication request.| `additional_headers do {<br> "API-Versi0"<br> "X-Account": "700"<br> }` |
|              | `additional_claims`: Additional claims to put in the JWT.| `additional_claims do {<br> "scope":"https://www.googleapis.com/auth/prediction"<br> }` |
|              | `scopes`: List of scopes used to create JWT token. | `["api:read", "api:write"]` |

Example code block:
```ruby
auth "my_oauth2_jwt_bearer_auth", type: "oauth2" do
  token_url "https://www.googleapis.com/oauth2/v4/token"
  grant type: "jwt_bearer" do
    iss cred("GC_ACCOUNT_EMAIL")
    signing_key cred("GC_PRIVATE_KEY")
    alg "RS512"
    max_minutes 90
    aud "https://www.googleapis.com/oauth2/v4/token"
    additional_headers do {
      "Some-Header" => "Some Value"
    } end
    additional_claims do {
      "scope": "https://www.googleapis.com/auth/prediction"
    } end
    scopes ["https://www.googleapis.com/auth/admin.datatransfer.readonly"]
  end
end
```