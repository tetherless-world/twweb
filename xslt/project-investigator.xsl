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
                xmlns:exsl="http://exslt.org/common"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:template name="project-investigator">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="false()"/>
    <div class="project">
    <link href="/css/project.css" type="text/css" rel="stylesheet"/>
    <link href="/css/objects.css" type="text/css" rel="stylesheet"/>
    <span class="prop" style="font-weight:bold;">
      Principal Investigator:
    </span>
    <span rel="tw:hasAgentWithRole">
    <xsl:variable name="investigators">
      <xsl:call-template name="get-project-principal">
        <xsl:with-param name="project" select="$node"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="exsl:node-set($investigators)/*">
      <xsl:sort select="tw:index" data-type="number" order="ascending"/>
<!--
      <xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
-->
      <span typeof="tw:PrincipalInvestigator" rev="tw:hasRole">
        <xsl:call-template name="place-person-link">
          <xsl:with-param name="person" select="current()"/>
          <xsl:with-param name="style">full</xsl:with-param>
          <xsl:with-param name="rdfa" select="true()"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="last()&gt;2 and position()&lt;last()-1">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:when test="last()&gt;2 and position()=last()-1">
            <xsl:text>, and </xsl:text>
          </xsl:when>
          <xsl:when test="last()=2 and position()=1">
            <xsl:text> and </xsl:text>
          </xsl:when>
        </xsl:choose>
      </span>
    </xsl:for-each>
    </span>
    <br />
    <span class="prop" style="font-weight:bold;">
      Co Investigator:
    </span>
    <span rel="tw:hasAgentWithRole">
    <xsl:variable name="coinvestigators">
      <xsl:call-template name="get-project-coinvestigator">
        <xsl:with-param name="project" select="$node"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="exsl:node-set($coinvestigators)/*">
      <xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
      <span typeof="tw:CoInvestigator" rev="tw:hasRole">
        <xsl:call-template name="place-person-link">
          <xsl:with-param name="person" select="current()"/>
          <xsl:with-param name="style">full</xsl:with-param>
          <xsl:with-param name="rdfa" select="true()"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="last()&gt;2 and position()&lt;last()-1">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:when test="last()&gt;2 and position()=last()-1">
            <xsl:text>, and </xsl:text>
          </xsl:when>
          <xsl:when test="last()=2 and position()=1">
            <xsl:text> and </xsl:text>
          </xsl:when>
        </xsl:choose>
      </span>
    </xsl:for-each>
    </span>
    </div>
  </xsl:template>
</xsl:stylesheet>
