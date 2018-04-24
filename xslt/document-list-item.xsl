<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:exsl="http://exslt.org/common"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/time-raw.xsl"/>

  <xsl:template name="document-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <tr class="document-list-item">
      <td style="border:1px solid black;width:25%">
	<xsl:call-template name="place-uri-link">
	  <xsl:with-param name="document" select="$node"/>
	</xsl:call-template>
      </td>
      <td style="border:1px solid black;width:25%">
	<xsl:call-template name="place-creators-link">
	  <xsl:with-param name="document" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </td>
      <td style="border:1px solid black;width:25%">
	<xsl:call-template name="get-date-timeplain-monthabrev">
	  <xsl:with-param name="dt">
	    <xsl:value-of select="$node/dc:modified"/>
	  </xsl:with-param>
	</xsl:call-template>
      </td>
      <td style="border:1px solid black;width:25%">
	<xsl:call-template name="get-date-timeplain-monthabrev">
	  <xsl:with-param name="dt">
	    <xsl:value-of select="$node/dc:created"/>
	  </xsl:with-param>
	</xsl:call-template>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>

