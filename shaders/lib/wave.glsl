#ifdef VERT
/* Vertex Shader */


// #define STATIC_WAVES

#define BLOCK_X_MAX_HEIGHT 0.35
#define WATER_X_MAX_HEIGHT 0.25
#define BLOCK_Z_MAX_HEIGHT 0.25
#define WATER_Z_MAX_HEIGHT 2.5

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
		position.y = sin(blockPos.x * BLOCK_X_MAX_HEIGHT + blockPos.z * BLOCK_Z_MAX_HEIGHT) + position.y;
	#ifdef CHECK_FLUID
	} else {
		position.y = cos(blockPos.x * WATER_X_MAX_HEIGHT - blockPos.z * WATER_Z_MAX_HEIGHT) + position.y - 1;
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
