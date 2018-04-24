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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="tw:Event-nodes"
	   match="/rdf:RDF//tw:Event|/rdf:RDF//*[rdf:type/@rdf:resource='&tw;Event']"
	   use="@rdf:about"/>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
                mode="link">
    <xsl:param name="proceedings" select="false()"/>
    <xsl:param name="dateandlocation" select="false()"/>
    <xsl:variable name="page">
      <xsl:call-template name="get-event-page">
        <xsl:with-param name="event" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="tw:Event">
      <a href="{$page}" rel="tw:page">
        <xsl:if test="$proceedings=true()">
	  <xsl:text>Proceedings of </xsl:text>
        </xsl:if>
        <xsl:call-template name="event-name">
          <xsl:with-param name="event" select="current()"/>
          <xsl:with-param name="root" select="/"/>
        </xsl:call-template>
      </a>
      <xsl:if test="$dateandlocation=true()">
	<xsl:if test="tw:hasDateTimeCoverage or tw:hasLocation">
	  <xsl:text> (</xsl:text>
	  <xsl:if test="tw:hasDateTimeCoverage">
	    <span rel="tw:hasDateTimeCoverage">
	      <xsl:apply-templates select="tw:hasDateTimeCoverage/*" mode="date-range"/>
	    </span>
	    <xsl:if test="tw:hasLocation">
	      <xsl:text>, </xsl:text>
	    </xsl:if>
	  </xsl:if>
	  <xsl:if test="tw:hasLocation">
	    <xsl:apply-templates select="." mode="location"/>
	  </xsl:if>
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
		mode="location">
    <span about="{@rdf:about}" typeof="tw:Event">
      <span rel="tw:hasLocation">
        <span property="rdfs:label">
	  <xsl:copy-of select="tw:hasLocation/rdfs:label"/>
        </span>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
		mode="external-link">
    <xsl:variable name="href" select="dc:source/@rdf:resource"/>
    <span about="{@rdf:about}" typeof="tw:Event">
      <a href="{$href}" rel="dc:source">
	<xsl:call-template name="event-name">
	  <xsl:with-param name="event" select="current()"/>
	  <xsl:with-param name="root" select="/"/>
	  <xsl:with-param name="traverse" select="false()"/>
	</xsl:call-template>
      </a>
    </span>
  </xsl:template>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
		mode="get-description">
    <xsl:copy-of select="dc:description/*"/>
  </xsl:template>

  <xsl:template match="tw:inEvent" mode="place-event">
    <xsl:apply-templates select="key('tw:Event-nodes',@rdf:resource)|key('tw:Event-nodes',*/@rdf:about)" mode="link"/>
  </xsl:template>

  <xsl:template name="get-event-page">
    <xsl:param name="event"/>
    <xsl:choose>
      <xsl:when test="$event/tw:page/@rdf:resource">
	<xsl:value-of select="$event/tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:when test="$event/tw:page/*/@rdf:about">
	<xsl:value-of select="$event/tw:page/*/@rdf:about"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$event/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-event-URL">
    <xsl:param name="event"/>
    <xsl:if test="$event/dc:source">
      <xsl:value-of select="$event/dc:source/@rdf:resource"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="event-name">
    <xsl:param name="event"/>
    <xsl:param name="root"/>
    <xsl:param name="traverse" select="true()"/>
    <span typeof="tw:Event" about="{$event/@rdf:about}">
      <span property="foaf:name">
	<xsl:value-of select="$event/foaf:name"/>
      </span>
      <xsl:if test="$event/tw:inEvent and $traverse=true()">
	<xsl:text> at </xsl:text>
	<span rel="tw:inEvent">
	<xsl:choose>
	  <xsl:when test="$event/tw:inEvent/@rdf:resource">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$root//*[@rdf:about=$event/tw:inEvent/@rdf:resource]"/>
	      <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="$event/tw:inEvent/@rdf:nodeID">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$root//*[@rdf:nodeID=$event/tw:inEvent/@rdf:nodeID]/*/.."/>
	      <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="$event/tw:inEvent/*">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$event/tw:inEvent/*"/>
	    <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	</xsl:choose>
	</span>
      </xsl:if>
    </span>
  </xsl:template>
</xsl:stylesheet>
