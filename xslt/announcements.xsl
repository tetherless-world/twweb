<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://tw.rpi.edu/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
]>
<xsl:stylesheet 
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:tw="&tw;"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dc="http://purl.org/dc/terms/"
   xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="/xslt/announcement-list-item.xsl"/>

  <xsl:template match="/">
    <link href="/css/announcements.css" rel="stylesheet" type="text/css"/>
    <div class="announcements">
    <div class="right-align">
    <a class="ui-icon ui-icon-circle-triangle-n"><xsl:comment/></a> 
    <a class="ui-icon ui-icon-pause pause"><xsl:comment/></a>
    <a class="ui-icon ui-icon-circle-triangle-s"><xsl:comment/></a>
    </div>
    <!--
    <a class="grah"></a><a class="ui-icon ui-icon-circle-triangle-s grah"></a><a class="ui-icon ui-icon-play grah"></a>
    -->
    <div class="scrollable announcement-list">
      <div class="items">
	<xsl:for-each select="//tw:Announcement|//*[rdf:type/@rdf:resource='&tw;Announcement']">
	  <xsl:sort select="tw:hasAnnouncementDate/*/time:inXSDDateTime" order="descending"/>
	  <xsl:if test="position()&lt;6">
	    <xsl:call-template name="announcement-list-item">
	      <xsl:with-param name="embed" select="true()"/>
	      <xsl:with-param name="node" select="current()"/>
	      <xsl:with-param name="root" select="/"/>
	      <xsl:with-param name="use_description" select="false()"/>
	    </xsl:call-template>
	  </xsl:if>
	</xsl:for-each>
      </div>
    </div>
    <script type="text/javascript">
      $(function() { $(".scrollable").scrollable({'circular':true,'vertical':true}).autoscroll(3500); });
      $(function() {
        var pause = function(e) { 
          var api = $(".scrollable").data("scrollable");
          $(this).toggleClass("ui-icon-pause").toggleClass("ui-icon-play");
          $(this).hasClass("ui-icon-pause") ? api.play() : api.stop();
        };
        $(".announcements .ui-icon-pause").click(pause);
        $(".announcements .ui-icon-circle-triangle-s").click(function(e) {
          var btn = $(".announcements .pause");
          if(btn.hasClass("ui-icon-pause")) {
            pause.call(btn, e);
          }
          $(".scrollable").data("scrollable").next();
        });
        $(".announcements .ui-icon-circle-triangle-n").click(function(e) {
          var btn = $(".announcements .pause");
          if(btn.hasClass("ui-icon-pause")) {
            pause.call(btn, e);
          }
          $(".scrollable").data("scrollable").prev();
        });
      });
    </script>
    </div>
  </xsl:template>
  
</xsl:stylesheet>


   
