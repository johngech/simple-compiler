#ifndef AST_H
#define AST_H

#include <string>
#include <vector>

namespace minicpp {

enum class ASTNodeType {
    PROGRAM, DECLARATION, ASSIGNMENT, BINARY_EXPR, UNARY_EXPR,
    IDENTIFIER, NUMBER, CLASS, STRUCT,
    ACCESS_SPECIFIER, RETURN_STMT
};

struct ASTNode {
    ASTNodeType type;
    std::string name = "";
    double number = 0.0;
    char op = 0;
    ASTNode* left = nullptr;
    ASTNode* right = nullptr;
    std::vector<ASTNode*> children;
    std::string access = "";
    ASTNode(ASTNodeType t) : type(t) {}
};

ASTNode* ast_program();
ASTNode* ast_number(double value);
ASTNode* ast_identifier(const std::string& name);
ASTNode* ast_binary(ASTNode* left, ASTNode* right, char op);
ASTNode* ast_unary(ASTNode* operand, char op);
ASTNode* ast_declaration(const std::string& name);
ASTNode* ast_assignment(const std::string& name, ASTNode* expr);
ASTNode* ast_class(const std::string& name);
ASTNode* ast_struct(const std::string& name);
ASTNode* ast_access_specifier(const std::string& access);
ASTNode* ast_return(ASTNode* expr);

extern ASTNode* root; // Declaration of the global root
}
#endif