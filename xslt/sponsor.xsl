<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [  
<!ENTITY tw "http://tw.rpi.edu/schema/">
<!ENTITY here "http://tw.rpi.edu/instances/">
<!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
  xmlns:tw="&tw;" 
  xmlns:fn="http://www.w3.org/2005/xpath-functions" 
  xmlns:time="http://www.w3.org/2006/time#" 
  xmlns:owl="http://www.w3.org/2002/07/owl#" 
  xmlns:foaf="http://xmlns.com/foaf/0.1/" 
  xmlns:dc="http://purl.org/dc/terms/" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:template match="/">
    <xsl:param name="root" select="/"/>
    <div style="text-align:center;font-size:1pt;">
      <xsl:for-each select="//foaf:Organization|//*[rdf:type/@rdf:resource='&foaf;Organization']">
        <xsl:variable name="url">
          <xsl:call-template name="get-organization-page">
            <xsl:with-param name="organization" select="current()"/>
            <xsl:with-param name="root" select="$root"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="name">
          <xsl:call-template name="get-organization-name">
            <xsl:with-param name="organization" select="current()"/>
            <xsl:with-param name="root" select="$root"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="logo-raw">
          <xsl:call-template name="get-organization-logo">
            <xsl:with-param name="organization" select="current()"/>
            <xsl:with-param name="root" select="$root"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="logo" select="exsl:node-set($logo-raw)/*"/>
        <a href="{$url}">
          <xsl:call-template name="place-image">
            <xsl:with-param name="image" select="$logo"/>
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="style">padding-right:20px;vertical-align:middle;width:90px;</xsl:with-param>
            <xsl:with-param name="rdfa">foaf:logo</xsl:with-param>
          </xsl:call-template>
        </a>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>