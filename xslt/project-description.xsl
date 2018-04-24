<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:template name="project-description">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="project">
    <link href="/css/project.css" type="text/css" rel="stylesheet"/>
    <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
    <xsl:choose>
      <xsl:when test="$header=true()">
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Description</xsl:with-param>
	  <xsl:with-param name="stylesheet">project-description</xsl:with-param>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      <span class="prop" style="font-weight:bold;">
	Description:
      </span>
      </xsl:otherwise>
    </xsl:choose>
    <div class="projdescription section" id="project-description">
      <xsl:call-template name="get-project-description">
	<xsl:with-param name="project" select="$node"/>
      </xsl:call-template>
    </div>
    </div>
  </xsl:template>
</xsl:stylesheet>

