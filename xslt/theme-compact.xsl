<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://localhost/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:s="http://www.w3.org/2005/sparql-results#">
  <xsl:template name="theme-compact">
    <xsl:with-param name="admin"/>
    <xsl:with-param name="node"/>
    <tr class="theme">
      <td>
	<a href="{@rdf:about}">
	  <xsl:choose>
	    <xsl:when test="tw:hasLogo">
	      <img src="{tw:hasLogo}"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <img src="twlogo.png"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
      </td>
      <td>
	<a class="title" href="{@rdf:about}">
	  <xsl:choose>
	    <xsl:when test="tw:hasName">
	      <xsl:value-of select="tw:hasName"/>
	    </xsl:when>
	    <xsl:when test="rdfs:label">
	      <xsl:value-of select="rdfs:label"/>
	    </xsl:when>
	    <xsl:otherwise>
	      Untitled (<xsl:value-of select="@rdf:about"/>)
	    </xsl:otherwise>
	  </xsl:choose>
	    </a>
	<xsl:if test="$admin">
	  <a class="edit" href="{@rdf:about}/edit">
	    Edit
	  </a>
	</xsl:if>
	<br/>
	<span>
	  <b>Lead Professor: </b>
	  <xsl:for-each select="key('foaf:Person-nodes',$node/tw:hasLeadProfessor/*/@rdf:about)|key('foaf:Person-nodes',$node/tw:hasLeadProfessor/@rdf:resource)">
	    <xsl:sort select="foaf:lastName|foaf:surname|foaf:family_name|foaf:familyName"/>
	    <xsl:apply-templates select="." mode="place-link"/>
	    <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	  </xsl:for-each>
	</span><br/>
	<span>
	  <b>Description: </b>
	  <xsl:choose>
	    <xsl:when test="dc:description">
	      <xsl:value-of select="dc:description"/>
	    </xsl:when>
	    <xsl:when test="rdfs:comment">
	      <xsl:value-of select="rdfs:comment"/>
	    </xsl:when>
	    <xsl:otherwise>
	      None.
	    </xsl:otherwise>
	  </xsl:choose>
	</span><br/>
	<span>
	  <b>Concepts: </b>
	  <xsl:for-each select="tw:hasTopic">
	    <xsl:choose>
	      <xsl:when test="@rdf:resource">
		<xsl:variable name="resource"
			      select="@rdf:resource"/>
		<a href="{$resource}">
		  <xsl:value-of select="/rdf:RDF//*[@rdf:about=$resource]/tw:hasName"/>
		</a>
	      </xsl:when>
	      <xsl:when test="./*[@rdf:about]">
		<a href="{./*[@rdf:about]/@rdf:about}">
		  <xsl:value-of select="./*[@rdf:about]/tw:hasName"/>
		</a>
	      </xsl:when>
	      
	      <xsl:otherwise>
		Warning: Uncaught condition in themes.xsl
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	  </xsl:for-each>
	  <xsl:if test="count(tw:hasTopic)=0">None.</xsl:if>
	</span>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
