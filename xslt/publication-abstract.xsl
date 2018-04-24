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

  <xsl:template name="section-publication-abstract">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <div class="section">
      <link href="/css/publication.css" type="text/css" rel="stylesheet"/>
      <div class="abstract">
	<xsl:if test="$header=true()">
	  <xsl:call-template name="header">
	    <xsl:with-param name="text">Abstract</xsl:with-param>
	    <xsl:with-param name="stylesheet">publication-citation</xsl:with-param>
	  </xsl:call-template>
	</xsl:if>
	<p><xsl:call-template name="get-publication-abstract"><xsl:with-param name="publication" select="$node"/></xsl:call-template></p>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
