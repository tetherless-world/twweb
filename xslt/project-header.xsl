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
	        xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:template name="project-header">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <div class="project">
      <link href="/css/project.css" type="text/css" rel="stylesheet"/>
    <div class="header">
    <h1 xmlns:tw="&tw;">
      <xsl:variable name="logo-raw">
	<xsl:call-template name="get-project-logo">
	  <xsl:with-param name="project" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:choose>
	<xsl:when test="$logo-raw!=''">
	  <span about="{$node/@rdf:about}" rel="foaf:logo">
          <xsl:variable name="logo" select="exsl:node-set($logo-raw)"/>
	  <xsl:call-template name="place-image">
	    <xsl:with-param name="image" select="$logo/*"/>
      	    <xsl:with-param name="rel">foaf:logo</xsl:with-param>
	  </xsl:call-template>
	  </span>
	</xsl:when>
	<xsl:otherwise>
	  <img src="https://tw.rpi.edu/images/tw-logo-v2.png" alt="TW Logo"/>
	</xsl:otherwise>
      </xsl:choose>
    </h1>
  </div>
  </div>
 </xsl:template>
</xsl:stylesheet> 
