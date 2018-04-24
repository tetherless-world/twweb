<?php
header("Content-Type: text/xml");
$type = $_GET["type"];

$referer = $_GET["r"];
if($referer==null) $referer = $_SERVER["HTTP_REFERER"]; 

readfile("empty.xsl");
?>
   <xsl:include href="/xslt/section-general.xsl"/>
   <xsl:include href="/xslt/<?=$type?>.xsl"/>
   <xsl:template match="rdf:RDF">
     <xsl:param name="admin"/>
     <xsl:param name="embed"/>
     <xsl:param name="uri"/>
     <xsl:variable name="node" select="//*[@rdf:about=$uri]"/>
     <xsl:call-template name="<?=$type?>">
       <xsl:with-param name="admin" select="$admin"/>
       <xsl:with-param name="embed" select="$embed"/>
       <xsl:with-param name="node" select="$node"/>
       <xsl:with-param name="rel">tw:hasAuthor</xsl:with-param>
     </xsl:call-template>
   </xsl:template>
   <xsl:template match="/">
     <div xmlns="http://www.w3.org/1999/xhtml">
       <xsl:apply-templates select="rdf:RDF">
	 <xsl:with-param name="admin" select="false()"/>
	 <xsl:with-param name="embed" select="true()"/>
	 <xsl:with-param name="uri"><?=$referer?></xsl:with-param>
       </xsl:apply-templates>
     </div>
   </xsl:template>
</xsl:stylesheet>
