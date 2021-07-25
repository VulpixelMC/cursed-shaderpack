#ifdef VERT
/* Vertex Shader */


// #define STATIC_WAVES

#define BLOCK_MAX_HEIGHT -0.5 // [-2.5 2.5]
#define WATER_MAX_HEIGHT 0.25 // [-2.5 2.5]
#define BLOCK_MIN_HEIGHT 0.5 // [-2.5 2.5]
#define WATER_MIN_HEIGHT 2.5 // [-2.5 2.5]
#define AMPLITUDE 2 // [1 8]

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

#ifdef CHECK_FLUID
attribute vec2 mc_Entity;
#endif

out vec2 texcoord;
out vec2 lmcoord;
out vec4 glcolor;

void main() {
	vec4 position = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex);
	vec3 blockPos = position.xyz;

	#ifdef STATIC_WAVES // make the waves render relative to the camera's position
	blockPos += cameraPosition;
	#endif
	
	#ifdef CHECK_FLUID
	if (mc_Entity.x != 1) {
	#endif
		position.y = AMPLITUDE * sin(blockPos.x * BLOCK_MAX_HEIGHT + blockPos.z * BLOCK_MIN_HEIGHT) + position.y;
	#ifdef CHECK_FLUID
	} else {
		position.y = cos(blockPos.x * WATER_MAX_HEIGHT - blockPos.z * WATER_MIN_HEIGHT) + position.y - 1;
	}
	#endif

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}


#endif



#ifdef FRAG
/* Fragment Shader */


#include "/lib/generic.glsl"


#endif
