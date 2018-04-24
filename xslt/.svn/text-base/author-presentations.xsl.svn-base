<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
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
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/presentation-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:template name="author-presentations">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="uri" select="$node/@rdf:about"/>
    <xsl:variable name="presentations-raw">
      <xsl:call-template name="get-person-presentations">
	<xsl:with-param name="person" select="$node"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="presentations" select="exsl:node-set($presentations-raw)"/>
    <xsl:if test="$presentations-raw!=''">
      <div class="section" id="author-presentations">
      <link href="/css/presentations.css" type="text/css" rel="stylesheet"/>
      <xsl:call-template name="header">
	<xsl:with-param name="text">Presentations</xsl:with-param>
	<xsl:with-param name="stylesheet">author-presentations</xsl:with-param>
      </xsl:call-template>
<!--
      <xsl:call-template name="presentation-list">
	<xsl:with-param name="presentations" select="$presentations"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
-->
      <table class="presentations-list">
	<xsl:for-each select="$presentations/*">
	  <tr><td>
	      <xsl:call-template name="get-presentation-citation">
		<xsl:with-param name="presentation" select="current()"/>
		<xsl:with-param name="root" select="$root"/>
	      </xsl:call-template>
	  </td></tr>
	</xsl:for-each>
      </table>
<!--
      <table class="papers-list">
	<xsl:for-each select="$node/tw:hasRole/*/rdf:type[@rdf:resource='&tw;Author']/..|$node/tw:hasRole/tw:Author|$node/tw:hasRole/*/rdf:type/*[@rdf:about='&tw;Author']/../..|//*[@rdf:about=$node/tw:hasRole/@rdf:resource]">
	  <xsl:choose>
	    <xsl:when test="current()/tw:ofDocument[@rdf:resource]">
	      <xsl:variable name="paper" select="current()/tw:ofDocument/@rdf:resource"/>
	      <xsl:if test="//*[@rdf:about=$paper]/rdf:type/@rdf:resource='&tw;Presentation'">
	      <xsl:call-template name="paper-list-item">
		<xsl:with-param name="admin" select="$admin"/>
		<xsl:with-param name="node" select="//*[@rdf:about=$paper]"/>
		<xsl:with-param name="embed" select="$embed"/>
	      </xsl:call-template>
	      </xsl:if>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:if test="current()/tw:ofDocument/*//rdf:type/@rdf:resource='&tw;Presentation'">
	      <xsl:call-template name="paper-list-item">
		<xsl:with-param name="admin" select="$admin"/>
		<xsl:with-param name="node" select="current()/tw:ofDocument/*[@rdf:about]|current()/tw:ofDocument/*"/>
		<xsl:with-param name="embed" select="$embed"/>
	      </xsl:call-template>
	      </xsl:if>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </table>
-->
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
