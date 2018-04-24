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
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:template name="publication-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <tr class="publication-list-item">
      <td>
	<xsl:call-template name="get-publication-citation">
	  <xsl:with-param name="publication" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>

