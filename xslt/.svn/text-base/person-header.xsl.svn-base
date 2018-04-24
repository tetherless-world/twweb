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
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:exsl="http://exslt.org/common"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/person-infobox.xsl"/>
  <xsl:template name="person-header">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <div class="header">
      <link href="/css/person.css" rel="stylesheet" type="text/css"/>
      <xsl:choose>
	<xsl:when test="not($embed=true())">
	  <h1 xmlns:tw="&tw;">
	    <span property="foaf:firstName">
	      <xsl:value-of select="$node/foaf:firstName"/>
	    </span>
	    <xsl:text> </xsl:text>
	    <span property="foaf:lastName">
	      <xsl:value-of select="$node/foaf:lastName"/>
	    </span>
	    <xsl:if test="$admin='true'">
	      <span class="edit"> (<a href="{$node/@rdf:about}/edit">Edit</a>)</span>
	    </xsl:if>
<!--
	    <xsl:variable name="image-raw">
	      <xsl:call-template name="get-person-depiction">
		<xsl:with-param name="person" select="$node"/>
		<xsl:with-param name="root" select="$root"/>
	      </xsl:call-template>
	    </xsl:variable>-
	    <xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
	    <xsl:choose>
	      <xsl:when test="$image-raw!=''">
		<xsl:call-template name="place-image">
		  <xsl:with-param name="image" select="$image"/>
		  <xsl:with-param name="class">thumb</xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
		<img class="thumb" src="/tw.rpi.edu/img_avtrs/Unknown_AVTR.jpg"/>
	      </xsl:otherwise>
	    </xsl:choose>
-->
	  </h1>
	  <xsl:call-template name="person-infobox">
	    <xsl:with-param name="admin" select="$admin"/>
	    <xsl:with-param name="node" select="$node"/>
	    <xsl:with-param name="embed" select="$embed"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="person-infobox">
	    <xsl:with-param name="admin" select="$admin"/>
	    <xsl:with-param name="node" select="$node"/>
	    <xsl:with-param name="embed" select="$embed"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
<!--
	  <xsl:variable name="image-raw">
	    <xsl:call-template name="get-person-depiction">
	      <xsl:with-param name="person" select="$node"/>
	      <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:variable>
	  <xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
	  <xsl:choose>
	    <xsl:when test="$image-raw!=''">
	      <xsl:call-template name="place-image">
		<xsl:with-param name="image" select="$image"/>
		<xsl:with-param name="class">thumb</xsl:with-param>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <img class="thumb" src="/tw.rpi.edu/img_avtrs/Unknown_AVTR.jpg"/>
	    </xsl:otherwise>
	  </xsl:choose>
-->
	</xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>
