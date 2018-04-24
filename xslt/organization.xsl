<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>

<xsl:stylesheet 
   version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns="http://www.w3.org/1999/xhtml">
   
   <xsl:include href="organization-header.xsl"/>
   <xsl:include href="organization-description.xsl"/>
   <!--<xsl:include href="organization-sponsored-project.xsl"/>
   <xsl:include href="project-list-item.xsl"/>-->

   <xsl:template match="//tw:Organization|//*[rdf:type='&tw;Organization']">
    <xsl:param name="admin"/>
    <xsl:call-template name="organization-header">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
    </xsl:call-template>
    <xsl:call-template name="organization-description">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
    </xsl:call-template>
    <xsl:call-template name="organization-sponsored-projects">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/>
    </xsl:call-template>
    <!-- <xsl:call-template name="project-list-item">
      <xsl:with-param name="admin" select="$admin"/>
      <xsl:with-param name="node" select="current()"/> 
    </xsl:call-template> -->

 <xsl:template match="/">
    <html><body>
      <xsl:call-template name="organization">
        <xsl:with-param name="node" select="//*[@rdf:about='&here;NSF']"/>
      </xsl:call-template>
    </body></html>
  </xsl:template>
</xsl:stylesheet>


   
