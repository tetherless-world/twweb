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
  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:key name="foaf:Person-nodes" match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']" use="@rdf:about"/>

  <xsl:template name="event-attendees">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="event">
      <link href="/css/event.css" type="text/css" rel="stylesheet"/>
      <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
      <div class="attendees section" id="event-attendees">
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Attending</xsl:with-param>
	  <xsl:with-param name="stylesheet">event-attendees</xsl:with-param>
	</xsl:call-template>
	<ul>
	<xsl:for-each select="key('foaf:Person-nodes',$node/tw:hasAttendee/*/@rdf:about)|key('foaf:Person-nodes',$node/tw:hasAttendee/@rdf:resource)">
	  <xsl:sort select="foaf:lastName|foaf:surname|foaf:family_name|foaf:familyName"/>
	  <li><xsl:apply-templates select="." mode="place-link"/></li>
	</xsl:for-each>
	</ul>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
