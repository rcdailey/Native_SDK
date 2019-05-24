#version 450

const lowp vec3 Eta = vec3(0.85, 0.87, 0.89);

const lowp float FresnelBias = 0.3;
const lowp float FresnelScale = 0.7;
const lowp float FresnelPower = 1.5;

layout(std140,set = 0, binding = 0)uniform Buffer
{
	highp mat4 MVPMatrix;
	mediump mat3 MMatrix;
	mediump vec3 EyePos;
};

layout(location = 0)in highp vec3 inVertex;
layout(location = 1)in mediump vec3 inNormal;

layout(location = 0) out mediump vec3 ReflectDir;
layout(location = 1) out mediump vec3 RefractDirRed;
layout(location = 2) out mediump vec3 RefractDirGreen;
layout(location = 3) out mediump vec3 RefractDirBlue;
layout(location = 4) out highp float ReflectFactor;

void main()
{
	// Transform position
	gl_Position = MVPMatrix * vec4(inVertex, 1.0);
	
	// Calculate view direction in model space
	mediump vec3 ViewDir = normalize(inVertex - EyePos);

	// Reflect view direction and transform to world space
	ReflectDir = MMatrix * reflect(ViewDir, inNormal);

	// Refract view direction and transform to world space
	RefractDirRed = MMatrix * refract(ViewDir, inNormal, Eta.r);
	RefractDirGreen = MMatrix * refract(ViewDir, inNormal, Eta.g);
	RefractDirBlue = MMatrix * refract(ViewDir, inNormal, Eta.b);

	// Calculate the reflection factor
	ReflectFactor = FresnelBias + FresnelScale * pow(1.0 + dot(ViewDir, inNormal), FresnelPower);
	ReflectFactor = clamp(ReflectFactor, 0.0, 1.0);
}
