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

        <xsl:template match="tw:TWAnnouncement|rdf:Description[rdf:type/@rdf:resource='&tw;TWAnnouncement']" mode="list-item">
           <li>
     		<xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
	   </li>
        </xsl:template>

        <xsl:template match="/">
               <ul>
			<xsl:apply-templates select="rdf:RDF//tw:Announcement|rdf:RDF//*[rdf:type/@rdf:resource='&tw;Announcement']" mode="list-item">
                                 <xsl:sort select="key('triples',@rdf:about)/tw:hasAcronym"/>
                        </xsl:apply-templates>
              </ul>
        </xsl:template>
</xsl:stylesheet>

