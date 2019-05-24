#version 450
layout(set = 1, binding = 0) uniform sampler2D  sTexture;
layout(std140, set = 1, binding = 1) uniform Material
{
	mediump vec3 AlbedoModulation;
	mediump float SpecularExponent;  //How smooth is the object
	mediump float Metallicity;  //How much is the specular light colored by the object's color
	mediump float Reflectivity; //How much of the light is diffuse/specular
};

layout (location = 0) in mediump vec3 ViewNormal;
layout (location = 1) in mediump vec2 TexCoord;

layout (location = 0) out lowp vec4 oColor;

const mediump float AMBIENT = .25;
const mediump vec3 ViewLightDirection = vec3(0.57735, 0.57735, -0.57735);
void main()
{
	// Overall color of the material. AlbedoModulation is not strictly required (as this information will
	//normally come from a texture), but it is very helpful for a "tweakable" shader

	mediump vec3 albedo = texture(sTexture, TexCoord).rgb * AlbedoModulation;

	//Add an ambient factor (greatly helps the look in general, otherwise high reflectivity makes the
	//the object pitch black...)
	//Diffuse factor       (colored)  : AMBIENT * albedo * (1 - reflectivity)
	//Specular, metallic   (colored)  : AMBIENT * albedo * reflectivity * metallicity
	// ==> Colored ambient = AMBIENT * albedo * (1 + reflectivity * (metallicity  - 1))
	
	//Specular, non-metallic (white)  : AMBIENT * reflectivity * (1 - metallicity)

	mediump float colorAmbientFactor = Reflectivity * (Metallicity - 1.) + 1.;
	mediump float whiteAmbientFactor = Reflectivity * (1. - Metallicity);

	mediump vec3 ambient = vec3(AMBIENT * whiteAmbientFactor) + albedo * AMBIENT * colorAmbientFactor;

	mediump vec3 normal = normalize(ViewNormal);
	mediump float n_dot_l = max(dot(normal, -ViewLightDirection), 0.);

	mediump vec3 color = ambient + (n_dot_l) * albedo * (1. - Reflectivity);

	if (n_dot_l > .0) //Skip if no specular needed...
	{
		mediump vec3 viewDirection = vec3(0.,0.,-1);
		mediump vec3 reflectedLightDirection = reflect(-ViewLightDirection, normal);
		mediump float v_dot_r = max(dot(viewDirection, reflectedLightDirection), 0.0);
		
		//Most metallic:    Specular Color = albedo color
		//Most un-metallic: Specular Color = white

		mediump	float specularIntensity = max(pow(v_dot_r, SpecularExponent) * Reflectivity, 0.);

		mediump float metallicSpecularIntensity = Metallicity * specularIntensity;
		mediump float plasticSpecularIntensity = (1. - Metallicity) * specularIntensity;

		mediump vec3 specularColor = vec3(plasticSpecularIntensity) + metallicSpecularIntensity * albedo;
		color += specularColor;
	}

	oColor = vec4(color, 1.);
}
