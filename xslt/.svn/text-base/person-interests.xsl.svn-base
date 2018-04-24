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
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:template name="person-interests">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="interests-raw">
      <xsl:call-template name="get-person-interests">
	<xsl:with-param name="person" select="$node"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="interests" select="exsl:node-set($interests-raw)"/>
    <xsl:if test="$interests-raw!=''">
      <p><strong>Interests: </strong>
	<xsl:for-each select="$interests/*">
	  <xsl:sort select="foaf:name"/>
	  <xsl:call-template name="place-concept-link">
	    <xsl:with-param name="concept" select="current()"/>
	    <xsl:with-param name="rel">tw:hasInterest</xsl:with-param>
	  </xsl:call-template>
	  <xsl:if test="position()!=last()">
	    <xsl:text>, </xsl:text>
	  </xsl:if>
	</xsl:for-each>
      </p>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
