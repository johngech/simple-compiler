#ifndef CODEGEN_H
#define CODEGEN_H

#include <string>
namespace minicpp {
    struct ASTNode;
    // Generate a C++ source file from the AST. Returns true on success.
    bool generate_cpp(ASTNode* root, const std::string& out_cpp_path);
}

#endif
