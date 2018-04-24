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
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/health-person-list-item.xsl"/>
  <xsl:template name="person-list">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:choose>
      <xsl:when test="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']">
	<div xmlns="http://www.w3.org/1999/xhtml">
	  <link href="/css/person-list.css" type="text/css" rel="stylesheet"/>
	  <table class="person-list">
	    <xsl:for-each select="$node//foaf:Person[@rdf:about]|$node//*[rdf:type/@rdf:resource='&foaf;Person' and @rdf:about]">
	      <xsl:sort select="foaf:lastName|foaf:surname|foaf:familyName|foaf:family_name"/>
	      <xsl:call-template name="health-person-list-item">
		<xsl:with-param name="admin" select="$admin"/>
		<xsl:with-param name="node" select="current()"/>
	      </xsl:call-template>
	    </xsl:for-each>
	  </table>
	</div>
      </xsl:when>
      <xsl:otherwise>
	<p xmlns="http://www.w3.org/1999/xhtml">No elements matched your query</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="/">
    <xsl:call-template name="person-list">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="node" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
