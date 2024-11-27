import { Avansel } from "avansel"
const container = document.querySelector(`#${panorama.domid}`)
new Avansel(container)
	.multires(panorama.tiles, () => (s, l, x, y) => {
		l = parseInt(l) + 1
		return `${panorama.prefix}/${l}/${s}_${y}_${x}.jpg`
	}).start();
