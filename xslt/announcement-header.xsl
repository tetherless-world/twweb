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
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/announcement-common.xsl"/>

  <xsl:template name="announcement-header">
    <xsl:param name="node"/>
    <xsl:param name="admin"/>
    <xsl:param name="embed"/>

    <div class="announcement">
      <link href="/css/announcement.css" type="text/css" rel="stylesheet"/>
      <div class="header">
        <h1 xmlns:tw="&tw;">
	  <xsl:if test="not($embed=true())">
            <span rel="tw:hasTitle">
              <xsl:call-template name="get-announcement-title">
                <xsl:with-param name="theme" select="$node"/>
              </xsl:call-template>
            </span>
          </xsl:if>
        </h1>  
      </div>
    </div>
  </xsl:template>
 
</xsl:stylesheet>
