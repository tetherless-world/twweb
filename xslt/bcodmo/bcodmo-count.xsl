<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet 
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:bcodmo="http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/"
   xmlns:res="http://www.w3.org/2005/sparql-results#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template name="get-binding-value">
    <xsl:param name="node"/>
    <xsl:param name="var"/>
    <xsl:for-each select="//res:binding">
      <xsl:choose>
        <xsl:when test="current()[@name=$var]">
	  <xsl:value-of select="current()"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/">
    <xsl:variable name="label">
      <xsl:call-template name="get-binding-value">
	<xsl:with-param name="node" select="current()"/>
	<xsl:with-param name="var">
	  <xsl:text>type_label</xsl:text>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="value">
      <xsl:call-template name="get-binding-value">
	<xsl:with-param name="node" select="current()"/>
	<xsl:with-param name="var">
	  <xsl:text>type_count</xsl:text>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <tr>
    <td style="width:75%;text-align:left;"><xsl:value-of select="$label"/></td>
    <td style="width:25%;text-align:right;"><xsl:value-of select="$value"/></td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>

