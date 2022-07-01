<?xml version="1.0"?>
<!--
Provisioning template for SAML assertions that are compatible with the "classic"
RightScale SAML implementation as documented at
http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Settings/User/Actions/Getting_Started_with_SAML/index.html

Classic assertions have three attributes with fixed names:
1. email
2. surname
3. givenname
-->
<xsl:stylesheet version="1.0"
                xmlns="https://login.rightscale.com/rpml/1.xsd"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
                xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                exclude-result-prefixes="saml samlp ds">

  <!-- override the default text matching template -->
  <xsl:template match="text()" />

  <!-- extract user metadata attributes.
       we only expect each attribute to appear once, but we use for-each to omit output tag
       when match fails. -->
  <xsl:template name="extract-user">
    <user>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[contains(@Name, 'email')]/saml:AttributeValue">
        <email><xsl:value-of select="."/></email>
      </xsl:for-each>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[contains(@Name, 'surname')]/saml:AttributeValue">
        <surname><xsl:value-of select="."/></surname>
      </xsl:for-each>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[contains(@Name, 'givenname')]/saml:AttributeValue">
        <givenname><xsl:value-of select="."/></givenname>
      </xsl:for-each>
    </user>
  </xsl:template>

  <!-- match the root node (samlp:Response) and output our own <rpml> root
       node, then call xsl templates within the context of the saml:Assertion
       node to fill in the rest -->
  <xsl:template match="//samlp:Response">
    <rpml>
      <xsl:call-template name="extract-user"/>
    </rpml>
  </xsl:template>
</xsl:stylesheet>
