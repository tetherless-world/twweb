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

  <xsl:import href="/xslt/project-list-item.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>

  <xsl:key name="tw:hasAgentWithRole-nodes"
           match="foaf:Project/tw:hasAgentWithRole|*[rdf:type/@rdf:resource='&foaf;Project']/tw:hasAgentWithRole"
           use="@rdf:nodeID|*/@rdf:nodeID" />

  <xsl:template name="person-projects">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>

    <xsl:variable name="roles_pi" select="key('tw:PrincipalInvestigator-nodes',$node/tw:hasRole/@rdf:nodeID|$node/tw:hasRole/*/@rdf:nodeID)"/>
    <xsl:variable name="projects_pi" select="key('tw:hasAgentWithRole-nodes',$roles_pi/@rdf:nodeID)/.."/>
    <xsl:if test="count($projects_pi)>0">
      <div id="person-projects" class="section">
	<link href="/css/project.css" rel="stylesheet" type="text/css"/>
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Project PI</xsl:with-param>
	  <xsl:with-param name="stylesheet">person-projects</xsl:with-param>
	</xsl:call-template>
	<table class="project-list" rel="tw:hasRole">
	  <xsl:for-each select="$projects_pi">
	    <xsl:sort select="foaf:name"/>
	    <xsl:call-template name="project-list-item">
	      <xsl:with-param name="admin" select="$admin"/>
	      <xsl:with-param name="embed" select="$embed"/>
	      <xsl:with-param name="root" select="$root"/>
	      <xsl:with-param name="node" select="current()"/>
	      <xsl:with-param name="tr-typeof">tw:Collaborator</xsl:with-param>
	      <xsl:with-param name="tr-rev">tw:hasAgentWithRole</xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</table>
      </div>
    </xsl:if>

    <xsl:variable name="roles_coi" select="key('tw:CoInvestigator-nodes',$node/tw:hasRole/@rdf:nodeID|$node/tw:hasRole/*/@rdf:nodeID)"/>
    <xsl:variable name="projects_coi" select="key('tw:hasAgentWithRole-nodes',$roles_coi/@rdf:nodeID)/.."/>
    <xsl:if test="count($projects_coi)>0">
      <div id="person-projects" class="section">
	<link href="/css/project.css" rel="stylesheet" type="text/css"/>
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Project CO-PI</xsl:with-param>
	  <xsl:with-param name="stylesheet">person-projects</xsl:with-param>
	</xsl:call-template>
	<table class="project-list" rel="tw:hasRole">
	  <xsl:for-each select="$projects_coi">
	    <xsl:sort select="foaf:name"/>
	    <xsl:call-template name="project-list-item">
	      <xsl:with-param name="admin" select="$admin"/>
	      <xsl:with-param name="embed" select="$embed"/>
	      <xsl:with-param name="root" select="$root"/>
	      <xsl:with-param name="node" select="current()"/>
	      <xsl:with-param name="tr-typeof">tw:Collaborator</xsl:with-param>
	      <xsl:with-param name="tr-rev">tw:hasAgentWithRole</xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</table>
      </div>
    </xsl:if>

    <xsl:variable name="roles" select="key('tw:Collaborator-nodes',$node/tw:hasRole/@rdf:nodeID|$node/tw:hasRole/*/@rdf:nodeID)"/>
    <xsl:variable name="projects" select="key('tw:hasAgentWithRole-nodes',$roles/@rdf:nodeID)/.."/>
    <xsl:if test="count($projects)>0">
      <div id="person-projects" class="section">
	<link href="/css/project.css" rel="stylesheet" type="text/css"/>
	<xsl:call-template name="header">
	  <xsl:with-param name="text">Project Collaborator</xsl:with-param>
	  <xsl:with-param name="stylesheet">person-projects</xsl:with-param>
	</xsl:call-template>
	<table class="project-list" rel="tw:hasRole">
	  <xsl:for-each select="$projects">
	    <xsl:sort select="foaf:name"/>
	    <xsl:call-template name="project-list-item">
	      <xsl:with-param name="admin" select="$admin"/>
	      <xsl:with-param name="embed" select="$embed"/>
	      <xsl:with-param name="root" select="$root"/>
	      <xsl:with-param name="node" select="current()"/>
	      <xsl:with-param name="tr-typeof">tw:Collaborator</xsl:with-param>
	      <xsl:with-param name="tr-rev">tw:hasAgentWithRole</xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
