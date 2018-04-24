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

  <xsl:import href="/xslt/event-list-item.xsl"/>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']">
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>

    <link href="/css/event.css" rel="stylesheet" type="text/css"/>
    <table class="event-list">
    <xsl:variable name="event" select="current()"/>
    <xsl:call-template name="event-list-item">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="embed" select="true()"/>
      <xsl:with-param name="node" select="current()"/>
      <xsl:with-param name="root" select="$root"/>
    </xsl:call-template>
    </table>
  </xsl:template>
</xsl:stylesheet>
