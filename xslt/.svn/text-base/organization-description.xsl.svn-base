<?xml version="1.0"?>
<!-- Created by David Molik using Gedit-->

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
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/organization-common.xsl"/>
  
  <xsl:template name="organization-description">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="header"/>
    
    <p property="dc:description">
      <xsl:call-template name="get-organization-description">
	<xsl:with-param name="organization" select="$node"/>
      </xsl:call-template>
    </p>
  </xsl:template>

</xsl:stylesheet>


	
