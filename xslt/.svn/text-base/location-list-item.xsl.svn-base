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
<xsl:include href="/xslt/building-common.xsl"/>
<xsl:include href="/xslt/room-common.xsl"/>
<xsl:import href="/xslt/location-lists-internal.xsl"/>

<xsl:template name="location-list-item">
  <xsl:param name="admin"/>
  <xsl:param name="embed"/>
  <xsl:param name="node"/>
  <xsl:param name="root"/>
  <xsl:param name="class">location-list-item</xsl:param>

<tr class="{$class}" about="{$node/@rdf:about}">
  <td>
  <a class="title" href="{$node/@rdf:about}"  > <!-- or something like that -->
    <xsl:call-template name="get-location-name">
      <xsl:with-param name="location" select="$node"/>
    </xsl:call-template>
  </a>
  </td>
  <xsl:choose>
    <xsl:when test="$Location/tw:Room">
    <td>
      <xsl:text>A Room </xsl:text> 
      <xsl:call-template name="get-room-has-office-number">
        <xsl:with-param name="room" select="$node"/>
      </xsl:call-template>
      <xsl:call-template name="list-contacts-by-name-room">
        <xsl:with-param name="room" select="$node"/>
      </xsl:call-template>
    </td>
    </xsl:when>
    <xsl:when test="$Location/tw:Building">
    <td>
      <xsl:text>A Building </xsl:text>
      <xsl:call-template name="get-building-city">
        <xsl:with-param name="building" select="$node"/>
      </xsl:call-template>
      <xsl:call-template name="get-building-state">
        <xsl:with-param name="building" select="$node"/>
      </xsl:call-template>
      <xsl:call-template name="list-contacts-by-name-building">
        <xsl:with-param name="building" select="$node"/>
      </xsl:call-template>
    </td>
    </xsl:when>
    <xsl:when test="$Location/tw:PointLocation">
    <td>
      <xsl:text>A Point </xsl:text>
    </td>
    </xsl:when>
    <xsl:when test="$Location/tw:KMLLocation">
    <td>     
      <xsl:text>A KML </xsl:text>
    </td>
    </xsl:when>
    <xsl:when test="$Location/tw:RegionLocation">
    <td>
      <xsl:text>A Region </xsl:text>
    </td>
    </xsl:when>
    <xsl:otherwise>
    <td>
      <xsl:text>An Unknown Type </xsl:text>
    </td>
    </xsl:otherwise>
  </xsl:choose>
</tr>
</xsl:template>

</xsl:stylesheet>
