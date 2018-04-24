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
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/event-common.xsl"/>

  <xsl:template match="tw:Presentation|*[rdf:type/@rdf:resource='&tw;Presentation']" mode="citation">
    <xsl:variable name="author-ids">
    <xsl:call-template name="get-document-authors">
      <xsl:with-param name="document" select="current()"/>
      <xsl:with-param name="root" select="/"/>
    </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="page">
      <xsl:call-template name="get-presentation-page">
        <xsl:with-param name="presentation" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="tw:Presentation">
      <xsl:for-each select="key('tw:Author-nodes',exsl:node-set($author-ids)/*)">
	<xsl:sort select="tw:index" data-type="number"/>
	<xsl:variable name="author" select="key('tw:hasRole-nodes',@rdf:nodeID)/.."/>
	<xsl:apply-templates select="$author" mode="link">
          <xsl:with-param name="style">ln,fi</xsl:with-param>
	</xsl:apply-templates>
	<xsl:choose>
          <xsl:when test="position()=last()">
          </xsl:when>
          <xsl:when test="position()=last()-1">
            <xsl:text>, &amp; </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
      <xsl:text> (</xsl:text><span rel="tw:hasDate">
	<xsl:apply-templates select="tw:hasDate/*" mode="year"/>
      </span>
      <xsl:text>). </xsl:text>
      <a href="{@rdf:about}" rel="tw:page"><!-- was $page -->
	<span about="{@rdf:about}"><span property="dc:title"><xsl:value-of select="dc:title"/></span></span>
      </a>
      <xsl:variable name="last-char" select="substring(dc:title,string-length(dc:title)-1,string-length(dc:title))"/>
      <xsl:if test="last-char!='.' and last-char!='?' and last-char!='!'">
	<xsl:text>.</xsl:text>
      </xsl:if>
      <xsl:if test="tw:hasPresentation|tw:hasPresentationEvent">
	<xsl:text> In:</xsl:text>
	<xsl:choose>
          <xsl:when test="tw:hasPresentationEvent">
            <span rel="tw:hasPresentationEvent">
              <xsl:apply-templates select="tw:hasPresentationEvent" mode="link"/>
            </span>
          </xsl:when>
          <xsl:when test="tw:hasPublicationDocument">
            <span rel="tw:hasPublicationDocument">
              <xsl:apply-templates select="tw:hasPublicationDocument" mode="link"/>
            </span>
          </xsl:when>
	</xsl:choose>
      </xsl:if>
    </span>
  </xsl:template>
    
  <xsl:template name="get-presentation-page">
    <xsl:param name="presentation"/>
    <xsl:choose>
      <xsl:when test="$presentation/tw:page">
        <xsl:value-of select="$presentation/tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$presentation/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  <xsl:template name="get-presentation-citation">
    <xsl:param name="presentation"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="authors-raw">
      <xsl:call-template name="get-document-authors">
	<xsl:with-param name="document" select="$presentation"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="authors" select="exsl:node-set($authors-raw)"/>
    <xsl:variable name="title">
      <xsl:call-template name="get-document-title">
	<xsl:with-param name="document" select="$presentation"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="presdate">
      <xsl:call-template name="get-presentation-date">
	<xsl:with-param name="presentation" select="$presentation"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="presevent-raw">
      <xsl:call-template name="get-presentation-event">
	<xsl:with-param name="presentation" select="$presentation"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="presevent" select="exsl:node-set($presevent-raw)"/>
    <span about="{$presentation/@rdf:about}" typeof="tw:Publication">
    <xsl:for-each select="$authors/*">
      <xsl:if test="position()=last() and last()!=1">
	<xsl:text>&amp; </xsl:text>
      </xsl:if>
      <span about="{current()/@rdf:about}" typeof="foaf:Person">
	<xsl:call-template name="place-person-link">
	  <xsl:with-param name="person" select="current()"/>
	  <xsl:with-param name="style">last,fi</xsl:with-param>
	  <xsl:with-param name="rdfa" select="true()"/>
	</xsl:call-template>
	<span rel="tw:hasRole">
	  <span typeof="tw:Author">
	    <span property="tw:index" content="{position()}"/>
	    <span rel="tw:ofDocument" resource="{$presentation/@rdf:about}"/>
	    <span rev="tw:hasAgentWithRole" resource="{$presentation/@rdf:about}"/>
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text> </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>, </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>(</xsl:text>
    <span rel="tw:hasDate"><span typeof="time:Instant"><span
    property="time:inXSDDateTime" datatype="xsd:dateTime"
    content="{$presdate}"><xsl:value-of select="substring($presdate,1,4)"/></span></span></span>
    <xsl:text>). </xsl:text>
    <a href="{$presentation/@rdf:about}" property="dc:title">
      <xsl:value-of select="$title"/>
    </a>
    <xsl:text>. In: </xsl:text>
    <span rel="tw:hasPresentationEvent">
    <span about="{$presevent/*/@rdf:about}">
      <xsl:variable name="event-page">
	<xsl:call-template name="get-event-page">
	  <xsl:with-param name="event" select="$presevent/*"/>
	</xsl:call-template>
      </xsl:variable>
    <a href="{$event-page}" rel="tw:page">
      <xsl:call-template name="event-name">
	<xsl:with-param name="event" select="$presevent/*"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </a>
    </span>
    </span>
    <xsl:text>.</xsl:text>
    </span>
  </xsl:template>

  <xsl:template name="get-presentation-projects">
    <xsl:param name="presentation"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$presentation/tw:hasProjectReference">
      <xsl:choose>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and *]"/>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:copy-of select="current()/*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-presentation-concepts">
    <xsl:param name="presentation"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$presentation/tw:hasTopic">
      <xsl:choose>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and *]"/>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:copy-of select="current()/*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-presentation-themes">
    <xsl:param name="presentation"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$presentation/tw:hasThemeReference">
      <xsl:choose>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and *]"/>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:copy-of select="current()/*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-presentation-citation-number">
    <xsl:param name="presentation"/>
    <xsl:value-of select="$presentation/tw:hasCitationNumber"/>
  </xsl:template>
-->
</xsl:stylesheet>
