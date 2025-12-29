#include "ast.h"

namespace minicpp {

// Allocate the global root pointer here
ASTNode* root = nullptr;

ASTNode* ast_program() { return new ASTNode(ASTNodeType::PROGRAM); }
ASTNode* ast_number(double value) { ASTNode* n = new ASTNode(ASTNodeType::NUMBER); n->number = value; return n; }
ASTNode* ast_identifier(const std::string& name) { ASTNode* n = new ASTNode(ASTNodeType::IDENTIFIER); n->name = name; return n; }
ASTNode* ast_binary(ASTNode* left, ASTNode* right, char op) {
    ASTNode* n = new ASTNode(ASTNodeType::BINARY_EXPR);
    n->left = left; n->right = right; n->op = op;
    return n;
}
ASTNode* ast_unary(ASTNode* operand, char op) {
    ASTNode* n = new ASTNode(ASTNodeType::UNARY_EXPR);
    n->left = operand; n->op = op;
    return n;
}
ASTNode* ast_declaration(const std::string& name) { ASTNode* n = new ASTNode(ASTNodeType::DECLARATION); n->name = name; return n; }
ASTNode* ast_assignment(const std::string& name, ASTNode* expr) {
    ASTNode* n = new ASTNode(ASTNodeType::ASSIGNMENT);
    n->name = name; n->left = expr;
    return n;
}
ASTNode* ast_class(const std::string& name) { ASTNode* n = new ASTNode(ASTNodeType::CLASS); n->name = name; return n; }
ASTNode* ast_struct(const std::string& name) { ASTNode* n = new ASTNode(ASTNodeType::STRUCT); n->name = name; return n; }
ASTNode* ast_access_specifier(const std::string& access) {
    ASTNode* n = new ASTNode(ASTNodeType::ACCESS_SPECIFIER);
    n->access = access; return n;
}
ASTNode* ast_return(ASTNode* expr) { ASTNode* n = new ASTNode(ASTNodeType::RETURN_STMT); n->left = expr; return n; }

} // namespace minicpp