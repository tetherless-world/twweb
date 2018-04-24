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

  <xsl:template name="section-publication-header">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <div class="section">
      <link href="/css/publication.css" 
	    type="text/css" 
	    rel="stylesheet"/>
      <div class="header">
	<h1 xmlns:tw="&tw;">
	  <xsl:if test="not($embed=true())">
	    <span rel="tw:hasTitle">
	      <xsl:call-template name="get-document-title">
		<xsl:with-param name="document" select="$node"/>
	      </xsl:call-template>
	      <xsl:if test="$admin=true()">
		<a href="./edit">Edit</a>
	      </xsl:if>
	    </span>
	  </xsl:if>
	</h1>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
