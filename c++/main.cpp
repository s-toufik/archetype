#include <spdlog/spdlog.h>

int main() {
    spdlog::set_level(spdlog::level::debug);
    spdlog::info("{{PROJECT_NAME}} starting up");
    return 0;
}
