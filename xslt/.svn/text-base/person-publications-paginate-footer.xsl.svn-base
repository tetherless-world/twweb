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
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="&foaf;"
   xmlns:s="http://www.w3.org/2005/sparql-results#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:variable name="limit" select="10"/>

  <xsl:template name="genList">
    <xsl:param name="first"/>
    <xsl:param name="stop"/>
    <xsl:choose>
      <xsl:when test="$first > $stop">
      </xsl:when>
      <xsl:when test="$first=$stop">
	<s:number><xsl:value-of select="$first"/></s:number>
      </xsl:when>
      <xsl:otherwise>
	<s:number><xsl:value-of select="$first"/></s:number>
	<xsl:call-template name="genList">
	  <xsl:with-param name="first" select="$first + 1"/>
	  <xsl:with-param name="stop" select="$stop"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    
    <div class="person-publications-paginate-footer">
      <xsl:variable name="list">
	<xsl:call-template name="genList">
	  <xsl:with-param name="first" select="1"/>
	  <xsl:with-param name="stop" select="(number(//s:literal)-1) div $limit + 1"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:text>Page: </xsl:text>
      <xsl:for-each select="exsl:node-set($list)/*">
	<span class="page">
	  <xsl:if test="position() = 1">
	    <xsl:attribute name="class">page selected</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="."/></span>
      </xsl:for-each>
      <script type="text/javascript">$(function() { window.pageLimit = <xsl:value-of select="$limit"/>; if(window.paginated===undefined) paginate(); });</script>
    </div>
  </xsl:template>

</xsl:stylesheet>
