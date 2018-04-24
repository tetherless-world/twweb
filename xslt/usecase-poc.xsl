<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY media "http://tw.rpi.edu/media/">
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
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:foaf="&foaf;"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/usecase-common.xsl"/>
  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>

  <xsl:template match="tw:UseCase|*[rdf:type/@rdf:resource='&tw;UseCase']" mode="list-poc">
    <xsl:variable name="usecase" select="."/>
    <xsl:for-each select="key('tw:PointOfContact-nodes',tw:hasAgentWithRole/*[rdf:type]/@rdf:nodeID)|key('tw:PointOfContact-nodes',tw:hasAgentWithRole/@rdf:nodeID)">
      <xsl:sort select="tw:index" order="ascending" data-type="number"/>
      <span rel="tw:hasAgentWithRole">
	<xsl:apply-templates select="." mode="place-link"/>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text> </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1 and last()=2">
	  <xsl:text> &amp; </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1">
	  <xsl:text>, &amp; </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>, </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="usecase-poc">
    <xsl:param name="node"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <div class="section">
      <link href="/css/document.css" type="text/css" rel="stylesheet"/>
      <p>
	<b class="label">Points of Contact:</b>
	<xsl:apply-templates select="$node" mode="list-poc">
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="embed" select="$embed"/>
	  <xsl:with-param name="root" select="$root"/>
	  <xsl:with-param name="header" select="$header"/>
	</xsl:apply-templates>
      </p>
    </div>
  </xsl:template>

</xsl:stylesheet>

