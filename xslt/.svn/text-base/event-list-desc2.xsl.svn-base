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
	        xmlns:time="http://www.w3.org/2006/time#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/event-list-item.xsl"/>

  <xsl:template name="event-list-desc">
    <xsl:param name="admin"/>
    <xsl:param name="events"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="order"/>
    <link href="/css/event.css" rel="stylesheet" type="text/css"/>
    <table class="event-list" style="width:auto;">
      <tr><td></td></tr>
      <xsl:for-each select="$events">
	<xsl:sort select="tw:hasDateTimeCoverage/*/time:hasBeginning/*/time:inXSDDateTime" order="descending"/>
	<xsl:call-template name="event-list-item">
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="embed" select="true()"/>
	  <xsl:with-param name="node" select="current()"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:for-each>
    </table>
  </xsl:template>
</xsl:stylesheet>
