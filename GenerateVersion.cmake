list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

#From https://github.com/rpavlik/cmake-modules
include(GetGitRevisionDescription)

get_git_head_revision(GIT_REFSPEC GIT_SHA1)
git_describe(DESC --always --tags)
git_get_exact_tag(TAG)

message(STATUS "Building on ${GIT_REFSPEC} : ${GIT_SHA1}")

set(versionRegex "^v([0-9]*).([0-9]*).([0-9]*)(-[0-9]*-g)([a-z0-9]*)$")

set(GENERATED_PROJECT_VERSION_MAJOR "?")
set(GENERATED_PROJECT_VERSION_MINOR "?")
set(GENERATED_PROJECT_VERSION_PATCH "?")
set(GENERATED_PROJECT_VERSION_TWEAK "")

string(REGEX MATCH  ${versionRegex} VERSION_FORMAT_IS_OK "${DESC}")

if( VERSION_FORMAT_IS_OK )
	string(REGEX REPLACE ${versionRegex} "\\1" GENERATED_PROJECT_VERSION_MAJOR "${DESC}")
	string(REGEX REPLACE ${versionRegex} "\\2" GENERATED_PROJECT_VERSION_MINOR "${DESC}")
	string(REGEX REPLACE ${versionRegex} "\\3" GENERATED_PROJECT_VERSION_PATCH "${DESC}")
endif()

if(${TAG} MATCHES "^.*-NOTFOUND")
	string(REGEX REPLACE ${versionRegex} "\\5" HEXA_SHA1 "${DESC}")
	set(GENERATED_PROJECT_VERSION_TWEAK "-${HEXA_SHA1}")

endif()

set(GENERATED_PROJECT_VERSION "${GENERATED_PROJECT_VERSION_MAJOR}.${GENERATED_PROJECT_VERSION_MINOR}.${GENERATED_PROJECT_VERSION_PATCH}${GENERATED_PROJECT_VERSION_TWEAK}" )

message(STATUS "Setting cmake project version to : ${GENERATED_PROJECT_VERSION}")

configure_file("${CMAKE_CURRENT_LIST_DIR}/version.h.in" version.h @ONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/version.rc.in" version.rc @ONLY)

#Add include path to version.h
include_directories(${CMAKE_CURRENT_BINARY_DIR})
