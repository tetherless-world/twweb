<?xml version="1.1"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet
   version="1.1"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:exsl="http://exslt.org/common"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:template name="people-list">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:choose>
      <xsl:when test="$node//foaf:Person|$node//*/rdf:type[@rdf:resource='&foaf;Person']">
        <div xmlns="http://www.w3.org/1999/xhtml">
          <xsl:variable name="letters-raw"><l>a</l><l>b</l><l>c</l><l>d</l><l>e</l><l>f</l><l>g</l><l>h</l><l>i</l><l>j</l><l>k</l><l>l</l><l>m</l><l>n</l><l>o</l><l>p</l><l>q</l><l>r</l><l>s</l><l>t</l><l>u</l><l>v</l><l>w</l><l>x</l><l>y</l><l>z</l></xsl:variable>
          <xsl:variable name="letters" select="exsl:node-set($letters-raw)"/>
          <xsl:for-each select="$letters/*">
            <xsl:variable name="smallCase" select="'abcdefghijklmnopqrstuvwxyz'"/>
            <xsl:variable name="upperCase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	    <xsl:if test="$node//*[starts-with(foaf:lastName,current()) or starts-with(foaf:lastName,translate(current(),$smallCase,$upperCase))]">
              <h2><xsl:value-of select="translate(current(),$smallCase,$upperCase)"/></h2>
            </xsl:if>
            <xsl:for-each select="$node//*[starts-with(foaf:lastName,current()) or starts-with(foaf:lastName,translate(current(),$smallCase,$upperCase))]">
              <xsl:sort select="translate(./foaf:lastName, $smallCase, $upperCase)"/>
              <div about="{@rdf:about}">
		<xsl:call-template name="place-person-link">
		  <xsl:with-param name="person" select="current()"/>
		  <xsl:with-param name="style">last,first</xsl:with-param>
		  <xsl:with-param name="rdfa" select="true()"/>
		</xsl:call-template>
		<!--
                <xsl:variable name="link" select="tw:page/@rdf:resource" /> 
                <a href="{$link}" rel="tw:page"><span about="{@rdf:about}" property="foaf:name"><xsl:value-of select="foaf:name"/></span></a>
		-->
              </div>
            </xsl:for-each>
          </xsl:for-each>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p xmlns="http://www.w3.org/1999/xhtml">No elements matched your query</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <xsl:call-template name="people-list">
      <xsl:with-param name="admin" select="false()"/>
      <xsl:with-param name="node" select="/rdf:RDF"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>

