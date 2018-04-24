
function getXMLHttp() {
    var xhttp=null;
    if(window.XMLHttpRequest) {
	xhttp=new XMLHttpRequest();
    }
    else {
	xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    if(xhttp==null) {
	alert("Your browser does not support XML HTTP Requests.");
	return  null;
    }
    return xhttp;
}


window.sparqlResults = [];

function loadXMLDoc(dname, body, callback) {
    var xmlhttp = getXMLHttp();
    if(xmlhttp==null) return;
    if(body==null) {
	xmlhttp.open("GET",dname,true);
	xmlhttp.onreadystatechange = function() {
	    if(xmlhttp.readyState==4 && xmlhttp.status==200) {
		callback(xmlhttp.responseText);
	    }
	    else if(xmlhttp.readyState==4 && xmlhttp.status/100 >= 5) {
		window.setTimeout(function() {
			loadXMLDoc(dname, body, callback);
		    },100);
	    }
	};
	xmlhttp.send(null);
    }
    else {
	xmlhttp.open("POST",dname,true);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-Length", ""+body.length);
	xmlhttp.onreadystatechange = function() {
	    if(xmlhttp.readyState==4 && xmlhttp.status==200) {
		window.sparqlResults.push(xmlhttp.responseText);
		callback(xmlhttp.responseText);
	    }
	    else if(xmlhttp.readyState==4 && xmlhttp.status/100 >= 5) {
		window.setTimeout(function() {
			loadXMLDoc(dname, body, callback);
		    },100);
	    }
	};
	xmlhttp.send(body);
    }
}

window.xslxml = [];

function displayResultClosure(xml,element,callback) {
    return function(xsl) {
	if(xml==null || xsl==null) return;
	if(window.ActiveXObject) {
	    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	    xmlDoc.async=false;
	    xmlDoc.validateOnParse=false;
	    xmlDoc.loadXML(xml);
	    xslDoc = new ActiveXObject("Microsoft.XMLDOM");
	    xslDoc.async=false;
	    xslDoc.validateOnParse=false;
	    xslDoc.loadXML(xsl);
	    includes = xslDoc.getElementsByTagName("xsl:include");
	    for(var i=0;i<includes.length;i++) {
		includes[i].setAttribute("href","http://wineagent.tw.rpi.edu"+includes[i].getAttribute("href"));
	    }
	    ex=xmlDoc.transformNode(xslDoc);
	    element = document.getElementById(element.substr(1));
	    element.innerHTML=ex;
	}
	else {
	    window.xslxml.push([xml, xsl]);
	    $(element).transform({xslstr:xsl,xmlstr:xml,error:function(msg) {
			alert(arguments[4]);
		    }});
	}
	if(callback) callback(document.getElementById(element.substr(1)));
    };
}

function displayResult(xml, xslt, element, callback) {
    loadXMLDoc(xslt,null,displayResultClosure(xml,element,callback));
}

function query(endpoint, sparql, xslt, element) {
    loadXMLDoc(endpoint,"query="+escape(sparql),function(xml) {
	    if(xml!=null)
		displayResult(xml, xslt, element);
	});
}

function retrieveNamedQuery(name, data, callback) {
    var xmlhttp = getXMLHttp();
    if(xmlhttp==null) return null;
    var url = "http://wineagent.tw.rpi.edu/tw.rpi.edu/queries/"+name+".rq";
    if(data!=null) {
	url += "?";
	for(key in data) {
	    url += key + "=" + escape(data[key]) + "&";
	}
	url = url.substr(0, url.length-1);
    }
    xmlhttp.open("GET",url,true);
    xmlhttp.onreadystatechange = function() {
	if(xmlhttp.readyState==4 && xmlhttp.status==200) {
	    callback(xmlhttp.responseText);
	}
    };
    xmlhttp.send(null);
}

function named_query(endpoint, query, data, xslt, element, callback) {
    retrieveNamedQuery(query, data, function(text) {
	    loadXMLDoc(endpoint,"query="+escape(text), function(xml) {
		    if(xml!=null) {
			displayResult(xml, xslt, element, function() {
				if(callback) callback(document.getElementById(element.substr(1)));
			    });
		    }
		});
	});
}

function limited_query(endpoint, sparql, xslt, element, limit, offset) {
    if(typeof element == "string") {
	element = document.getElementById(element);
    }
    if(offset==null) offset = 0;
    xml = loadXMLDoc(endpoint,"query="+escape(sparql+"\nLIMIT "+limit+"\nOFFSET "+offset));
    if(xml!=null)
	displayPartialResult(xml, xslt, element, limit, offset);
}

function displayPartialResult(xml, xslt, element, limit, offset) {
    element.innerHTML="";
    if(xml==null || xsl==null) return;
    if(window.ActiveXObject) {
	ex=xml.transformNode(xsl);
	element.innerHTML=ex;
    }
    else if(document.implementation && document.implementation.createDocument) {
	xsltProcessor=new XSLTProcessor();
	xsltProcessor.importStylesheet(xsl);
	resultDocument = xsltProcessor.transformToFragment(xml,document);
	element.appendChild(resultDocument);
    }
    var p=document.createElementNS("http://www.w3.org/1999/xhtml", "p");
    var less=document.createElementNS("http://www.w3.org/1999/xhtml","a");
    var span=document.createElementNS("http://www.w3.org/1999/xhtml","span");
    var more=document.createElementNS("http://www.w3.org/1999/xhtml","a");
    p.appendChild(less);
    less.innerHTML="&lt;";
    p.appendChild(span);
    span.innerHTML=""+(offset+1)+"-"+(offset+limit);
    p.appendChild(more);
    more.innerHTML="&gt;";
    element.appendChild(p);
}
