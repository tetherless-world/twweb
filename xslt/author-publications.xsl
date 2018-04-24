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
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="&foaf;"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:key name="tw:Author-nodes"
           match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']"
           use="@rdf:nodeID" />
  <xsl:key name="tw:Publication-nodes"
           match="tw:Publication|*[rdf:type/@rdf:resource='&tw;Publication']"
           use="@rdf:about" />
  <xsl:key name="tw:hasAgentWithRole-nodes"
           match="tw:Publication/tw:hasAgentWithRole|*[rdf:type/@rdf:resource='&tw;Publication']/tw:hasAgentWithRole"
           use="@rdf:nodeID|*/@rdf:nodeID" />

  <xsl:template name="author-publications">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="authorships" select="key('tw:Author-nodes',$node/tw:hasRole/*/@rdf:nodeID|$node/tw:hasRole/@rdf:nodeID)" />
    <xsl:variable name="publications" select="key('tw:hasAgentWithRole-nodes',$authorships/@rdf:nodeID)/.." />
    <xsl:if test="count($publications)>0">
      <div id="author-publications" class="section">
        <link href="/css/papers.css" type="text/css" rel="stylesheet"/>
      <xsl:call-template name="header">
        <xsl:with-param name="stylesheet">author-publications</xsl:with-param>
        <xsl:with-param name="text">Publications</xsl:with-param>
      </xsl:call-template>
      <table class="papers-list">
      <xsl:for-each select="$publications">
        <xsl:sort select="tw:hasDate/*/time:inXSDDateTime" order="descending"/>
        <tr class="publication-list-item"><td>
          <xsl:apply-templates select="current()" mode="aaai-citation"/>
        </td></tr>
      </xsl:for-each>
      </table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
