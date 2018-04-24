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
		xmlns:exsl="http://exslt.org/common"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:template match="tw:Announcement|*[rdf:type/@rdf:resource='&tw;Announcement']" mode="place-link">
    <xsl:variable name="page">
      <xsl:call-template name="get-announcement-page">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="source">
      <xsl:call-template name="get-announcement-source">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="title">
      <xsl:call-template name="get-announcement-title">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="./tw:page">
	<a href="{$page}" rel="tw:page">
          <xsl:copy-of select="$title"/>
	</a>
      </xsl:when>
      <xsl:when test="./dc:source">
	<a href="{$source}" rel="dc:source">
	  <xsl:copy-of select="$title"/>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$title"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-announcement-page">
    <xsl:param name="announcement"/>
    <xsl:choose>
      <xsl:when test="$announcement/tw:page">
	<xsl:for-each select="$announcement/tw:page">
	  <xsl:if test="contains(@rdf:resource,'web') and contains(@rdf:resource,'tw.rpi.edu')">
	    <xsl:value-of select="@rdf:resource"/>
	  </xsl:if>
          <xsl:if test="contains(@rdf:resource,'google.com')">
            <xsl:value-of select="@rdf:resource"/>
          </xsl:if>
	</xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-announcement-source">
    <xsl:param name="announcement"/>
    <xsl:choose>
      <xsl:when test="$announcement/dc:source">
	<xsl:for-each select="$announcement/dc:source">
	  <xsl:value-of select="@rdf:resource"/>
	</xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-announcement-title">
    <xsl:param name="announcement"/>
    <xsl:param name="rdfa" select="true()"/>
    <xsl:variable name="title">
      <xsl:value-of select="$announcement/dc:title"/>
    </xsl:variable>
    <span>
      <xsl:if test="$rdfa=true()">
	<xsl:attribute name="property">dc:title</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="$title"/>
    </span>
  </xsl:template>

  <xsl:template name="get-announcement-description">
    <xsl:param name="announcement"/>
    <xsl:param name="rdfa" select="true()"/>
    <xsl:variable name="description">
      <xsl:copy-of select="$announcement/dc:description"/>
    </xsl:variable>
    <span>
      <xsl:if test="$rdfa=true()">
	<xsl:attribute name="property">dc:description</xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="$description"/>
    </span>
  </xsl:template>

  <xsl:template name="get-announcement-depiction">
    <xsl:param name="announcement"/>
    <xsl:param name="root" select="/"/>

    <xsl:value-of select="$announcement/foaf:depiction/@rdf:resource|$announcement/foaf:depiction/*/@rdf:about"/>
  </xsl:template>

  <!--
  <xsl:template name="get-announcement-interests">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/tw:hasInterest">
      <xsl:choose>
	<xsl:when test="@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="@rdf:nodeID">
	  <xsl:copy-of select="$root//tw:Concept[@rdf:nodeID=current()/@rdf:nodeID]|$root//*[@rdf:nodeID=current()/@rdf:nodeID and rdf:type/@rdf:resource='&tw;Concept']"/>
	</xsl:when>
	<xsl:when test="*">
	  <xsl:copy-of select="*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  -->
</xsl:stylesheet>
