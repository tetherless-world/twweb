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
   xmlns:exsl="http://exslt.org/common"
   xmlns:foaf="&foaf;"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/section-general.xsl"/>
  <xsl:import href="/xslt/publication-common.xsl"/>
  <xsl:import href="/xslt/aaai-citation.xsl"/>

  <xsl:key name="tw:Author-nodes"
           match="tw:Author|*[rdf:type/@rdf:resource='&tw;Author']"
           use="@rdf:nodeID" />
  <xsl:key name="tw:Publication-nodes"
           match="tw:Publication|*[rdf:type/@rdf:resource='&tw;Publication']"
           use="@rdf:about" />
  <xsl:key name="tw:hasAgentWithRole-nodes"
           match="tw:Publication/tw:hasAgentWithRole|*[rdf:type/@rdf:resource='&tw;Publication']/tw:hasAgentWithRole"
           use="@rdf:nodeID|*/@rdf:nodeID" />
  <xsl:key name="tw:Editor-nodes"
           match="tw:Editor|*[rdf:type/@rdf:resource='&tw;Editor']"
           use="@rdf:nodeID"/>
  <xsl:key name="foaf:Person-nodes"
	   match="foaf:Person|*[rdf:type/@rdf:resource='&foaf;Person']"
	   use="@rdf:about"/>
  <xsl:key name="tw:hasRole-nodes"
	   match="tw:hasRole"
	   use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="tw:Event-nodes"
	   match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
	   use="@rdf:about"/>
  <xsl:key name="tw:Journal-nodes"
	   match="tw:Journal|*[rdf:type/@rdf:resource='&tw;Journal']|tw:Book|*[rdf:type/@rdf:resource='&tw;Book']"
	   use="@rdf:about"/>

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

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-authors">
    <xsl:param name="sep">,</xsl:param>
    <xsl:for-each select="tw:hasAgentWithRole/@rdf:nodeID|tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:sort select="key('tw:Author-nodes',.)/tw:index" data-type="number"/>
      <span rel="tw:hasAgentWithRole">
	<span typeof="tw:Author">
	  <span rev="tw:hasRole">
	    <xsl:apply-templates select="key('tw:hasRole-nodes',.)/.." mode="place-link">
	      <xsl:with-param name="style">last,fi.mi</xsl:with-param>
	    </xsl:apply-templates>
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text> </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1 and last()=2">
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1">
	  <xsl:value-of select="$sep"/>
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$sep"/>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-editors">
    <xsl:param name="sep">,</xsl:param>
    <xsl:for-each select="tw:hasAgentWithRole/@rdf:nodeID[key('tw:Editor-nodes',.)/rdf:type/@rdf:resource='&tw;Editor' or name(key('tw:Editor-nodes',.))='tw:Editor']|tw:hasAgentWithRole/*/@rdf:nodeID">
      <xsl:sort select="key('tw:Editor-nodes',.)/tw:index" data-type="number"/>
      <span rel="tw:hasAgentWithRole">
	<span typeof="tw:Editor">
	  <span rev="tw:hasRole">
	    <xsl:apply-templates select="key('tw:hasRole-nodes',.)/.." mode="place-link" />
	  </span>
	</span>
      </span>
      <xsl:choose>
	<xsl:when test="position()=last()">
	  <xsl:text></xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1 and last()=2">
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:when test="position()=last()-1">
	  <xsl:value-of select="$sep"/>
	  <xsl:text> and </xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="$sep"/>
	  <xsl:text> </xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tw:Book|*[rdf:type/@rdf:resource='&tw;Book']" mode="subcitation">
    <span about="{@rdf:about}" typeof="tw:Book">
      <xsl:apply-templates select="." mode="aaai-editors">
        <xsl:with-param name="sep">,</xsl:with-param>
      </xsl:apply-templates>
      <xsl:choose>
        <xsl:when test="count(key('tw:Editor-nodes',tw:hasAgentWithRole/@rdf:nodeID)) &gt; 2">
          <xsl:text>, editors, </xsl:text>
        </xsl:when>
        <xsl:when test="count(key('tw:Editor-nodes',tw:hasAgentWithRole/@rdf:nodeID)) = 1">
          <xsl:text>, editor, </xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="tw:page">
          <a href="{tw:page/@rdf:resource}" rel="tw:page">
            <span about="{@rdf:about}" property="dc:title">
              <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
            </span>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <span property="dc:title">
            <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="event-name">
    <xsl:param name="event"/>
    <xsl:param name="root"/>
    <xsl:param name="traverse" select="true()"/>
    <span typeof="tw:Event" about="{$event/@rdf:about}">
      <span property="foaf:name">
	<xsl:value-of select="$event/foaf:name"/>
      </span>
      <xsl:if test="$event/tw:inEvent and $traverse=true()">
	<xsl:text> at </xsl:text>
	<span rel="tw:inEvent">
	<xsl:choose>
	  <xsl:when test="$event/tw:inEvent/@rdf:resource">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$root//*[@rdf:about=$event/tw:inEvent/@rdf:resource]"/>
	      <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="$event/tw:inEvent/@rdf:nodeID">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$root//*[@rdf:nodeID=$event/tw:inEvent/@rdf:nodeID]/*/.."/>
	      <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="$event/tw:inEvent/*">
	    <xsl:call-template name="event-name">
	      <xsl:with-param name="event" select="$event/tw:inEvent/*"/>
	    <xsl:with-param name="root" select="$root"/>
	    </xsl:call-template>
	  </xsl:when>
	</xsl:choose>
	</span>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template name="get-event-page">
    <xsl:param name="event"/>
    <xsl:choose>
      <xsl:when test="$event/tw:page/@rdf:resource">
	<xsl:value-of select="$event/tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:when test="$event/tw:page/*/@rdf:about">
	<xsl:value-of select="$event/tw:page/*/@rdf:about"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$event/@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
                mode="link">
    <xsl:param name="proceedings" select="false()"/>
    <xsl:param name="dateandlocation" select="false()"/>
    <xsl:variable name="page">
      <xsl:call-template name="get-event-page">
        <xsl:with-param name="event" select="current()"/>
      </xsl:call-template>
    </xsl:variable>
    <span about="{@rdf:about}" typeof="tw:Event">
      <a href="{$page}" rel="tw:page">
        <xsl:if test="$proceedings=true()">
	  <xsl:text>Proceedings of </xsl:text>
        </xsl:if>
        <xsl:call-template name="event-name">
          <xsl:with-param name="event" select="current()"/>
          <xsl:with-param name="root" select="/"/>
        </xsl:call-template>
      </a>
      <xsl:if test="$dateandlocation=true()">
	<xsl:if test="tw:hasDateTimeCoverage or tw:hasLocation">
	  <xsl:text> (</xsl:text>
	  <xsl:if test="tw:hasDateTimeCoverage">
	    <span rel="tw:hasDateTimeCoverage">
	      <xsl:apply-templates select="tw:hasDateTimeCoverage/*" mode="date-range"/>
	    </span>
	    <xsl:if test="tw:hasLocation">
	      <xsl:text>, </xsl:text>
	    </xsl:if>
	  </xsl:if>
	  <xsl:if test="tw:hasLocation">
	    <xsl:apply-templates select="." mode="location"/>
	  </xsl:if>
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="tw:Event|*[rdf:type/@rdf:resource='&tw;Event']"
		mode="location">
    <span about="{@rdf:about}" typeof="tw:Event">
      <span rel="tw:hasLocation">
        <span property="rdfs:label">
	  <xsl:copy-of select="tw:hasLocation/rdfs:label"/>
        </span>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="time:Instant|*[rdf:type/@rdf:resource='&time;Instant']"
                mode="year">
    <span typeof="time:Instant">
      <span property="time:inXSDDateTime"
            datatype="xsd:dateTime"
            content="{time:inXSDDateTime}">
        <xsl:value-of select="substring(time:inXSDDateTime,1,4)"/>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-citation-nested">
    <xsl:apply-templates select="." mode="aaai-authors">
      <xsl:with-param name="sep">,</xsl:with-param>
    </xsl:apply-templates>
    <!--
    <xsl:if test="not(name(.)='tw:BookChapter') and not(rdf:type/@rdf:resource='&tw;BookChapter')">
      <span rel="tw:hasDate">
        <xsl:apply-templates select="tw:hasDate/*" mode="year"/>
      </span>
      <xsl:text>. </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="tw:page">
	<a href="{tw:page/@rdf:resource}" rel="tw:page">
	  <span about="{@rdf:about}" property="dc:title">
	    <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
	  </span>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<span property="dc:title">
	  <xsl:value-of select="dc:title|foaf:name|rdfs:label"/>
	</span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>. </xsl:text>
    <xsl:choose>
      <xsl:when test="tw:inEvent">
	<xsl:text>In </xsl:text>
	<span rel="tw:inEvent">
	  <xsl:apply-templates select="key('tw:Event-nodes',tw:inEvent/*/@rdf:about|tw:inEvent/@rdf:resource)" mode="link">
	    <xsl:with-param name="proceedings" select="true()"/>
	    <xsl:with-param name="dateandlocation" select="true()"/>
	  </xsl:apply-templates>
	</span>
      </xsl:when>
      <xsl:when test="tw:inPublication">
        <xsl:choose>
          <xsl:when test="name(.)='tw:BookChapter' or rdf:type/@rdf:resource='&tw;BookChapter'">
            In <span rel="tw:inPublication"><xsl:apply-templates select="key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)" mode="subcitation"/></span>
          </xsl:when>
          <xsl:otherwise>
	    <i>
	      <span rel="tw:inPublication">
	        <xsl:apply-templates select="key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)" mode="link"/>
	      </span>
	    </i>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="tw:startPage">
	<xsl:text>, pages </xsl:text>
	<xsl:value-of select="tw:startPage"/>
	<xsl:text>&#8211;</xsl:text>
	<xsl:value-of select="tw:endPage"/>
	<xsl:text>. </xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:if test="tw:inEvent|tw:inDocument">
	  <xsl:text>. </xsl:text>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="name(.)='tw:BookChapter' or rdf:type/@rdf:resource='&tw;BookChapter'">
      <xsl:if test="tw:publishedBy|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy">
        <span rel="tw:publishedBy">
          <xsl:value-of select="tw:publishedBy/*/foaf:name|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy/*/foaf:name" />
        </span>
      </xsl:if>
      <xsl:if test="tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished">
        <xsl:text> </xsl:text>
        <span rel="tw:wherePublished">
          <xsl:value-of select="tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished" />
        </span>
      </xsl:if>
      <xsl:if test="tw:publishedBy|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:publishedBy|tw:wherePublished|key('tw:Journal-nodes',tw:inPublication/*/@rdf:about|tw:inPublication/@rdf:resource)/tw:wherePublished">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <span rel="tw:hasDate">
        <xsl:apply-templates select="tw:hasDate/*" mode="year"/>
      </span>
      <xsl:text>. </xsl:text>
      <xsl:if test="bibo:doi">
        <a href="https://dx.doi.org/{bibo:doi}" rel="bibo:doi"><xsl:value-of select="bibo:doi" /></a>
      </xsl:if>
    </xsl:if>
    -->
  </xsl:template>
  
  <xsl:template match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" mode="aaai-citation">
    <span about="{@rdf:about}" typeof="foaf:Document">
      <xsl:apply-templates select="current()" mode="aaai-citation-nested"/>
    </span>
  </xsl:template>

    <xsl:template name="author-publications">
	<xsl:param name="node"/>
	<xsl:param name="root" select="/"/>
	<xsl:variable name="authorships" select="key('tw:Author-nodes',$node/tw:hasRole/*/@rdf:nodeID|$node/tw:hasRole/@rdf:nodeID)" />
	<xsl:variable name="publications" select="key('tw:hasAgentWithRole-nodes',$authorships/@rdf:nodeID)/.." />
	<xsl:if test="count($publications)>0">
	    <div class="author-title">
		Publications
	    </div>
	    <div class="author-publications">
		<xsl:for-each select="$publications">
		    <xsl:sort select="tw:hasDate/*/time:inXSDDateTime" order="descending"/>
		    <xsl:apply-templates select="current()" mode="aaai-citation"/>
		</xsl:for-each>
	    </div>
	</xsl:if>
    </xsl:template>

    <xsl:template match="rdf:RDF">
	<xsl:call-template name="author-publications">
	    <xsl:with-param name="person" select="current()"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="/">
	<xsl:apply-templates select="rdf:RDF"/>
    </xsl:template>

</xsl:stylesheet>
