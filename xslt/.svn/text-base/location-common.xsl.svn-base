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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
		xmlns="http://www.w3.org/1999/xhtml"
>
<!-- get the following hasDescription hasDepiction hasName *hasPoint* <==[not going to lie, no idea how to do that]  [or that]==> *LocatedIn* -->
<xsl:template name="get-location-depiction">
  <xsl:param name="location"/>
</xsl:template>

<xsl:template name="get-location-name">
  <xsl:param name="location"/>
  <xsl:value-of select="$location/tw:hasName"/>
</xsl:template>

<xsl:template name="get-location-located-in"> <!-- itc -->
<xsl:param name="location"/>
  <xsl:param name="location" select="/tw:LocatedIn"/>
  <xsl:for-each select="$location/tw:LocatedIn"/>
    <xsl:choose>
    <xsl:when test="current()/@rdf:nodeID">
      <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID/*/..]"/>
    </xsl:when>
    <xsl:when test="current()/@rdf:resource">
      <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
    </xsl:when>
    <xsl:when test="current()/*">
      <xsl:copy-of select="current()/*"/>
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>

<xsl:template name="get-loaction-has-point"> <!-- itc -->
  <xsl:param name="location"/>
  <xsl:value-of select="$location/tw:hasPoint"/>  
</xsl:template>

<xsl:template name="get-location-has-description">
  <xsl:param name="location"/>
  <xsl:value-of select="$loactaion/dc:description"/>
</xsl:template>

<xsl:template name="get-location-has-depiction">
  <xsl:param name="location"/>
  <xsl:value-of select="$loaction/tw:hasDepiction"/>
</xsl:template>

<!--
<xsl:template name="process-wgs">
</xsl:template>
-->

</xsl:stylesheet>
