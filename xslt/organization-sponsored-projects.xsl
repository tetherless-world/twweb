<?xml version="1.0"?>
<!-- Created by David Molik using Gedit-->

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
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:import href="/xslt/project-list.xsl"/>

  <xsl:template name="organization-sponsored-projects">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

    <link href="/css/project.css" rel="stylesheet" type="text/css"/>
    
    <xsl:variable name="projects-raw">
      <xsl:call-template name="get-organization-sponsored-projects">
	<xsl:with-param name="organization" select="$node"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="projects" select="exsl:node-set($projects-raw)"/>
    <xsl:if test="$projects-raw!=''">
      <div id="person-projects" class="section">
      <xsl:call-template name="header">
	<xsl:with-param name="text">Sponsored Projects:</xsl:with-param>
	<xsl:with-param name="stylesheet">organization-sponsored-projects</xsl:with-param>
      </xsl:call-template>
      <table class="project-list" rel="tw:hasRole">
        <xsl:for-each select="$projects/*">
  	  <xsl:sort select="foaf:name"/>
  	  <xsl:call-template name="project-list-item">
  	    <xsl:with-param name="admin" select="$admin"/>
  	    <xsl:with-param name="embed" select="$embed"/>
  	    <xsl:with-param name="root" select="$root"/>
  	    <xsl:with-param name="node" select="current()"/>
  	    <xsl:with-param name="tr-typeof">tw:ProjectCollaborator</xsl:with-param>
  	    <xsl:with-param name="tr-rev">tw:hasAgentWithRole</xsl:with-param>
  	  </xsl:call-template>
        </xsl:for-each>
      </table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
