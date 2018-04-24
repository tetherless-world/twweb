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

  <xsl:key name="years" match="s:literal" use="text()"/>

  <xsl:template name="genListR">
    <xsl:param name="first"/>
    <xsl:param name="stop"/>
    <xsl:choose>
      <xsl:when test="$first &lt; $stop">
      </xsl:when>
      <xsl:when test="$first=$stop">
	<s:number><xsl:value-of select="$first"/></s:number>
      </xsl:when>
      <xsl:otherwise>
	<s:number><xsl:value-of select="$first"/></s:number>
	<xsl:call-template name="genListR">
	  <xsl:with-param name="first" select="$first - 1"/>
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
    
    <xsl:variable name="first" select="s:sparql//s:result[1]"/>
    <xsl:variable name="last" select="s:sparql//s:result[last()]"/>
    <xsl:variable name="list">
      <xsl:call-template name="genListR">
	<xsl:with-param name="first" select="number($first)"/>
	<xsl:with-param name="stop" select="number($last)"/>
      </xsl:call-template>
    </xsl:variable>

    <div class="section">
      <link href="/css/paginate.css" type="text/css" rel="stylesheet"></link>
    <h3>Publications</h3>
    <div class="person-publications-paginate-header">
      <span class="yearOption selected">All</span>
      <xsl:for-each select="exsl:node-set($list)/*">
	<xsl:variable name="text"><xsl:value-of select="text()"/></xsl:variable>
	<span>
	  <xsl:if test="$root//s:literal[text()=$text]">
	    <xsl:attribute name="class">yearOption</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$text"/>
	</span>
      </xsl:for-each>
    </div>
    <script src="/js/paginate.js" type="text/javascript"><xsl:comment/></script>
    </div>
  </xsl:template>

</xsl:stylesheet>
