<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
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
  <xsl:key name="tw:Theme-nodes"
	   match="tw:Theme|*[rdf:type/@rdf:resource='&tw;Theme']"
	   use="@rdf:about"/>

  <xsl:template name="get-theme-name">
    <xsl:param name="theme"/>
    <xsl:value-of select="$theme/foaf:name"/>
  </xsl:template>

  <xsl:template name="get-theme-page">
    <xsl:param name="theme"/>
    <xsl:choose>
      <xsl:when test="$theme/tw:page">
	<xsl:for-each select="$theme/tw:page">
	  <xsl:if test="contains(@rdf:resource,'web') and contains(@rdf:resource,'tw.rpi.edu')">
	    <xsl:value-of select="@rdf:resource"/>
	  </xsl:if>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$theme/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-theme-link">
    <xsl:param name="theme"/>
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-theme-page">
	<xsl:with-param name="theme" select="$theme"/>
      </xsl:call-template>
    </xsl:variable>
    <span>
      <xsl:if test="$rel!=''">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
    <span about="{$theme/@rdf:about}" typeof="tw:Theme">
    <a href="{$uri}" rel="tw:page" property="foaf:name">
      <xsl:call-template name="get-theme-name">
	<xsl:with-param name="theme" select="$theme"/>
      </xsl:call-template>
    </a>
    </span>
    </span>
  </xsl:template>

  <xsl:template name="get-theme-lead-prof">
    <xsl:param name="theme"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$theme/tw:hasLeadProfessor">
      <xsl:choose>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID/*/..]"/>
	</xsl:when>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:copy-of select="current()/*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-theme-description">
    <xsl:param name="theme"/>
    <xsl:value-of select="$theme/dc:description"/>
  </xsl:template>

  <xsl:template name="get-theme-projects">
    <xsl:param name="theme"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$root//foaf:Project[tw:hasThemeReference/@rdf:resource=$theme/@rdf:about]|$root//foaf:Project[tw:hasThemeReference/@rdf:nodeID=$theme/@rdf:nodeID]|$root//foaf:Project[tw:hasThemeReference/*/@rdf:about=$theme/@rdf:about]|$root//foaf:Project[tw:hasThemeReference/*/@rdf:nodeID=$theme/@rdf:nodeID]|$root//*[tw:hasThemeReference/@rdf:resource=$theme/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasThemeReference/@rdf:nodeID=$theme/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasThemeReference/*/@rdf:about=$theme/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasThemeReference/*/@rdf:nodeID=$theme/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']">
	<xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-theme-presentations">
    <xsl:param name="theme"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="projects-raw"><xsl:call-template name="get-theme-projects"><xsl:with-param name="theme" select="$theme"/></xsl:call-template></xsl:variable>
    <xsl:variable name="projects" select="exsl:node-set($projects-raw)"/>
    <xsl:for-each select="$projects/*">
      <xsl:variable name="uri" select="current()/@rdf:about"/>
      <xsl:for-each select="$root//*[tw:hasProjectReference/@rdf:resource=$uri]|$root//*[tw:hasProjectReference/*/@rdf:about=$uri]">
	<xsl:if test="current()[name()='tw:Presentation']|rdf:type[@rdf:resource='&tw;Presentation']|rdf:type/*[@rdf:about='&tw;Presentation']">
	  <xsl:copy-of select="current()"/>
	</xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-theme-concepts">
    <xsl:param name="theme"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$theme/tw:hasTopic">
      <xsl:choose>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:copy-of select="$root//*[@rdf:nodeID=current()/@rdf:nodeID]/*/.."/>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:copy-of select="current()/*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-theme-logo">
    <xsl:param name="theme"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="$theme/foaf:logo/@rdf:resource">
	<xsl:copy-of select="$root//*[@rdf:about=$theme/foaf:logo/@rdf:resource]"/>
      </xsl:when>
      <xsl:when test="$theme/foaf:logo/@rdf:nodeID">
	<xsl:copy-of select="$root//*[@rdf:nodeID=$theme/foaf:logo/@rdf:nodeID]/*/.."/>
      </xsl:when>
      <xsl:when test="$theme/foaf:logo/*">
	<xsl:copy-of select="$theme/foaf:logo/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
