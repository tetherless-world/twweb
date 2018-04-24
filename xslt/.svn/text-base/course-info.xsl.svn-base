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
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/course-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']"
		mode="render-info">
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>

    <div about="{@rdf:about}" typeof="tw:Course">
      <link href="/css/course.css" rel="stylesheet" type="text/css"/>

    <span rel="tw:hasAgentWithRole">
    <xsl:variable name="professors">
      <xsl:call-template name="get-course-profs">
	<xsl:with-param name="course" select="current()"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="exsl:node-set($professors)/*">
      <xsl:sort select="tw:index"/>
      <xsl:value-of select="tw:index"/>
      <xsl:if test="position()=1">
	<span class="title">Professors: </span>
      </xsl:if>
      <span typeof="tw:Faculty" rev="tw:hasRole">
	<xsl:call-template name="place-person-link">
	  <xsl:with-param name="person" select="current()"/>
	  <xsl:with-param name="style">full</xsl:with-param>
	  <xsl:with-param name="rdfa" select="true()"/>
	</xsl:call-template>
	<xsl:choose>
	  <xsl:when test="last()&gt;2 and position()&lt;last()-1">
	    <xsl:text>, </xsl:text>
	  </xsl:when>
	  <xsl:when test="last()&gt;2 and position()=last()-1">
	    <xsl:text>, and </xsl:text>
	  </xsl:when>
	  <xsl:when test="last()=2 and position()=1">
	    <xsl:text> and </xsl:text>
	  </xsl:when>
	</xsl:choose>
      </span>
    </xsl:for-each>
    </span>
    <br/>

    <xsl:apply-templates select="current()" mode="topics">
      <xsl:with-param name="root" select="$root"/>
    </xsl:apply-templates>

    <br />
    </div>
  </xsl:template>

  <xsl:template name="course-info">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

    <xsl:apply-templates select="$node" mode="render-info">
      <xsl:with-param name="embed" select="$embed"/>
      <xsl:with-param name="root" select="$root"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//tw:Course|//*[rdf:type/@rdf:resource='&tw;Course']" mode="render-info">
      <xsl:with-param name="embed" select="false()"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>
