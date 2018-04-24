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

  <xsl:import href="http://tw.rpi.edu/xslt/person-common.xsl"/>
  <xsl:import href="http://tw.rpi.edu/xslt/event-common.xsl"/>
  <xsl:import href="http://tw.rpi.edu/xslt/time-common.xsl"/>

  <xsl:key name="author-nodes" match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']" use="@rdf:nodeID"/>
  <xsl:key name="has-role-nodes" match="tw:hasRole" use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="event-nodes" match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']" use="@rdf:about"/>

  <xsl:template match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']">
    <xsl:param name="presentation"/>
    <xsl:param name="author"/>
    <span about="{@rdf:about}" typeof="foaf:Person">
      <span rel="tw:hasRole">
	<span typeof="tw:Author">
	  <span property="tw:index" content="{$author/tw:hasIndex}"/>
	  <span rel="tw:ofDocument" resource="{$presentation/@rdf:about}"/>
	  <span rev="tw:hasAgentWithRole" resource="{$presentation/@rdf:about}"/>
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
    <xsl:param name="presentation"/>
    <xsl:apply-templates select="key('has-role-nodes',@rdf:nodeID)/..">
      <xsl:with-param name="presentation" select="$presentation"/>
      <xsl:with-param name="author" select="."/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="dc:title">
    <xsl:param name="document"/>
    <span about="{$document/@rdf:about}"><span property="dc:title"><xsl:value-of select="."/></span></span>
  </xsl:template>

  <xsl:template match="tw:Presentation|*[rdf:type/@rdf:resource='&tw;Presentation']" mode="table">
    <xsl:variable name="presentation" select="."/>
    <tr><td>
    <span about="{@rdf:about}" typeof="tw:Presentation">
    <xsl:for-each select="key('author-nodes',tw:hasAgentWithRole/*/@rdf:nodeID)|key('author-nodes',tw:hasAgentWithRole/@rdf:nodeID)">
      <xsl:sort select="tw:index" order="ascending" data-type="number"/>
      <xsl:apply-templates select=".">
	<xsl:with-param name="presentation" select="$presentation"/>
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
    <xsl:text>(</xsl:text>
    <span rel="tw:hasDate">
      <xsl:apply-templates select="tw:hasDate/*" mode="date" />
    </span>
    <xsl:text>). </xsl:text>

    <a href="{tw:page/@rdf:resource}" rel="tw:page">
      <xsl:apply-templates select="dc:title">
	<xsl:with-param name="document" select="."/>
      </xsl:apply-templates>
    </a>
    <xsl:text>. </xsl:text>
    <xsl:if test="tw:inEvent">
      <xsl:text>In: </xsl:text>
      <span rel="tw:inEvent">
	<xsl:apply-templates select="tw:inEvent/*|key('event-nodes',tw:inEvent/@rdf:resource)" mode="link"/>
      </span>
    </xsl:if>
    </span>
    </td></tr>
  </xsl:template>

  <xsl:template match="rdf:RDF">
    <div>
      <xsl:if test="//tw:Presentation|//*[rdf:type/@rdf:resource='&tw;Presentation']">
        <link href="/css/presentation-list.css" type="text/css" rel="stylesheet"/>
        <table class="presentation-list">
          <xsl:apply-templates select="//tw:Presentation|//*[rdf:type/@rdf:resource='&tw;Presentation']" mode="table">
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
