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
        xmlns:exsl="http://exslt.org/common"
        xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:owl="http://www.w3.org/2002/07/owl#"
	xmlns="http://www.w3.org/1999/xhtml">
	
	<xsl:include href="/xslt/project-common.xsl"/>
	<xsl:include href="/xslt/concept-common.xsl"/>
	
      <xsl:template name="project-concepts">
	<xsl:param name="admin"/>
	<xsl:param name="node"/>
	<xsl:param name="root"/>
	<xsl:param name="embed"/>
	<xsl:if test="$node/tw:hasTopic">
	  <span class="prop" style="font-weight:bold;">
	    Concepts:
	  </span>
	  <xsl:for-each select="$node/tw:hasTopic">
	    <!--
	    <xsl:variable name="something" select="key('tw:Concept-nodes',current()/@rdf:resource)|key('tw:Concept-nodes',current()/*/@rdf:about)"/>
	    <xsl:call-template name="place-concept-link">
	      <xsl:with-param name="concept" select="$something"/>
	      <xsl:with-param name="rel">tw:hasTopic</xsl:with-param>
	    </xsl:call-template>
	    -->
	    <xsl:choose>
	      <xsl:when test="@rdf:resource">
		<xsl:variable name="concept" select="//*[@rdf:about=current()/@rdf:resource]"/>
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="$concept"/>
		  <xsl:with-param name="rel">tw:hasTopic</xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:variable name="concept" select="./*"/>
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="$concept"/>
		  <xsl:with-param name="rel">tw:hasTopic</xsl:with-param>
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
