<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
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
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/theme-common.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/person-list.xsl"/>

  <xsl:template name="section-publication-citation">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <div class="section">
      <link href="/css/publication.css" type="text/css" rel="stylesheet"/>
      <xsl:call-template name="header">
	<xsl:with-param name="text">Citation</xsl:with-param>
	<xsl:with-param name="stylesheet">publication-citation</xsl:with-param>
      </xsl:call-template>
      <div class="citation">
	<xsl:text>[</xsl:text>
	<xsl:call-template name="get-publication-citation-number">
	  <xsl:with-param name="publication" select="$node"/>
	</xsl:call-template>
	<xsl:text>] </xsl:text>
	<xsl:call-template name="get-publication-citation">
	  <xsl:with-param name="publication" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
<xsl:if test="$node/@rdf:about"><br/>
	  <xsl:text>Download: </xsl:text><a href="{$node/@rdf:about}"><xsl:value-of select="$node/@rdf:about"/></a></xsl:if>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>

