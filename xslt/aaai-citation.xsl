<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY time "http://www.w3.org/2006/time#">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY dc "http://purl.org/dc/terms/">
  <!ENTITY bibo "http://purl.org/ontology/bibo/">
]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:tw="&tw;"
                xmlns:time="&time;"
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:s="http://www.w3.org/2005/sparql-results#"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:foaf="&foaf;"
		xmlns:dc="&dc;"
                xmlns:bibo="&bibo;"
                xmlns="http://www.w3.org/1999/xhtml"
		xsl:extension-element-prefixes="exsl fn s"
>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/event-common.xsl"/>
  <xsl:import href="/xslt/time-common.xsl"/>

  <xsl:key name="tw:Author-nodes"
	   match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']"
	   use="@rdf:nodeID"/>
  <xsl:key name="tw:Editor-nodes"
           match="tw:Editor|*[rdf:type/@rdf:resource='&tw;Editor']"
           use="@rdf:nodeID"/>
  <xsl:key name="foaf:Person-nodes"
	   match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']"
	   use="@rdf:about"/>
  <xsl:key name="tw:hasRole-nodes"
	   match="tw:hasRole"
	   use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="tw:Event-nodes"
	   match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
	   use="@rdf:about"/>
  <xsl:key name="tw:Journal-nodes"
	   match="tw:Journal|*[rdf:type/@rdf:resource='&tw;Journal']|tw:Book|*[rdf:type/@rdf:resource='&tw;Book']"
	   use="@rdf:about"/>
  
  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-authors">
    <xsl:param name="sep">,</xsl:param>
    <xsl:for-each select="tw:hasAgentWithRole/@rdf:nodeID|tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:sort select="key('tw:Author-nodes',.)/tw:index" data-type="number"/>
      <span rel="tw:hasAgentWithRole">
	<span typeof="tw:Author">
	  <span rev="tw:hasRole">
	    <xsl:apply-templates select="key('tw:hasRole-nodes',.)/.." mode="place-link">
	      <xsl:with-param name="style">last,fi.mi</xsl:with-param>
	    </xsl:apply-templates>
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text> </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1 and last()=2">
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1">
	  <xsl:value-of select="$sep"/>
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$sep"/>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-editors">
    <xsl:param name="sep">,</xsl:param>
    <xsl:for-each select="tw:hasAgentWithRole/@rdf:nodeID[key('tw:Editor-nodes',.)/rdf:type/@rdf:resource='&tw;Editor' or name(key('tw:Editor-nodes',.))='tw:Editor']|tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:sort select="key('tw:Editor-nodes',.)/tw:index" data-type="number"/>
      <span rel="tw:hasAgentWithRole">
	<span typeof="tw:Editor">
	  <span rev="tw:hasRole">
	    <xsl:apply-templates select="key('tw:hasRole-nodes',.)/.." mode="place-link" />
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text></xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1 and last()=2">
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1">
	  <xsl:value-of select="$sep"/>
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$sep"/>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tw:Book|*[rdf:type/@rdf:resource='&tw;Book']" mode="subcitation">
    <span about="{@rdf:about}" typeof="tw:Book">
      <xsl:apply-templates select="." mode="aaai-editors">
        <xsl:with-param name="sep">,</xsl:with-param>
      </xsl:apply-templates>
      <xsl:choose>
        <xsl:when test="count(key('tw:Editor-nodes',tw:hasAgentWithRole/@rdf:nodeID)) &gt; 2">
          <xsl:text>, editors, </xsl:text>
        </xsl:when>
        <xsl:when test="count(key('tw:Editor-nodes',tw:hasAgentWithRole/@rdf:nodeID)) = 1">
          <xsl:text>, editor, </xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="tw:page">
          <a href="{tw:page/@rdf:resource}" rel="tw:page">
            <span about="{@rdf:about}" property="dc:title">
              <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
            </span>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <span property="dc:title">
            <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-citation-nested">
    <xsl:apply-templates select="." mode="aaai-authors">
      <xsl:with-param name="sep">,</xsl:with-param>
    </xsl:apply-templates>
    <xsl:if test="not(name(.)='tw:BookChapter') and not(rdf:type/@rdf:resource='&tw;BookChapter')">
      <span rel="tw:hasDate">
        <xsl:apply-templates select="tw:hasDate/*" mode="year"/>
      </span>
      <xsl:text>. </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="tw:page">
	<a href="{tw:page/@rdf:resource}" rel="tw:page">
	  <span about="{@rdf:about}" property="dc:title">
	    <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
	  </span>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<span property="dc:title">
	  <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
	</span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>. </xsl:text>
    <xsl:choose>
      <xsl:when test="tw:inEvent">
	<xsl:text>In </xsl:text>
	<span rel="tw:inEvent">
	  <xsl:apply-templates select="key('tw:Event-nodes',tw:inEvent/*/@rdf:about|tw:inEvent/@rdf:resource)" mode="link">
	    <xsl:with-param name="proceedings" select="true()"/>
	    <xsl:with-param name="dateandlocation" select="true()"/>
	  </xsl:apply-templates>
	</span>
      </xsl:when>
      <xsl:when test="tw:inPublication">
        <xsl:choose>
          <xsl:when test="name(.)='tw:BookChapter' or rdf:type/@rdf:resource='&tw;BookChapter'">
            In <span rel="tw:inPublication"><xsl:apply-templates select="key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)" mode="subcitation"/></span>
          </xsl:when>
          <xsl:otherwise>
	    <i>
	      <span rel="tw:inPublication">
	        <xsl:apply-templates select="key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)" mode="link"/>
	      </span>
	    </i>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="tw:startPage">
	<xsl:text>, pages </xsl:text>
	<xsl:value-of select="tw:startPage"/>
	<xsl:text>&#8211;</xsl:text>
	<xsl:value-of select="tw:endPage"/>
	<xsl:text>. </xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:if test="tw:inEvent|tw:inDocument">
	  <xsl:text>. </xsl:text>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="name(.)='tw:BookChapter' or rdf:type/@rdf:resource='&tw;BookChapter'">
      <xsl:if test="tw:publishedBy|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy">
        <span rel="tw:publishedBy">
          <xsl:value-of select="tw:publishedBy/*/foaf:name|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy/*/foaf:name" />
        </span>
      </xsl:if>
      <xsl:if test="tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished">
        <xsl:text> </xsl:text>
        <span rel="tw:wherePublished">
          <xsl:value-of select="tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished" />
        </span>
      </xsl:if>
      <xsl:if test="tw:publishedBy|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy|tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <span rel="tw:hasDate">
        <xsl:apply-templates select="tw:hasDate/*" mode="year"/>
      </span>
      <xsl:text>. </xsl:text>
      <xsl:if test="bibo:doi">
        <a href="https://dx.doi.org/{bibo:doi}" rel="bibo:doi"><xsl:value-of select="bibo:doi" /></a>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-citation">
    <xsl:param name="mode">span</xsl:param>
    <xsl:choose>
      <xsl:when test="$mode='table'">
	<tr about="{@rdf:about}" typeof="foaf:Document">
	  <td>
	    <xsl:apply-templates select="current()" mode="aaai-citation-nested"/>
	  </td>
	</tr>
      </xsl:when>
      <xsl:otherwise>
	<span about="{@rdf:about}" typeof="foaf:Document">
	  <xsl:apply-templates select="current()" mode="aaai-citation-nested"/>
	</span>
	<br />
	<br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
