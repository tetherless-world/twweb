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
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:key name="project"
	match="*[@rdf:about]"
	use="@rdf:about"/>

   <xsl:include href="/xslt/bcodmo/bcodmo-header.xsl"/>

  <xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;Project']" mode="list-item">
	<tr>
	<td style="padding: 2 3 2;">
		<a href="/web/project/BCO-DMO/InstanceViz/project?uri={@rdf:about}">
			<xsl:value-of select="key('project', @rdf:about)/bcodmo:hasAcronym"/>
		</a>
	</td>
	<td style="padding:2 3 2;">
		<xsl:value-of select="key('project',@rdf:about)/rdfs:label" disable-output-escaping="yes" />
	</td>
	<td style="padding:2 3 2;">
		<xsl:choose>
			<xsl:when test="key('project',@rdf:about)/rdfs:seeAlso/@rdf:resource">
				<a href="{key('project',@rdf:about)/rdfs:seeAlso/@rdf:resource}">
					<xsl:value-of select="key('project',@rdf:about)/rdfs:seeAlso/@rdf:resource"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="key('project',@rdf:about)/bcodmo:osprey_page/@rdf:resource">
						<a href="{key('project',@rdf:about)/bcodmo:osprey_page/@rdf:resource}">Osprey URL</a>
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
        <th style="padding: 3 5 3;">Acronym</th>
	<th style="padding: 3 5 3;">Full Name</th>
	<th style="padding: 3 5 3;">URL</th>
      </tr>
      <xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Project']" mode="list-item">
	<xsl:sort select="key('project',@rdf:about)/bcodmo:hasAcronym"/>
      </xsl:apply-templates>
    </table>
  </xsl:template>
  
</xsl:stylesheet>

