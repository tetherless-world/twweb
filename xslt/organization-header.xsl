<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
]>

<!-- the transformations -->

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:exsl="http://exslt.org/common"
	        xmlns:foaf="http://xmlsn.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:template name="organization-header">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <div class="organization">
      <link href="/css/organization.css" type="text/css" rel="stylesheet"/>
    <div class="header">
    <h1 xmlns:tw="&tw;">
      <xsl:variable name="url-raw">
        <xsl:if test="$embed=false()">
	  <xsl:call-template name="get-organization-page">
	    <xsl:with-param name="organization" select="$node"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
        </xsl:if>
        <xsl:if test="$embed=true()">
	  <xsl:call-template name="get-organization-link">
	    <xsl:with-param name="organization" select="$node"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
        </xsl:if>
      </xsl:variable>
      <xsl:variable name="url" select="exsl:node-set($url-raw)"/>
      <xsl:variable name="logo-raw">
	<xsl:call-template name="get-organization-logo">
	  <xsl:with-param name="organization" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:variable name="logo" select="exsl:node-set($logo-raw)"/>
      <a href="{$url}">
      <xsl:call-template name="place-image">
	<xsl:with-param name="image" select="$logo/*"/>
	<xsl:with-param name="style">width:100px;padding-right:20px;vertical-align:middle;</xsl:with-param>
      </xsl:call-template>
      </a>
      <xsl:if test="$embed=false()">
        <a href="{$url}">
          <xsl:call-template name="get-organization-name">
	    <xsl:with-param name="organization" select="$node"/>
          </xsl:call-template>
        </a>
      </xsl:if>
    </h1>
    <p class="lead">
      <xsl:variable name="parent-raw">
	<xsl:call-template name="get-organization-parent">
	  <xsl:with-param name="organization" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:variable name="parent" select="exsl:node-set($parent-raw)/*"/>
      <xsl:if test="$parent-raw!=''">
        <span class="label">Parent Organization: </span>
        <xsl:call-template name="place-organization-link">
	  <xsl:with-param name="organization" select="$parent"/>
	  <xsl:with-param name="rel">tw:hasParentOrganization</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </p>
  </div>
  </div>
 </xsl:template>
</xsl:stylesheet> 

