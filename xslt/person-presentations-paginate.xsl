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
  <xsl:import href="/xslt/presentation-common.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:key name="tw:Author-nodes"
           match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']"
           use="@rdf:nodeID" />
  <xsl:key name="tw:Presentation-nodes"
           match="tw:Presentation|*[rdf:type/@rdf:resource='&tw;Presentation']"
           use="@rdf:about" />
  <xsl:key name="tw:hasAgentWithRole-nodes"
           match="tw:Presentation/tw:hasAgentWithRole|*[rdf:type/@rdf:resource='&tw;Presentation']/tw:hasAgentWithRole"
           use="@rdf:nodeID|*/@rdf:nodeID" />

  <xsl:template name="person-presentations-paginate">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="authorships" select="key('tw:Author-nodes',$node/tw:hasRole/*/@rdf:nodeID|$node/tw:hasRole/@rdf:nodeID)" />
    <xsl:variable name="presentations" select="key('tw:hasAgentWithRole-nodes',$authorships/@rdf:nodeID)/.." />
    <div class="person-presentations-paginate">
      <link href="/css/papers.css" type="text/css" rel="stylesheet"></link>
      <table class="papers-list">
	<xsl:for-each select="$presentations">
          <xsl:sort select="tw:hasDate/*/time:inXSDDateTime" order="descending"/>
          <tr class="presentations-list-item"><td>
              <xsl:apply-templates select="current()" mode="aaai-citation"/>
          </td></tr>
	</xsl:for-each>
      </table>
      <script type="text/javascript">window.instanceURI=&quot;<xsl:value-of select="$node/@rdf:about"/>&quot;;</script>
    </div>
  </xsl:template>
  
</xsl:stylesheet>
