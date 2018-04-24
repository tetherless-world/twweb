<?php
header("Content-Type: text/xsl");

$referer = $_GET["r"];
if($referer==null) $referer = $_SERVER["HTTP_REFERER"]; 

function incxslt($str) {
  echo "  <xsl:import href=\"/xslt/$str\"/>\n";
}

function call($str) {
  echo "    <xsl:call-template name=\"$str\">\n";
  echo "      <xsl:with-param name=\"admin\" select=\"\$admin\"/>\n";
  echo "      <xsl:with-param name=\"node\" select=\"current()\"/>\n";
  echo "      <xsl:with-param name=\"embed\" select=\"\$embed\"/>\n";
  echo "    </xsl:call-template>\n";
}

$embed = false;

if($_GET["q"]==null||$_GET["q"]=="empty.xsl") {
  readfile("empty.xsl");
  echo "  <xsl:text>".$_GET['q']."</xsl:text>\n";
  echo "</xsl:stylesheet>";
}
else if($_GET["q"]!=null) {
  $template = substr($_GET["q"],0,strlen($_GET["q"])-4);
  readfile("empty.xsl");
  incxslt($_GET["q"]);
  echo "  <xsl:template match=\"*[@rdf:about='$referer']\" mode=\"default\">\n";
  echo "    <xsl:param name=\"admin\"/>\n";
  echo "    <xsl:param name=\"embed\"/>\n";
  echo "    <xsl:param name=\"uri\"/>\n";
  echo "    <div about=\"{\$uri}\">\n";
  echo "      <link href=\"/css/objects.css\" rel=\"stylesheet\" type=\"text/css\"/>\n";
  call($template);
  echo "    </div>\n";
  echo "  </xsl:template>\n";
  $embed = true;
}
if(0==preg_match("/.*-embed.xsl$/",$_GET["q"])&&!$embed) {
?>
  <xsl:template match="/">
    <xsl:variable name="admin" select="false()"/>
    <html xmlns="http://www.w3.org/1999/xhtml"
	  xmlns:time="http://www.w3.org/2006/time#"
	  xmlns:tw="http://tw.rpi.edu/schema/">
      <body class="twqueryresult <?php echo $class; ?>">
	<link type="text/css" href="/css/objects.css" rel="stylesheet"/>
        <script type="text/javascript" src="/js/layout.js"></script>
	<xsl:apply-templates>
	  <xsl:with-param name="admin" select="$admin"/>
	  <xsl:with-param name="uri"><?php echo $referer; ?></xsl:with-param>
	  <xsl:with-param name="embed" select="false()"/>
	</xsl:apply-templates>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="uri"/>
    <xsl:param name="embed"/>
<?php
  }
  else {
?>
  <xsl:template match="/">
    <xsl:variable name="admin" select="false()"/>
      <div class="twqueryresult <?php echo "";/*$class;*/ ?>" about="<?=$referer?>">
      <link rel="stylesheet" type="text/css" href="/css/objects.css"/>
      <script type="text/javascript" src="/js/layout.js"><xsl:comment/></script>
      <xsl:apply-templates>
	<xsl:with-param name="admin" select="$admin"/>
	<xsl:with-param name="uri"><?php echo $referer; ?></xsl:with-param>
	<xsl:with-param name="embed" select="true()"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
  <xsl:template match="rdf:RDF">
    <xsl:param name="admin"/>
    <xsl:param name="uri"/>
    <xsl:param name="embed"/>
<?php
 }
   echo "    <xsl:apply-templates select=\"//*[@rdf:about=\$uri]\" mode=\"default\">\n";
   echo "      <xsl:with-param name=\"admin\" select=\"\$admin\"/>\n";
   echo "      <xsl:with-param name=\"embed\" select=\"\$embed\"/>\n";
   echo "      <xsl:with-param name=\"uri\" select=\"\$uri\"/>\n";
   echo "    </xsl:apply-templates>\n";
?>
  </xsl:template>
</xsl:stylesheet>

