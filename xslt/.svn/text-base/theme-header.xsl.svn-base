<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/theme-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>

  <xsl:template match="tw:Theme|*[rdf:type/@rdf:resource='&tw;Theme']" mode="place-header">
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root"/>

    <xsl:variable name="theme" select="."/>

    <div class="theme">
      <link href="/css/theme.css" type="text/css" rel="stylesheet"/>
    <div id="theme-header" class="header">
    <h1 xmlns:tw="&tw;">
      <xsl:if test="not($embed=true())">
	<span rel="tw:hasName">
	  <xsl:call-template name="get-theme-name">
	    <xsl:with-param name="theme" select="$theme"/>
	  </xsl:call-template>
	  <xsl:if test="$admin=true()">
	    <a href="./edit">Edit</a>
	  </xsl:if>
	</span>
      </xsl:if>
      <xsl:if test="$theme/foaf:logo">
        <xsl:apply-templates select="$theme/foaf:logo" mode="place-image">
	  <xsl:with-param name="style">width:200px;float:right;</xsl:with-param>
	  <xsl:with-param name="rel">foaf:logo</xsl:with-param>
	</xsl:apply-templates>
      </xsl:if>
    </h1>
    </div>
    <p class="lead">
      <span class="label">Lead Professor: </span>
      <xsl:for-each select="key('foaf:Person-nodes',$theme/tw:hasLeadProfessor/*/@rdf:about)|key('foaf:Person-nodes',$theme/tw:hasLeadProfessor/@rdf:resource)">
	<xsl:sort select="foaf:lastName|foaf:surname|foaf:family_name|foaf:familyName"/>
	<xsl:apply-templates select="." mode="place-link"/>
	<xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
      </xsl:for-each>
    </p>
    </div>
  </xsl:template>

  <xsl:template name="theme-header">
    <xsl:param name="node"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <div class="section">
      <link href="/css/document.css" type="text/css" rel="stylesheet"/>
      <xsl:apply-templates select="$node" mode="place-header">
        <xsl:with-param name="admin" select="$admin"/>
        <xsl:with-param name="embed" select="$embed"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
</xsl:stylesheet>

