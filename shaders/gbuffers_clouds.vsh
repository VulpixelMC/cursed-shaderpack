#version 150

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;

out vec2 texcoord;
out vec4 glcolor;

void main() {
	// gl_Position = ftransform();
	vec4 position = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex);
	
	position.y = -tan(frameTimeCounter) + position.y;
	
	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}
