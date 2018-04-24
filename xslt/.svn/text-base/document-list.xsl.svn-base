<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/document-list-item.xsl"/>

  <xsl:template name="place-document-list">
    <xsl:param name="documents"/>
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="false()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="class">document-list</xsl:param>
    <xsl:param name="sort" select="false()"/>
    <table class="{$class}" style="border:1px solid black;">
      <tr>
        <td style="width:25%;border:1px solid black;">
	  Document
	</td>
        <td style="width:25%;border:1px solid black;">
	  Creator
	</td>
        <td style="width:25%;border:1px solid black;">
	  Modified
	</td>
        <td style="width:25%;border:1px solid black;">
	  Created
	</td>
      </tr>
      <xsl:for-each select="$documents/*">
	<xsl:sort select="dc:modified" order="descending"/>
	<xsl:call-template name="document-list-item">
	  <xsl:with-param name="node" select="current()"/>
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="embed" select="$embed"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:for-each>
    </table>
  </xsl:template>
  
  <xsl:template name="place-document-list-stylesheet">
    <link href="/css/document-list.css" type="text/css" rel="stylesheet"/>
  </xsl:template>

  <xsl:template name="publication-list">
    <xsl:param name="admin" select="false()"/>
    <xsl:param name="embed" select="true()"/>
    <xsl:param name="root" select="/"/>
    <xsl:param name="uri"/>
    <xsl:variable name="docs">
      <xsl:for-each select="$root//*[rdf:type/@rdf:resource='&foaf;Document']|$root//foaf:Document">
	<xsl:copy-of select="current()"/>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="docs2" select="exsl:node-set($docs)"/>
    <div class="publication-list">
      <xsl:call-template name="place-document-list-stylesheet"/>
      <p>Total documents: <xsl:value-of select="count($docs2/*)"/></p>
      <xsl:call-template name="place-document-list">
	<xsl:with-param name="documents" select="$docs2"/>
	<xsl:with-param name="sort" select="true()"/>
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="embed" select="$embed"/>
	<xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </div>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="publication-list">
      <xsl:with-param name="root" select="current()"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>

