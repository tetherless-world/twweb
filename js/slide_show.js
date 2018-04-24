var slideshowDivs = [];
var currentDivIndexes = [];
 
function getChildDivs(id) {
	var parent = document.getElementById(id);
	var spacer = document.getElementById(id + '-spacer');
	var childDivs = [];
	var childDivCount = 0;
	var i;
	var maxHeight = 0;
	var maxWidth = 0;
	for (i=0; i < parent.childNodes.length; i++) {
		var child = parent.childNodes[i];
		if (child.tagName == 'DIV') {
			childDivs[childDivCount++] = child;
			if (maxHeight < child.offsetHeight) {
				maxHeight = child.offsetHeight
			}
			if (maxWidth < child.offsetWidth) {
				maxWidth = child.offsetWidth
			}
			child.style.position = 'relative';
			//child.style.height = '0px';
			//child.style.width = '0px';
			//child.style.overflow = 'visible';
			hide(child);
		}
	}
	//parent.style.position = 'relative';
	//spacer.style.height = maxHeight + 'px';
	//spacer.style.width = maxWidth + 'px';
 
	return childDivs;
}
 
function getInitialDivIndex(id, sequence) {
	var index = -1;
	if (sequence == 'forward') {
	  index = 0;
	} else if (sequence == 'backward') {
	  index = (slideshowDivs[id].length)-1;
	} else if (sequence == 'random') {
		index = Math.floor(Math.random()*slideshowDivs[id].length);
	}
	show(slideshowDivs[id][index]);
	return index;
}
 
function getNextDivIndex(id, sequence) {
	var index = -1;
	if (sequence == 'forward') {
		index = currentDivIndexes[id] + 1;
		if (index == slideshowDivs[id].length) {
			index = 0;
		}
	} else if (sequence == 'backward') {
		index = currentDivIndexes[id] - 1;
		if (index == -1) {
			index = slideshowDivs[id].length - 1;
		}
	} else if (sequence == 'random') {
		index = currentDivIndexes[id];
		if (slideshowDivs[id].length > 1) {
			while (index == currentDivIndexes[id]) {
				index = Math.floor(Math.random()*slideshowDivs[id].length);
			}
		}
	}
 
	return index;
}
 
function getNode(id, index) {
	return slideshowDivs[id][index];
}
 
function doTransition(currentNode, newNode, transition) {
	if (transition == 'cut') {
		hide(currentNode);
		show(newNode);
	} else if (transition == 'fade') {
		currentNode.style.zIndex = 2;
		setOpacity(newNode,0);
		newNode.style.zIndex = 1;
		var fadeTransition = new Effect.Parallel([
			new Effect.Opacity(currentNode, {from: 1.0, to: 0.0}),
			new Effect.Opacity(newNode, {from: 0.0, to: 1.0})
			], {duration: 1.0, afterFinish: function() { currentNode.style.zIndex = 0; }});
	} else if (transition == 'blindDown') {
		currentNode.style.zIndex = 1;
		newNode.style.zIndex = 2;
		new Effect.BlindDown(newNode, {duration: 1.0});
	}
}
 
function slideshow(id, sequence, transition) {
	var newIndex = getNextDivIndex(id, sequence);
	doTransition(getNode(id, currentDivIndexes[id]), getNode(id, newIndex), transition);
	currentDivIndexes[id] = newIndex;
}
 
function startSlideshow(id, refresh, sequence, transition) {
	slideshowDivs[id] = getChildDivs(id);
	if (slideshowDivs[id].length > 0) {
		currentDivIndexes[id] = getInitialDivIndex(id, sequence);
		setInterval("slideshow('" + id + "', '" + sequence + "', '" + transition + "');", refresh);
	}
}
 
function hide(node) {
   if (node != null) {
		setOpacity(node, 0);
	node.style.display = "none";
		node.style.zIndex = 0;
	}
}
 
function show(node) {
   if (node != null) {
		setOpacity(node, 1);
	node.style.display = "block";
		node.style.zIndex = 1;
	}
}
 
function setOpacity(node, value) {
   if (node != null) {
		node.style.opacity = value;
		node.style.filter = 'alpha(opacity = ' + (value * 100) + ')';
	}
}

