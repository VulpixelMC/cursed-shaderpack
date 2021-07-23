#version 150

uniform sampler2D lightmap;
uniform sampler2D tex;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

void main() {
	vec4 color = texture2D(tex, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}