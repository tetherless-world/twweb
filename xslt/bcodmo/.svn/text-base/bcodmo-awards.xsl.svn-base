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

  <xsl:template match="bcodmo:hasFundingSource" mode="list-item">
	<a href="/web/project/BCO-DMO/InstanceViz/fund?uri={@rdf:resource}">
		<xsl:value-of select="key('triples',@rdf:resource)/foaf:name"/>
	</a>
  </xsl:template>

  <xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;GrantAward']" mode="list-item">
  <tr>
    <td>
        <a href="/web/project/BCO-DMO/InstanceViz/award?uri={@rdf:about}">
		<xsl:choose>
			<xsl:when test="key('triples',@rdf:about)/bcodmo:hasAwardNumber">
		      		 <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasAwardNumber"/>
			</xsl:when>
			<xsl:otherwise>
				Unknown
			</xsl:otherwise>
		</xsl:choose>
        </a>
    </td>
    <td>
            <xsl:apply-templates select="key('triples',@rdf:about)/bcodmo:hasFundingSource" mode="list-item"/>
    </td>
    <td>
	<xsl:choose>
		<xsl:when test="key('triples',@rdf:about)/bcodmo:hasAwardURL/@rdf:resource">
			<a href="{key('triples',@rdf:about)/bcodmo:hasAwardURL/@rdf:resource}">
        		    URL
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:about)/bcodmo:osprey_page/@rdf:resource">
					<a href="{key('triples',@rdf:about)/bcodmo:osprey_page/@rdf:resource}">
						Osprey URL
					</a>
				</xsl:when>
				<xsl:otherwise>
					no URL
				</xsl:otherwise>
			</xsl:choose>
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
        <th>Awards</th>
	<th>Sponsors</th>
	<th>URL</th>
      </tr>
      <xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;GrantAward']" mode="list-item">
	<xsl:sort select="key('triples',@rdf:about)/bcodmo:hasAwardNumber"/>
      </xsl:apply-templates>
    </table>
      <xsl:value-of select="count(rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;GrantAward'])"/>
  </xsl:template>
  
</xsl:stylesheet>

