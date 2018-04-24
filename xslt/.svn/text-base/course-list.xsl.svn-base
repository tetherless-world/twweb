<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:tw="&tw;"
		xmlns:exsl="http://exslt.org/common"
		xmlns:foaf="&foaf;"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/course-list-item.xsl"/>

  <xsl:template match="/rdf:RDF">
    <link href="/css/course.css" rel="stylesheet" type="text/css"/>
    <table class="course-list">
    <xsl:for-each select="//tw:Course|//*[rdf:type/@rdf:resource='&tw;Course']">
      <xsl:sort select="foaf:name"/>
      <xsl:apply-templates select="current()" mode="list-item">
	<xsl:with-param name="root" select="/"/>
	<xsl:with-param name="class">
	  <xsl:choose>
	    <xsl:when test="(position() mod 2) = 0">even</xsl:when>
	    <xsl:when test="(position() mod 2) = 1">odd</xsl:when>
	  </xsl:choose>
	</xsl:with-param>
      </xsl:apply-templates>
    </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="rdf:RDF"/>
  </xsl:template>
</xsl:stylesheet>
