<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY bcodmo "http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/">
]>
<xsl:stylesheet 
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:bcodmo="http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:include href="/xslt/bcodmo/bcodmo-header.xsl"/>

<xsl:key name="triples"
	match="*[@rdf:about]"
	use="@rdf:about"/>

<xsl:key name="node"
	match="*[@rdf:nodeID]"
	use="@rdf:nodeID"/>

<xsl:template match="bcodmo:ofPlatform" mode="list-item">
	<a href="/web/project/BCO-DMO/InstanceViz/platform?uri={@rdf:resource}">
           <xsl:value-of select="key('triples',@rdf:resource)/rdfs:label"/>
	</a> 
 </xsl:template>

<xsl:template match="time:hasBeginning" mode="list-item">
	  <xsl:value-of select="substring(key('node',@rdf:nodeID)/time:inXSDDateTime,1,4)"/>
</xsl:template>

<xsl:template match="bcodmo:hasDateTimeCoverage" mode="list-item">
	<xsl:apply-templates select="key('node',@rdf:nodeID)/time:hasBeginning" mode="list-item"/>
</xsl:template>

  <xsl:template match="/">
	<xsl:apply-templates select="/" mode="header"/>
	<br/>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Deployments</th>
	<th>Alias</th>
	<th>Platform</th>
	<th>Location</th>
	<th>Start Date</th>
      </tr>
     <xsl:for-each select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Deployment']">
        <xsl:sort select="key('triples',@rdf:about)/rdfs:label"/>
        <tr>
	<td>
              <a href="/web/project/BCO-DMO/InstanceViz/deployment?uri={@rdf:about}">
                           <xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
              </a>
        </td>
        <td>
                <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasSynonym"/>
        </td>
        <td>
                <xsl:apply-templates select="key('triples',@rdf:about)/bcodmo:ofPlatform" mode="list-item"/>
        </td>
        <td>
                <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasLocation"/>
        </td>
	<td>
		<xsl:apply-templates select="key('triples',@rdf:about)/bcodmo:hasDateTimeCoverage" mode="list-item"/>
	</td>
        </tr>
     </xsl:for-each>
    </table>
  </xsl:template>
  
</xsl:stylesheet>

