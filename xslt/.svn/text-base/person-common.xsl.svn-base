<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
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
		xmlns:foaf="http://xmlns.com/foaf/0.1/"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:key name="tw:Publication-nodes" match="tw:Publication|*[rdf:type/@rdf:resource='&tw;Publication']" use="@rdf:about"/>
  <xsl:key name="tw:Author-nodes" match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']" use="@rdf:nodeID"/>
  <xsl:key name="tw:hasRole-nodes" match="tw:hasRole" use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="foaf:Person-nodes" match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']" use="@rdf:about"/>

  <xsl:template match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']" mode="place-link">
    <xsl:param name="style">full</xsl:param>
    <xsl:variable name="uri">
      <xsl:call-template name="get-person-page">
	<xsl:with-param name="person" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="name">
      <xsl:call-template name="get-person-name">
	<xsl:with-param name="person" select="."/>
	<xsl:with-param name="style" select="$style"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="full-name">
      <xsl:call-template name="get-person-name">
	<xsl:with-param name="person" select="."/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="foaf:Person">
      <a href="{$uri}" rel="tw:page">
	<span about="{@rdf:about}">
	  <xsl:copy-of select="$name"/>
	  <span property="foaf:name" content="{string(exsl:node-set($full-name))}"/>
	</span>
      </a>
    </span>
  </xsl:template>

  <xsl:template name="get-person-publication-uris">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/tw:hasRole/*/@rdf:nodeID|$person/tw:hasRole/@rdf:nodeID">
      <xsl:variable name="node" select="key('tw:Author-nodes',current())"/>
      <xsl:if test="$node/@rdf:nodeID">
        <uri><xsl:value-of select="$node/tw:ofDocument/@rdf:resource|$node/tw:ofDocument/*/@rdf:about"/></uri>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']"
                mode="link">
    <xsl:param name="style">full</xsl:param>
    <xsl:variable name="uri">
      <xsl:call-template name="get-person-page">
        <xsl:with-param name="person" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="name">
      <xsl:call-template name="get-person-name">
        <xsl:with-param name="person" select="current()"/>
        <xsl:with-param name="style" select="$style"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="full-name">
      <xsl:call-template name="get-person-name">
        <xsl:with-param name="person" select="current()"/>
        <xsl:with-param name="style">full</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="foaf:Person">
      <a href="{$uri}" rel="tw:page">
        <span about="{@rdf:about}">
          <xsl:copy-of select="$name"/>
          <span property="foaf:name" content="{string(exsl:node-set($full-name))}"/>
        </span>
      </a>
    </span>
  </xsl:template>

  <xsl:template name="get-person-page">
    <xsl:param name="person"/>
    <xsl:choose>
      <xsl:when test="$person/tw:page">
	<xsl:for-each select="$person/tw:page">
	  <xsl:if test="contains(@rdf:resource,'web') and contains(@rdf:resource,'tw.rpi.edu') or contains(@rdf:resource,'wineagent.tw.rpi.edu')">
	    <xsl:value-of select="@rdf:resource"/>
	  </xsl:if>
          <xsl:if test="contains(@rdf:resource,'google.com')">
            <xsl:value-of select="@rdf:resource"/>
          </xsl:if>
          <xsl:if test="contains(@rdf:resource,'whoi.edu')">
            <xsl:value-of select="@rdf:resource"/>
          </xsl:if>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$person/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-person-link">
    <xsl:param name="person"/>
    <xsl:param name="style">full</xsl:param>
    <xsl:param name="rel"/>
    <xsl:variable name="uri">
      <xsl:call-template name="get-person-page">
	<xsl:with-param name="person" select="$person"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="name">
      <xsl:call-template name="get-person-name">
	<xsl:with-param name="person" select="$person"/>
	<xsl:with-param name="style" select="$style"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="full-name">
      <xsl:call-template name="get-person-name">
	<xsl:with-param name="person" select="$person"/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{$person/@rdf:about}" typeof="foaf:Person">
      <a href="{$uri}" rel="tw:page">
	<span about="{$person/@rdf:about}">
	  <xsl:copy-of select="$name"/>
	  <span property="foaf:name" content="{string(exsl:node-set($full-name))}"/>
	</span>
      </a>
    </span>
  </xsl:template>

  <xsl:template name="get-person-name">
    <xsl:param name="person"/>
    <xsl:param name="style">full</xsl:param>
    <xsl:param name="rdfa" select="true()"/>
    <xsl:variable name="firstname">
      <xsl:choose>
        <xsl:when test="$person/foaf:firstName[@xml:lang='en']|$person/foaf:givenName[@xml:lang='en']|$person/foaf:givenname[@xml:lang='en']">
          <xsl:value-of select="$person/foaf:firstName[@xml:lang='en']|$person/foaf:givenName[@xml:lang='en']|$person/foaf:givenname[@xml:lang='en']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$person/foaf:firstName[not(@xml:lang)]|$person/foaf:givenName[not(@xml:lang)]|$person/foaf:givenname[not(@xml:lang)]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="lastname">
      <xsl:choose>
        <xsl:when test="$person/foaf:lastName[@xml:lang='en']|$person/foaf:surname[@xml:lang='en']|$person/foaf:familyName[@xml:lang='en']|$person/foaf:family_name[@xml:lang]">
          <xsl:value-of select="$person/foaf:lastName[@xml:lang='en']|$person/foaf:surname[@xml:lang='en']|$person/foaf:familyName[@xml:lang='en']|$person/foaf:family_name[@xml:lang='en']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$person/foaf:lastName[not(@xml:lang)]|$person/foaf:surname[not(@xml:lang)]|$person/foaf:familyName[not(@xml:lang)]|$person/foaf:family_name[not(@xml:lang)]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="middleInitial">
      <xsl:value-of select="substring($person/tw:middleInitial,1,1)"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$style='full'">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:firstName</xsl:attribute>
	  </xsl:if>
          <xsl:value-of select="$firstname"/>
	</span>
	<xsl:text> </xsl:text>
	<xsl:if test="$person/tw:middleInitial">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">tw:middleInitial</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="substring($middleInitial,1,1)"/>
	</span>
	<xsl:text>. </xsl:text>
	</xsl:if>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:lastName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$lastname"/>
	</span>
      </xsl:when>
      <xsl:when test="$style='last,fi' or $style='ln,fi'">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:lastName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$lastname"/>
	</span>
	<xsl:text>, </xsl:text>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:firstName</xsl:attribute>
	    <xsl:attribute name="content">
	      <xsl:value-of select="$firstname"/>
	    </xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="substring($firstname,1,1)"/>
	</span>
	<xsl:text>.</xsl:text>
      </xsl:when>
      <xsl:when test="$style='fi.last' or $style='fi.ln'">
        <span>
          <xsl:if test="$rdfa=true()">
            <xsl:attribute name="property">foaf:firstName</xsl:attribute>
            <xsl:attribute name="content">
              <xsl:value-of select="$firstname" />
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="substring($firstname,1,1)" />
        </span>
        <xsl:text>.</xsl:text>
        <span>
          <xsl:if test="$rdfa=true()">
            <xsl:attribute name="property">foaf:lastName</xsl:attribute>
          </xsl:if>
          <xsl:value-of select="$lastname"/>
        </span>
      </xsl:when>
      <xsl:when test="$style='last,fi.mi' or $style='ln,fi.mi'">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:lastName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$lastname"/>
	</span>
	<xsl:text>, </xsl:text>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:firstName</xsl:attribute>
	    <xsl:attribute name="content">
	      <xsl:value-of select="$firstname"/>
	    </xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="substring($firstname,1,1)"/>
	</span>
	<xsl:text>.</xsl:text>
	<xsl:if test="$person/tw:middleInitial">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">tw:middleInitial</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="substring($middleInitial,1,1)"/>
	</span>
	<xsl:text>.</xsl:text>
	</xsl:if>
      </xsl:when>
      <xsl:when test="$style='last,first' or $style='ln,fn'">
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:lastName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$lastname"/>
	</span>
	<xsl:text>, </xsl:text>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:firstName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$firstname"/>
	</span>
	<xsl:if test="$person/tw:middleInitial">
	<xsl:text> </xsl:text>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">tw:middleInitial</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="substring($middleInitial,1,1)"/>
	</span>
	<xsl:text>.</xsl:text>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:firstName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$firstname"/>
	</span>
	<xsl:text> </xsl:text>
	<span>
	  <xsl:if test="$rdfa=true()">
	    <xsl:attribute name="property">foaf:lastName</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="$lastname"/>
	</span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-person-bio">
    <xsl:param name="person"/>
    <p property="tw:hasBio" datatype="rdf:XMLLiteral">
      <xsl:if test="$person/tw:hasBio/@xml:lang">
	<xsl:attribute name="xml:lang">
	  <xsl:value-of select="$person/tw:hasBio/@xml:lang"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$person/tw:hasBio/*">
          <xsl:copy-of select="$person/tw:hasBio/*"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$person/tw:hasBio"/>
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

  <xsl:template name="get-person-depiction">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="$root//*[@rdf:about=$person/foaf:depiction/@rdf:resource]">
	<xsl:copy-of select="$root//*[@rdf:about=$person/foaf:depiction/@rdf:resource]"/>
      </xsl:when>
      <xsl:when test="$person/foaf:depiction/@rdf:nodeID">
	<xsl:copy-of select="$root//*[@rdf:nodeID=$person/foaf:depiction/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Image']|$root//foaf:Image[@rdf:nodeID=$person/foaf:depiction/@rdf:nodeID]"/>
      </xsl:when>
      <xsl:when test="$person/foaf:depiction/*">
	<xsl:copy-of select="$person/foaf:depiction/*"/>
      </xsl:when>
      <xsl:when test="$person/foaf:depiction/@rdf:resource">
	<foaf:Image rdf:about="{$person/foaf:depiction/@rdf:resource}"></foaf:Image>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-person-publications">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/tw:hasRole">
      <xsl:choose>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:variable name="role" select="$root//tw:Author[@rdf:nodeID=current()/@rdf:nodeID]|$root//*[@rdf:nodeID=current()/@rdf:nodeID and rdf:type/@rdf:resource='&tw;Author']"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:ofDocument/@rdf:resource">
	      <xsl:variable name="document" select="$root//*[@rdf:about=$role/tw:ofDocument/@rdf:resource]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/@rdf:nodeID">
	      <xsl:variable name="document" select="$root//*[@rdf:nodeID=$role/tw:ofDocument/@rdf:nodeID and tw:hasTitle]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/*">
	      <xsl:variable name="document" select="$role/tw:ofDocument/*"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:variable name="role" select="$root//*[@rdf:about=current()/@rdf:resource and tw:ofDocument]"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:ofDocument/@rdf:resource">
	      <xsl:variable name="document" select="$root//*[@rdf:about=$role/tw:ofDocument/@rdf:resource]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/@rdf:nodeID">
	      <xsl:variable name="document" select="$root//*[@rdf:nodeID=$role/tw:ofDocument/@rdf:nodeID and tw:hasTitle]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/*">
	      <xsl:variable name="document" select="$role/tw:ofDocument/*"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:variable name="role" select="current()/*"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:ofDocument/@rdf:resource">
	      <xsl:variable name="document" select="$root//*[@rdf:about=$role/tw:ofDocument/@rdf:resource]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/@rdf:nodeID">
	      <xsl:variable name="document" select="$root//*[@rdf:nodeID=$role/tw:ofDocument/@rdf:nodeID and tw:hasTitle]"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	    <xsl:when test="$role/tw:ofDocument/*">
	      <xsl:variable name="document" select="$role/tw:ofDocument/*"/>
	      <xsl:if test="$document[name()='tw:Publication']|$document[rdf:type/@rdf:resource='&tw;Publication']|$document[rdf:type/*/@rdf:about='&tw;Publication']">
		<xsl:copy-of select="$document"/>
	      </xsl:if>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-presentations">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/tw:hasRole">
      <xsl:choose>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:variable name="role" select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and tw:presented]"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:presented/@rdf:resource">
	      <xsl:copy-of select="$root//*[@rdf:about=$role/tw:presented/@rdf:resource]"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/@rdf:nodeID">
	      <xsl:copy-of select="$root//tw:Presentation[@rdf:nodeID=$role/tw:presented/@rdf:nodeID]|$root//*[@rdf:nodeID=$role/tw:presented/@rdf:nodeID and rdf:type='&tw;Presentation']"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/*">
	      <xsl:copy-of select="$role/tw:presented/*"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:variable name="role" select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:presented/@rdf:resource">
	      <xsl:copy-of select="$root//*[@rdf:about=$role/tw:presented/@rdf:resource]"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/@rdf:nodeID">
	      <xsl:copy-of select="$root//tw:Presentation[@rdf:nodeID=$role/tw:presented/@rdf:nodeID]|$root//*[@rdf:nodeID=$role/tw:presented/@rdf:nodeID and rdf:type='&tw;Presentation']"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/*">
	      <xsl:copy-of select="$role/tw:presented/*"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/*">
	  <xsl:variable name="role" select="current()/*"/>
	  <xsl:choose>
	    <xsl:when test="$role/tw:presented/@rdf:resource">
	      <xsl:copy-of select="$root//*[@rdf:about=$role/tw:presented/@rdf:resource]"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/@rdf:nodeID">
	      <xsl:copy-of select="$root//tw:Presentation[@rdf:nodeID=$role/tw:presented/@rdf:nodeID]|$root//*[@rdf:nodeID=$role/tw:presented/@rdf:nodeID and rdf:type='&tw;Presentation']"/>
	    </xsl:when>
	    <xsl:when test="$role/tw:presented/*">
	      <xsl:copy-of select="$role/tw:presented/*"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-projects">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/tw:hasRole[@rdf:nodeID or (not(@rdf:parseType='Resource') and */@rdf:nodeID)]">
      <xsl:choose>
	<xsl:when test="current()/@rdf:nodeID">
	  <xsl:variable name="role" select="$root//*[@rdf:nodeID=current()/@rdf:nodeID and tw:hasDateTimeCoverage]"/>
	  <xsl:choose>
	    <xsl:when test="$root//foaf:Project[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID]">
	      <xsl:copy-of select="$root//foaf:Project[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID]"/>
	    </xsl:when>
	    <xsl:when test="$root//*[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']">
	      <xsl:copy-of select="$root//*[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/@rdf:resource">
	  <xsl:variable name="role" select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	  <xsl:choose>
	    <xsl:when test="$root//foaf:Project[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about]">
	      <xsl:copy-of select="$root//foaf:Project[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about]"/>
	    </xsl:when>
	    <xsl:when test="$root//*[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']">
	      <xsl:copy-of select="$root//*[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/*[@rdf:nodeID and not(rdf:parseType)]">
	  <xsl:variable name="role" select="current()/*"/>
	  <xsl:choose>
	    <xsl:when test="$root//foaf:Project[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID]">
	      <xsl:copy-of select="$root//foaf:Project[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID]"/>
	    </xsl:when>
	    <xsl:when test="$root//*[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']">
	      <xsl:copy-of select="$root//*[tw:hasAgentWithRole/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:nodeID=$role/@rdf:nodeID and rdf:type/@rdf:resource='&foaf;Project']"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
	<xsl:when test="current()/*/@rdf:about">
	  <xsl:variable name="role" select="current()/*"/>
	  <xsl:choose>
	    <xsl:when test="$root//foaf:Project[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about]">
	      <xsl:copy-of select="$root//foaf:Project[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about]|$root//foaf:Project[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about]"/>
	    </xsl:when>
	    <xsl:when test="$root//*[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']">
	      <xsl:copy-of select="$root//*[tw:hasAgentWithRole/@rdf:resource=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']|$root//*[tw:hasAgentWithRole/*/@rdf:about=$role/@rdf:about and rdf:type/@rdf:resource='&foaf;Project']"/>
	    </xsl:when>
	  </xsl:choose>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-postal-address">
  </xsl:template>

  <!--
  <xsl:template name="get-person-email-address">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/foaf:mbox">
      <xsl:choose>
	<xsl:when test="@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="*">
	  <xsl:copy-of select="*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  -->

  <xsl:template name="get-person-email-address">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/foaf:mbox">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-homepage">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/foaf:homepage">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-seeAlso">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/rdfs:seeAlso">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-weblog">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/foaf:weblog">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-workplace-homepage">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/foaf:workplaceHomepage">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-school-homepage">
    <xsl:param name="person"/>
    <xsl:for-each select="$person/foaf:schoolHomepage">
      <foaf:Document rdf:about="{current()/@rdf:resource}"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-person-interests">
    <xsl:param name="person"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="$person/tw:hasInterest">
      <xsl:choose>
	<xsl:when test="@rdf:resource">
	  <xsl:copy-of select="$root//*[@rdf:about=current()/@rdf:resource]"/>
	</xsl:when>
	<xsl:when test="@rdf:nodeID">
	  <xsl:copy-of select="$root//tw:Concept[@rdf:nodeID=current()/@rdf:nodeID]|$root//*[@rdf:nodeID=current()/@rdf:nodeID and rdf:type/@rdf:resource='&tw;Concept']"/>
	</xsl:when>
	<xsl:when test="*">
	  <xsl:copy-of select="*"/>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
