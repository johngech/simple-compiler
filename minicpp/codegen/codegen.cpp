#include "codegen.h"
#include "../ast/ast.h"
#include <fstream>
#include <iostream>

using namespace std;

namespace minicpp {

static string expr_to_cpp(ASTNode* n) {
    if (!n) return "0";
    switch (n->type) {
        case ASTNodeType::NUMBER: {
            // Print as-is (double)
            return to_string(n->number);
        }
        case ASTNodeType::IDENTIFIER:
            return n->name;
        case ASTNodeType::BINARY_EXPR: {
            string l = expr_to_cpp(n->left);
            string r = expr_to_cpp(n->right);
            char op = n->op;
            if (op == '^') return "pow(" + l + ", " + r + ")";
            string ops(1, op);
            return string("(") + l + " " + ops + " " + r + ")";
        }
        case ASTNodeType::UNARY_EXPR: {
            string operand = expr_to_cpp(n->left);
            char op = n->op;
            if (op == '-') return string("-") + operand;
            if (op == 'd') return operand + "--";
            return operand;
        }
        default:
            return "0";
    }
}

bool generate_cpp(ASTNode* root, const string& out_cpp_path) {
    if (!root) return false;
    ofstream ofs(out_cpp_path);
    if (!ofs.is_open()) return false;

    ofs << "#include <iostream>\n";
    ofs << "#include <cmath>\n";
    ofs << "using namespace std;\n\n";
    ofs << "int main() {\n";

    // Emit variable declarations encountered as DECLARATION nodes
    for (auto* c : root->children) {
        if (c->type == ASTNodeType::DECLARATION) {
            ofs << "    double " << c->name << " = 0;\n";
        }
    }

    // Emit statements
    for (auto* c : root->children) {
        switch (c->type) {
            case ASTNodeType::ASSIGNMENT: {
                string rhs = expr_to_cpp(c->left);
                ofs << "    " << c->name << " = " << rhs << ";\n";
            } break;
            case ASTNodeType::RETURN_STMT: {
                string r = expr_to_cpp(c->left);
                ofs << "    return (int) (" << r << ");\n";
            } break;
            case ASTNodeType::PRINT_STMT: {
                string e = expr_to_cpp(c->left);
                ofs << "    cout << " << e << " << endl;\n";
            } break;
            default:
                break;
        }
    }

    ofs << "    return 0;\n";
    ofs << "}\n";

    ofs.close();
    cout << "Generated C++ file: " << out_cpp_path << endl;
    return true;
}

} // namespace minicpp
