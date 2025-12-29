#include <iostream>
#include <fstream>
#include "ast/ast.h"
#include "evaluators/evaluator.h"
#include "codegen/codegen.h"

// Lexer bridge
void set_lexer_input(std::istream& is);
extern int yyparse();

namespace minicpp {
    extern ASTNode* root;
}

static void print_usage() {
    std::cerr << "Usage:\n  Run (interpret): ./minicpp <file>\n  Compile: ./minicpp -c <file> [-o output_exe]" << std::endl;
}

int main(int argc, char** argv) {
    bool compile_mode = false;
    std::string infile;
    std::string out_exe = "a.out";

    if (argc < 2) {
        print_usage();
        return 1;
    }

    if (std::string(argv[1]) == "-c") {
        compile_mode = true;
        if (argc < 3) { print_usage(); return 1; }
        infile = argv[2];
        for (int i = 3; i < argc; ++i) {
            if (std::string(argv[i]) == "-o" && i + 1 < argc) { out_exe = argv[i+1]; ++i; }
        }
    } else {
        infile = argv[1];
    }

    std::ifstream input(infile);
    if (!input.is_open()) {
        std::cerr << "Error: Could not open file " << infile << std::endl;
        return 1;
    }

    set_lexer_input(input);

    if (yyparse() == 0 && minicpp::root) {
        std::cout << "Successfully parsed the file." << std::endl;
        if (compile_mode) {
            std::string tmp_cpp = "minicpp_gen.cpp";
            if (!minicpp::generate_cpp(minicpp::root, tmp_cpp)) {
                std::cerr << "Code generation failed." << std::endl;
                return 1;
            }
            std::string cmd = std::string("g++ -std=c++17 -O2 ") + tmp_cpp + " -o " + out_exe;
            std::cout << "Running: " << cmd << std::endl;
            int rc = system(cmd.c_str());
            if (rc != 0) {
                std::cerr << "Compilation failed (return code " << rc << ")." << std::endl;
                return rc;
            }
            std::cout << "Built executable: " << out_exe << std::endl;
        } else {
            try {
                minicpp::Evaluator eval;
                eval.eval(minicpp::root);
                std::cout << "Execution finished." << std::endl;
            } catch (const std::exception& e) {
                std::cerr << e.what() << std::endl;
            }
        }
    } else {
        std::cerr << "Parsing failed." << std::endl;
    }

    return 0;
}
