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

  <xsl:template match="/">
	<xsl:apply-templates select="/" mode="header"/>
	<br/>
	<div id="table" style="width:100%">
    <table style="width:100%;" border="1">
	<col width="25%"/>
	<col width="20%"/>
	<col width="55%"/>
      <tr bgcolor="#9acd32">
                <th style="padding: 3 8 3;width:25%;">Instrument</th>
 		<th style="padding: 3 8 3;width:20%;">Acronym</th>
		<th style="padding: 3 8 3;width:55%;">Description</th>
      </tr>
	<xsl:for-each select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Instrument']">
                <xsl:sort select="key('triples',@rdf:about)/rdfs:label"/>
                <tr>
                   <td style="padding:0 3 0;width:35%;">
                    <a href="/web/project/BCO-DMO/InstanceViz/instrument?uri={@rdf:about}">
                             <xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
                    </a>
                   </td>
                   <td style="padding:0 3 0;width:20%;">
                        <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasAcronym"/>
                   </td>
                   <td style="padding: 0 3 0;width:55%;">
                        <xsl:value-of select="key('triples',@rdf:about)/dc:description" disable-output-escaping="yes"/>
                   </td>
                </tr>
	</xsl:for-each>
    </table>
	</div>
  </xsl:template>
  
</xsl:stylesheet>
