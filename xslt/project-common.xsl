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
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:exsl="http://exslt.org/common"
>
  <!--
    List of roles that are of type PrincipalInvestigator using rdf:nodeID
  -->
  <xsl:key name="tw:PrincipalInvestigator-nodes"
           match="tw:PrincipalInvestigator|*[rdf:type/@rdf:resource='&tw;PrincipalInvestigator']"
	   use="@rdf:nodeID"/>

  <!--
    List of roles that are of type CoInvestigator using rdf:nodeID
  -->
  <xsl:key name="tw:CoInvestigator-nodes"
           match="tw:CoInvestigator|*[rdf:type/@rdf:resource='&tw;CoInvestigator']"
	   use="@rdf:nodeID"/>

  <!--
    List of roles that are of type ProjectCollaborator using rdf:nodeID
  -->
  <xsl:key name="tw:Collaborator-nodes"
           match="tw:ProjectCollaborator|*[rdf:type/@rdf:resource='&tw;ProjectCollaborator']"
	   use="@rdf:nodeID"/>

  <!--
    List of URI's that have the property tw:hasRole
  -->
  <xsl:key name="tw:hasRole-nodes"
           match="tw:hasRole"
	   use="@rdf:nodeID|*/@rdf:nodeID"/>

  <!--
    List of uri's that are of type Project using rdf:about
  -->
  <xsl:key name="foaf:Project-nodes"
           match="foaf:Project|*[rdf:type/@rdf:resource='&foaf;Project']"
	   use="@rdf:about"/>

  <xsl:template name="get-project-logo">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="$project/foaf:logo/@rdf:resource">
	<xsl:copy-of select="$root//*[@rdf:about=$project/foaf:logo/@rdf:resource]"/>
      </xsl:when>
      <xsl:when test="$project/foaf:logo/@rdf:nodeID">
	<xsl:copy-of select="$root//*[@rdf:nodeID=$project/foaf:logo/@rdf:nodeID]/*/.."/>
      </xsl:when>
      <xsl:when test="$project/foaf:logo/*">
	<xsl:copy-of select="$project/foaf:logo/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-project-acronym">
    <xsl:param name="project"/>
    <xsl:if test="$project/tw:hasAcronym">
      <xsl:value-of select="$project/tw:hasAcronym"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="get-project-name">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:value-of select="$project/foaf:name"/>
  </xsl:template>

  <xsl:template match="foaf:Project|*[rdf:type/@rdf:resource='&foaf;Project']"
		mode="link">
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-project-page">
	<xsl:with-param name="project" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <a href="{$uri}">
      <xsl:if test="$rel!=''">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="get-project-name">
	<xsl:with-param name="project" select="current()"/>
      </xsl:call-template>
    </a>    
  </xsl:template>

  <xsl:template name="get-project-description">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:copy-of select="$project/dc:description"/>
  </xsl:template>

  <xsl:template name="get-project-short-description">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="$project/tw:hasShortDescription">
        <xsl:value-of select="$project/tw:hasShortDescription"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="description-raw"><xsl:call-template name="get-project-description"><xsl:with-param name="project" select="$project"/><xsl:with-param name="root" select="$root"/></xsl:call-template></xsl:variable>
        <xsl:variable name="description"><xsl:value-of select="exsl:node-set($description-raw)"/></xsl:variable>
        <xsl:choose>
          <xsl:when test="contains($description,'.')">
            <xsl:value-of select="concat(substring-before($description,'.'),'.')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($description,'.')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-project-page">
    <xsl:param name="project"/>
    <xsl:choose>
      <xsl:when test="$project/tw:page">
	<xsl:for-each select="$project/tw:page">
	  <xsl:if test="contains(@rdf:resource,'web') and contains(@rdf:resource,'tw.rpi.edu')">
	    <xsl:value-of select="@rdf:resource"/>
	  </xsl:if>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$project/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-project-principal">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$project/tw:hasAgentWithRole/@rdf:nodeID|$project/tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:for-each select="key('tw:PrincipalInvestigator-nodes',.)">
        <xsl:for-each select="key('tw:hasRole-nodes',@rdf:nodeID)">
	  <xsl:copy-of select=".."/>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-project-coinvestigator">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$project/tw:hasAgentWithRole/@rdf:nodeID|$project/tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:for-each select="key('tw:CoInvestigator-nodes',.)">
        <xsl:for-each select="key('tw:hasRole-nodes',@rdf:nodeID)">
	  <xsl:copy-of select=".."/>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-project-collaborator">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$project/tw:hasAgentWithRole/@rdf:nodeID|$project/tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:for-each select="key('tw:Collaborator-nodes',.)">
	<xsl:if test="count(key('tw:PrincipalInvestigator-nodes',@rdf:nodeID))=0 and count(key('tw:CoInvestigator-nodes',@rdf:nodeID))=0">
          <xsl:for-each select="key('tw:hasRole-nodes',@rdf:nodeID)">
	    <xsl:copy-of select=".."/>
          </xsl:for-each>
	</xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-project-sponsors">
    <xsl:param name="project"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$project/tw:hasSponsor">
      <xsl:choose>
	<xsl:when test="@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and rdf:type='&foaf;Organization']|$root//foaf:Organization"/>
	</xsl:when>
	<xsl:when test="*">
	  <xsl:copy-of select="*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="place-project-link">
    <xsl:param name="project"/>
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-project-page">
	<xsl:with-param name="project" select="$project"/>
      </xsl:call-template>
    </xsl:variable>
    <a href="{$uri}">
      <xsl:if test="$rel!=''">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="get-project-name">
	<xsl:with-param name="project" select="$project"/>
      </xsl:call-template>
    </a>
  </xsl:template>
</xsl:stylesheet>
