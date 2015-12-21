/*!*********************************************************************************************************************
\file         PVRApi\GpuCapabilities.h
\author       PowerVR by Imagination, Developer Technology Team
\copyright    Copyright (c) Imagination Technologies Limited.
\brief		Contains enumerations that represent several kinds of queries for the GPU capabilities
***********************************************************************************************************************/
#pragma once
#include "PVRCore/Types.h"
namespace pvr {
class IGraphicsContext;
namespace api {

/*!****************************************************************************************************************
\brief	Contains enumerations for GPU capability queries
*******************************************************************************************************************/
namespace gpuCapabilities {

/*!****************************************************************************************************************
\brief	Texture and Sampler query.
*******************************************************************************************************************/
namespace TextureAndSamplers {
/*!****************************************************************************************************************
\brief	Texture and Sampler query.
*******************************************************************************************************************/
enum Enum
{
	MaxTextureImageUnit,//< max texture binding supported
	MaxSamples,//< max samples supported
	Max3DTextureSize,//< max 3d texture supported
	MaxArrayTextureLayer,//< max array-texture layer supported
	MaxTextureLodBias,//< max texture LOD bias supported
	MaxTextureSize,//< max texture size supported
	MaxCubeMapTexSize,//< max cube map texture size supported
	Count
};
}

/*!****************************************************************************************************************
\brief	Shader and Program query.
*******************************************************************************************************************/
namespace ShaderAndProgram {
/*!****************************************************************************************************************
\brief	Shader and Program query.
*******************************************************************************************************************/
enum Enum
{
	MaxProgramTexelOffset,//< max texel offset supported by the shader program
	MinProgramTexelOffset,//< min texel offset supported by the shader program
        NumProgramBinaryFormats, //< number of program binary formats supported
	NumCompressedTextureFormats,
	NumShaderBinaryFormats, //< number of shader binary format supported
	Count
};
}

/*!****************************************************************************************************************
\brief	TransformFeedback query.
*******************************************************************************************************************/
namespace TransformFeedback {
/*!****************************************************************************************************************
\brief	TransformFeedback query.
*******************************************************************************************************************/
enum Enum
{
	MaxInterleavedComponent,//< max transform-feedback interleaved component supported
	MaxSeparateAttribs,//< max transform feedback separate attribute supported
	SeparateComponents,//< max transform feedback
	Count
};
}

/*!****************************************************************************************************************
\brief	Uniform query.
*******************************************************************************************************************/
namespace Uniform {
enum Enum
{
	MaxUniformBlockSize,//< maximum size in basic machine units of a uniform block.
	MaxUniformBufferBindings,//< maximum number of uniform buffer binding points
	MaxCombinedUniformBlocks,//<maximum number of uniform blocks per program
	MaxCombinedVertexUniformComponent,
	Count
};
}

/*!****************************************************************************************************************
\brief	Element query.
*******************************************************************************************************************/
namespace Element {
enum Enum
{
	MaxIndices,//< max indices supported
	MaxVertices, //< max vertices supported
	Count
};
}

/*!****************************************************************************************************************
\brief	Buffers query.
*******************************************************************************************************************/
namespace Buffers {
enum Enum { MaxDrawBuffers, Count };
}

/*!****************************************************************************************************************
\brief	FragmentShader query.
*******************************************************************************************************************/
namespace FragmentShader {
enum Enum
{
	MaxFragmentInputComponents,//< max fragment input components  supported
	MaxfragmentUniformBlocks,//< max fragment uniform blocks  supported
	MaxFragmentUniformComponent,//< max fragment uniform component supported
	MaxFragmentUniformVectors,
	Count
};
}

/*!****************************************************************************************************************
\brief  Query gpu's texture and sampler capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A TextureAndSamplers enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, TextureAndSamplers::Enum query);


/*!****************************************************************************************************************
\brief	Query gpu's fragment capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A FragmentShader enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, FragmentShader::Enum query);

/*!****************************************************************************************************************
\brief	Query gpu's shader and program capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A ShaderAndProgram enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, ShaderAndProgram::Enum query);

/*!****************************************************************************************************************
\brief	Query gpu's Buffers capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A Buffers enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, Buffers::Enum query);

/*!****************************************************************************************************************
\brief	Query gpu's Element capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A Element enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, Element::Enum query);

/*!****************************************************************************************************************
\brief	Query gpu's transformfeedback capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A TransformFeedback enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, TransformFeedback::Enum query);

/*!****************************************************************************************************************
\brief  Query gpu's Uniform capabilities.
\return	The capability requested, as an Int32
\param	context The context whose capability is queried
\param	query A Uniform enum representing the capability to be queried
*******************************************************************************************************************/
int32 get(IGraphicsContext& context, Uniform::Enum query);

}
}
}
