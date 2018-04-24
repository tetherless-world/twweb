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
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/announcement-common.xsl"/>
  <xsl:import href="/xslt/announcement-header.xsl"/>
  <xsl:import href="/xslt/announcement-description.xsl"/>
     
  <xsl:template match="tw:Announcement|*[rdf:type/@rdf:resource='&tw;Announcement']" mode="place-announcement">
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root"/>

    <xsl:variable name="announcement" select="."/>

    <xsl:call-template name="announcement-header">
      <xsl:with-param name="node" select="$announcement"/>
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>

    <xsl:call-template name="announcement-description">
      <xsl:with-param name="node" select="$announcement"/>
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="embed" select="$embed"/>
    </xsl:call-template>

  </xsl:template>
  
  <xsl:template name="announcement">
    <xsl:param name="node"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <div class="section">
      <link href="/css/announcements.css" rel="stylesheet" type="text/css"/>
      <xsl:apply-templates select="$node" mode="place-announcement">
        <xsl:with-param name="admin" select="$admin"/>
        <xsl:with-param name="embed" select="$embed"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
</xsl:stylesheet>

