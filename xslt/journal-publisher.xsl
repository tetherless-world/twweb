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
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns:exsl="http://exslt.org/common"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:import href="/xslt/organization-common.xsl"/>
  <xsl:template match="/">
    <xsl:param name="root" select="/"/>
    <xsl:if test="//foaf:Organization|//*[rdf:type/@rdf:resource='&foaf;Organization']">
    <br />
    <b class="label">Publisher:</b>
      <xsl:for-each select="//foaf:Organization|//*[rdf:type/@rdf:resource='&foaf;Organization']">
	<xsl:call-template name="place-organization-link">
	    <xsl:with-param name="organization" select="current()"/>
	    <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:for-each>
  </xsl:if>
  <br />
  </xsl:template>
</xsl:stylesheet>

