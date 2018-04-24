<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
]>
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
  <xsl:import href="/xslt/project-themes.xsl"/>
  <xsl:import href="/xslt/project-investigator.xsl"/>
  <xsl:import href="/xslt/project-concepts.xsl"/>
  <xsl:import href="/xslt/project-description.xsl"/>

  <xsl:template name="project-embed">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

    <div class="project" about="{$node/@rdf:about}" typeof="foaf:Project">
      <link href="/css/objects.css" rel="stylesheet" type="text/css"/>
      <link href="/css/project.css" rel="stylesheet" type="text/css"/>

      <xsl:call-template name="project-themes">
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="embed" select="$embed"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>

      <xsl:call-template name="project-investigator">
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="embed" select="$embed"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>

      <xsl:call-template name="project-concepts">
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="embed" select="$embed"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>

      <xsl:call-template name="project-description">
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="embed" select="$embed"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>

    </div>

  </xsl:template>
</xsl:stylesheet>

