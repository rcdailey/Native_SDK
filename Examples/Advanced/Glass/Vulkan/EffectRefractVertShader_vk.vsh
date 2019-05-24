#version 450
const lowp float Eta = 0.87;


layout(location = 0)in highp vec3 inVertex;
layout(location = 1)in mediump vec3 inNormal;
layout(location = 0)out mediump vec3 RefractDir;

layout(std140,set = 0, binding = 0) uniform Buffer
{
	uniform highp mat4 MVPMatrix;
	uniform mediump mat3 MMatrix;
	uniform mediump vec3 EyePos;
};


void main()
{
	// Transform position
	gl_Position = MVPMatrix * vec4(inVertex, 1.0);
	
	// Calculate view direction in model space
	mediump vec3 ViewDir = normalize(inVertex - EyePos);
	RefractDir = MMatrix * refract(ViewDir, inNormal, Eta);
}
