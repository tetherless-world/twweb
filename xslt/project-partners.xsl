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
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns="http://www.w3.org/1999/xhtml">

		<xsl:include href="organization-list-item.xsl"/>

		<xsl:template name="project-partners">
			<xsl:param name="admin"/>
			<xsl:param name="node"/>
			<xsl:param name="embed"/>

		<xsl:if test="//tw:hasSponsor[@rdf:nodeID]|//tw:hasSponsor/*[@rdf:nodeID]">
		<div id="project-partners" class="section">
		<link href="/css/organization.css" rel="stylesheet" type="text/css"/>

		<xsl:call-template name="header">
			<xsl:with-param name="text">Organizations</xsl:with-param>
			<xsl:with-param name="stylesheet">project-partners</xsl:with-param>
		</xsl:call-template>

		<table class="organization-list">
			<xsl:for-each select="$node/tw:hasSponsor/@rdf:nodeID">
				<xsl:sort select="//tw:hasSponsor[@rdf:nodeID=current()]/../tw:hasName|//tw:hasSponsor/*[@rdf:nodeID=current()]/../../tw:hasName"/>
	    			<xsl:variable name="newnode" select="//tw:hasSponsor[@rdf:nodeID=current()]/..|//tw:hasSponsor/*[@rdf:nodeID=current()]/../.."/>
	    			<xsl:call-template name="organization-list-item">
	     				<xsl:with-param name="admin" select="$admin"/>
	     				<xsl:with-param name="embed" select="$embed"/>
	      				<xsl:with-param name="node" select="$newnode"/>
	    			</xsl:call-template>
	  		</xsl:for-each>
		</table>
      		</div>
    		</xsl:if>
  </xsl:template>
</xsl:stylesheet>
