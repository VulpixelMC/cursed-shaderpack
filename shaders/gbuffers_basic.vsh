#version 150

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;

attribute vec2 mc_Entity;

out vec2 texcoord;
out vec4 glcolor;

void main() {
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 blockpos = position.xyz + cameraPosition;
	
	if (mc_Entity.x != 1) {
		position.y = 2 * sin(blockpos.x * 0.5
		+ blockpos.z * 0.7) + position.y;
	} else {
		position.y = 2 * cos(blockpos.x * 0.5
		+ blockpos.z * 2.5) + position.y;
	}

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}
