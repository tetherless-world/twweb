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

  <xsl:import href="/xslt/announcement-list-item-new.xsl"/>

  <xsl:template match="/">
    <div class="tw-announcement-controls">
      <a id="tw-go-left" class="tw-announcement-control tw-go-left" onclick="goLeft();"><xsl:comment/></a>
      <a id="tw-play-pause" class="tw-announcement-control tw-pause" onclick="playPause();"><xsl:comment/></a>
      <a id="tw-go-right" class="tw-announcement-control tw-go-right" onclick="goRight();"><xsl:comment/></a>
    </div>
	<xsl:for-each select="//tw:Announcement|//*[rdf:type/@rdf:resource='&tw;Announcement']">
	  <xsl:sort select="tw:hasAnnouncementDate/*/time:inXSDDateTime" order="descending"/>
	  <xsl:if test="position()&lt;6">
        <xsl:variable name="index">
          <xsl:value-of select="position()"/>
        </xsl:variable>
        <div id="tw-announcement{$index}" class="tw-announcement tw-announcement-hidden" about="{@rdf:about}" typeof="tw:Announcement">
	      <xsl:call-template name="announcement-list-item">
	        <xsl:with-param name="embed" select="true()"/>
	        <xsl:with-param name="node" select="current()"/>
	        <xsl:with-param name="root" select="/"/>
	        <xsl:with-param name="use_description" select="false()"/>
	      </xsl:call-template>
        </div>
	  </xsl:if>
	</xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>

