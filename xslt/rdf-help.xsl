<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:template name="valuesForProperty">
    <xsl:param name="node"/>
    <xsl:param name="property"/>
    <xsl:for-each select="$node/$property/@rdf:resource">
      <xsl:copy-of select="//*[@rdf:about=current()]"/>
    </xsl:for-each>
    <xsl:for-each select="$node/$property/*">
      <xsl:copy-of select="current()"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="valuesForPropertyOfType">
    <xsl:param name="node"/>
    <xsl:param name="property"/>
    <xsl:param name="qname"/>
    <xsl:param name="uri"/>
    <xsl:for-each select="$node/$property/@rdf:resource">
      <xsl:variable name="resource" select="//*[@rdf:about=current()]"/>
      <xsl:if test="$resource/rdf:type/@rdf:resource=$uri|node-name(current())=$qname">
	<xsl:copy-of select="$resource"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="$node/$property/$qname|$node/$property/rdf:type[@rdf:resource=$uri]/..|$node/$property/rdf:type/*[@rdf:about=$uri]/../..|$node/$property[@rdf:datatype=$uri]/text()">
      <xsl:copy-of select="current()"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
