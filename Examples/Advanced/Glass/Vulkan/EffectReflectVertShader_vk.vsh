#version 450

layout(location = 0)in highp vec3 inVertex;
layout(location = 1)in mediump vec3 inNormal;

layout(location = 0) out highp vec3 ReflectDir;


layout(std140,set = 0, binding = 0)uniform Buffer
{
	highp mat4 MVPMatrix;
	mediump mat3 MMatrix;
	mediump vec3 EyePos;
};

void main()
{
	// Transform position
	gl_Position = MVPMatrix * vec4(inVertex, 1.0);
	
	// Calculate view direction in model space
	mediump vec3 ViewDir = normalize(inVertex - EyePos);

	// Reflect view direction and transform to world space
	ReflectDir = MMatrix * reflect(ViewDir, inNormal);
}
