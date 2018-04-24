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
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/project-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/theme-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:template name="project-participants">
    <xsl:param name="project"/>
    <xsl:param name="root"/>
    <xsl:param name="admin"/>
    <br/>
    <h2>Project Participants</h2>
    <br />
    <span class="prop">
      <h3>Principal Investigator:</h3>
    </span>
    <xsl:variable name="investigators">
      <xsl:call-template name="get-project-principal">
	<xsl:with-param name="project" select="$project"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <span rel="tw:hasAgentWithRole">
      <ul>
      <xsl:for-each select="exsl:node-set($investigators)/*">
	<xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
	<li>
	<span typeof="tw:PrincipalInvestigator" rev="tw:hasRole">
	  <xsl:call-template name="place-person-link">
	    <xsl:with-param name="person" select="current()"/>
	    <xsl:with-param name="style">full</xsl:with-param>
	    <xsl:with-param name="rdfa" select="true()"/>
	  </xsl:call-template>
	</span>
	</li>
      </xsl:for-each>
      </ul>
    </span>
    <span class="prop">
      <h3>Co Investigator:</h3>
    </span>
    <xsl:variable name="coinvestigators">
      <xsl:call-template name="get-project-coinvestigator">
	<xsl:with-param name="project" select="$project"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <span rel="tw:hasAgentWithRole">
      <ul>
      <xsl:for-each select="exsl:node-set($coinvestigators)/*">
	<xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
        <li>
	<span typeof="tw:CoInvestigator" rev="tw:hasRole">
	  <xsl:call-template name="place-person-link">
	    <xsl:with-param name="person" select="current()"/>
	    <xsl:with-param name="style">full</xsl:with-param>
	    <xsl:with-param name="rdfa" select="true()"/>
	  </xsl:call-template>
	</span>
	</li>
      </xsl:for-each>
      </ul>
    </span>
    <span class="prop">
      <h3>Collaborators:</h3>
    </span>
    <xsl:variable name="collaborators">
      <xsl:call-template name="get-project-collaborator">
	<xsl:with-param name="project" select="$project"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <span rel="tw:hasAgentWithRole">
      <ul>
      <xsl:for-each select="exsl:node-set($collaborators)/*">
	<xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
	<span typeof="tw:ProjectCollaborator" rev="tw:hasRole">
	  <li>
	  <xsl:call-template name="place-person-link">
	    <xsl:with-param name="person" select="current()"/>
	    <xsl:with-param name="style">full</xsl:with-param>
	    <xsl:with-param name="rdfa" select="true()"/>
	  </xsl:call-template>
	  </li>
	</span>
      </xsl:for-each>
      </ul>
    </span>
  </xsl:template>

  <xsl:template match="/rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
    <div>
      <xsl:variable name="project" select="//foaf:Project|//*[rdf:type/@rdf:resource='&foaf;Project']"/>
      <xsl:call-template name="project-participants">
	<xsl:with-param name="project" select="$project"/>
	<xsl:with-param name="root" select="/"/>
	<xsl:with-param name="admin" select="$admin"/>
      </xsl:call-template>
    </div>
  </xsl:template>
</xsl:stylesheet>
