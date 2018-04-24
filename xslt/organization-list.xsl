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
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/organization-header.xsl"/>
  <xsl:import href="/xslt/organization-description.xsl"/>
  <xsl:template name="organization-list">
    <xsl:param name="admin"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="orgs"/>
    <xsl:param name="root" select="/"/>
    <link href="/css/organization.css" rel="stylesheet" type="text/css"/>
    <xsl:for-each select="$orgs">
      <xsl:sort select="foaf:name"/>
      <xsl:call-template name="organization-header">
	<xsl:with-param name="node" select="current()"/>
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="embed" select="$embed"/>
      </xsl:call-template>
      <xsl:call-template name="organization-description">
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="node" select="current()"/>
	<xsl:with-param name="embed" select="$embed"/>
      </xsl:call-template>
      <hr width="100%" size="1" color="navy"/>
      <br/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
    <div>
      <xsl:variable name="orgs" select="//foaf:Organization|//*[rdf:type/@rdf:resource='&foaf;Organization']"/>
      <xsl:call-template name="organization-list">
	<xsl:with-param name="orgs" select="$orgs"/>
	<xsl:with-param name="root" select="/"/>
	<xsl:with-param name="admin" select="$admin"/>
      </xsl:call-template>
    </div>
  </xsl:template>
</xsl:stylesheet>
