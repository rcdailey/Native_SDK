#version 450

layout(location = 0)in highp vec3 inVertex;
layout(location = 1)in mediump vec3 inNormal;
layout(location = 2)in highp vec2 inTexCoords;

layout(std140,set = 0, binding = 0) uniform Dynamic
{
	highp mat4 MVPMatrix;
	highp vec3 LightDir;
	highp vec3 EyePos;
};

layout(location = 0)out highp vec2 TexCoords;
layout(location = 1)out highp float LightIntensity;

void main()
{
	// Transform position
	gl_Position = MVPMatrix * vec4(inVertex, 1.0);
	
	// Pass through texture coordinates
	TexCoords = inTexCoords;

	// Calculate light intensity
	// Ambient
	LightIntensity = 0.4;
	
	// Diffuse
	LightIntensity += max(dot(inNormal, LightDir), 0.0) * 0.3;

	// Specular
	mediump vec3 EyeDir = normalize(EyePos - inVertex);
	LightIntensity += pow(max(dot(reflect(-LightDir, inNormal), EyeDir), 0.0), 5.0) * 0.8;
}
