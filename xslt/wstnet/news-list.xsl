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
			<font size="2">
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:resource)/tw:hasAcronym">
					(<xsl:value-of select="key('triples',@rdf:resource)/tw:hasAcronym"/>)
				</xsl:when>
				<xsl:when test="key('triples',@rdf:resource)/foaf:name">
						(<xsl:value-of select="key('triples',@rdf:resource)/foaf:name"/>)
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			</font>
		</a>
	</xsl:template>


        <xsl:template match="tw:Announcement|*[rdf:type/@rdf:resource='&tw;Announcement']" mode="list-item">
	 <xsl:if test="position()-1 &lt; 4">
           <li type="disc" style="margin-bottom:10px;margin-left:7px;">
		<xsl:choose>
			<xsl:when test="key('triples',@rdf:about)/tw:page/@rdf:resource">
				<a href="{key('triples',@rdf:about)/tw:page/@rdf:resource}" style="text-decoration:none;">
			     		<xsl:value-of select="key('triples',@rdf:about)/dc:title"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a href="{key('triples',@rdf:about)/dc:source/@rdf:resource}" style="text-decoration:none;">
						<xsl:value-of select="key('triples',@rdf:about)/dc:title"/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
		<font size="2">
			<xsl:text> (</xsl:text>
	              <xsl:choose>
        	                <xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '01'">
                	       		<xsl:text>January </xsl:text>
                	        </xsl:when>
                	        <xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '02'">
                	                <xsl:text>February </xsl:text>
               		         </xsl:when>
               		         <xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '03'">
                	                <xsl:text>March </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '04'">
                        	        <xsl:text>April </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '05'">
                        	        <xsl:text>May </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '06'">
                       	 	        <xsl:text>June </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '07'">
                        	        <xsl:text>July </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '08'">
                        	        <xsl:text>August </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '09'">
                        	        <xsl:text>September </xsl:text>
                        	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '10'">
                        	        <xsl:text>October </xsl:text>
                         	</xsl:when>
                        	<xsl:when test="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2) = '11'">
                        	        <xsl:text>November </xsl:text>
                        	</xsl:when>
                        	<xsl:otherwise>
                        	        <xsl:text>December </xsl:text>
                        	</xsl:otherwise>
                	</xsl:choose>
                        	<xsl:value-of select="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,9,2)"/>
                        	<xsl:text>, </xsl:text>
                        	<xsl:value-of select="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,1,4)"/>
                        	<xsl:text>)</xsl:text>
                </font>
		<xsl:apply-templates select="key('triples',@rdf:about)/tw:hasProjectReference" mode="list-item"/>
	   </li>
	 </xsl:if>
        </xsl:template>

        <xsl:template match="/">
               <ul>
			<xsl:apply-templates select="rdf:RDF//tw:Announcement|rdf:RDF//*[rdf:type/@rdf:resource='&tw;Announcement']" mode="list-item">
				<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,1,4)" data-type="number" order="descending"/>
				<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,6,2)" data-type="number" order="descending"/>
				<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasAnnouncementDate/rdfs:Resource/time:inXSDDateTime,9,2)" data-type="number" order="descending"/>
                        </xsl:apply-templates>
              </ul>
        </xsl:template>
</xsl:stylesheet>

