/*!*********************************************************************************************************************
 \file         PVRPlatformGlue\EAGL\EaglGetProcAddress.cpp
 \author       PowerVR by Imagination, Developer Technology Team
 \copyright    Copyright (c) Imagination Technologies Limited.
 \brief 	   Apple EGL does not use the extension mechanism hence this implementation is empty.
 ***********************************************************************************************************************/
 //!\cond NO_DOXYGEN
#include <stdio.h>


namespace pvr {
namespace native {
// Apple EGL does not use the extension mechanism hence this functions always returns null.
	void* glueGetProcAddress(const char* functionName)
	{
		return NULL;
	}
}
}
//!\endcond