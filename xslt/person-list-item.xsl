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
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="&foaf;"
   xmlns:exsl="http://exslt.org/common"
   xmlns="http://www.w3.org/1999/xhtml">
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:template name="person-list-item">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="url">
      <xsl:call-template name="get-person-page">
	<xsl:with-param name="person" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="name">
      <xsl:call-template name="get-person-name">
	<xsl:with-param name="person" select="$node"/>
	<xsl:with-param name="style">full</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <tr class="person-list-item" about="{$node/@rdf:about}">
      <td class="center">
	<xsl:variable name="image-raw">
	  <xsl:call-template name="get-person-depiction">
	    <xsl:with-param name="person" select="$node"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
	<a rel="foaf:depiction" href="{$url}">
	  <xsl:choose>
	    <xsl:when test="$image-raw!=''">
	      <xsl:call-template name="place-image">
		<xsl:with-param name="image" select="$image"/>
		<xsl:with-param name="class">thumb</xsl:with-param>
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <img class="thumb" src="https://tw.rpi.edu/img_avtrs/Unknown_AVTR.jpg"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</a>
      </td>
      <td>
	<a rel="tw:page" href="{$url}">
	  <span property="foaf:name"><xsl:value-of select="$name"/></span>
	</a>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
