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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/course-common.xsl"/>

  <xsl:template match="/rdf:RDF">
    <link href="/css/course.css" rel="stylesheet" type="text/css"/>
    <br />
    <xsl:if test="//tw:CourseClass|//*[rdf:type/@rdf:resource='&tw;CourseClass']">
      <span style="font-weight:bold;">Past Class(es)</span>
      <ul>
      <xsl:for-each select="//tw:CourseClass|//*[rdf:type/@rdf:resource='&tw;CourseClass']">
	<xsl:sort select="tw:hasDateTimeCoverage/*/time:hasBeginning/*/time:inXSDDateTime" order="descending"/>
	<li>
        <xsl:apply-templates select="current()" mode="place-link"/>
	</li>
      </xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="rdf:RDF"/>
  </xsl:template>
</xsl:stylesheet>
