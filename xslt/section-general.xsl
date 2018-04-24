<?xml version="1.0"?>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
>
  <xsl:template name="header">
    <xsl:param name="text"/>
    <xsl:param name="stylesheet"/>
    <h3 class="header"><xsl:value-of select="$text"/>
      <span class="hidden">
	Move:
	<a href="#" onclick="moveSection('{$stylesheet}','top')">
	  <img src="/images/move-top.png" alt="top"/>
	</a>
	<a href="#" onclick="moveSection('{$stylesheet}','up')">
	  <img src="/images/move-up.png" alt="up"/>
	</a>
	<a href="#" onclick="moveSection('{$stylesheet}','down')">
	  <img src="/images/move-down.png" alt="down"/>
	</a>
	<a href="#" onclick="moveSection('{$stylesheet}','bottom')">
	  <img src="/images/move-bottom.png" alt="bottom"/>
	</a>
      </span>
    </h3>
  </xsl:template>
</xsl:stylesheet>
