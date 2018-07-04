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
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/theme-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/announcement-common.xsl"/>

  <xsl:template name="announcement-list-item">
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root"/>
    <xsl:param name="use_description"/>

  <xsl:variable name="depiction">
	<xsl:call-template name="get-announcement-depiction">
	  <xsl:with-param name="announcement" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
  </xsl:variable>
  <xsl:variable name="title">
	<xsl:call-template name="get-announcement-title">
	  <xsl:with-param name="announcement" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
  </xsl:variable>
  <xsl:variable name="link">
    <xsl:apply-templates select="$node" mode="place-link"/>
  </xsl:variable>
  <div class="tw-announcement-depiction">
    <xsl:choose>
      <xsl:when test="$depiction">
        <img style="width:100px">
		  <xsl:attribute name="src">
		    <xsl:value-of select="$depiction"/>
		  </xsl:attribute>
		  <xsl:attribute name="alt">
		    <xsl:value-of select="$title"/>
		  </xsl:attribute>
		</img>
      </xsl:when>
    </xsl:choose>
  </div>
  <div class="tw-announcement-info">
    <div class="tw-announcement-title">
      <xsl:copy-of select="$link"/>
    </div>
    <div class="tw-announcement-date">
      <span rel="tw:hasAnnouncementDate">
        <xsl:apply-templates select="tw:hasAnnouncementDate/*" mode="date"/>
      </span>
    </div>
  </div>

  </xsl:template>
</xsl:stylesheet>
