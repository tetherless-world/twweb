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

  <xsl:template name="get-person-bio">
    <xsl:param name="person"/>
      <xsl:if test="$person/tw:hasBio/@xml:lang">
	<xsl:attribute name="xml:lang">
	  <xsl:value-of select="$person/tw:hasBio/@xml:lang"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$person/tw:hasBio/*">
          <xsl:copy-of select="$person/tw:hasBio/*"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$person/tw:hasBio"/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

    <xsl:template match="rdf:RDF">
	<xsl:if test="current()/foaf:Person|current()//*[rdf:type/@rdf:resource='&foaf;Person']">
	    <xsl:call-template name="get-person-bio">
		<xsl:with-param name="person" select="current()/foaf:Person|current()//*[rdf:type/@rdf:resource='&foaf;Person']"/>
	    </xsl:call-template>
	</xsl:if>
    </xsl:template>

    <xsl:template match="/">
	<xsl:apply-templates select="rdf:RDF"/>
    </xsl:template>

</xsl:stylesheet>
