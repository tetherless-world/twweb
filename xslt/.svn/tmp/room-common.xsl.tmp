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
<!-- get the following *hasContact* hasOfficeNumber -->

<xsl:template name="get-room-contact">
  <xsl:param name="room"/>
  <xsl:param name="root" select="/"/>
  <xsl:for-each select="$room/tw:hasContact"/>
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

<xsl:template name="get-room-has-office-number"/> 
  <xsl:param name="room"/>
  <xsl:value-of select="$room/tw:hasOfficeNumber"/>  
</xsl:template>

</xsl:stylesheet>
