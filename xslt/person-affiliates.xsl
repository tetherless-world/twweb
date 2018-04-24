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
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/organization-list-item.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:template name="person-affiliates">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:if test="$node/tw:hasAffiliation">
      <div id="person-affiliates" class="section">
      <link href="/css/organization.css" rel="stylesheet" type="text/css"/>
      <xsl:call-template name="header">
	<xsl:with-param name="text">Affiliations</xsl:with-param>
	<xsl:with-param name="stylesheet">person-affiliates</xsl:with-param>
      </xsl:call-template>
      <table class="organization-list" rel="tw:hasAffiliation">
	<xsl:for-each select="$node/tw:hasAffiliation">
	  <xsl:sort select="//*[@rdf:about=current()/@rdf:resource]/foaf:name|current()/*/foaf:name"/>
	  <xsl:choose>
	    <xsl:when test="@rdf:resource">
	      <xsl:variable name="resource" select="@rdf:resource"/>
	      <xsl:call-template name="organization-list-item">
		<xsl:with-param name="admin" select="$admin"/>
		<xsl:with-param name="node" select="//*[@rdf:about=$resource]"/>
		<xsl:with-param name="rdfa">tw:hasAffiliation</xsl:with-param>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="organization-list-item">
		<xsl:with-param name="admin" select="$admin"/>
		<xsl:with-param name="node" select="./*"/>
		<xsl:with-param name="rdfa">tw:hasAffiliation</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
