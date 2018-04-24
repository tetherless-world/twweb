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
  <xsl:import href="/xslt/time-common.xsl"/>

  <xsl:key name="tw:Event-nodes"
	   match="/rdf:RDF//tw:Event|/rdf:RDF//*[rdf:type/@rdf:resource='&tw;Event']"
	   use="@rdf:about"/>

  <xsl:template name="event-description">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="event">
      <link href="/css/event.css" type="text/css" rel="stylesheet"/>
      <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
      <xsl:if test="$node/dc:source">
	  <span class="prop">Website: </span>
	  <xsl:apply-templates select="$node" mode="external-link"/>
	  <br/>
      </xsl:if>
      <span class="prop">When: </span>
      <xsl:choose>
        <xsl:when test="$node/tw:hasDateTimeCoverage">
	  <span rel="tw:hasDateTimeCoverage">
            <xsl:apply-templates select="$node/tw:hasDateTimeCoverage/*" mode="date-range"/>
	  </span>
        </xsl:when>
        <xsl:otherwise>
	  <i>Not specified</i>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$node/tw:hasLocation">
	<br/>
	<span class="prop">Where: </span>
	<xsl:apply-templates select="$node" mode="location"/>
      </xsl:if>
      <br/>
      <xsl:if test="$node/tw:inEvent">
	<span class="prop">Part of: </span>
	<span rel="tw:inEvent">
	  <xsl:apply-templates select="key('tw:Event-nodes',$node/tw:inEvent/@rdf:resource)|key('tw:Event-nodes',$node/tw:inEvent/*/@rdf:about)" mode="link"/>
	</span>
        <br/>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="$header=true()">
	  <xsl:call-template name="header">
	    <xsl:with-param name="text">Description</xsl:with-param>
	    <xsl:with-param name="stylesheet">event-description</xsl:with-param>
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	  <span class="prop">
	    Description:
	  </span>
	</xsl:otherwise>
      </xsl:choose>
      <div class="description section" id="event-description">
	<xsl:apply-templates select="$node" mode="get-description"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
