#version 150

const float PI = 3.1415927;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 normal;
out vec3 shadowLightPosition;
// Attributes
attribute vec4 mc_Entity;

// Uniforms
uniform vec3 cameraPosition;
uniform float frameTimeCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

void main() {
	normal = normalize(gl_NormalMatrix * gl_Normal);
	gl_Position = ftransform();
	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	vec3 worldpos = position.xyz + cameraPosition;
		// Calculate wave
		float wave = 1*sin(2 * PI * (frameTimeCounter*0.7 + worldpos.x * 0.14 + worldpos.z * 0.07))
				+ 1*sin(2 * PI * (frameTimeCounter*0.5 + worldpos.x * 0.10 + worldpos.z * 0.20));
		position.y = wave * 0.5 + position.y;
	if (mc_Entity.x == 31)
	{
				// Calculate wave
		float wave = 1*cos(2 * PI * (frameTimeCounter*0.7 + worldpos.x * 0.14 + worldpos.z * 0.07))
				+ 1*cos(2 * PI * (frameTimeCounter*0.5 + worldpos.x * 0.10 + worldpos.z * 0.20));
		position.y = wave * 0.5 + position.y;
	}

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * 	gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}