<?xml version="1.0"?>
<!-- Created by David Molik using Gedit-->

	<!DOCTYPE xsl:stylesheet [
	  <!ENTITY tw "http://tw.rpi.edu/schema/">
	  <!ENTITY here "http://tw.rpi.edu/instances/">
	]>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:exsl="http://exslt.org/common"
  xmlns:foaf="http://xmlns.com/foaf/0.1/"
  xmlns:tw="&tw;"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:include href="theme-common.xsl"/>
  <xsl:include href="project-common.xsl"/>

  <xsl:template name="project-themes">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root"/>
    <xsl:param name="embed"/>
    <xsl:if test="$node/tw:hasThemeReference">
      <span class="prop" style="font-weight:bold;">
	Research Areas:
      </span>
      <xsl:for-each select="$node/tw:hasThemeReference">
	<xsl:choose>
	  <xsl:when test="@rdf:resource">
	    <xsl:variable name="theme" select="//*[@rdf:about=current()/@rdf:resource]"/>
	    <xsl:call-template name="place-theme-link">
	      <xsl:with-param name="theme" select="$theme"/>
	      <xsl:with-param name="rel">tw:hasThemeReference</xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:variable name="theme" select="./*"/>
	    <xsl:call-template name="place-theme-link">
	      <xsl:with-param name="theme" select="$theme"/>
	      <xsl:with-param name="rel">tw:hasThemeReference</xsl:with-param>
	    </xsl:call-template>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="not(position()=last())">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>
      <br />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>

