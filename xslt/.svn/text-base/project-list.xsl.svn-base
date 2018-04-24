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

  <xsl:import href="/xslt/project-list-item.xsl"/>

  <xsl:template name="project-list">
    <xsl:param name="admin"/>
    <xsl:param name="projects"/>
    <xsl:param name="root" select="/"/>
    <link href="/css/project.css" rel="stylesheet" type="text/css"/>
    <table class="project-list">
      <xsl:for-each select="$projects">
	<xsl:sort select="foaf:name"/>
	<xsl:call-template name="project-list-item">
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
      <xsl:variable name="projects" select="//foaf:Project|//*[rdf:type/@rdf:resource='&foaf;Project']"/>
      <xsl:call-template name="project-list">
	<xsl:with-param name="projects" select="$projects"/>
	<xsl:with-param name="root" select="/"/>
	<xsl:with-param name="admin" select="$admin"/>
      </xsl:call-template>
    </div>
  </xsl:template>

</xsl:stylesheet>
