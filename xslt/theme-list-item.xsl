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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>
  <xsl:import href="/xslt/theme-common.xsl"/>

  <xsl:template match="tw:Theme|*[rdf:type/@rdf:resource='&tw;Theme']"
		mode="list-item">
    <xsl:param name="indent" select="false()"/>
    <xsl:variable name="page">
      <xsl:call-template name="get-theme-page">
	<xsl:with-param name="theme" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <tr class="theme-list-item" about="{@rdf:about}">
      <td>
	<a href="{$page}" rel="tw:page">
	  <xsl:choose>
	    <xsl:when test="foaf:logo">
	      <xsl:apply-templates select="foaf:logo" mode="place-image">
		<xsl:with-param name="rel">foaf:logo</xsl:with-param>
		<xsl:with-param name="style">width:100px;</xsl:with-param>
	      </xsl:apply-templates>
	    </xsl:when>
	    <xsl:otherwise>
	      <img class="thumb" src="https://tw.rpi.edu/images/tw-logo-v2.png" alt="TW Logo"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
      </td>
      <td>
	<a class="title" href="{$page}" rel="tw:page">
	  <span about="{@rdf:about}">
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
	  </span>
	</a>
	<xsl:if test="$admin">
	  <a class="edit" href="{$page}/edit">
	    Edit
	  </a>
	</xsl:if>
	<xsl:if test="tw:hasLeadProfessor">
	  <br/>
	  <span>
	    <b>Lead Professor: </b>
	    <xsl:for-each select="key('foaf:Person-nodes',$node/tw:hasLeadProfessor/*/@rdf:about)|key('foaf:Person-nodes',$node/tw:hasLeadProfessor/@rdf:resource)">
	      <xsl:sort select="foaf:lastName|foaf:surname|foaf:family_name|foaf:familyName"/>
	      <xsl:apply-templates select="." mode="place-link"/>
	      <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	    </xsl:for-each>
	    <xsl:apply-templates select="key('foaf:Person-nodes',tw:hasLeadProfessor/@rdf:resource)|key('foaf:Person-nodes',tw:hasLeadProfessor/*/@rdf:about)"
				 mode="place-link">
	      <xsl:with-param name="style">full</xsl:with-param>
	      
	    </xsl:apply-templates>
	    <xsl:choose>
	      <xsl:when test="$node/tw:hasLeadProfessor/@rdf:resource">
		<xsl:variable name="professor"
			      select="$node/tw:hasLeadProfessor/@rdf:resource"/>
		<xsl:call-template name="place-person-link">
		  <xsl:with-param name="person"
                                  select="$root//*[@rdf:about=$professor]"/>
		  <xsl:with-param name="style">full</xsl:with-param>
		  <xsl:with-param name="rel">tw:hasLeadProfessor</xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:when test="$node/tw:hasLeadProfessor/*">
		<xsl:variable name="professor"
			      select="$node/tw:hasLeadProfessor/*"/>
		<xsl:call-template name="place-person-link">
		  <xsl:with-param name="person" select="$professor"/>
		  <xsl:with-param name="style">full</xsl:with-param>
		  <xsl:with-param name="rel">tw:hasLeadProfessor</xsl:with-param>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
		Not Specified.
	      </xsl:otherwise>
	    </xsl:choose>
	  </span><br/>
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
		  <xsl:value-of select="$node/rdfs:comment"/>
		</span>
	      </xsl:when>
	      <xsl:otherwise>
		None.
	      </xsl:otherwise>
	    </xsl:choose>
	  </span><br/>
	  <span>
	    <b>Concepts: </b>
	    <xsl:for-each select="$node/tw:hasTopic">
	      <xsl:sort select="@rdf:resource|./*/@rdf:about"/>
	      <xsl:choose>
		<xsl:when test="@rdf:resource">
		  <xsl:variable name="resource"
				select="@rdf:resource"/>
		  <xsl:call-template name="place-concept-link">
		    <xsl:with-param name="concept" select="$root//*[@rdf:about=$resource]"/>
		  </xsl:call-template>
		</xsl:when>
		<xsl:when test="./*[@rdf:about]">
		  <xsl:call-template name="place-concept-link">
		    <xsl:with-param name="concept" select="./*[@rdf:about]"/>
		  </xsl:call-template>
		</xsl:when>
		
		<xsl:otherwise>
		  Warning: Uncaught condition in themes.xsl
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	    </xsl:for-each>
	    <xsl:if test="count($node/tw:hasTopic)=0">None.</xsl:if>
	  </span>
	</xsl:if>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template name="theme-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="class">theme-list-item</xsl:param>
    <xsl:variable name="uri">
      <xsl:call-template name="get-person-page">
	<xsl:with-param name="person" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <tr class="{$class}" about="{$uri}">
      <td>
	<a href="{$uri}">
	  <xsl:choose>
	    <xsl:when test="$node/foaf:logo/@rdf:resource">
	      <xsl:call-template name="place-image">
		<xsl:with-param name="image" select="//*[@rdf:about=$node/foaf:logo/@rdf:resource]"/>
		<xsl:with-param name="style">width:100px;</xsl:with-param>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:when test="$node/foaf:logo/foaf:Image|$node/foaf:logo/*/rdf:type[@rdf:resource='&foaf;Image']|$node/foaf:logo/*/rdf:type/*[@rdf:about='&foaf;Image']">
	      <xsl:call-template name="place-image">
		<xsl:with-param name="image" select="$node/foaf:logo/foaf:Image|$node/foaf:logo/*/rdf:type[@rdf:resource='&foaf;Image']/..|$node/foaf:logo/*/rdf:type/*[@rdf:about='&foaf;Image']/../.."/>
		<xsl:with-param name="style">width:100px;</xsl:with-param>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <img class="thumb" style="width:100px;" src="https://tw.rpi.edu/images/tw-logo-v2.png" alt="TW Logo"/>
	      <!--
	      <xsl:call-template name="place-image">
		<xsl:with-param name="image" select="//*[@rdf:about='&here;TWLogo']"/>
		<xsl:with-param name="style">width:100px;</xsl:with-param>
	      </xsl:call-template>
	      -->
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
      </td>
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
	    <xsl:when test="$node/dc:description">
	      <span property="dc:description">
		<xsl:copy-of select="$node/dc:description"/>
	      </span>
	    </xsl:when>
	    <xsl:when test="$node/rdfs:comment">
	      <span property="rdfs:comment">
		<xsl:value-of select="$node/rdfs:comment"/>
	      </span>
	    </xsl:when>
	    <xsl:otherwise>
	      None.
	    </xsl:otherwise>
	  </xsl:choose>
	</span><br/>
	<span>
	  <b>Concepts: </b>
	  <xsl:for-each select="$node/tw:hasTopic">
	    <xsl:sort select="@rdf:resource|./*/@rdf:about"/>
	    <xsl:choose>
	      <xsl:when test="@rdf:resource">
		<xsl:variable name="resource"
			      select="@rdf:resource"/>
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="$root//*[@rdf:about=$resource]"/>
		</xsl:call-template>
	      </xsl:when>
	      <xsl:when test="./*[@rdf:about]">
		<xsl:call-template name="place-concept-link">
		  <xsl:with-param name="concept" select="./*[@rdf:about]"/>
		</xsl:call-template>
	      </xsl:when>
	      
	      <xsl:otherwise>
		Warning: Uncaught condition in themes.xsl
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	  </xsl:for-each>
	  <xsl:if test="count($node/tw:hasTopic)=0">None.</xsl:if>
	</span>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
