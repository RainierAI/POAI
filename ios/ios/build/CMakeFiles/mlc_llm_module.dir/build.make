# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.28.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.28.1/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/younghwanyu/POAI/mlc-llm

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/younghwanyu/POAI/mlc-llm/ios/build

# Include any dependencies generated for this target.
include CMakeFiles/mlc_llm_module.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/mlc_llm_module.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/mlc_llm_module.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mlc_llm_module.dir/flags.make

# Object files for target mlc_llm_module
mlc_llm_module_OBJECTS =

# External object files for target mlc_llm_module
mlc_llm_module_EXTERNAL_OBJECTS = \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/conv_templates.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/conversation.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/image_embed.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/llm_chat.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/loader/multi_gpu_loader.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/metadata/model.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/async_threaded_engine.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/config.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/data.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/encoding.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/action.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/action_commons.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_decode.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_draft.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_verify.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/new_request_prefill.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_state.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/event_trace_recorder.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/function_table.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar_parser.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar_serializer.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/model.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/request.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/request_state.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/serve/sampler.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/streamer.cc.o" \
"/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_objs.dir/cpp/tokenizers.cc.o"

libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/conv_templates.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/conversation.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/image_embed.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/llm_chat.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/loader/multi_gpu_loader.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/metadata/model.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/async_threaded_engine.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/config.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/data.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/encoding.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/action.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/action_commons.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_decode.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_draft.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/batch_verify.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_actions/new_request_prefill.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/engine_state.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/event_trace_recorder.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/function_table.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar_parser.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/grammar/grammar_serializer.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/model.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/request.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/request_state.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/serve/sampler.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/streamer.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_objs.dir/cpp/tokenizers.cc.o
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_module.dir/build.make
libmlc_llm_module.dylib: tvm/libtvm.dylib
libmlc_llm_module.dylib: tokenizers/libtokenizers_cpp.a
libmlc_llm_module.dylib: tokenizers/aarch64-apple-ios/release/libtokenizers_c.a
libmlc_llm_module.dylib: tokenizers/sentencepiece/src/libsentencepiece.a
libmlc_llm_module.dylib: CMakeFiles/mlc_llm_module.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Linking CXX shared library libmlc_llm_module.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mlc_llm_module.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/mlc_llm_module.dir/build: libmlc_llm_module.dylib
.PHONY : CMakeFiles/mlc_llm_module.dir/build

CMakeFiles/mlc_llm_module.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mlc_llm_module.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mlc_llm_module.dir/clean

CMakeFiles/mlc_llm_module.dir/depend:
	cd /Users/younghwanyu/POAI/mlc-llm/ios/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/younghwanyu/POAI/mlc-llm /Users/younghwanyu/POAI/mlc-llm /Users/younghwanyu/POAI/mlc-llm/ios/build /Users/younghwanyu/POAI/mlc-llm/ios/build /Users/younghwanyu/POAI/mlc-llm/ios/build/CMakeFiles/mlc_llm_module.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/mlc_llm_module.dir/depend

