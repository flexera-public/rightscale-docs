<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
                xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns="https://login.rightscale.com/rpml/1.xsd"
                exclude-result-prefixes="saml samlp ds">

  <!-- override the default text matching template -->
  <xsl:template match="text()" />

  <!-- extract user metadata attributes.
       we only expect each attribute to appear once, but we use for-each to omit output tag
       when match fails. -->
  <xsl:template name="extract-user">
    <user>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[@Name='User.email']/saml:AttributeValue">
        <email><xsl:value-of select="."/></email>
      </xsl:for-each>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[@Name='User.LastName']/saml:AttributeValue">
        <surname><xsl:value-of select="."/></surname>
      </xsl:for-each>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[@Name='User.FirstName']/saml:AttributeValue">
        <givenname><xsl:value-of select="."/></givenname>
      </xsl:for-each>
    </user>
  </xsl:template>

  <!-- extract group membership attributes -->
  <xsl:template name="extract-memberships">
    <memberships>
      <xsl:for-each select="saml:Assertion/saml:AttributeStatement/saml:Attribute[@Name='memberOf']/saml:AttributeValue">
        <membership><xsl:value-of select="."/></membership>
      </xsl:for-each>
    </memberships>
  </xsl:template>

  <!-- match the root node (samlp:Response) and output our own <rpml> root
       node, then call xsl templates within the context of the saml:Assertion
       node to fill in the rest -->
  <xsl:template match="//samlp:Response">
    <rpml>
      <xsl:call-template name="extract-user"/>
      <xsl:call-template name="extract-memberships"/>
    </rpml>
  </xsl:template>
</xsl:stylesheet>
