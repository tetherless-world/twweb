<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [  
<!ENTITY tw "http://tw.rpi.edu/schema/">
<!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
  xmlns:tw="&tw;" 
  xmlns:time="http://www.w3.org/2006/time#" 
  xmlns:owl="http://www.w3.org/2002/07/owl#" 
  xmlns:s="http://www.w3.org/2005/sparql-results#" 
  xmlns:foaf="http://xmlns.com/foaf/0.1/" 
  xmlns:dc="http://purl.org/dc/terms/" 
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template name="get-organization-name">
    <xsl:param name="organization"/>
    <xsl:value-of select="$organization/foaf:name"/>
  </xsl:template>
  <xsl:template name="get-organization-parent">
    <xsl:param name="organization"/>
    <xsl:param name="root"/>
    <xsl:choose>
      <xsl:when test="$organization/tw:hasParentOrganization/@rdf:resource">
        <xsl:copy-of select="$root//*[@rdf:about=$organization/tw:hasParentOrganization/@rdf:resource]"/>
      </xsl:when>
      <xsl:when test="$organization/tw:hasParentOrganization/@rdf:nodeID">
        <xsl:copy-of select="$root//foaf:Organization[@rdf:nodeID=$organization/tw:hasParentOrganization/@rdf:nodeID]|$root//*[@rdf:nodeID=$organization/tw:hasParentOrganization/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Organization']"/>
      </xsl:when>
      <xsl:when test="$organization/tw:hasParentOrganization/*">
        <xsl:copy-of select="$organization/tw:hasParentOrganization/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="get-organization-link">
    <xsl:param name="organization"/>
    <xsl:value-of select="$organization/dc:source/@rdf:resource"/>
  </xsl:template>
  <xsl:template name="get-organization-acronym">
    <xsl:param name="organization"/>
    <xsl:value-of select="$organization/tw:hasAcronym"/>
  </xsl:template>
  <xsl:template name="get-organization-description">
    <xsl:param name="organization"/>
    <xsl:copy-of select="$organization/dc:description"/>
  </xsl:template>
  <xsl:template name="get-organization-logo">
    <xsl:param name="organization"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="$organization/foaf:logo/@rdf:resource">
        <xsl:copy-of select="$root//*[@rdf:about=$organization/foaf:logo/@rdf:resource]"/>
      </xsl:when>
      <xsl:when test="$organization/foaf:logo/@rdf:nodeID">
        <xsl:copy-of select="$root//*[@rdf:nodeID=$organization/foaf:logo/@rdf:nodeID]/*/.."/>
      </xsl:when>
      <xsl:when test="$organization/foaf:logo/*">
        <xsl:copy-of select="$organization/foaf:logo/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="get-organization-sponsored-projects">
    <xsl:param name="organization"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$root//*[tw:hasSponsor/@rdf:resource=$organization/@rdf:about]|$root//*[tw:hasSponsor/*/@rdf:about=$organization/@rdf:about]">
      <xsl:copy-of select="current()"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="get-organization-page">
    <xsl:param name="organization"/>
    <xsl:choose>
      <xsl:when test="$organization/tw:page">
        <xsl:for-each select="$organization/tw:page">
          <xsl:if test="contains(@rdf:resource,'web') and contains(@rdf:resource,'tw.rpi.edu')">
            <xsl:value-of select="@rdf:resource"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$organization/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="place-organization-link">
    <xsl:param name="organization"/>
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-organization-page">
        <xsl:with-param name="organization" select="$organization"/>
      </xsl:call-template>
    </xsl:variable>
    <span>
      <xsl:if test="$rel!=''">
        <xsl:attribute name="rel">
          <xsl:value-of select="$rel"/>
        </xsl:attribute>
      </xsl:if>
      <span about="{$organization/@rdf:about}" typeof="foaf:Organization">
        <a href="{$uri}" rel="tw:page" property="foaf:name">
          <xsl:call-template name="get-organization-name">
            <xsl:with-param name="organization" select="$organization"/>
          </xsl:call-template>
        </a>
      </span>
    </span>
  </xsl:template>
</xsl:stylesheet>