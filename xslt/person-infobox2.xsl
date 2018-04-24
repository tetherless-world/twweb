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
  <xsl:import href="/xslt/person-common.xsl"/>
  <xsl:import href="/xslt/image-common.xsl"/>
  <xsl:template name="person-infobox2">
    <xsl:param name="admin"/>
    <xsl:param name="node"/>
    <xsl:param name="embed"/>
    <xsl:param name="root" select="/"/>

      <link href="/css/person.css" type="text/css" rel="stylesheet"/>
      <xsl:variable name="image-raw">
	<xsl:call-template name="get-person-depiction">
	  <xsl:with-param name="person" select="$node"/>
	  <xsl:with-param name="root" select="$root"/>
	</xsl:call-template>
      </xsl:variable>
      <xsl:variable name="image" select="exsl:node-set($image-raw)/*"/>
	<!--<tr><td colspan="2" class="header"><xsl:call-template name="get-person-name"><xsl:with-param name="person" select="$node"/><xsl:with-param name="style">full</xsl:with-param></xsl:call-template><xsl:if test="$admin=true()">(<a href="">Edit</a>)</xsl:if></td></tr>
	-->
	<tr><td colspan="2" class="header"><xsl:apply-templates select="$node" mode="place-link"/><xsl:if test="$admin=true()">(<a href="">Edit</a>)</xsl:if></td></tr>
	<xsl:if test="$image-raw!=''">
	  <tr><td colspan="2" class="img"><xsl:call-template name="place-image"><xsl:with-param name="image" select="$image"/></xsl:call-template></td></tr>
	</xsl:if>
	<xsl:variable name="email-addrs-raw">
	  <xsl:call-template name="get-person-email-address">
	    <xsl:with-param name="person" select="$node"/>
	    <xsl:with-param name="root" select="$root"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="email-addrs" select="exsl:node-set($email-addrs-raw)"/>
	<xsl:variable name="homepage-raw">
	  <xsl:call-template name="get-person-homepage">
	    <xsl:with-param name="person" select="$node"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="homepage" select="exsl:node-set($homepage-raw)"/>

	<xsl:variable name="seeAlso-raw">
	  <xsl:call-template name="get-person-seeAlso">
	    <xsl:with-param name="person" select="$node"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="seeAlso" select="exsl:node-set($seeAlso-raw)"/>

	<xsl:variable name="workplace-homepage-raw">
	  <xsl:call-template name="get-person-workplace-homepage">
	    <xsl:with-param name="person" select="$node"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="workplace-homepage" select="exsl:node-set($workplace-homepage-raw)"/>
	<xsl:variable name="school-homepage-raw">
	  <xsl:call-template name="get-person-school-homepage">
	    <xsl:with-param name="person" select="$node"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="school-homepage" select="exsl:node-set($school-homepage-raw)"/>
	<xsl:variable name="weblog-page-raw">
	  <xsl:call-template name="get-person-weblog">
	    <xsl:with-param name="person" select="$node"/>
	  </xsl:call-template>
	</xsl:variable>
	<xsl:variable name="weblog-page" select="exsl:node-set($weblog-page-raw)"/>
	<xsl:if test="$email-addrs-raw!='' or $email-addrs/*">
	  <tr><td colspan="2" class="section">Contact Info</td></tr>
	  <xsl:if test="$email-addrs-raw!='' or $email-addrs/*">
	    <xsl:for-each select="$email-addrs/*">
	      <tr>
		<xsl:if test="position()=1">
		<td rowspan="{count($email-addrs/*)}">Email</td>
		</xsl:if>
		<td><a href="{@rdf:about}" rel="foaf:mbox">
		    <xsl:choose>
		      <xsl:when test="contains(@rdf:about,'mailto:')">
			<xsl:value-of select="substring-after(@rdf:about,'mailto:')"/>
		      </xsl:when>
		      <xsl:otherwise>
			<xsl:value-of select="@rdf:about"/>
		      </xsl:otherwise>
		    </xsl:choose>
		</a></td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	</xsl:if>
	<xsl:if test="$homepage-raw!='' or $workplace-homepage-raw!='' or $school-homepage-raw!='' or $weblog-page-raw!='' or $homepage/* or $workplace-homepage/* or $school-homepage/* or $weblog-page/* or $seeAlso-raw!='' or $seeAlso/*">
	  <tr><td colspan="2" class="section">On the Web</td></tr>
	  <xsl:if test="$homepage-raw!='' or $homepage/*">
	    <xsl:for-each select="$homepage/*">
	      <tr>
		<xsl:if test="position()=1">
		  <td rowspan="{count($homepage/*)}"> </td>
		</xsl:if>
		<td>
		  <a href="{@rdf:about}" rel="foaf:homepage">Homepage</a>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	  <xsl:if test="$workplace-homepage-raw!='' or $workplace-homepage/*">
	    <xsl:for-each select="$workplace-homepage/*">
	      <tr>
		<xsl:if test="position()=1">
		  <td rowspan="{count($workplace-homepage/*)}"> </td>
		</xsl:if>
		<td>
		  <a href="{@rdf:about}">Workplace Homepage</a>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	  <xsl:if test="$school-homepage-raw!='' or $school-homepage/*">
	    <xsl:for-each select="$school-homepage/*">
	      <tr>
		<xsl:if test="position()=1">
		  <td rowspan="{count($school-homepage/*)}">School<br/>Homepage</td>
		</xsl:if>
		<td>
		  <a href="{@rdf:about}">
		    <xsl:value-of select="@rdf:about"/>
		  </a>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	  <xsl:if test="$weblog-page-raw!='' or $weblog-page/*">
	    <xsl:for-each select="$weblog-page/*">
	      <tr>
		<xsl:if test="position()=1">
		  <td rowspan="{count($weblog-page/*)}"> </td>
		</xsl:if>
		<td>
		  <a href="{@rdf:about}">Blog</a>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	  <xsl:if test="$seeAlso-raw!='' or $seeAlso/*">
	    <xsl:for-each select="$seeAlso/*">
	      <tr>
		<xsl:if test="position()=1">
		  <td rowspan="{count($seeAlso/*)}"> </td>
		</xsl:if>
		<td>
		  <a href="{@rdf:about}" rel="rdfs:seeAlso">See Also</a>
		</td>
	      </tr>
	    </xsl:for-each>
	  </xsl:if>
	</xsl:if>
  </xsl:template>
</xsl:stylesheet>
