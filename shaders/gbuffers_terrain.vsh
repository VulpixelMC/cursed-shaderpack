#version 150

// #define STATIC_WAVES

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 cameraPosition;

attribute vec2 mc_Entity;

out vec2 texcoord;
out vec2 lmcoord;
out vec4 glcolor;

void main() {
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 blockPos = position.xyz;

	#ifdef STATIC_WAVES // make the waves render relative to the camera's position
		blockPos += cameraPosition;
	#endif
	
	if (mc_Entity.x != 1) {
		position.y = 2 * sin(blockPos.x * 0.5 + blockPos.z * 0.7) + position.y;
	} else {
		position.y = 2 * cos(blockPos.x * 0.5 + blockPos.z * 2.5) + position.y;
	}

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}
