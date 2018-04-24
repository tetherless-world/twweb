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
  <xsl:import href="/xslt/time-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/section-general.xsl"/>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="place-history">
    <tr about="{@rdf:about}">
      <td>
	<xsl:apply-templates select="dc:modified"/>
      </td>
      <td>
	<xsl:apply-templates select="dc:creator/*|//*[@rdf:about=current()/dc:creator/@rdf:resource]" mode="place-link"/>
      </td>
      <td><a href="{@rdf:about}">Download</a></td>
    </tr>
    <xsl:if test="dc:replaces">
      <xsl:variable name="doc" select="document(concat(dc:replaces/@rdf:resource,'?mode=rdf'))"/>
      <xsl:apply-templates select="$doc//foaf:Document|$doc//*[rdf:type/@rdf:resource='&foaf;Document']" mode="place-history"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="document-history">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="header" select="true()"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="contains($node/@rdf:about,'media') and contains($node/@rdf:about,'tw.rpi.edu')">
        <div class="section" id="document-history">
          <link href="/css/document.css" type="text/css" rel="stylesheet"/>
          <xsl:call-template name="header">
	    <xsl:with-param name="text">History</xsl:with-param>
	    <xsl:with-param name="stylesheet">document-history</xsl:with-param>
          </xsl:call-template>
          <p><upload href="{$node/@rdf:about}" revision="true" id="new-revision"/></p>
          <table>
	    <tr><th>Date</th><th>Created By</th><th>Link</th></tr>
	    <xsl:variable name="doc" select="document(concat(@rdf:about,'?mode=rdf'))"/>
	    <xsl:apply-templates select="$doc//foaf:Document|$doc//*[rdf:type/@rdf:resource='&foaf;Document']" mode="place-history">
	      <xsl:with-param name="admin" select="$admin"/>
  	    </xsl:apply-templates>
          </table>
        </div>
      </xsl:when>
      <xsl:otherwise>
	<br />
        <span style="font-weight:bold;">Download: </span><a href="{$node/@rdf:about}"><xsl:value-of select="$node/@rdf:about"/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
