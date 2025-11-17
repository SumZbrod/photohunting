shader_type canvas_item;
uniform float speed = 0.;

void vertex() {
	if (VERTEX.y < .0){
		VERTEX.x += speed*(abs(mod(TIME,4.)-2.) - 1.);
	}
}
