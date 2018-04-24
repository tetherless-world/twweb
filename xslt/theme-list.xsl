<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/theme-list-item.xsl"/>
  <xsl:template name="theme-list">
    <xsl:param name="admin"/>
    <xsl:param name="themes"/>
    <xsl:param name="indent-subthemes" select="false()"/>
    <xsl:param name="root" select="/"/>
    <link href="/css/theme.css" rel="stylesheet" type="text/css"/>
    <table class="theme-list">
      <xsl:for-each select="$themes">
	<xsl:sort select="foaf:name"/>
	<xsl:call-template name="theme-list-item">
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="embed" select="true()"/>
	  <xsl:with-param name="node" select="current()"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:for-each>
      </table>
  </xsl:template>
  <xsl:template match="/rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
    <div>
      <xsl:variable name="themes" select="//tw:Theme|//*[rdf:type/@rdf:resource='&tw;Theme']"/>
      <xsl:call-template name="theme-list">
	<xsl:with-param name="themes" select="$themes"/>
	<xsl:with-param name="root" select="/"/>
	<xsl:with-param name="admin" select="$admin"/>
      </xsl:call-template>
    </div>
  </xsl:template>
</xsl:stylesheet>
