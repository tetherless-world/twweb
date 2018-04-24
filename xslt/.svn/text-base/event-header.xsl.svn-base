<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:time="http://www.w3.org/2006/time#"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/event-common.xsl"/>

  <xsl:template name="event-header">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <div class="header">
      <link href="/css/event.css" rel="stylesheet" type="text/css"/>
      <xsl:choose>
	<xsl:when test="not($embed=true())">
	  <h1 xmlns:tw="&tw;">
	    <span property="dc:title">
	      <xsl:value-of select="$node/dc:title"/>
	    </span>
	    <xsl:if test="$admin='true'">
	      <span class="edit"> (<a href="{$node/@rdf:about}/edit">Edit</a>)</span>
	    </xsl:if>
	  </h1>
	</xsl:when>
      </xsl:choose>
    </div>
  </xsl:template>

</xsl:stylesheet>
