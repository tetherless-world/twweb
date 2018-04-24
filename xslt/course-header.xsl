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

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']"
		mode="header">
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    
    <xsl:choose>
      <xsl:when test="$embed=true()">
        <h3><xsl:apply-templates select="current()" mode="name"/></h3>
      </xsl:when>
      <xsl:otherwise>
	<br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="course-header">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

    <xsl:apply-templates select="$node" mode="header">
      <xsl:with-param name="embed" select="$embed"/>
      <xsl:with-param name="root" select="$root"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//tw:Course|//*[rdf:type/@rdf:resource='&tw;Course']" mode="header">
      <xsl:with-param name="embed" select="false()"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>
