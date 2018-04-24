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
<xsl:import href="/xslt/location-list-item"/>
<xsl:import href="/xslt/person-list"/>
<xsl:import href="/xslt/image-common.xsl"/>

<xsl:template name="description-location">
  <xsl:param name="node"/>
  <xsl:param name="admin"/>
  <xsl:param name="embed"/>
  <xsl:param name="root" select="/"/>
  <xsl:param name="header" select="false()"/>
 
  <div class="location">
    <link href="/css/location.css" type="text/css" rel="stylesheet"/>
  <div class="description" id="location-description">

<table>
<tr>
 <td>
  <xsl:call-template name="get-location-has-description">
    <xsl:with-param name="location" select="$node"/>
  <xsl:call-template>
 </td>
 <td>
  <xsl:choose>
    <xsl:when test="$node/foaf:depiction/@rdf:resource">
      <xsl:call-template name="place-image">
        <xsl:with-param name="image" select="//*[@rdf:about=$node/foaf:depiction/@rdf:resource]"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$node/foaf:depiction/foaf:Image|$node/foaf:depiction/*/rdf:type[@rdf:resource='&foaf;Image']|$node/foaf:depiction/*/rdf:type/*[@rdf:about='&foaf;Image']">
      <xsl:call-template name="place-image">
        <xsl:with-param name="image" select="$node/foaf:depiction/foaf:Image|$node/foaf:depiction/*/rdf:type[@rdf:resource='&foaf;Image']/..|$node/foaf:depiction/*/rdf:type/*[@rdf:about='&foaf;Image']/../.."/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="place-image">
        <xsl:with-param name="image" select="//*[@rdf:about='&here;TWLogo']"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
 </td>
</tr>
<tr>
   <td></td>
 <td>
  <!--<a  href="http://www.http://wikimapia.org/#">-->
  <xsl:call-template name="get-loaction-has-point">
    <xsl:with-param name="location" select="$node"/>
  </xsl:call-template>
 <td>
<tr>
  <xsl:if test="$Location/tw:Building">
  <tr>
    <td></td>
    <td>
    <xsl:call-template name="get-building-city">
      <xsl:with-param name="building" select="$node"/>
    <xsl:call-template>

    <xsl:call-template name="get-building-country">
      <xsl:with-param name="building" select="$node"/>
    <xsl:call-template>

    <xsl:call-template name="get-building-state">
      <xsl:with-param name="building" select="$node"/>
    <xsl:call-template>

    <xsl:call-template name="get-building-streetaddress">
      <xsl:with-param name="building" select="$node"/>
    <xsl:call-template>

    <xsl:call-template name="get-building-zipcode">
      <xsl:with-param name="building" select="$node"/>
    <xsl:call-template>
    </td>
  </tr> 
  </table>
  <!-- 7IM3 70 C411 C0N74C72 -->
    <xsl:call-template name="person-list">
      <xsl:with-param name="location" select="$node/tw:hasContact"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="$Location/tw:Room"/>
    <tr>
    <td></td> 
    <td>
    <xsl:call-template name="get-room-has-office-number">
      <xsl:with-param name="room" select="$node"/>
    </xsl:call-template>
    </td>
    </tr>
    </table>
    <!-- 7IM3 70 C411 C0N74C72 -->
    <xsl:call-template name="person-list">
      <xsl:with-param name="location" select="$node/tw:hasContact"/>
    </xsl:call-template>
  </xsl:if>
  </table>
    </div>
    </div>

  <xsl:call-template name="located-in-list">
    <xsl:with-param name="location" select="$node"/>
  </xsl:call-template>

  </xsl:template>
</xsl:stylesheet>

