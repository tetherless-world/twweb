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
   xmlns:tw="http://tw.rpi.edu/schema/"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#">
  <xsl:template name="meeting-rss">
    <xsl:param name="node"/>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title><xsl:text>Upcoming meetings for </xsl:text><xsl:value-of select="$node/tw:hasFirstName"/><xsl:text> </xsl:text><xsl:value-of select="$node/tw:hasLastName"/></title>
      <link>http://wineagent.tw.rpi.edu/sample2/Meetings</link>
      <summary>An aggregate of upcoming meetings for all projects in the Tetherless World Constellation</summary>
      <xsl:for-each select="//rdf:type[@rdf:resource='http://tw.rpi.edu/schema/Meeting']/..|//rdf:type/*[@rdf:about='http://tw.rpi.edu/schema/Meeting']/../..|//tw:Meeting">
	<xsl:sort select="tw:hasDateTimeCoverage//time:hasBeginning//time:inXSDDateTime"/>
	<xsl:variable name="project" select="//*[@rdf:about=current()/tw:hasProjectReference/@rdf:resource]|current()/tw:hasProjectReference/*[@rdf:about]"/>
	<xsl:if test="$node/tw:hasRole[@rdf:nodeID=$project/tw:hasAgentWithRole/*/@rdf:nodeID]|$node/tw:hasRole/*[@rdf:nodeID=$project/tw:hasAgentWithRole/@rdf:nodeID]">
	  <entry>
	    <title><xsl:text>Meeting for </xsl:text><xsl:value-of select="$project/tw:hasName"/></title>
	    <link href="{$project/@rdf:about}"/>
	    <summary type="html">&lt;p xmlns="http://www.w3.org/1999/xhtml"&gt;<xsl:text>An upcoming meeting for </xsl:text><xsl:value-of select="$project/tw:hasName"/><xsl:text>.</xsl:text>&lt;br/&gt;<xsl:text>Start time: </xsl:text><xsl:value-of select="current()/tw:hasDateTimeCoverage//time:hasBeginning//time:inXSDDateTime"/>&lt;br/&gt;<xsl:text>End time: </xsl:text><xsl:value-of select="current()/tw:hasDateTimeCoverage//time:hasEnd//time:inXSDDateTime"/>&lt;/p&gt;</summary>
	    <updated><xsl:value-of select="current()/tw:hasDateTimeCoverage//time:hasBeginning//time:inXSDDateTime"/></updated>
	  </entry>
	</xsl:if>
      </xsl:for-each>
    </feed>
  </xsl:template>
</xsl:stylesheet>
