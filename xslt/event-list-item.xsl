<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/event-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>

  <xsl:template name="event-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="class">event-list-item</xsl:param>
    <xsl:variable name="uri">
      <xsl:call-template name="get-event-page">
	<xsl:with-param name="event" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <tr class="{$class}" about="{$uri}">
      <td>
	<a class="title" href="{$uri}">
	  <xsl:choose>
	    <xsl:when test="$node/foaf:name">
	      <span property="foaf:name">
		<xsl:value-of select="$node/foaf:name"/>
	      </span>
	    </xsl:when>
	    <xsl:when test="$node/rdfs:label">
	      <span property="rdfs:label">
		<xsl:value-of select="$node/rdfs:label"/>
	      </span>
	    </xsl:when>
	    <xsl:otherwise>
	      Untitled (<xsl:value-of select="$node/@rdf:about"/>)
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
	<xsl:if test="$admin">
	  <a class="edit" href="{$node/@rdf:about}/edit">
	    Edit
	  </a>
	</xsl:if>
	<br />
	<span>
	  <b>Description: </b>
	  <xsl:choose>
	    <xsl:when test="$node/dc:description">
	      <span property="dc:description">
		<xsl:copy-of select="$node/dc:description"/>
	      </span>
	    </xsl:when>
	    <xsl:when test="$node/rdfs:comment">
	      <span property="rdfs:comment">
		<xsl:copy-of select="$node/rdfs:comment"/>
	      </span>
	    </xsl:when>
	    <xsl:otherwise>
	      None.
	    </xsl:otherwise>
	  </xsl:choose>
	</span><br/>
	<span>
	  <b>Dates: </b>
	  <xsl:choose>
	    <xsl:when test="$node/tw:hasDateTimeCoverage/*/time:hasBeginning">
	      <span rel="tw:hasDateTimeCoverage">
	        <xsl:apply-templates select="$node/tw:hasDateTimeCoverage/*/time:hasBeginning" mode="date"/>
		<xsl:choose>
		  <xsl:when test="$node/tw:hasDateTimeCoverage/*/time:hasEnd">
		    <xsl:text> - </xsl:text>
		    <span rel="tw:hasDateTimeCoverage">
		      <xsl:apply-templates select="$node/tw:hasDateTimeCoverage/*/time:hasEnd" mode="date"/>
		    </span>
		  </xsl:when>
		</xsl:choose>
	      </span>
	    </xsl:when>
	    <xsl:otherwise>
	      Not Found
	    </xsl:otherwise>
	  </xsl:choose>
	</span><br />
	<span>
	  <b>Concepts: </b>
	</span>
	  <xsl:for-each select="$node/tw:hasTopic">
	    <xsl:choose>
	      <xsl:when test="@rdf:resource">
		<xsl:variable name="concept" select="//*[@rdf:about=current()/@rdf:resource]"/>
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="$concept"/>
		  <xsl:with-param name="rel">tw:hasTopic</xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:variable name="concept" select="./*"/>
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="$concept"/>
		  <xsl:with-param name="rel">tw:hasTopic</xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:if test="not(position()=last())">
	      <xsl:text>, </xsl:text>
	    </xsl:if>
	  </xsl:for-each>	  
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
