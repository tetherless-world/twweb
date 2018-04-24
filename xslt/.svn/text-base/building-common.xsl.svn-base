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
<!-- get the following hasCity *hasContact* hasCountry hasState hasStreetAddress hasZipCode -->

<xsl:template name="get-building-contact">
  <xsl:param name="building"/>
  <xsl:param name="root" select="/"/>
  <xsl:for-each select="$building/tw:hasContact"/>
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

<xsl:template name="get-building-city">
  <xsl:param name="building"/>
  <xsl:value-of select="$location/tw:hasCity"/>
</xsl:template>

<xsl:template name="get-building-country">
  <xsl:param name="building"/>
  <xsl:value-of select="$location/tw:hasCountry"/>
</xsl:template>

<xsl:template name="get-building-state">
  <xsl:param name="building"/>
  <xsl:value-of select="$location/tw:hasState"/>
</xsl:template>

<xsl:template name="get-building-streetaddress">
  <xsl:param name="building"/>
  <xsl:value-of select="$location/tw:hasStreetAddress"/>
</xsl:template>

<xsl:template name="get-building-zipcode">
  <xsl:param name="building"/>
  <xsl:value-of select="$location/tw:hasZipCode"/>
</xsl:template>
