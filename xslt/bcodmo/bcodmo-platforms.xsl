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
	xmlns:res="http://www.w3.org/2005/sparql-results#"
	xmlns:bcodmo="http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/"
	xmlns="http://www.w3.org/1999/xhtml">

   <xsl:include href="/xslt/bcodmo/bcodmo-header.xsl"/>
	
	<xsl:key name="triples"
		match="*[@rdf:about]"
		use="@rdf:about"/>

	<xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;Platform']" mode="list-item">
		<tr>
			<td style="padding: 0 3 0;">
				<a href="/web/project/BCO-DMO/InstanceViz/platform?uri={@rdf:about}">
					<xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
				</a>
			</td>
			<td style="padding: 0 3 0;">
				<xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasPlatformTitle"/>
			</td>
		</tr>
	</xsl:template>

<xsl:template match="/">
	<xsl:apply-templates select="/" mode="header"/>
	<br/>
	<div id="all" style="margin-left:22;">
		<table border="1">
			<tr bgcolor="#9acd32">
				<th>Platform</th>
				<th>Type</th>
			</tr>
			<xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Platform']" mode="list-item">
				<xsl:sort select="key('triples',@rdf:about)/rdfs:label"/>
			</xsl:apply-templates>
		</table>
	</div>
	</xsl:template>
</xsl:stylesheet>

