<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/organization-infobox.xsl"/>
  <xsl:import href="/xslt/organization-header.xsl"/>
  <xsl:import href="/xslt/organization-description.xsl"/>
  <xsl:import href="/xslt/organization-sponsored-projects.xsl"/>

  <xsl:template name="organization-embed">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

  <div class="organization-embed" about="{$node/@rdf:about}" typeof="foaf:Organization">
   <link href="/css/objects.css" rel="stylesheet" type="text/css"/>
   <link href="/css/organization.css" rel="stylesheet" type="text/css"/>

  <xsl:call-template name="organization-infobox">
    <xsl:with-param name="admin" select="$admin"/>
    <xsl:with-param name="node" select="$node"/>
    <xsl:with-param name="embed" select="$embed"/>
    <xsl:with-param name="root" select="$root"/>
  </xsl:call-template>

  <xsl:call-template name="organization-header">
    <xsl:with-param name="admin" select="$admin"/>
    <xsl:with-param name="node" select="$node"/>
    <xsl:with-param name="embed" select="$embed"/>
    <xsl:with-param name="root" select="$root"/>
  </xsl:call-template>

  <xsl:call-template name="organization-description">
    <xsl:with-param name="admin" select="$admin"/>
    <xsl:with-param name="node" select="$node"/>
    <xsl:with-param name="embed" select="$embed"/>
    <xsl:with-param name="root" select="$root"/>
  </xsl:call-template>
  
  <xsl:call-template name="organization-sponsored-projects">
    <xsl:with-param name="admin" select="$admin"/>
    <xsl:with-param name="node" select="$node"/>
    <xsl:with-param name="embed" select="$embed"/>
    <xsl:with-param name="root" select="$root"/>
  </xsl:call-template>

  </div>
 </xsl:template>
</xsl:stylesheet>

