<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:dc="http://purl.org/dc/terms/"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:skos="http://www.w3.org/2008/05/skos#"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:key name="tw:Concept-nodes" match="tw:Concept|*[rdf:type/@rdf:resource='&tw;Concept']" use="@rdf:about"/>

  <xsl:template name="get-concept-name">
    <xsl:param name="concept"/>
    <xsl:param name="root" select="/"/>
    <xsl:value-of select="$concept/skos:prefLabel"/>
  </xsl:template>

  <xsl:template name="get-concept-description">
    <xsl:param name="concept"/>
    <xsl:param name="root" select="/"/>
    <xsl:copy-of select="$concept/skos:definition"/>
  </xsl:template>

  <xsl:template name="get-concept-page">
    <xsl:param name="concept"/>
    <xsl:choose>
      <xsl:when test="$concept/tw:page">
	<xsl:value-of select="$concept/tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$concept/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-concept-link">
    <xsl:param name="concept"/>
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-concept-page">
	<xsl:with-param name="concept" select="$concept"/>
      </xsl:call-template>
    </xsl:variable>
    <span>
      <xsl:if test="$rel!=''">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
      <span about="{$concept/@rdf:about}" typeof="tw:Concept">
	<a href="{$uri}" rel="tw:page" property="skos:prefLabel">
	  <xsl:call-template name="get-concept-name">
	    <xsl:with-param name="concept" select="$concept"/>
	  </xsl:call-template>
	</a>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="tw:Concept|*[rdf:type/@rdf:resource='&tw;Concept']"
		mode="place-link">
    <xsl:call-template name="place-concept-link">
      <xsl:with-param name="concept" select="current()"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="get-concept-seeAlso">
    <xsl:param name="concept"/>
    <xsl:for-each select="$concept/rdfs:seeAlso">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
