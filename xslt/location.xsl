<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
		xmlns="http://www.w3.org/1999/xhtml"
>
<xsl:import href="/xslt/location-header.xsl">
<xsl:import href="/xslt/location-description.xsl">

<xsl:template name="location">
    <xsl:param name="node"/>
    <xsl:call-template name="location-header">
      <xsl:with-param name="node" select="$node"/>
    </xsl:call-template>
    <xsl:call-template name="description-location">
      <xsl:with-param name="node" select="$node"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>

<!-- header, description, located in, contacts(if applicable) -->
