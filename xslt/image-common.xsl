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
  xmlns:foaf="&foaf;" 
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:key name="foaf:Image-nodes" match="foaf:Image|*[rdf:type/@rdf:resource='&foaf;Image']" use="@rdf:about"/>
  <xsl:template match="foaf:logo|foaf:depiction" mode="place-image">
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
  <!-- Retrieves the url for the specified image.

       Templates should call this template instead of expecting a particular
       DOM tree to be present -->
  <xsl:template name="image-url">
    <xsl:param name="image"/>
    <xsl:value-of select="$image/@rdf:about"/>
  </xsl:template>
  <!-- Tries to find an appropriate alternate title for an <img> tag.
       
       Templates should call this template instead of expecting a particular
       DOM tree to be present -->
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
  <!-- Places an image tag in the current output stream. Calling template can 
       specify image object and style/class information for CSS integration -->
  <xsl:template name="place-image">
    <xsl:param name="image"/>
    <xsl:param name="name"/>
    <xsl:param name="style"/>
    <xsl:param name="class"/>
    <xsl:param name="call-image-url-template" select="true()"/>
    <xsl:param name="rel" select="false()"/>
    <xsl:param name="rev" select="false()"/>
    <xsl:variable name="url">
      <xsl:call-template name="image-url">
        <xsl:with-param name="image" select="$image"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="title">
      <xsl:call-template name="image-title">
        <xsl:with-param name="image" select="$image"/>
      </xsl:call-template>
    </xsl:variable>
    <img src="{$url}">
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
      <xsl:choose>
        <xsl:when test="$name">
          <xsl:attribute name="alt">
            <xsl:value-of select="$name"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="alt">
            <xsl:value-of select="$title"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </img>
  </xsl:template>
</xsl:stylesheet>