<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet
   version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="/xslt/announcement-list-item.xsl" type="text/xsl"/>
  <xsl:template name="announcement-list">
    <xsl:param name="announcements"/>
    <ul class="announcement-list">
      <xsl:for-each select="$announcements">
	<xsl:call-template name="announcement-list-item">
	  <xsl:with-param name="node" select="current()"/>
	</xsl:call-template>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>
