#version 450


layout(location = 0)in highp vec3 inVertex;

layout(location = 0)out mediump vec3 RayDir;


layout(std140,set = 0, binding = 0) uniform Dynamic
{
	highp mat4 InvVPMatrix;
	mediump vec3 EyePos;
};

void main()
{
	// Set position
	gl_Position = vec4(inVertex, 1.0);

	// Calculate world space vertex position
	vec4 WorldPos = InvVPMatrix * gl_Position;
	WorldPos /= WorldPos.w;

	// Calculate ray direction
	RayDir = normalize(WorldPos.xyz - EyePos);
}
