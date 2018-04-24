<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tw "http://leo.tw.rpi.edu/projects/webdeb/schema/">
  <!ENTITY here "http://tw.rpi.edu/instances/">
  <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
  <!ENTITY bcodmo "http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/">
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
   xmlns:bcodmo="http://escience.rpi.edu/ontology/BCO-DMO/bcodmo/3/0/"
   xmlns="http://www.w3.org/1999/xhtml">

   <xsl:include href="/xslt/bcodmo/bcodmo-header.xsl"/>

<xsl:key name="triples"
		match="*[@rdf:about]"
		use="@rdf:about"/>

<xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;DeploymentDatasetCollection']" mode="list-item">
	<li>
		<a href="/web/project/BCO-DMO/InstanceViz/dataset?uri={@rdf:about}">
			<xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
		</a>
	</li>
</xsl:template>

<xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;Deployment']" mode="list-item">
	<li>
		<a href="/web/project/BCO-DMO/InstanceViz/deployment?uri={@rdf:about}">
			<xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
		</a>
	</li>
</xsl:template>

<xsl:template match="rdf:Description[rdf:type/@rdf:resource='&bcodmo;Instrument']" mode="list-item">
 		<h2> 
		<xsl:value-of select="key('triples',@rdf:about)/rdfs:label"/>
		</h2>
		<br/>
		<xsl:if test="key('triples',@rdf:about)/bcodmo:hasAcronym">
              	Acronym:	
                       <xsl:value-of select="key('triples',@rdf:about)/bcodmo:hasAcronym"/>
                 <br/>
                </xsl:if>
		Osprey Site:
			<a href="{key('triples',@rdf:about)/bcodmo:osprey_page/@rdf:resource}">
				URL
			</a>
		<br/>
		<br/>
		<a href="#" onMouseDown="toggleDiv('description','descriptionArrow');"><img src="http://osprey.bcodmo.org/images/right-arrow.gif" id="descriptionArrow" width="9" height="9" /></a>     
		<a href="javascript:;" onmousedown="toggleDiv('description','descriptionArrow');"> Description</a>
		<br></br>
		<div id="description" style="display:none">	
			<xsl:value-of select="key('triples',@rdf:about)/dc:description" disable-output-escaping="yes"/>
		</div>
		<br></br><hr/>
</xsl:template>

<xsl:template match="/">
	<script language="javascript">
		function toggleDiv(divid,imgId){
	   		 if(document.getElementById(divid).style.display == 'none'){
	     			document.getElementById(divid).style.display = 'block';
	      			document.getElementById(imgId).src = "http://osprey.bcodmo.org/images/down-arrow.gif";
	  		  }else{
	   			 document.getElementById(divid).style.display = 'none';
	    			 document.getElementById(imgId).src = "http://osprey.bcodmo.org/images/right-arrow.gif";
	  	  }
	  	}
	</script>
	<xsl:apply-templates select="/" mode="header"/>
	<tr>
	       <xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Instrument']" mode="list-item"/>
		<br/>
		Additional Information about this Instrument
		<br/>
		<a href="#" onMouseDown="toggleDiv('deployment','deploymentArrow');"><img src="http://osprey.bcodmo.org/images/right-arrow.gif" id="deploymentArrow" width="9" height="9" /></a>     
		<a href="javascript:;" onmousedown="toggleDiv('deployment','deploymentArrow');"> Deployments</a>
		<br/>
		<div id="deployment" style="display:none">
			<xsl:choose>
				<xsl:when test="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Deployment']">
					<ul>
						<xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;Deployment']" mode="list-item"/>
					</ul>
				</xsl:when>
				<xsl:otherwise>
					none available yet
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<a href="#" onMouseDown="toggleDiv('dataset','datasetArrow');"><img src="http://osprey.bcodmo.org/images/right-arrow.gif" id="datasetArrow" width="9" height="9" /></a>     
		<a href="javascript:;" onmousedown="toggleDiv('dataset','datasetArrow');"> Datasets Associated with this Instrument</a>
		<br/>
		<div id="dataset" style="display:none">
			<xsl:choose>
				<xsl:when test="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;DeploymentDatasetCollection']">	
					<ul>
						<xsl:apply-templates select="rdf:RDF//*[rdf:type/@rdf:resource='&bcodmo;DeploymentDatasetCollection']" mode="list-item"/>
					</ul>
				</xsl:when>
				<xsl:otherwise>
					none available yet
				</xsl:otherwise>
			</xsl:choose>
		</div>
   	</tr>
</xsl:template>
  
</xsl:stylesheet>
