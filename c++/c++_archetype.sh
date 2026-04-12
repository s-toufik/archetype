#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR=$1
cd "$TARGET_DIR"
set -euo pipefail

PROJECT_NAME=$2
NAMESPACE=$3

echo "Creating C++ project: $PROJECT_NAME"

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

mkdir -p \
  src/$NAMESPACE/domain/model \
  src/$NAMESPACE/domain/service \
  src/$NAMESPACE/application/use_cases \
  src/$NAMESPACE/application/port/inbound \
  src/$NAMESPACE/application/port/outbound \
  src/$NAMESPACE/adapter/inbound \
  src/$NAMESPACE/adapter/outbound \
  tests/unit \
  tests/integration \
  cmake \
  docker \
  scripts \
  include/$NAMESPACE

cp $SCRIPT_DIR/CMakeLists.txt            $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/CMakeLists.src.txt        $TARGET_DIR/$PROJECT_NAME/src/CMakeLists.txt
cp $SCRIPT_DIR/CMakeLists.tests.txt      $TARGET_DIR/$PROJECT_NAME/tests/CMakeLists.txt
cp $SCRIPT_DIR/main.cpp                  $TARGET_DIR/$PROJECT_NAME/src/
cp $SCRIPT_DIR/conanfile.txt             $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/conanprofile              $TARGET_DIR/$PROJECT_NAME/.conanprofile
cp $SCRIPT_DIR/Makefile                  $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/gitignore                 $TARGET_DIR/$PROJECT_NAME/.gitignore
cp $SCRIPT_DIR/clang-format              $TARGET_DIR/$PROJECT_NAME/.clang-format
cp $SCRIPT_DIR/clang-tidy                $TARGET_DIR/$PROJECT_NAME/.clang-tidy
cp -r $SCRIPT_DIR/cmake/                 $TARGET_DIR/$PROJECT_NAME/cmake/
cp -r $SCRIPT_DIR/github/               $TARGET_DIR/$PROJECT_NAME/.github/
cp $SCRIPT_DIR/MIT-LICENSE               $TARGET_DIR/$PROJECT_NAME/LICENSE

_subst() {
  perl -i -pe "s/\{\{PROJECT_NAME\}\}/$PROJECT_NAME/g; s/\{\{NAMESPACE\}\}/$NAMESPACE/g" "$1"
}

_subst $TARGET_DIR/$PROJECT_NAME/CMakeLists.txt
_subst $TARGET_DIR/$PROJECT_NAME/src/CMakeLists.txt
_subst $TARGET_DIR/$PROJECT_NAME/tests/CMakeLists.txt
_subst $TARGET_DIR/$PROJECT_NAME/src/main.cpp

# Stub source files
cat > $TARGET_DIR/$PROJECT_NAME/src/$NAMESPACE/domain/service/example_service.cpp << 'EOF'
#include <spdlog/spdlog.h>

EOF

cat > $TARGET_DIR/$PROJECT_NAME/tests/unit/domain_test.cpp << 'EOF'
#include <gtest/gtest.h>

TEST(DomainTest, Placeholder) {
    EXPECT_TRUE(true);
}
EOF

echo "Done. Run: cd $PROJECT_NAME && make setup && make build"
