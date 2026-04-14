#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGET_DIR="$1"
PROJECT_NAME="$2"
NAMESPACE="$3"

echo "Creating C++ hexagonal microservice: $PROJECT_NAME"

mkdir -p "$TARGET_DIR/$PROJECT_NAME"
cd "$TARGET_DIR/$PROJECT_NAME"

# Move and create
mkdir -p \
  include/$NAMESPACE/domain/model \
  include/$NAMESPACE/domain/service \
  include/$NAMESPACE/application/port/inbound \
  include/$NAMESPACE/application/port/outbound \
  include/$NAMESPACE/application/usecase

mkdir -p \
  src/$NAMESPACE/domain/service \
  src/$NAMESPACE/application/usecase \
  src/$NAMESPACE/adapter/inbound \
  src/$NAMESPACE/adapter/outbound

mkdir -p apps/main

mkdir -p tests/unit tests/integration

mkdir -p cmake docker

cp $SCRIPT_DIR/CMakeLists.txt            $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/CMakeLists.src.txt        $TARGET_DIR/$PROJECT_NAME/src/CMakeLists.txt
cp $SCRIPT_DIR/CMakeLists.apps.txt        $TARGET_DIR/$PROJECT_NAME/apps/CMakeLists.txt
cp $SCRIPT_DIR/CMakeLists.tests.txt      $TARGET_DIR/$PROJECT_NAME/tests/CMakeLists.txt
cp $SCRIPT_DIR/main.cpp                  $TARGET_DIR/$PROJECT_NAME/apps/main
cp $SCRIPT_DIR/Makefile                  $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/conanfile.txt             $TARGET_DIR/$PROJECT_NAME/
cp $SCRIPT_DIR/gitignore                 $TARGET_DIR/$PROJECT_NAME/.gitignore
cp $SCRIPT_DIR/clang-format              $TARGET_DIR/$PROJECT_NAME/.clang-format
cp $SCRIPT_DIR/clang-tidy                $TARGET_DIR/$PROJECT_NAME/.clang-tidy
cp -r $SCRIPT_DIR/github/               $TARGET_DIR/$PROJECT_NAME/.github/
cp $SCRIPT_DIR/MIT-LICENSE               $TARGET_DIR/$PROJECT_NAME/LICENSE


# ------------------------------------------------------------
# SAFE FILES (prevents empty build failure)
# ------------------------------------------------------------
cat > include/$NAMESPACE/domain/model/example.hpp << EOF
#pragma once
namespace $NAMESPACE::domain::model {
struct Example {};
}
EOF

cat > src/$NAMESPACE/domain/service/example.cpp << EOF
namespace $NAMESPACE::domain::service {
void example() {}
}
EOF

cat > tests/unit/example_test.cpp << EOF
#include <gtest/gtest.h>

TEST(Example, Basic) {
    EXPECT_TRUE(true);
}
EOF

# ------------------------------------------------------------
# FINAL SUBSTITUTE
# ------------------------------------------------------------
find . -type f -exec sed -i '' \
  -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
  -e "s/{{NAMESPACE}}/$NAMESPACE/g" {} +

echo "Done. Build with:"
echo "cd $PROJECT_NAME && make setup && make build"
