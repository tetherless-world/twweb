<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
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

  <xsl:import href="/xslt/announcement-list-item.xsl"/>
     
  <xsl:template match="/">
    <link href="/css/announcements.css" rel="stylesheet" type="text/css"/>
    <table border="0" class="announcement-list">
      <xsl:for-each select="//tw:Announcement|//*[rdf:type/@rdf:resource='&tw;Announcement']">
	<xsl:sort select="tw:hasAnnouncementDate/*/time:inXSDDateTime" order="descending"/>
	<xsl:call-template name="announcement-list-item">
	  <xsl:with-param name="embed" select="true()" />
	  <xsl:with-param name="node" select="current()"/>
	  <xsl:with-param name="root" select="/"/>
	  <xsl:with-param name="use_description" select="true()"/>
	</xsl:call-template>
      </xsl:for-each>
    </table>
  </xsl:template>
  
</xsl:stylesheet>


   
