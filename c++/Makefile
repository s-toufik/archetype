BUILD_DIR=build
PROFILE=default
CONAN_TC=$(BUILD_DIR)/conan_toolchain.cmake

.PHONY: setup build test run clean

dependencies-install:
	conan install . \
	  --output-folder=$(BUILD_DIR) \
	  --build=missing \
	  --profile=$(PROFILE)

configure:
	cmake -B $(BUILD_DIR) \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_TOOLCHAIN_FILE=$(CONAN_TC) \
	  -G Ninja

git_init:
	git init
	git add --all
	git commit -m "init project"
	git checkout -b develop

setup: dependencies-install configure 

build:
	cmake --build $(BUILD_DIR)

test:
	ctest --test-dir $(BUILD_DIR) --output-on-failure

run:
	./$(BUILD_DIR)/apps/{{PROJECT_NAME}}

clean:
	rm -rf $(BUILD_DIR)

format:
	find apps src include tests \( -name "*.cpp" -o -name "*.hpp" \) -print0 | xargs -0 clang-format -i

lint:
	find src apps tests -name "*.cpp" -print0 | xargs -0 clang-tidy -p build
