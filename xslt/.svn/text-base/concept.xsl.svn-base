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
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:import href="/xslt/concept-common.xsl"/>
  
  <xsl:template name="concept">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="name">
      <xsl:call-template name="get-concept-name">
	<xsl:with-param name="concept" select="$node"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="description">
      <xsl:call-template name="get-concept-description">
	<xsl:with-param name="concept" select="$node"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    Description: 
    <xsl:choose>
      <xsl:when test="$description!=''">
        <xsl:copy-of select="$description"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:variable name="seeAlso-raw">
      <xsl:call-template name="get-concept-seeAlso">
	<xsl:with-param name="concept" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="seeAlso" select="exsl:node-set($seeAlso-raw)"/>
    <xsl:if test="$seeAlso-raw!='' or $seeAlso/*">
      <table border="0" width="200px">
        <xsl:for-each select="$seeAlso/*">
	  <tr>
	    <xsl:if test="position()=1">
	      <td rowspan="{count($seeAlso/*)}">See Also</td>
	    </xsl:if>
	    <td>
	      <a href="{@rdf:about}" rel="rdfs:seeAlso">
	        <xsl:value-of select="@rdf:about"/>
	      </a>
	    </td>
	  </tr>
        </xsl:for-each>
      </table>
    </xsl:if>

  </xsl:template>
 
  <xsl:template match="/">
    <xsl:variable name="admin" select="false()"/>
    <link rel="stylesheet" type="text/css" href="/css/objects.css"/>
    <script type="text/javascript" src="/js/layout.js"><xsl:comment/></script>
    <xsl:if test="//tw:Concept|//*[rdf:type/@rdf:resource='&tw;Concept']">
      <xsl:call-template name="concept">
        <xsl:with-param name="node" select="//tw:Concept|//*[rdf:type/@rdf:resource='&tw;Concept']"/>
        <xsl:with-param name="admin" select="$admin"/>
        <xsl:with-param name="embed" select="true()"/>
      </xsl:call-template>
    </xsl:if>
    <br/>
  </xsl:template>
</xsl:stylesheet>
