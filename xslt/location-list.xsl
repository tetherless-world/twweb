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
		xmlns:s="http://www.w3.org/2005/sparql-results#"
		xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#"
		xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="located-in-list">
    <xsl:param name="node"/>
    <xsl:param name="location"/>
    <div>
      <link href="/css/location.css" rel="stylesheet" type="text/css"/>
      <table class="theme-list">
      <xsl:for-each select="//tw:Location[not(tw:locatedIn)]|//*[rdf:type/@rdf:resource='&tw;Location' and not(tw:locatedIn)]">
	<xsl:sort select="tw:hasName"/>
	<xsl:call-template name="location-list-item">
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="embed" select="true()"/>
	  <xsl:with-param name="node" select="current()"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
	<xsl:if test="$root//*[tw:locatedIn/@rdf:resource=current()/@rdf:about or tw:locatedIn/*/@rdf:about=current()/@rdf:about]">
	  <xsl:for-each select="$root//*[tw:locatedIn/@rdf:resource=current()/@rdf:about or tw:LocatedIn/*/@rdf:about=current()/@rdf:about]">
	    <xsl:sort select="tw:hasName"/>
	    <xsl:call-template name="location-list-item">
	      <xsl:with-param name="admin" select="$admin"/>
	      <xsl:with-param name="embed" select="true()"/>
	      <xsl:with-param name="node" select="current()"/>
	      <xsl:with-param name="root" select="$root"/>
	      <xsl:with-param name="class">located-in-list-item</xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	  <tr class="location-separator"><td></td></tr>
	</xsl:if>
      </xsl:for-each>
      </table>
    </div>
  </xsl:template>
</xsl:stylesheet>

