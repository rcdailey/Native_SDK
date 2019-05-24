#version 450

layout(location = 0)in highp vec3 inVertex;
layout(location = 1)in mediump vec3 inNormal;
layout(location = 2)in highp vec2 inTexCoords;

layout(std140,set = 0, binding = 0) uniform Dynamic
{
	highp mat4 MVMatrix;
	highp vec3 LightDir;
	highp vec3 EyePos;
	highp float Far;
};


layout(location = 0)out highp vec2 TexCoords;
layout(location = 1)out highp float LightIntensity;

void main()
{

	// Transform position to the paraboloid's view space
	gl_Position = MVMatrix * vec4(inVertex, 1.0);
	// Store the distance
	highp float Distance = -gl_Position.z;
	// Calculate and set the X and Y coordinates
	gl_Position.xyz = normalize(gl_Position.xyz);
	gl_Position.xy /= 1.0 - gl_Position.z;

	// Calculate and set the Z and W coordinates
	gl_Position.z = -((Distance / Far) - 0.5) * 2.0;
	gl_Position.w = 1.;
	// Pass through texture coordinates
	TexCoords = inTexCoords;

	// Calculate light intensity
	// Ambient
	LightIntensity = 0.4;
	
	LightIntensity += max(dot(inNormal, LightDir), 0.0) * 0.3;
	// Specular
	mediump vec3 EyeDir = normalize(EyePos - gl_Position.xyz);
	LightIntensity += pow(max(dot(reflect(-LightDir, inNormal), EyeDir), 0.0), 5.0) * 0.8;
}
