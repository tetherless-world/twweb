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

	<xsl:key name="node"
		match="*[@rdf:nodeID]"
		use="@rdf:nodeID"/>

	<xsl:template match="tw:hasProjectReference|tw:hasProjectReference/rdfs:Resource" mode="list-item">
		<xsl:if test="position() != 1">
			<xsl:text>, </xsl:text>
			<xsl:if test="position() = last()">
				<xsl:text>and </xsl:text>
			</xsl:if>
		</xsl:if>
		<a href="{key('triples',@rdf:resource)/tw:page/@rdf:resource}|{key('triples',@rdf:about)/tw:page/@rdf:resource}" style="color:#003399;text-decoration:none;font-size:small;">
			<xsl:choose>
				<xsl:when test="key('triples',@rdf:resource)/tw:hasAcronym|key('triples',@rdf:about)/tw:hasAcronym">
					<xsl:value-of select="key('triples',@rdf:resource)/tw:hasAcronym|key('triples',@rdf:about)/tw:hasAcronym"/>
				</xsl:when>
				<xsl:when test="key('triples',@rdf:resource)/foaf:name|key('triples',@rdf:about)/foaf:name">
					<xsl:value-of select="key('triples',@rdf:resource)/foaf:name|key('triples',@rdf:about)/foaf:name"/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</a>
	</xsl:template>

	<xsl:template match="tw:hasRole|tw:hasRole/rdfs:Resource|tw:hasRole/tw:Role" mode="list-item">
		<xsl:param name="r"/>
		<xsl:param name="url"/>
		<xsl:param name="person"/>

		<xsl:if test="$r = key('node',@rdf:nodeID)/@rdf:nodeID">
			<a href="{$url}" style="color:#006666;text-decoration:none;font-size:small;">
				<xsl:copy-of select="$person"/>
			</a>
		</xsl:if>
	</xsl:template>
		
	
	<xsl:template match="foaf:Person|rdfs:Resource|*[rdf:type/@rdf:resource='&foaf;Person']|*[rdf:type/@rdf:resource='&foaf;Agent']" mode="match">
		<xsl:param name="rol"/>
		<xsl:variable name="page" select="key('triples',@rdf:about)/tw:page/@rdf:resource"/>
		<xsl:variable name="title">
         	         <xsl:choose>
                                <xsl:when test="key('triples',@rdf:about)/foaf:lastName">
                                       <xsl:value-of select="key('triples',@rdf:about)/foaf:lastName"/>
                                </xsl:when>
                                <xsl:otherwise>
                                       <xsl:value-of select="key('triples',@rdf:about)/foaf:family_name"/>
                                </xsl:otherwise>
                         </xsl:choose>
                         <xsl:text>, </xsl:text>
                         <xsl:choose>
                                <xsl:when test="key('triples',@rdf:about)/foaf:firstName">
                                        <xsl:value-of select="substring(key('triples',@rdf:about)/foaf:firstName,1,1)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="substring(key('triples',@rdf:about)/foaf:givenname,1,1)"/>
                                </xsl:otherwise>
                         </xsl:choose>
                         <xsl:text>. </xsl:text>
                         <xsl:if test="key('triples',@rdf:about)/tw:middleInitial">
                                <xsl:value-of select="key('triples',@rdf:about)/tw:middleInitial"/>
                                         <xsl:text>.</xsl:text>
                         </xsl:if>
		</xsl:variable>

		<xsl:apply-templates select="key('triples',@rdf:about)/tw:hasRole" mode="list-item">
			<xsl:with-param name="r" select="$rol"/>
			<xsl:with-param name="url" select="$page"/>
			<xsl:with-param name="person" select="$title"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="key('triples',@rdf:about)/tw:hasRole/rdfs:Resource" mode="list-item">
                        <xsl:with-param name="r" select="$rol"/>
                        <xsl:with-param name="url" select="$page"/>
                        <xsl:with-param name="person" select="$title"/>
                </xsl:apply-templates>
		<xsl:apply-templates select="key('triples',@rdf:about)/tw:hasRole/tw:Role" mode="list-item">
                        <xsl:with-param name="r" select="$rol"/>
                        <xsl:with-param name="url" select="$page"/>
                        <xsl:with-param name="person" select="$title"/>
                </xsl:apply-templates>


	</xsl:template>
	
    <xsl:template match="tw:hasAgentWithRole|tw:hasAgentWithRole/rdfs:Resource|tw:hasAgentWithRole/tw:Role" mode="list-item">
	<xsl:param name="auth"/>
	<xsl:param name="page"/>
	<xsl:choose>
	    <xsl:when test="key('node',@rdf:nodeID)/tw:index = 1">
		<xsl:variable name="role" select="key('node',@rdf:nodeID)/@rdf:nodeID"/>
		<xsl:apply-templates select="$auth" mode="match">
		    <xsl:with-param name="rol" select="$role"/>
		</xsl:apply-templates>
	    </xsl:when>
	    <xsl:when test="key('node',@rdf:nodeID)/tw:index = 2">
		<a href="{$page}">et al.</a>
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:text></xsl:text>
	    </xsl:otherwise>
	</xsl:choose>
	<!--
	This doesn't work. The position function only works within a
	for-each. Also, John wanted this to display one author and then
	et al. with the links.
	-->
	<!--
	<xsl:if test="key('node',@rdf:nodeID)/tw:index &lt; 4">
	    <xsl:if test="key('node',@rdf:nodeID)/tw:index != 1">
		<xsl:text>, </xsl:text>
		<xsl:choose>
		    <xsl:when test="position() = last()">
			<xsl:text>and </xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
			<xsl:if test="key('node',@rdf:nodeID)/tw:index = 3">		
			    <xsl:text>and </xsl:text>
			</xsl:if>
		    </xsl:otherwise>
		</xsl:choose>
	    </xsl:if>
	    <xsl:variable name="role" select="key('node',@rdf:nodeID)/@rdf:nodeID"/>
	    <xsl:apply-templates select="$auth" mode="match">
		<xsl:with-param name="rol" select="$role"/>
	    </xsl:apply-templates>
	</xsl:if>
	-->
    </xsl:template>

    <xsl:template match="tw:Publication|*[rdf:type/@rdf:resource='&tw;Publication']" mode="list-item">
	<xsl:param name="author"/>
	<xsl:if test="position() &lt; 8">
	    <li class="disc" style="margin-bottom:10px;">
		<xsl:variable name="page" select="key('triples',@rdf:about)/tw:page/@rdf:resource"/>
		<a href="{$page}" style="font-weight:bold;">
		    <xsl:value-of select="key('triples',@rdf:about)/dc:title"/>
		</a>
		<xsl:if test="key('triples',@rdf:about)/tw:hasAgentWithRole|key('triples',@rdf:about)/tw:hasAgentWithRole/rdfs:Resource|key('triples',@rdf:about)/tw:hasAgentWithRole/tw:Role">
		    <br/>
		    <xsl:apply-templates select="key('triples',@rdf:about)/tw:hasAgentWithRole|key('triples',@rdf:about)/tw:hasAgentWithRole/rdfs:Resource|key('triples',@rdf:about)/tw:hasAgentWithRole/tw:Role" mode="list-item">
		    <xsl:with-param name="auth" select="$author"/>
		    <xsl:with-param name="page" select="$page"/>
		    <xsl:sort select="key('node',@rdf:nodeID)/tw:index" data-type="number" order="ascending"/>
		    </xsl:apply-templates>
		</xsl:if>
		<xsl:if test="key('triples',@rdf:about)/tw:hasProjectReference">
		    <br/>
		    (Projects:
		    <xsl:apply-templates select="key('triples',@rdf:about)/tw:hasProjectReference|key('triples',@rdf:about)/tw:hasProjectReference/rdfs:Resource" mode="list-item"/>
		    )
		</xsl:if>
	    </li>
	</xsl:if>
    </xsl:template>

    <xsl:template match="/">
	<ul>
	    <xsl:variable name="authors" select="rdf:RDF//foaf:Agent|rdf:RDF//*[rdf:type/@rdf:resource='&foaf;Agent']|rdf:RDF//rdfs:Resource"/>
	    <xsl:apply-templates select="rdf:RDF//tw:Publication|rdf:RDF//*[rdf:type/@rdf:resource='&tw;Publication']" mode="list-item">
		<xsl:with-param name="author" select="$authors"/>
		<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasDate/rdfs:Resource/time:inXSDDateTime,1,4)" data-type="number" order="descending"/>
		<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasDate/rdfs:Resource/time:inXSDDateTime,6,2)" data-type="number" order="descending"/>
		<xsl:sort select="substring(key('triples',@rdf:about)/tw:hasDate/rdfs:Resource/time:inXSDDateTime,9,2)" data-type="number" order="descending"/>                      
	    </xsl:apply-templates>
	</ul>
    </xsl:template>
</xsl:stylesheet>

