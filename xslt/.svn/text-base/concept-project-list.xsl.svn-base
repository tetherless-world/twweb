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
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/project-list.xsl"/>

  <xsl:template match="/rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
  <xsl:variable name="projects" select="//foaf:Project|//*[rdf:type/@rdf:resource='&foaf;Project']"/>
  <xsl:choose>
    <xsl:when test="$projects!=''">
      <div>
	<strong>Projects: </strong>
	<xsl:call-template name="project-list">
	  <xsl:with-param name="projects" select="$projects"/>
	  <xsl:with-param name="root" select="/"/>
	  <xsl:with-param name="admin" select="$admin"/>
	</xsl:call-template>
      </div>
    </xsl:when>
    <xsl:otherwise>
      <div>
      </div>
    </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
