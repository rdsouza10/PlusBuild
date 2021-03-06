###############################################################################
# Find OptiTrack NatNet SDK
#
#     find_package(OptiTrackSDK)
#
# Variables defined by this module:
#
#  OPTITRACKSDK_FOUND                True if OptiTrack NatNet SDK was found
#  OPTITRACKSDK_VERSION              The version of NatNet SDK
#  OPTITRACKSDK_INCLUDE_DIR          The location(s) of NatNet SDK headers
#  OPTITRACKSDK_LIBRARY_DIR          Libraries needed to use NatNet SDK
#  OPTITRACKSDK_BINARY_DIR           Binaries needed to use NatNet SDK

SET(OPTITRACKSDK_PATH_HINTS
  "$ENV{PROGRAMFILES}/OptiTrack/NatNetSDK"
  "$ENV{PROGRAMW6432}/OptiTrack/NatNetSDK"
  "C:/Program Files (x86)/OptiTrack/NatNetSDK"
  "C:/Program Files/OptiTrack/NatNetSDK"
  "../PLTools/OptiTrack/NatNet-2.10"
  "../../PLTools/OptiTrack/NatNet-2.10"
  "../trunk/PLTools/OptiTrack/NatNet-2.10"
  "${CMAKE_CURRENT_BINARY_DIR}/PLTools/OptiTrack/NatNet-2.10"
  )

find_path(OPTITRACKSDK_DIR Readme-NatNet.txt
  PATHS ${OPTITRACKSDK_PATH_HINTS}
  DOC "OptiTrack NatNet SDK directory")

if (OPTITRACKSDK_DIR)
  # Include directories
  set(OPTITRACKSDK_INCLUDE_DIR ${OPTITRACKSDK_DIR}/include)
  mark_as_advanced(OPTITRACKSDK_INCLUDE_DIR)

  # Libraries
  SET(PLATFORM_SUFFIX "")
  IF (CMAKE_HOST_WIN32 AND CMAKE_CL_64 )
    SET(PLATFORM_SUFFIX "/x64/")
  ENDIF (CMAKE_HOST_WIN32 AND CMAKE_CL_64 )

  find_path(OptiTrackSDK_LIBRARY_DIR
            NAMES NatNetLib${CMAKE_STATIC_LIBRARY_SUFFIX}
            PATHS "${OPTITRACKSDK_DIR}/lib" NO_DEFAULT_PATH
            PATH_SUFFIXES ${PLATFORM_SUFFIX})

  find_path(OptiTrackSDK_BINARY_DIR
            NAMES NatNetLib${CMAKE_SHARED_LIBRARY_SUFFIX}
            PATHS "${OPTITRACKSDK_DIR}/lib" NO_DEFAULT_PATH
            PATH_SUFFIXES ${PLATFORM_SUFFIX})

  set(OPTITRACKSDK_LIBRARY_DIR ${OptiTrackSDK_LIBRARY_DIR})
  set(OPTITRACKSDK_BINARY_DIR ${OptiTrackSDK_BINARY_DIR})
  mark_as_advanced(OptiTrackSDK_LIBRARY_DIR)
  mark_as_advanced(OptiTrackSDK_BINARY_DIR)

  #Version
  #TODO: properly set SDK version using REGEX from NatNetTypes.h
  set(OPTITRACKSDK_VERSION "2.10.0")

endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OPTITRACKSDK
  FOUND_VAR OPTITRACKSDK_FOUND
  REQUIRED_VARS OPTITRACKSDK_LIBRARY_DIR OPTITRACKSDK_BINARY_DIR OPTITRACKSDK_INCLUDE_DIR
  VERSION_VAR OPTITRACKSDK_VERSION
)
