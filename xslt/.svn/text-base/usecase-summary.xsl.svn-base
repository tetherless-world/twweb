<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY media "http://tw.rpi.edu/media/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
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
		xmlns:foaf="&foaf;"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/document-common.xsl"/>

  <xsl:template match="tw:UseCase|*[rdf:type/@rdf:resource='&tw;UseCase']" mode="place-summary">
    <div rel="tw:summary">
      <xsl:copy-of select="./tw:summary/*"/>
    </div>
  </xsl:template>

  <xsl:template name="usecase-summary">
    <xsl:param name="node"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <xsl:if test="tw:summary">
      <div class="section">
	<link href="/css/document.css" type="text/css" rel="stylesheet"/>
	<p>
	  <b class="label">Summary:</b>
	</p>
	<xsl:apply-templates select="$node" mode="place-summary"/>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
