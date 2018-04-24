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
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/event-common.xsl"/>

  <xsl:template match="tw:Publication|*[rdf:type/@rdf:resource='&tw;Publication']" mode="citation">
    <xsl:variable name="author-ids">
    <xsl:call-template name="get-document-authors">
      <xsl:with-param name="document" select="current()"/>
      <xsl:with-param name="root" select="/"/>
    </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="page">
      <xsl:call-template name="get-publication-page">
        <xsl:with-param name="publication" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="tw:Publication">
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
      <xsl:if test="tw:inEvent|tw:hasPublicationDocument">
	<xsl:text> In:</xsl:text>
	<xsl:choose>
          <xsl:when test="tw:inEvent">
            <span rel="tw:inEvent">
              <xsl:apply-templates select="tw:inEvent" mode="link"/>
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
    
  <xsl:template name="get-publication-page">
    <xsl:param name="publication"/>
    <xsl:choose>
      <xsl:when test="$publication/tw:page">
        <xsl:value-of select="$publication/tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$publication/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--
  <xsl:template name="get-publication-citation">
    <xsl:param name="publication"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="authors-raw">
      <xsl:call-template name="get-document-authors">
	<xsl:with-param name="document" select="$publication"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="authors" select="exsl:node-set($authors-raw)"/>
    <xsl:variable name="title">
      <xsl:call-template name="get-document-title">
	<xsl:with-param name="document" select="$publication"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="pubdate">
      <xsl:call-template name="get-publication-date">
	<xsl:with-param name="publication" select="$publication"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="pubevent-raw">
      <xsl:call-template name="get-publication-event">
	<xsl:with-param name="publication" select="$publication"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="pubevent" select="exsl:node-set($pubevent-raw)"/>
    <span about="{$publication/@rdf:about}" typeof="tw:Publication">
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
	    <span rel="tw:ofDocument" resource="{$publication/@rdf:about}"/>
	    <span rev="tw:hasAgentWithRole" resource="{$publication/@rdf:about}"/>
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
    <span rel="tw:hasDate"><span typeof="time:Instant"><span property="time:inXSDDateTime" datatype="xsd:dateTime" content="{$pubdate}"><xsl:value-of select="substring($pubdate,1,4)"/></span></span></span>
    <xsl:text>). </xsl:text>
    <a href="{$publication/@rdf:about}" property="dc:title">
      <xsl:value-of select="$title"/>
    </a>
    <xsl:text>. In: </xsl:text>
    <span rel="tw:inEvent">
    <span about="{$pubevent/*/@rdf:about}">
      <xsl:variable name="event-page">
	<xsl:call-template name="get-event-page">
	  <xsl:with-param name="event" select="$pubevent/*"/>
	</xsl:call-template>
      </xsl:variable>
    <a href="{$event-page}" rel="tw:page">
      <xsl:call-template name="event-name">
	<xsl:with-param name="event" select="$pubevent/*"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </a>
    </span>
    </span>
    <xsl:text>.</xsl:text>
    </span>
  </xsl:template>

  <xsl:template name="get-publication-projects">
    <xsl:param name="publication"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$publication/tw:hasProjectReference">
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

  <xsl:template name="get-publication-concepts">
    <xsl:param name="publication"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$publication/tw:hasTopic">
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

  <xsl:template name="get-publication-themes">
    <xsl:param name="publication"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$publication/tw:hasThemeReference">
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

  <xsl:template name="get-publication-citation-number">
    <xsl:param name="publication"/>
    <xsl:value-of select="$publication/tw:hasCitationNumber"/>
  </xsl:template>
-->
</xsl:stylesheet>
