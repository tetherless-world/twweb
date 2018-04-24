<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY media "http://tw.rpi.edu/media/">
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
		xmlns:exsl="http://exslt.org/common"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:foaf="&foaf;"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/event-common.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:key name="tw:Event-nodes" match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']" use="@rdf:about"/>
  <xsl:key name="foaf:Document-nodes" match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" use="@rdf:about"/>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="header">
    <xsl:param name="embed"/>
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>
    <!-- Not much to do here -->
    <div class="header">
      <link href="/css/document.css"
	    type="text/css"
	    rel="stylesheet"/>
      <xsl:if test="not($embed=true())">
	<h1 xmlns:tw="&tw;">
	  <span rel="dc:title">
	    <xsl:call-template name="get-document-title">
	      <xsl:with-param name="document" select="current()"/>
	    </xsl:call-template>
	  </span>
	  <xsl:if test="$admin=true()">
	    <a href="./edit">Edit</a>
	  </xsl:if>
	</h1>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="document-header-embed">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="header" select="true()"/>

    <xsl:apply-templates select="$node" mode="header">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="embed" select="false()"/>
      <xsl:with-param name="root" select="$root"/>
      <xsl:with-param name="header" select="$header"/>
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>
