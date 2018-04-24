<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet 
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:exsl="http://exslt.org/common"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/announcement-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>

  <xsl:template name="announcement-description">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>

    <xsl:variable name="title">
      <xsl:call-template name="get-announcement-title">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="source">
      <xsl:call-template name="get-announcement-source">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="depiction">
      <xsl:call-template name="get-announcement-depiction">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="description">
      <xsl:call-template name="get-announcement-description">
	<xsl:with-param name="announcement" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <div class="announcement-list" about="{@rdf:about}" typeof="tw:Announcement">
      <link href="/css/announcement.css" type="text/css" rel="stylesheet"/>

      <xsl:choose>
        <xsl:when test="$depiction">
	  <br/>
  	  <img class="left-align" style="width:100px">
	    <xsl:attribute name="src">
	      <xsl:value-of select="$depiction"/>
	    </xsl:attribute>
	    <xsl:attribute name="alt">
	      <xsl:value-of select="$title"/>
	    </xsl:attribute>
	  </img>
        </xsl:when>
      </xsl:choose>
      <span rel="tw:hasAnnouncementDate">
        <xsl:apply-templates select="tw:hasAnnouncementDate/*"
	                     mode="date"/>
      </span>
      <br/>
      <div class="spacing">
	<span property="dc:description">
	  <xsl:copy-of select="$description"/>
	</span>
      </div>
      <br/>
      <xsl:if test="$source!=''">
        <span style="font-weight:bold;"><a href="{$source}">Read More...</a></span>
      </xsl:if>
    </div>
    <br/><br/><br/>

  </xsl:template>

</xsl:stylesheet>

