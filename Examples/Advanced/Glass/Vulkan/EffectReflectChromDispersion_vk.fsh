#version 450

layout(set = 1, binding = 0)uniform sampler2D sParaboloids;
layout(set = 2, binding = 0)uniform samplerCube sSkybox;

layout(location = 0) in highp vec3 ReflectDir;
layout(location = 1) in highp vec3 RefractDirRed;
layout(location = 2) in highp vec3 RefractDirGreen;
layout(location = 3) in highp vec3 RefractDirBlue;
layout(location = 4) in highp float ReflectFactor;

layout(location = 0)out vec4 outColor;

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

	// Sample refraction to skybox
	lowp vec4 RefractSky;
	RefractSky.r = texture(sSkybox, RefractDirRed).r;
	RefractSky.g = texture(sSkybox, RefractDirGreen).g;
	RefractSky.b = texture(sSkybox, RefractDirBlue).b;
	
	// Sample refraction to paraboloids
	lowp vec4 Refraction;

	// Red
	Normalised = normalize(RefractDirRed);
	Normalised.xy /= abs(Normalised.z) + 1.0;
	Normalised.xy = Normalised.xy * 0.495 + 0.5;
	Normalised.x *= 0.5;
	Normalised.x += sign(-Normalised.z) * 0.25 + 0.25;
	lowp vec4 RefractRed = texture(sParaboloids, Normalised.xy);

	Refraction.r = mix(RefractSky.r, RefractRed.r, RefractRed.a);

	// Green
	Normalised = normalize(RefractDirGreen);
	Normalised.xy /= abs(Normalised.z) + 1.0;
	Normalised.xy = Normalised.xy * 0.495 + 0.5;
	Normalised.x *= 0.5;
	Normalised.x += sign(-Normalised.z) * 0.25 + 0.25;
	lowp vec4 RefractGreen = texture(sParaboloids, Normalised.xy);

	Refraction.g = mix(RefractSky.g, RefractGreen.g, RefractGreen.a);

	// Blue
	Normalised = normalize(RefractDirBlue);
	Normalised.xy /= abs(Normalised.z) + 1.0;
	Normalised.xy = Normalised.xy * 0.495 + 0.5;
	Normalised.x *= 0.5;
	Normalised.x += sign(-Normalised.z) * 0.25 + 0.25;
	lowp vec4 RefractBlue = texture(sParaboloids, Normalised.xy);

	Refraction.b = mix(RefractSky.b, RefractBlue.b, RefractBlue.a);
	// Combine reflection and refraction for final color
	outColor.rgb = mix(Refraction.rgb, Reflection.rgb, ReflectFactor);
	outColor.a = 1.0;
}
