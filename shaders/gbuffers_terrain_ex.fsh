#version 150

uniform sampler2D lightmap;
uniform sampler2D texture;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 normal;
in vec3 shadowLightPosition;
uniform vec3 cameraPosition;

float specularStrength = 1.0;

void main() {
    float ambientStrength = 1.0;
    vec3 ambient = ambientStrength * vec3(1.0);

    vec4 color = texture2D(texture, texcoord) * glcolor;
    color *= texture2D(lightmap, lmcoord);
    
    vec3 lightDir = shadowLightPosition * 0.01;
    float diff = max(dot(normal, lightDir), 0.0);
	
    vec3 viewDir = cameraPosition * 0.01;
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 256);
    vec3 specular = specularStrength * spec * vec3(0.1451, 0.0745, 0.0745);
    color.rgb *= (ambient + diff + specular) * glcolor.rgb;
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color;
}