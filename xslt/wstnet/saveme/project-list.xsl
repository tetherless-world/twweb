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
        xmlns:res="http://www.w3.org/2005/sparql-results#"
        xmlns="http://www.w3.org/1999/xhtml">

        <xsl:key name="triples"
                match="*[@rdf:about]"
                use="@rdf:about"/>

        <xsl:template match="foaf:Project|*[rdf:type/@rdf:resource='&foaf;Project']" mode="list-item">
        <tr><td>
	   <a href="{key('triples',@rdf:about)/tw:page/@rdf:resource}">
		<xsl:choose>
			<xsl:when test="key('triples',@rdf:about)/foaf:logo/rdfs:Resource/@rdf:about">
				<img src="{key('triples',@rdf:about)/foaf:logo/rdfs:Resource/@rdf:about}" alt="key('triples',@rdf:about)/foaf:logo/rdfs:Resource/rdfs:label" height="50"/>
			</xsl:when>
			<xsl:otherwise>
				<img class="thumb" src="https://tw.rpi.edu/images/tw-logo-v2.png" height="50"/>
			</xsl:otherwise>
		</xsl:choose>
	   </a>
	</td><td>
		<a href="{key('triples',@rdf:about)/tw:page/@rdf:resource}" style="color:#003399;text-decoration:none;">
		<font size="2"><b>
                <xsl:value-of select="key('triples',@rdf:about)/foaf:name"/>
                        <xsl:if test="key('triples',@rdf:about)/tw:hasAcronym">
                                (<xsl:value-of select="key('triples',@rdf:about)/tw:hasAcronym"/>)
                        </xsl:if>
		</b></font>
		</a>
        </td></tr>
        </xsl:template>

        <xsl:template match="/">
               <table cellspacing="29">
			<col width="25%"/>
			<col width="75%"/>
                                        <xsl:apply-templates select="rdf:RDF//foaf:Project|rdf:RDF//*[rdf:type/@rdf:resource='&foaf;Project']" 
mode="list-item">
                                                <xsl:sort select="key('triples',@rdf:about)/tw:hasAcronym"/>
                                        </xsl:apply-templates>
                    </table>
        </xsl:template>
</xsl:stylesheet>

