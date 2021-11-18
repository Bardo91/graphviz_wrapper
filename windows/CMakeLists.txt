cmake_minimum_required(VERSION 3.14)
set(PROJECT_NAME "graphviz_wrapper")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "graphviz_wrapper_plugin")

add_library(${PLUGIN_NAME} SHARED
  "graphviz_wrapper_plugin.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)

set(GRAPHVIZ_INCLUDE_DIRS  "C:/Program Files/Graphviz/include")
file( GLOB_RECURSE
      GRAPHVIZ_LIBRARIES
      "C:/Program Files/Graphviz/lib/*.lib" )

target_link_libraries(${PLUGIN_NAME} PRIVATE ${GRAPHVIZ_LIBRARIES})
target_include_directories(${PLUGIN_NAME} PRIVATE ${GRAPHVIZ_INCLUDE_DIRS})

file( GLOB_RECURSE
      GRAPHVIZ_LIBRARIES_TO_BUNDLE
      "C:/Program Files/Graphviz/bin/*.dll" )

# List of absolute paths to libraries that should be bundled with the plugin
set(graphviz_wrapper_bundled_libraries
  ""
  #${GRAPHVIZ_LIBRARIES_TO_BUNDLE}
  PARENT_SCOPE
)
