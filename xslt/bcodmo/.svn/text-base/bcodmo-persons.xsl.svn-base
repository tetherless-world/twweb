<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY bcodmo "http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
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

  <xsl:template match="bcodmo:hasAffiliation" mode="list-item"> 
    <li>
      <a href="/web/project/BCO-DMO/InstanceViz/org?uri={@rdf:resource}">
	      <xsl:value-of select="key('triples',@rdf:resource)/rdfs:label"/>
	      <xsl:if test="key('triples',@rdf:resource)/bcodmo:hasOrganizationSubName">
	        (
		<xsl:value-of select="key('triples',@rdf:resource)/bcodmo:hasOrganizationSubName"/>
	        )
	      </xsl:if>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="rdf:Description[rdf:type/@rdf:resource='&foaf;Person']" mode="list-item">	
    <tr>
      <td>
            <a href="/web/project/BCO-DMO/InstanceViz/individual?uri={@rdf:about}">
	      <xsl:if test="key('triples',@rdf:about)/foaf:title">
	        <xsl:value-of select="key('triples',@rdf:about)/foaf:title"/>
		<xsl:text> </xsl:text>
	      </xsl:if>
              <xsl:value-of select="key('triples',@rdf:about)/foaf:givenName"/>
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="key('triples',@rdf:about)/foaf:familyName"/>
            </a>
      </td>
      <td>
	<ul style="list-style:none;">
	    <xsl:apply-templates select="key('triples',@rdf:about)/bcodmo:hasAffiliation" mode="list-item"/>
	</ul>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/">
	<xsl:apply-templates select="/" mode="header"/>
	<br/>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Name</th>
	<th>Affiliation</th>
      </tr>
      <xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&foaf;Person']" mode="list-item">
		<xsl:sort select="key('triples',@rdf:about)/foaf:familyName"/>
	</xsl:apply-templates>
    </table>
  </xsl:template>
  
</xsl:stylesheet>

