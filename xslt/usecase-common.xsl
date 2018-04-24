<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
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
		xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	  	xmlns:foaf="&foaf;"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:key name="tw:PointOfContact-nodes" match="tw:PointOfContact|*[rdf:type/@rdf:resource='&tw;PointOfContact']" use="@rdf:nodeID"/>

  <xsl:template match="tw:PointOfContact|*[rdf:type/@rdf:resource='&tw;PointOfContact']" mode="place-link">
    <xsl:param name="usecase"/>
    <span typeof="tw:PointOfContact">
      <span rev="tw:hasRole">
      <xsl:apply-templates select="key('tw:hasRole-nodes',@rdf:nodeID)/.." mode="place-link">
	<xsl:with-param name="usecase" select="$usecase"/>
	<xsl:with-param name="author" select="."/>
      </xsl:apply-templates>
      </span>
      <span property="tw:index" content="{tw:index/text()}"></span>
    </span>
  </xsl:template>

</xsl:stylesheet>
