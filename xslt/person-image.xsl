<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:exsl="http://exslt.org/common"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>

  <xsl:template name="person-image">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="image-raw">
      <xsl:call-template name="get-person-depiction">
        <xsl:with-param name="person" select="$node"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
    <xsl:if test="$image-raw!=''">
      <xsl:call-template name="place-image"><xsl:with-param name="image" select="$image"/></xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
