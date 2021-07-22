#version 150

uniform sampler2D texture;

in vec2 texcoord;
in vec4 glcolor;

void main() {
    vec4 color = texture2D(texture, texcoord) * glcolor;
	gl_FragData[0] = color;
}
