<!DOCTYPE xsl:stylesheet [
        <!ENTITY tw "http://tw.rpi.edu/schema/">
        <!ENTITY twi "http://tw.rpi.edu/instances/">
        <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet
        version="1.0"
	xmlns:foaf="http://xmlns.com/foaf/0.1/"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
        xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
        xmlns:fn="http://www.w3.org/2005/xpath-functions"
        xmlns:time="http://www.w3.org/2006/time#"
        xmlns:owl="http://www.w3.org/2002/07/owl#"
        xmlns:dc="http://purl.org/dc/terms/"
	xmlns:tw="http://tw.rpi.edu/schema/"
	xmlns:twi="http://tw.rpi.edu/instances/"
	xmlns:nbsp="http://tw.rpi.edu/schema/"
        xmlns:res="http://www.w3.org/2005/sparql-results#"
        xmlns="http://www.w3.org/1999/xhtml">

        <xsl:key name="triples"
                match="*[@rdf:about]"
                use="@rdf:about"/>

	<xsl:template match="tw:hasProjectReference" mode="list-item">
		<a href="{key('triples',@rdf:resource)/tw:page/@rdf:resource}" style="text-decoration:none;color:#003399;">
			<font size="2"><b>
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:resource)/tw:hasAcronym">
					(<xsl:value-of select="key('triples',@rdf:resource)/tw:hasAcronym"/>)
				</xsl:when>
				<xsl:when test="key('triples',@rdf:resource)/foaf:name">
					(<xsl:value-of select="key('triples',@rdf:resource)/foaf:name"/>)
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			</b></font>
		</a>
	</xsl:template>

        <xsl:template match="tw:Announcement|*[rdf:type/@rdf:resource='&tw;Announcement']" mode="list-item">
           <li>
		<a href="{key('triples',@rdf:about)/tw:page/@rdf:resource}">
     		<xsl:value-of select="key('triples',@rdf:about)/dc:title"/>
		</a>
		<xsl:apply-templates select="key('triples',@rdf:about)/tw:hasProjectReference" mode="list-item"/>
	   </li>
	   <br/>
        </xsl:template>

        <xsl:template match="/">
               <ul>
			<xsl:apply-templates select="rdf:RDF//tw:Announcement|rdf:RDF//*[rdf:type/@rdf:resource='&tw;Announcement']" mode="list-item">
                        </xsl:apply-templates>
              </ul>
        </xsl:template>
</xsl:stylesheet>

