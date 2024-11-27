'use strict';
var previewUrl = panorama.prefix + "/preview.jpg";

var tileUrl = function(f, z, x, y) {
	return panorama.prefix + "/" + z + "/" + f + "_" + y + "_" + x + ".jpg";
};

var viewer = new Marzipano.Viewer(document.getElementById(panorama.domid), {stage: {progressive: true}});

var source = new Marzipano.ImageUrlSource(function(tile) {
	if (tile.z === 0) {
		var mapY = 'lfrbud'.indexOf(tile.face) / 6;
		return { url: previewUrl, rect: { x: 0, y: mapY, width: 1, height: 1/6 }};
	} else {
		return { url: tileUrl(tile.face, tile.z, tile.x+1, tile.y+1) };
	}
});

// Create geometry.
var geometry = new Marzipano.CubeGeometry(panorama.tiles);

// Create view.
var limiter = Marzipano.RectilinearView.limit.traditional(panorama.tiles[panorama.tiles.length-1].size, 100*Math.PI/180);
var view = new Marzipano.RectilinearView(null, limiter);

// Create scene.
var scene = viewer.createScene({
	source: source,
	geometry: geometry,
	view: view,
	pinFirstLevel: true
});

// Display scene.
scene.switchTo();

function attribution(first, second, url, position) {
	if (!url) return console.error('URL is required for the attribution link.');
	position = position || 'bottomleft';

	var link = document.createElement('a');
	link.href = url;
	link.target = '_blank';
	link.style = `
		position:absolute;display:block;font-family:Helvetica,Arial,sans-serif;
		text-transform:uppercase;text-decoration:none;color:#fff;opacity:.8;
		pointer-events:none;
		${position.replace(/bottom|top|left|right/g, m => `${m}:10px;`)}
		text-align:${/right/.test(position)?'right':'left'};`;

	var firstDiv = document.createElement('div');
	firstDiv.innerHTML = first;
	firstDiv.style = 'font-size:11px;margin-bottom:4px;';

	var secondDiv = document.createElement('div');
	secondDiv.innerHTML = second;
	secondDiv.style = 'font-size:16px;';

	link.appendChild(firstDiv);
	link.appendChild(secondDiv);
	document.body.appendChild(link);
}

if (panorama.attribution) {
	var { first = '', second = '', url = '', position = 'bottomleft' } = panorama.attribution;
	if (url) {
		attribution(first, second, url, position);
	} else {
		console.error('URL is required for the attribution link but was not provided.');
	}
}
