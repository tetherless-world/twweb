<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:tw="&tw;"
		xmlns:exsl="http://exslt.org/common"
		xmlns:foaf="&foaf;"
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/course-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>

  <xsl:output indent="yes"/>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']"
		mode="list-item">
    <xsl:param name="root" select="/"/>
    <xsl:param name="class"/>
    <tr>
      <xsl:if test="$class!=''">
	<xsl:attribute name="class">
	  <xsl:value-of select="$class"/>
	</xsl:attribute>
      </xsl:if>
      <td about="{@rdf:about}" type="tw:Course">
        <div about="{@rdf:about}" typeof="tw:Course">

	<h4>
	  <xsl:apply-templates select="current()" mode="place-link"/>
	</h4>

	<span rel="tw:hasAgentWithRole">
	<xsl:variable name="professors">
	  <xsl:call-template name="get-course-profs">
	    <xsl:with-param name="course" select="current()"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:for-each select="exsl:node-set($professors)/*">
	  <xsl:sort select="tw:index"/>
	  <xsl:value-of select="tw:index"/>
	  <xsl:if test="position()=1">
	    <span class="title">Professors: </span>
	  </xsl:if>
	  <span typeof="tw:Faculty" rev="tw:hasRole">
	    <xsl:call-template name="place-person-link">
	      <xsl:with-param name="person" select="current()"/>
	      <xsl:with-param name="style">full</xsl:with-param>
	      <xsl:with-param name="rdfa" select="true()"/>
	    </xsl:call-template>
	    <xsl:choose>
	      <xsl:when test="last()&gt;2 and position()&lt;last()-1">
		<xsl:text>, </xsl:text>
	      </xsl:when>
	      <xsl:when test="last()&gt;2 and position()=last()-1">
		<xsl:text>, and </xsl:text>
	      </xsl:when>
	      <xsl:when test="last()=2 and position()=1">
		<xsl:text> and </xsl:text>
	      </xsl:when>
	    </xsl:choose>
	  </span>
	</xsl:for-each>
	</span>

	<br/>

	<xsl:apply-templates select="current()" mode="topics">
	  <xsl:with-param name="root" select="$root"/>
	</xsl:apply-templates>

        <br/>

	<xsl:if test="tw:hasShortDescription|dc:description">
	  <span class="title">Description: </span>
	  <span property="dc:description">
	  <xsl:apply-templates select="current()"
			       mode="short-description"/>
	  </span>
	  <br />
	</xsl:if>

	<xsl:if test="tw:hasCourseGoal">
	  <span class="title">Goals: </span>
	  <span property="tw:hasCourseGoal">
	  <xsl:apply-templates select="current()"
			       mode="course-goal"/>
	  </span>
	</xsl:if>
      </div>
    </td></tr>
  </xsl:template>

</xsl:stylesheet>
