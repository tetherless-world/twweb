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
	xmlns:n0pred="http://xmlns.com/foaf/0.1/"
	xmlns:res="http://www.w3.org/2005/sparql-results#"
	xmlns="http://www.w3.org/1999/xhtml">
	
	<xsl:key name="triples"
		match="*[@rdf:about]"
		use="@rdf:about"/>

	<xsl:template match="rdf:Description[rdf:type/@rdf:resource='&foaf;Organization']" mode="list-item">
		<tr>
		
		<td>
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:about)/rdfs:seeAlso">
					<a href="{key('triples', @rdf:about)/rdfs:seeAlso}">
						<xsl:value-of select="key('triples',@rdf:about)/rdfs:label" disable-output-escaping="yes"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="key('triples',@rdf:about)/rdfs:label" disable-output-escaping="yes"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:about)/rdfs:seeAlso">
					<a href="{key('triples',@rdf:about)/rdfs:seeAlso}">
						<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasAcronym"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasAcronym"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:about)/rdfs:seeAlso">
					<a href="{key('triples',@rdf:about)/rdfs:seeAlso}">
						<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasOrganizationSubName"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasOrganizationSubName"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		</tr>
</xsl:template>

	<xsl:template match="/">
		<table border="1">
			<tr bgcolor="#9acd32">
				<th>Name</th>
				<th>Acronym</th>
				<th>SubName</th>
			</tr>
			<xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&foaf;Organization']" mode="list-item">
				<xsl:sort select="key('triples',@rdf:about)/rdfs:label"/>
			</xsl:apply-templates>
		</table>
	</xsl:template>
</xsl:stylesheet>
