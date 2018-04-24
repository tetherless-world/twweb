<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY time "http://www.w3.org/2006/time#">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns:date="http://exslt.org/dates-and-times"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/event-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>

  <xsl:key name="tw:hasDeadline-props" match="*[rdfs:subPropertyOf/@rdf:resource='&tw;hasDeadline']" use="@rdf:about"/>
  <xsl:key name="time:Instant-nodes" match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']" use="@rdf:nodeID"/>
  <xsl:key name="tw:hasDeadline-props2" match="*[namespace-uri(.)='&tw;' and local-name(.)!='hasDeadline' and contains(local-name(.),'Deadline')]"
	   use="@rdf:nodeID|*/@rdf:nodeID"/>

  <xsl:template name="event-deadlines">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="event">
      <link href="/css/event.css" type="text/css" rel="stylesheet"/>
      <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
      <div class="events section" id="event-deadlines">
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Deadlines</xsl:with-param>
	  <xsl:with-param name="stylesheet">event-deadlines</xsl:with-param>
	</xsl:call-template>
      </div>
      <p>
      <xsl:for-each select="$node/tw:hasDeadline">
	<xsl:sort select="key('time:Instant-nodes',*/@rdf:nodeID|@rdf:nodeID)/time:inXSDDateTime"/>
	<span>
	  <xsl:value-of select="key('tw:hasDeadline-props',concat(namespace-uri(key('tw:hasDeadline-props2',@rdf:nodeID|*/@rdf:nodeID)),local-name(key('tw:hasDeadline-props2',@rdf:nodeID|*/@rdf:nodeID))))/rdfs:label"/><xsl:text>: </xsl:text>
	  <span>
	    <xsl:if test="substring(date:difference(date:date-time(),key('time:Instant-nodes',*/@rdf:nodeID|@rdf:nodeID)/time:inXSDDateTime),1,1)='-'">
	      <xsl:attribute name="class">passdue</xsl:attribute>
	    </xsl:if>
	    <xsl:apply-templates select="key('time:Instant-nodes',*/@rdf:nodeID|@rdf:nodeID)" mode="date"/>
	  </span>
	</span><br/>
      </xsl:for-each>
      </p>
    </div>
  </xsl:template>

</xsl:stylesheet>
