BUILD_DIR=build
PROFILE=default

.PHONY: setup build test run clean

setup:
	conan install . \
	  --output-folder=$(BUILD_DIR) \
	  --build=missing \
	  --profile=$(PROFILE)

configure:
	cmake -B $(BUILD_DIR) \
	  -G Ninja \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_TOOLCHAIN_FILE=$(BUILD_DIR)/conan_toolchain.cmake

build: setup configure
	cmake --build $(BUILD_DIR)

test:
	ctest --test-dir $(BUILD_DIR) --output-on-failure

run:
	./$(BUILD_DIR)/apps/pricelabcpp-core

clean:
	rm -rf $(BUILD_DIR)

git_init:
	git init
	git add --all
	git commit -m "init project"
	git checkout -b develop

format:
	find apps src include tests \( -name "*.cpp" -o -name "*.hpp" \) -print0 | xargs -0 clang-format -i

lint:
	find src apps tests -name "*.cpp" -print0 | xargs -0 clang-tidy -p build
