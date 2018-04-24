var autocomplete_objects = {};

function performAutocomplete() {
    var input = document.getElementById("autocomplete_input");
    var test = input.value;
    if(test=="") {
	var i;
	for(i in autocomplete_objects) {
	    var j;
	    for(j=0;j<autocomplete_objects[i].length;j++)
		autocomplete_objects[i][j].style.display = "table-row";
	}
	return;
    }
    test = new RegExp(test, "i");
    var i,j;
    for(i in autocomplete_objects) {
	if(test.test(i)) {
	    for(j=0;j<autocomplete_objects[i].length;j++)
		autocomplete_objects[i][j].style.display = "table-row";
	}
	else {
	    for(j=0;j<autocomplete_objects[i].length;j++)
		autocomplete_objects[i][j].style.display = "none";
	}
    }
}

function prepareAutocomplete(element) {
    var e = element.getElementsByTagName("tr");
    if(e.length == 0) return;
    e = e[0];
    while(e) {
	var text = e.getAttribute("label");
	if(text != null) {
	    if(autocomplete_objects[text]==null)
		autocomplete_objects[text] = [];
	    autocomplete_objects[text].push(e);
	}
	e = e.nextSibling;
    }
}