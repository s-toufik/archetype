CXX        := c++
BUILD_DIR  := build
PROFILE    := default
CONAN_TC   := $(BUILD_DIR)/build/Release/generators/conan_toolchain.cmake

.PHONY: conan-install configure build test clean format lint run

conan-install:
	conan install . \
	  --output-folder=$(BUILD_DIR) \
	  --build=missing \
	  --profile=$(PROFILE)

configure:
	cmake -B $(BUILD_DIR) \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_CXX_COMPILER=$(CXX) \
	  -DCMAKE_TOOLCHAIN_FILE=$(CONAN_TC) \
	  -G Ninja

build:
	cmake --build $(BUILD_DIR)

setup: conan-install configure

test:
	ctest --test-dir $(BUILD_DIR) --output-on-failure

run:
	./$(BUILD_DIR)/src/{{PROJECT_NAME}}

clean:
	rm -rf $(BUILD_DIR)

format:
	find src include tests -name "*.cpp" -o -name "*.hpp" | xargs clang-format -i

lint:
	clang-tidy src/**/*.cpp -- -std=c++20
