<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
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
   xmlns:res="http://www.w3.org/2005/sparql-results#"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:include href="/xslt/bcodmo/bcodmo-header.xsl"/>

  <xsl:key name="triples"
           match="*[@rdf:about]"
	   use="@rdf:about"/>

  <xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;Parameter']" mode="list-item">
  <tr>
   <td style="padding: 0 3 0;">
	<a href="/web/project/BCO-DMO/InstanceViz/parameter?uri={@rdf:about}">
      		 <xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
	</a> 
   </td>
   <td style="padding:0 3 0;">
	<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasParameterShortName"/>
   </td>

   <td style="padding:0 3 0;">
        <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasParameterShortDescription"/>
   </td>
   <td style="padding:0 3 0;">
	<xsl:choose>
		<xsl:when test="key('triples',@rdf:about)/rdfs:seeAlso/@rdf:resource">
			<a href="key('triples',@rdf:about)/rdfs:seeAlso/@rdf:resource">
				URL
			</a>
		</xsl:when>
		<xsl:otherwise>
			no URL
		</xsl:otherwise>
	</xsl:choose>
   </td>
  </tr>
  </xsl:template>

  <xsl:template match="/">
	<xsl:apply-templates select="/" mode="header"/>
	<br/>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th style="padding: 3 8 3;">Official Name</th>
	<th style="padding: 3 8 3;">Short Name</th>
	<th style="padding: 3 8 3;">Description</th>
	<th style="padding: 3 8 3;">URL</th>
      </tr>
      <xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Parameter']" mode="list-item">
	<xsl:sort select="key('triples',@rdf:about)/rdfs:label"/>
      </xsl:apply-templates>
    </table>
      <xsl:value-of select="count(rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Parameter'])"/>
  </xsl:template>
  
</xsl:stylesheet>

