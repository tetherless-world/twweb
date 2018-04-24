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
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#">
   xmlns:owl="http://www.w3.org/2002/07/owl#">
  <xsl:template name="announcement-rss">
    <xsl:param name="node"/>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title><xsl:text>Recent announcements</xsl:text></title>
      <link>http://wineagent.tw.rpi.edu/sample2/Announcements</link>
      <summary>An aggregate of recent announcements concerning the Tetherless World Constellation, its members, and its research.</summary>
      <xsl:for-each select="//*/rdf:type[@rdf:resource='&tw;Announcement']/..|//*/rdf:type/*[@rdf:about='&tw;Announcement']/../..|//tw:Announcement">
	<entry>
	  <title><xsl:value-of select="current()/tw:hasTitle"/></title>
	  <link href="{current()/@rdf:about}"/>
	  <summary><xsl:value-of select="current()/tw:hasTitle"/></summary>
	  <updated><xsl:value-of select="current()/tw:hasAnnouncementDate"/></updated>
	</entry>
      </xsl:for-each>
    </feed>
  </xsl:template>
</xsl:stylesheet>
