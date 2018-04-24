<?php

function incxslt($str) {
  echo "  <xsl:import href=\"/xslt/$str.xsl\"/>\n";
}

header("Content-Type: text/xsl");

$referer = $_GET["r"];
if($referer==NULL) $referer=$_SERVER["HTTP_REFERER"];

$header="true";
if($_GET["header"]=="false") $header="false";
$template = "section-".str_replace(".xsl","",$_GET["q"]);

if($_GET["q"]==NULL||$_GET["q"]=="empty.xsl") {
  readfile("empty.xsl");
  echo "</xsl:stylesheet>\n";
}
else {
  readfile("empty.xsl");
  incxslt($_GET["q"]);
  echo "  <xsl:template match=\"/\">\n";
  echo "    <xsl:variable name=\"header\" select=\"$header()\"/>\n";
  echo "    <xsl:variable name=\"root\" select=\"/\"/>\n";
  echo "    <div>\n";

  echo "    <xsl:for-each select=\"//*[@rdf:about='$referer']\">\n";
  echo "      <xsl:call-template name=\"$template\">\n";
  echo "        <xsl:with-param name=\"header\" select=\"\$header\"/>\n";
  echo "        <xsl:with-param name=\"admin\" select=\"false()\"/>\n";
  echo "        <xsl:with-param name=\"embed\" select=\"true()\"/>\n";
  echo "        <xsl:with-param name=\"node\" select=\"current()\"/>\n";
  echo "        <xsl:with-param name=\"root\" select=\"\$root\"/>\n";
  echo "      </xsl:call-template>\n";
  echo "    </xsl:for-each>\n";

  echo "    </div>\n";
  echo "  </xsl:template>\n";
  echo "</xsl:stylesheet>\n";
}
?>
