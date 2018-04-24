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
		xmlns:dc="http://purl.org/dc/terms/"
		xmlns:ical="http://www.w3.org/2002/12/cal/ical#"
		xmlns:exsl="http://exslt.org/common"
		xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:import href="/xslt/document-common.xsl"/>
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/concept-common.xsl"/>

  <xsl:key name="foaf:Document-nodes" match="foaf:Document|*[rdf:type/@rdf:resource='&foaf;Document']" use="@rdf:about"/>
  <xsl:key name="tw:Course-nodes" match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']" use="@rdf:about"/>
  <xsl:key name="tw:Faculty-nodes" match="tw:Faculty|*[rdf:type/@rdf:resource='&tw;Faculty']" use="@rdf:nodeID"/>
  <xsl:key name="tw:hasRole-nodes" match="tw:hasRole" use="@rdf:nodeID|*/@rdf:nodeID"/>
  <xsl:key name="tw:TeachingAssistant-nodes" match="tw:TeachingAssistant|*[rdf:type/@rdf:resource='&tw;TeachingAssistant']" use="@rdf:nodeID"/>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']" mode="topics">
    <xsl:param name="root" select="/"/>
    <xsl:if test="tw:hasTopic">
      <span class="title">Topics: </span>
      <xsl:for-each select="tw:hasTopic">
        <xsl:variable name="topic-uris-raw">
          <xsl:choose>
	    <xsl:when test="@rdf:resource">
	      <uri><xsl:value-of select="@rdf:resource"/></uri>
	    </xsl:when>
	    <xsl:when test="@rdf:nodeID">
	      <nodeID><xsl:value-of select="@rdf:nodeID"/></nodeID>
	    </xsl:when>
	    <xsl:when test="*/@rdf:about">
	      <uri><xsl:value-of select="*/@rdf:about"/></uri>
	    </xsl:when>
	    <xsl:when test="*/@rdf:nodeID">
	      <nodeID><xsl:value-of select="*/@rdf:nodeID"/></nodeID>
	    </xsl:when>
          </xsl:choose>
	</xsl:variable>
	<span rel="tw:hasTopic">
	<xsl:apply-templates select="$root//*[@rdf:about=$topic-uris-raw]"
			     mode="place-link"/>
	</span>
	<xsl:if test="position()!=last()">
	  <xsl:text>, </xsl:text>
	</xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="long-description">
    <xsl:choose>
      <xsl:when test="current()/dc:description/*">
        <xsl:copy-of select="current()/dc:description/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="current()/dc:description"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="course-goal">
    <xsl:choose>
      <xsl:when test="tw:hasCourseGoal">
	<xsl:copy-of select="tw:hasCourseGoal/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="course-objective">
    <xsl:choose>
      <xsl:when test="tw:hasLearningObjective">
	<xsl:copy-of select="tw:hasLearningObjective/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="course-academicIntegrity">
    <xsl:choose>
      <xsl:when test="tw:hasAcademicIntegrity">
	<xsl:copy-of select="tw:hasAcademicIntegrity/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="course-assessmentCriteria">
    <xsl:choose>
      <xsl:when test="tw:hasAssessmentCriteria">
	<xsl:copy-of select="tw:hasAssessmentCriteria/*"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="short-description">
    <xsl:choose>
      <xsl:when test="tw:hasShortDescription">
	<xsl:copy-of select="tw:hasShortDescription/*"/>
      </xsl:when>
      <xsl:when test="dc:description">
	<xsl:variable name="description">
	  <xsl:value-of select="dc:description"/>
	</xsl:variable>
	<xsl:choose>
	  <xsl:when test="contains($description,'.')">
	    <xsl:value-of select="concat(substring-before($description,'.'),'.')"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="concat($description,'.')"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']" mode="place-syllabus-link">
    <xsl:param name="root" select="/"/>
    <xsl:choose>
      <xsl:when test="tw:hasSyllabus">
	<a href="{tw:hasSyllabus/@rdf:resource|tw:hasSyllabus/*/@rdf:about}" rel="tw:hasSyllabus">
	  <xsl:variable name="title">
	    <xsl:apply-templates select="key('foaf:Document-nodes',tw:hasSyllabus/@rdf:resource|tw:hasSyllabus/*/@rdf:about)" mode="title"/>
	  </xsl:variable>
	  <xsl:choose>
	    <xsl:when test="$title!=''">
	      <span about="{tw:hasSyllabus/@rdf:resource|tw:hasSyllabus/*/@rdf:about}" property="dc:title">
		<xsl:value-of select="$title"/>
	      </span>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="tw:hasSyllabus/@rdf:resource|tw:hasSyllabus/*/@rdf:about"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>No Syllabus Provided</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']|tw:Concept|*[rdf:type/@rdf:resource='&tw;Concept']"
		mode="name">
    <xsl:choose>
      <xsl:when test="ical:summary">
	<xsl:value-of select="ical:summary"/>
      </xsl:when>
      <xsl:when test="dc:title">
	<xsl:value-of select="dc:title"/>
      </xsl:when>
      <xsl:when test="foaf:name">
	<xsl:value-of select="foaf:name"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']|tw:Concept|*[rdf:type/@rdf:resource='&tw;Concept']"
		mode="page">
    <xsl:choose>
      <xsl:when test="tw:page">
	<xsl:value-of select="tw:page/@rdf:resource"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="@rdf:about"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']"
		mode="homepage">
    <xsl:if test="foaf:homepage">
      <xsl:value-of select="foaf:homepage/@rdf:resource"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']|tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']|tw:Concept|*[rdf:type/@rdf:resource='&tw;Concept']"
		mode="place-link">
    <xsl:param name="rel"/>
    <a>
      <xsl:attribute name="href">
	<xsl:apply-templates select="current()" mode="page"/>
      </xsl:attribute>
      <xsl:if test="$rel!=''">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
      <span about="{@rdf:about}" property="foaf:name">
	<xsl:apply-templates select="current()" mode="name"/>
      </span>
    </a>
  </xsl:template>

  <xsl:template name="get-course-profs">
    <xsl:param name="course"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="key('tw:Faculty-nodes',$course/tw:hasAgentWithRole/@rdf:nodeID)|key('tw:Faculty-nodes',$course/tw:hasAgentWithRole/*/@rdf:nodeID)">
	<xsl:sort select="tw:index" data-type="number"/>
        <xsl:for-each select="key('tw:hasRole-nodes',@rdf:nodeID)">
	  <xsl:copy-of select=".."/>
        </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tw:CourseClass|*[rdf:type/@rdf:resource='&tw;CourseClass']" mode="professor">
    <xsl:for-each select="key('tw:Faculty-nodes',tw:hasAgentWithRole/@rdf:nodeID|tw:hasAgentWithRole/*/@rdf:nodeID)">
      <xsl:if test="current()/@rdf:nodeID">
	<xsl:variable name="prof" select="key('tw:hasRole-nodes',current()/@rdf:nodeID)/.."/>
	<uri><xsl:value-of select="$prof/@rdf:about"/></uri>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="get-course-tas">
    <xsl:param name="course"/>
    <xsl:param name="root" select="/"/>
    <xsl:for-each select="key('tw:TeachingAssistant-nodes',$course/tw:hasAgentWithRole/@rdf:nodeID)|key('tw:TeachingAssistant-nodes',$course/tw:hasAgentWithRole/*/@rdf:nodeID)">
	<xsl:sort select="tw:index" data-type="number"/>
        <xsl:for-each select="key('tw:hasRole-nodes',@rdf:nodeID)">
	  <xsl:copy-of select=".."/>
        </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tw:Course|*[rdf:type/@rdf:resource='&tw;Course']"
		mode="teaching-assistant">
    <xsl:for-each select="key('tw:TeachingAssistant-nodes',tw:hasAgentWithRole/@rdf:nodeID|tw:hasAgentWithRole/*/@rdf:nodeID)">
      <xsl:if test="current()/@rdf:nodeID">
	<xsl:variable name="prof" select="key('tw:hasRole-nodes',current()/@rdf:nodeID)/.."/>
	<uri><xsl:value-of select="$prof/@rdf:about"/></uri>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
