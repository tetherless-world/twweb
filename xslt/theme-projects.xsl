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
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:foaf="&foaf;"
>
  <xsl:import href="/xslt/theme-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/project-list.xsl"/>

  <xsl:template match="tw:Theme|*[rdf:type/@rdf:resource='&tw;Theme']" mode="place-projects">
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root"/>

    <xsl:variable name="theme" select="."/>

    <xsl:variable name="projects-raw">
      <xsl:call-template name="get-theme-projects">
	<xsl:with-param name="theme" select="$theme"/>
         <xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projects" select="exsl:node-set($projects-raw)"/>
    <xsl:if test="$projects-raw!=''">
      <div class="theme">
	<link href="/css/theme.css" type="text/css" rel="stylesheet"/>
	<link href="/css/objects.css" type="text/css" rel="stylesheet"/>
	<div class="description section" id="theme-projects">
	  <xsl:call-template name="header">
	    <xsl:with-param name="text">Projects</xsl:with-param>
	    <xsl:with-param name="stylesheet">theme-projects</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="project-list">
	    <xsl:with-param name="projects" select="$projects/*"/>
	    <xsl:with-param name="root" select="$root"/>
	    <xsl:with-param name="embed" select="$embed"/>
	    <xsl:with-param name="admin" select="$admin"/>
	  </xsl:call-template>
	</div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="theme-projects">
    <xsl:param name="node"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <div class="section">
      <link href="/css/document.css" type="text/css" rel="stylesheet"/>
      <xsl:apply-templates select="$node" mode="place-projects">
        <xsl:with-param name="admin" select="$admin"/>
        <xsl:with-param name="embed" select="$embed"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
</xsl:stylesheet>
