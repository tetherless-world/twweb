function loadPage(year, page) {
    if(year=="All") year = "";
    if(window.lastYear!=year) {
	$.ajax({url: window.twsparql,
		data: {"year": year,
		       "uri": window.instanceURI,
		       "query": "person-presentations-paginate-footer.rq",
		       "xslt": "person-presentations-paginate-footer.xsl"},
		success: function(data,textStatus,xhr) {
		    window.data = data;
		    var elem = $("*[class=\"person-presentations-paginate-footer\"]",data);
		    window.elem = elem;
		    var node;
		    if(!$.browser.msie) {
			node = document.importNode(elem[0],true);
			window.node = node;
			$(".person-presentations-paginate-footer").replaceWith(node);
		    }
		    else {
			$(".person-presentations-paginate-footer").replaceWith(/(<div.*>.*<\/div>)/.exec(xhr.responseText)[0]);
			node = $(".person-presentations-paginate-footer");
		    }
		    $("span.page",node).click(function() {
			loadPage(window.activeYear.text(),
				 window.pageOffset=(parseInt($(this).text())-1));
			window.activePage.removeClass("selected");
			window.activePage = $(this).addClass("selected");
		    });
		    window.activePage=$("span.selected",node);
		},
		dataType: "xml",
		error: function(a,b,c) { 
		    var text = a.responseText;
		    var p = new DOMParser();
		    window.data = p.parseFromString(text,"text/xml");
		    window.alert(a);
		    window.alert(b);
		    window.alert(c);
		}
	       });
    }
    var offset = page*10;
    var response = function(data,textStatus,xhr) {
	window.data = data;
	var elem = $("*[class=\"papers-list\"]",data.documentElement);
	window.element = elem[0];
	if(!$.browser.msie) {
	    var node = document.importNode(elem[0],true);
	    $(".papers-list").replaceWith(node);
	}
	else {
	    $(".papers-list").parent()[0].innerHTML = /(<table ?.*>.*<\/table>)/.exec(xhr.responseText)[0];
	}
    };
    $.ajax({url: window.twsparql,
	    data: {"year": year, "limit": window.pageLimit, "offset": offset,
		   "query": "person-presentations-paginate.rq",
		   "uri": window.instanceURI,
		   "xslt": "generate/person-presentations-paginate.xsl"},
	    success: response,
	    dataType: "xml",
	    error: response
	   });
}

function fixIEpaginate() {
    if (document.ELEMENT_NODE == null) {
	document.ELEMENT_NODE = 1;
	document.ATTRIBUTE_NODE = 2;
	document.TEXT_NODE = 3;
	document.CDATA_SECTION_NODE = 4;
	document.ENTITY_REFERENCE_NODE = 5;
	document.ENTITY_NODE = 6;
	document.PROCESSING_INSTRUCTION_NODE = 7;
	document.COMMENT_NODE = 8;
	document.DOCUMENT_NODE = 9;
	document.DOCUMENT_TYPE_NODE = 10;
	document.DOCUMENT_FRAGMENT_NODE = 11;
	document.NOTATION_NODE = 12;
    }
    if (!document.importNode) {
	document.importNode = function(node, allChildren) {
	    switch (node.nodeType) {
	    case document.ELEMENT_NODE:
		var newNode = document.createElement(node.nodeName);
		/* does the node have any attributes to add? */
		if (node.attributes && node.attributes.length > 0) {
		    for (var i = 0, il = node.attributes.length; i < il; i++) {
			newNode.setAttribute(node.attributes[i].nodeName,
					     node.getAttribute(node.attributes[i].nodeName));
		    }
		}
		/* are we going after children too, and does
		   the node have any? */
		if (allChildren && node.childNodes && node.childNodes.length > 0)
		    for (var i = 0, il = node.childNodes.length; i < il; i++)
			newNode.appendChild(document.importNode(node.childNodes[i], allChildren));
		return newNode;
	    case document.TEXT_NODE:
	    case document.CDATA_SECTION_NODE:
	    case document.COMMENT_NODE:
		return document.createTextNode(node.nodeValue);
	    }
	};
    }
}

function paginate() {
    window.paginated = true;
    fixIEpaginate();
    window.pageOffset = 0;
    window.lastYear = "";
    window.pageHeader = $(".person-presentations-paginate-header");
    window.pageFooter = $(".person-presentations-paginate-footer");
    window.activeYear = $("span.selected",window.pageHeader);
    window.activePage = $("span.selected",window.pageFooter);
    $("span.yearOption",window.pageHeader).click(function() {
	loadPage($(this).text(),window.pageOffset=0);
	if($(this).text()=="All") window.lastYear = "";
	else window.lastYear = $(this).text();
	window.activeYear.removeClass("selected");
	window.activeYear = $(this).addClass("selected");
    });
    $("span.page",window.pageFooter).click(function() {
	loadPage(window.activeYear.text(),
		 window.pageOffset=(parseInt($(this).text())-1));
	window.activePage.removeClass("selected");
	window.activePage = $(this).addClass("selected");
    });
}
