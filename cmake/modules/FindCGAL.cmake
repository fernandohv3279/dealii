## ---------------------------------------------------------------------
##
## Copyright (C) 2022 by the deal.II authors
##
## This file is part of the deal.II library.
##
## The deal.II library is free software; you can use it, redistribute
## it, and/or modify it under the terms of the GNU Lesser General
## Public License as published by the Free Software Foundation; either
## version 2.1 of the License, or (at your option) any later version.
## The full text of the license can be found in the file LICENSE.md at
## the top level directory of deal.II.
##
## ---------------------------------------------------------------------

#
# Try to find the CGAL libraries
#
# This module exports
#   
#   CGAL_INCLUDE_DIRS
#

SET(CGAL_DIR "" CACHE PATH "An optional hint to a CGAL installation")
SET_IF_EMPTY(CGAL_DIR "$ENV{CGAL_DIR}")

IF(NOT "${CGAL_DIR}" STREQUAL "")
  SET(CGAL_DIR ${CGAL_DIR})
ENDIF()

IF(DEAL_II_HAVE_CXX17)
  # temporarily disable ${CMAKE_SOURCE_DIR}/cmake/modules for module lookup
  LIST(REMOVE_ITEM CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules/)
  FIND_PACKAGE(CGAL 5.0)
  LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules/)
  IF(NOT CGAL_HEADER_ONLY)
    SET(CGAL_LIBS "-NOTFOUND")
    MESSAGE(STATUS "CGAL wrappers require header only version of CGAL.")
  ELSE()
    SET(CGAL_LIBS CGAL::CGAL)
  ENDIF(CGAL_HEADER_ONLY)
ELSE(DEAL_II_HAVE_CXX17)
  SET(CGAL_FOUND FALSE)
  SET(CGAL_INCLUDE_DIRS "-NOTFOUND")
  SET(CGAL_LIBS "-NOTFOUND")
  MESSAGE(STATUS "CGAL wrappers require C++17. Disabling CGAL Support.")
ENDIF(DEAL_II_HAVE_CXX17)

DEAL_II_PACKAGE_HANDLE(CGAL
  INCLUDE_DIRS
    REQUIRED CGAL_INCLUDE_DIRS
  LIBRARIES
    OPTIONAL CGAL_LIBS
  USER_INCLUDE_DIRS
    REQUIRED CGAL_INCLUDE_DIRS
  CLEAR 
    CGAL_INCLUDE_DIRS
    CGAL_LIBS
  )
