function calcResize(op){
	var ratio = Math[(op.fill)?'max':'min'](op.to.width/op.from.width,op.to.height/op.from.height);
	var r = {
		width: Math.round(op.from.width * ratio),
		height: Math.round(op.from.height * ratio)
	}
	r.x = Math.round((op.to.width - r.width) / 2);
	r.y = Math.round((op.to.height - r.height) / 2);
	return r;
}

console.log(calcResize({
	from: {
		width: 240,
		height: 320
	},
	to: {
		width: 320,
		height: 240
	},
	fill: true
}));
