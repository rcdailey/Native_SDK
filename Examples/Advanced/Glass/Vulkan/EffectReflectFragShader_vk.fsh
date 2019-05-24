#version 450

layout(set = 1, binding = 0)uniform sampler2D sParaboloids;
layout(set = 2, binding = 0)uniform samplerCube sSkybox;
layout(location = 0) in highp vec3 ReflectDir;
layout(location = 0) out vec4 outColor;
void main()
{
	mediump vec3 Normalised;

	// Sample reflection to skybox
	lowp vec4 ReflectSky = texture(sSkybox, ReflectDir);

	// Sample reflection to paraboloids
	lowp vec4 Reflection;
	Normalised = normalize(ReflectDir);
	Normalised.xy /= abs(Normalised.z) + 1.0;
	Normalised.xy = Normalised.xy * 0.495 + 0.5;
	Normalised.x *= 0.5;
	Normalised.x += sign(-Normalised.z) * 0.25 + 0.25;
	Reflection = texture(sParaboloids, Normalised.xy);
	// Combine skybox reflection with paraboloid reflection
	Reflection.rgb = mix(ReflectSky.rgb, Reflection.rgb, Reflection.a);
	outColor.rgb = Reflection.rgb;
	outColor.a = 1.0;
}
