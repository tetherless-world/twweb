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
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:exsl="http://exslt.org/common"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:key name="foaf:Image-nodes"
	   match="foaf:Image|*[rdf:type/@rdf:resource='&foaf;Image']"
	   use="@rdf:about"/>

  <xsl:template name="image-url">
    <xsl:param name="image"/>
    <xsl:value-of select="$image/@rdf:about"/>
  </xsl:template>

  <xsl:template name="image-title">
    <xsl:param name="image"/>
    <xsl:choose>
      <xsl:when test="$image/foaf:name">
	<xsl:value-of select="$image/foaf:name"/>
      </xsl:when>
      <xsl:when test="$image/rdfs:label">
	<xsl:value-of select="$image/rdfs:label"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="place-image">
    <xsl:param name="image"/>
    <xsl:param name="style"/>
    <xsl:param name="class"/>
    <xsl:param name="call-image-url-template" select="true()"/>
    <xsl:param name="rel" select="false()"/>
    <xsl:param name="rev" select="false()"/>

    <xsl:variable name="url"><xsl:call-template name="image-url"><xsl:with-param name="image" select="$image"/></xsl:call-template></xsl:variable>
    <xsl:variable name="title"><xsl:call-template name="image-title"><xsl:with-param name="image" select="$image"/></xsl:call-template></xsl:variable>
    
    <img src="{$url}" alt="{$title}">
      <xsl:if test="$rel!=false()">
	<xsl:attribute name="rel">
	  <xsl:value-of select="$rel"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="$rev!=false()">
	<xsl:attribute name="rev">
	  <xsl:value-of select="$rev"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="$class">
	<xsl:attribute name="class">
	  <xsl:value-of select="$class"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="$style">
	<xsl:attribute name="style">
	  <xsl:value-of select="$style"/>
	</xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <xsl:template match="foaf:logo|foaf:depiction"
		mode="place-image">
    <xsl:param name="style"/>
    <xsl:param name="class"/>
    <xsl:param name="rel" select="false()"/>
    <xsl:param name="rev" select="false()"/>
    <xsl:call-template name="place-image">
      <xsl:with-param name="image" select="key('foaf:Image-nodes',@rdf:resource)|key('foaf:Image-nodes',*/@rdf:about)"/>
      <xsl:with-param name="rel" select="$rel"/>
      <xsl:with-param name="rev" select="$rev"/>
      <xsl:with-param name="style" select="$style"/>
      <xsl:with-param name="class" select="$class"/>
    </xsl:call-template>
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

  <xsl:template name="person-image">
    <xsl:param name="node"/>
    <xsl:param name="root" select="/"/>
    <xsl:variable name="image-raw">
      <xsl:call-template name="get-person-depiction">
        <xsl:with-param name="person" select="$node"/>
        <xsl:with-param name="root" select="$root"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
    <xsl:copy-of select="$image"/>
    <xsl:if test="$image-raw!=''">
      <xsl:call-template name="place-image"><xsl:with-param name="image" select="$image"/></xsl:call-template>
    </xsl:if>
  </xsl:template>

    <xsl:template match="rdf:RDF">
	<xsl:if test="current()/foaf:Person|current()//*[rdf:type/@rdf:resource='&foaf;Person']">
	    <xsl:call-template name="person-image">
		<xsl:with-param name="node" select="current()/foaf:Person|current()//*[rdf:type/@rdf:resource='&foaf;Person']"/>
	    </xsl:call-template>
	</xsl:if>
    </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="rdf:RDF"/>
  </xsl:template>

</xsl:stylesheet>
