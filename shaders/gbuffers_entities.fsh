#version 140

uniform sampler2D lightmap;
uniform sampler2D tex;
uniform vec4 entityColor;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

void main() {
	vec4 color = texture2D(tex, texcoord) * glcolor;
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	color *= texture2D(lightmap, lmcoord);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
