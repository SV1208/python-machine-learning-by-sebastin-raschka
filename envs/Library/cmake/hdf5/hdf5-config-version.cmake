#
# Copyright by The HDF Group.
# All rights reserved.
#
# This file is part of HDF5.  The full HDF5 copyright notice, including
# terms governing use, modification, and redistribution, is contained in
# the COPYING file, which can be found at the root of the source code
# distribution tree, or in https://support.hdfgroup.org/ftp/HDF5/releases.
# If you do not have access to either file, you may request a copy from
# help@hdfgroup.org.
#
#-----------------------------------------------------------------------------
# HDF5 Version file for install directory
#-----------------------------------------------------------------------------
#
# The created file sets PACKAGE_VERSION_EXACT if the current version string and
# the requested version string are exactly the same and it sets
# PACKAGE_VERSION_COMPATIBLE if the current version is >= requested version,
# but only if the requested major.minor version is the same as the current one.
# The variable HDF5_VERSION_STRING must be set before calling configure_file().

set (PACKAGE_VERSION "1.10.6")

if(PACKAGE_VERSION VERSION_LESS PACKAGE_FIND_VERSION)
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
else()
  if("1.10" MATCHES "^([0-9]+)\\.([0-9]+)")
    set(CVF_VERSION_MAJOR "${CMAKE_MATCH_1}")
    set(CVF_VERSION_MINOR "${CMAKE_MATCH_2}")
  else()
    set(CVF_VERSION_MAJOR "1.10.6")
    set(CVF_VERSION_MINOR "")
  endif()

  if((PACKAGE_FIND_VERSION_MAJOR STREQUAL CVF_VERSION_MAJOR) AND
     (PACKAGE_FIND_VERSION_MINOR STREQUAL CVF_VERSION_MINOR))
    set(PACKAGE_VERSION_COMPATIBLE TRUE)
  else()
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
  endif()

  if(PACKAGE_FIND_VERSION STREQUAL PACKAGE_VERSION)
      set(PACKAGE_VERSION_EXACT TRUE)
  endif()
endif()


# if the installed or the using project don't have CMAKE_SIZEOF_VOID_P set, ignore it:
if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "" OR "8" STREQUAL "")
   return()
endif()

# check that the installed version has the same 32/64bit-ness as the one which is currently searching:
if(NOT CMAKE_SIZEOF_VOID_P STREQUAL "8")
  math(EXPR installedBits "8 * 8")
  set(PACKAGE_VERSION "${PACKAGE_VERSION} (${installedBits}bit)")
  set(PACKAGE_VERSION_UNSUITABLE TRUE)
endif()
