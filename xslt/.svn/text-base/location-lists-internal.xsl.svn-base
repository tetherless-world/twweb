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
<xsl:include href="/xslt/location-common.xsl"/>
<xsl:include href="/xslt/room-common.xsl"/>
<xsl:include href="/xslt/building-common.xsl"/>

<xsl:template name="list-contacts-by-name-room">
  <xsl:param name="admin"/>
  <xsl:param name="node"/>
  <xsl:call-template name="get-room-contact">
    <xsl:with-param name="room" select="$node"/>
  </xsl:call-template>
  <xsl:if test="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']">
    <xsl:for-each select="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']/..">
       <xsl:sort select="foaf:lastName"/>
       <a href="{$node/@rdf:about}">
         <xsl:value-of select="foaf:firstName"/>
         <xsl:value-of select="foaf:lastName"/>
       </a>
    </xsl:for-each>
  </xsl:if>
</xsl:template>

<xsl:template name="list-contacts-by-name-building">
  <xsl:param name="admin"/>
  <xsl:param name="node"/>
  <xsl:call-template name="get-building-contact">
    <xsl:with-param name="building" select="$node"/>
  </xsl:call-template>
  <xsl:if test="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']">
    <xsl:for-each select="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']/..">
       <xsl:sort select="foaf:lastName"/>
       <a href="{$node/@rdf:about}">
         <xsl:value-of select="foaf:firstName"/>
         <xsl:value-of select="foaf:lastName"/>
       </a>
    </xsl:for-each>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
