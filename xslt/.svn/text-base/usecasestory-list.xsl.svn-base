<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY time "http://www.w3.org/2006/time#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>

  <xsl:key name="author-nodes" match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']" use="@rdf:nodeID"/>
  <xsl:key name="has-role-nodes" match="tw:hasRole" use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="tw:UseCaseStory-nodes"
	   match="tw:UseCaseStory|*[rdf:type/@rdf:resource='&tw;UseCaseStory']"
	   use="@rdf:about"/>

  <xsl:template match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']">
    <xsl:param name="usecase"/>
    <xsl:param name="author"/>
    <span about="{@rdf:about}" typeof="foaf:Person">
      <span rel="tw:hasRole">
	<span typeof="tw:Author">
	  <span property="tw:index" content="{$author/tw:hasIndex}"/>
	  <span rel="tw:ofDocument" resource="{$usecase/@rdf:about}"/>
	  <span rev="tw:hasAgentWithRole" resource="{$usecase/@rdf:about}"/>
	</span>
      </span>
      <xsl:call-template name="place-person-link">
	<xsl:with-param name="person" select="."/>
	<xsl:with-param name="style">last,fi</xsl:with-param>
	<xsl:with-param name="rdfa" select="true()"/>
      </xsl:call-template>
    </span>
  </xsl:template>

  <xsl:template match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']">
    <xsl:param name="usecase"/>
    <xsl:apply-templates select="key('has-role-nodes',@rdf:nodeID)/..">
      <xsl:with-param name="usecase" select="$usecase"/>
      <xsl:with-param name="author" select="."/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="dc:title">
    <xsl:param name="document"/>
    <span about="{$document/@rdf:about}"><span property="dc:title"><xsl:value-of select="."/></span></span>
  </xsl:template>

  <xsl:template match="tw:UseCaseStory|*[rdf:type/@rdf:resource='&tw;UseCaseStory']"
		mode="uc-description">
    <xsl:choose>
      <xsl:when test="current()/dc:description/*">
        <xsl:copy-of select="current()/dc:description/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="current()/dc:description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:UseCaseStory|*[rdf:type/@rdf:resource='&tw;UseCaseStory']"
		mode="something">
    <xsl:variable name="usecase" select="."/>
    <tr><td>
    <span about="{@rdf:about}" typeof="tw:UseCaseStory">

    <h2>
    <xsl:choose>
      <xsl:when test="tw:page">
	<a href="{tw:page/@rdf:resource}" rel="tw:page">
	  <xsl:apply-templates select="dc:title">
	    <xsl:with-param name="document" select="."/>
	  </xsl:apply-templates>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<a href="{@rdf:about}" rel="tw:page">
	  <xsl:apply-templates select="dc:title">
	    <xsl:with-param name="document" select="."/>
	  </xsl:apply-templates>
	</a>
      </xsl:otherwise>
    </xsl:choose>
    </h2>

    <xsl:for-each select="key('author-nodes',tw:hasAgentWithRole/*/@rdf:nodeID)|key('author-nodes',tw:hasAgentWithRole/@rdf:nodeID)">
      <xsl:sort select="tw:index" order="ascending" data-type="number"/>
      <xsl:choose>
	<xsl:when test="position()=1">
	  <span style="font-weight:bold;">Author(s)</span>:
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select=".">
	<xsl:with-param name="usecase" select="$usecase"/>
      </xsl:apply-templates>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text> </xsl:text>
	</xsl:when>
        <xsl:when test="position()=last()-1">
          <xsl:text>, &amp; </xsl:text>
        </xsl:when>
	<xsl:otherwise>
	  <xsl:text>, </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <xsl:if test="dc:description">
      <div about="{@rdf:about}" typeof="tw:UseCaseStory">
        <span style="font-weight:bold;">Description: </span>
        <span property="dc:description">
          <xsl:apply-templates select="current()"
                               mode="uc-description"/>
        </span>
      </div>
    </xsl:if>
    </span>
    </td></tr>
  </xsl:template>

  <xsl:template match="rdf:RDF">
    <div>
      <xsl:if test="//tw:UseCaseStory|//*[rdf:type/@rdf:resource='&tw;UseCaseStory']">
        <link href="/css/usecase-list.css" type="text/css" rel="stylesheet"/>
        <table class="usecase-list">
          <xsl:apply-templates select="//tw:UseCaseStory|//*[rdf:type/@rdf:resource='&tw;UseCaseStory']" mode="something">
	    <xsl:sort select="tw:hasDate/*/time:inXSDDateTime" order="descending"/>
          </xsl:apply-templates>
        </table>
      </xsl:if>
      <br />
    </div>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="rdf:RDF"/>
  </xsl:template>

</xsl:stylesheet>
