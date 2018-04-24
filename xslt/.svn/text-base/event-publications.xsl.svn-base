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
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/event-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:template name="event-publications">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="event">
      <link href="/css/event.css" type="text/css" rel="stylesheet"/>
      <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
      <div class="publications section" id="event-publications">
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Publications</xsl:with-param>
	  <xsl:with-param name="stylesheet">event-publications</xsl:with-param>
	</xsl:call-template>
	<xsl:apply-templates select="//foaf:Document|//*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-citation">
	  <xsl:sort select="dc:title|foaf:name|rdfs:label"/>
	</xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
