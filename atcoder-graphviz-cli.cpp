#include <iostream>
#include <vector>
#include <map>
#include <sstream>
#include <iomanip>

struct Option {
    std::string longName;
    char shortName;
    std::string description;
    std::string usage;
};

std::vector<Option> options = {
    {"help",      'h', "Shows this help message",            "--help, -h"},
    {"tree",      't', "Use N-1 edges for the tree format", "--tree, -t"},
    {"directed",  'd', "Outputs a directed graph",          "--directed, -d"}
};

void displayHelp() {
    std::cout << "Usage: atcoder-graphviz-cli [OPTIONS]\n\n";
    std::cout << "Options:\n";

    size_t maxUsageLength = 0;
    for (const auto& option : options) {
        maxUsageLength = std::max(maxUsageLength, option.usage.length());
    }

    for (const auto& option : options) {
        std::cout << "\t" << std::setw(maxUsageLength + 4) << std::left << option.usage
                  << option.description << '\n';
    }
}

int main(int argc, char* argv[]) {
    std::map<std::string, bool> flags;
    for (const auto& option : options) {
        flags[option.longName] = false;
    }

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg.size() == 2 && arg[0] == '-') {  // Short flag
            char shortName = arg[1];
            bool found = false;
            for (const auto& option : options) {
                if (option.shortName == shortName) {
                    flags[option.longName] = true;
                    found = true;
                    break;
                }
            }
            if (!found) {
                std::cerr << "Unknown option: " << arg << '\n';
                return 1;
            }
        } else if (arg.size() > 2 && arg.substr(0, 2) == "--") {  // Long flag
            std::string longName = arg.substr(2);
            if (flags.find(longName) != flags.end()) {
                flags[longName] = true;
            } else {
                std::cerr << "Unknown option: " << arg << '\n';
                return 1;
            }
        } else {
            std::cerr << "Invalid argument: " << arg << '\n';
            return 1;
        }
    }

    if (flags["help"]) {
        displayHelp();
        return 0;
    }

    int N, M;
    std::cin >> N;
    if (!flags["tree"]) {
        std::cin >> M;
    } else {
        M = N - 1;
    }

    std::ostringstream output;
    output << (flags["directed"] ? "digraph" : "graph") << " G {\n";

    for (int i = 0; i < M; ++i) {
        int A, B;
        std::cin >> A >> B;
        output << "    " << A << (flags["directed"] ? " -> " : " -- ") << B << ";\n";
    }

    for (int i = 1; i <= N; i++) {
        output << "    " << i << ";\n";
    }

    output << "}\n";

    std::cout << output.str();

    return 0;
}
