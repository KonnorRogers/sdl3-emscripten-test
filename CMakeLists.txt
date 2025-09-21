cmake_minimum_required(VERSION 3.16)
project(main)

# set the output directory for built objects.
# This makes sure that the dynamic library goes into the build directory automatically.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")

# This assumes the SDL source is available in vendor/SDL
add_subdirectory(vendor/SDL EXCLUDE_FROM_ALL)

# Create your game executable target as usual
add_executable(main WIN32 main.c)

# Link to the actual SDL3 library.
target_link_libraries(main PRIVATE SDL3::SDL3)

# Define the path to your asset
set(BMP_PATH "${CMAKE_SOURCE_DIR}/sample.bmp")


# on Web targets, we need CMake to generate a HTML webpage.
if(EMSCRIPTEN)
  set(CMAKE_EXECUTABLE_SUFFIX ".html" CACHE INTERNAL "")

  # Embed the file into the virtual filesystem
  set_target_properties(main PROPERTIES
      LINK_FLAGS "--embed-file \"${BMP_PATH}@/sample.bmp\""
  )
else ()
  add_custom_command(
        TARGET main POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
                ${BMP_PATH}
                ${CMAKE_CURRENT_BINARY_DIR}/sample.bmp)
endif()

