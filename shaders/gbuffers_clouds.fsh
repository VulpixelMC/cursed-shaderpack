#version 150

uniform sampler2D tex;

in vec2 texcoord;
in vec4 glcolor;

void main() {
	vec4 color = texture2D(tex, texcoord) * glcolor;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}