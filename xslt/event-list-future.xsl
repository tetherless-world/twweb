<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:tw="&tw;"
		xmlns:owl="http://www.w3.org/2002/07/owl#"
	        xmlns:time="http://www.w3.org/2006/time#"
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/event-list-asc2.xsl"/>

  <xsl:template match="/rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="root" select="/"/>
    <div>
      <xsl:choose>
        <xsl:when test="//tw:Event|//*[rdf:type/@rdf:resource='&tw;Event']">
	  <h1>Future Events</h1>
          <xsl:variable name="events" select="//tw:Event|//*[rdf:type/@rdf:resource='&tw;Event']"/>
          <xsl:call-template name="event-list-asc">
	    <xsl:with-param name="events" select="$events"/>
	    <xsl:with-param name="root" select="/"/>
	    <xsl:with-param name="admin" select="$admin"/>
          </xsl:call-template>
	  <br/><br/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
</xsl:stylesheet>
