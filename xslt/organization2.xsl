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
  <xsl:include href="/xslt/organization-header.xsl"/>
  <xsl:include href="/xslt/organization-infobox.xsl"/>
  <xsl:include href="/xslt/organization-description.xsl"/>
  <xsl:include href="/xslt/organization-sponsored-projects.xsl"/>
  <xsl:template match="*[@rdf:about='http://tw.rpi.edu/instances/NSF']">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="uri"/>
    <div class="person" about="{$uri}">
      <link href="/css/objects.css" rel="stylesheet" type="text/css"/>
      <link href="/css/organization.css" rel="stylesheet" type="text/css"/>
    <xsl:call-template name="organization-header">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>
    <xsl:call-template name="organization-infobox">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>
    <xsl:call-template name="organization-description">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>
    <xsl:call-template name="organization-sponsored-projects">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>
    </div>
  </xsl:template>
  <xsl:template match="/">
    <xsl:variable name="admin" select="false()"/>
    <div class="twqueryresult organization">
      <link rel="stylesheet" type="text/css" href="/css/objects.css"/>
      <script type="text/javascript" src="/tw.rpi.edu/js/layout.js"></script>
      <xsl:apply-templates>
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="uri">http://tw.rpi.edu/instances/NSF</xsl:with-param>
	<xsl:with-param name="embed" select="true()"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
  <xsl:template match="rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="uri"/>
    <xsl:param name="embed"/>
    <xsl:apply-templates select="//*[@rdf:about=$uri]">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="embed" select="$embed"/>
      <xsl:with-param name="uri" select="$uri"/>
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>

