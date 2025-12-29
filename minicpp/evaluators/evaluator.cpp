#include "evaluator.h"
#include <stdexcept>
#include <cmath>
#include <iostream>

namespace minicpp {

Value Evaluator::eval(ASTNode* node, SymbolTable* scope) {
    if (!node) return Value{0.0, ""};
    if (!scope) scope = globals;

    switch (node->type) {
        case ASTNodeType::PROGRAM: {
            Value v = {0.0, ""};
            for (auto* c : node->children) v = eval(c, scope);
            return v;
        }
        case ASTNodeType::NUMBER: return Value{node->number, ""};
        case ASTNodeType::IDENTIFIER: {
            Symbol* s = scope->lookup(node->name);
            if (!s) throw std::runtime_error("Undefined: " + node->name);
            return s->value;
        }
        case ASTNodeType::DECLARATION: {
            scope->define(node->name, "double", Value{0.0, ""});
            return Value{0.0, ""};
        }
        case ASTNodeType::ASSIGNMENT: {
            Value v = eval(node->left, scope);
            if (!scope->update(node->name, v)) throw std::runtime_error("Error: " + node->name);
            return v;
        }
        case ASTNodeType::BINARY_EXPR: {
            double l = eval(node->left, scope).number;
            double r = eval(node->right, scope).number;
            if (node->op == '+') return Value{l + r, ""};
            if (node->op == '-') return Value{l - r, ""};
            if (node->op == '*') return Value{l * r, ""};
            if (node->op == '/') return Value{l / r, ""};
            if (node->op == '^') return Value{pow(l, r), ""};
            return Value{0.0, ""};
        }
        case ASTNodeType::UNARY_EXPR: {
            double v = eval(node->left, scope).number;
            if (node->op == '-') return Value{-v, ""};
            if (node->op == 'd') return Value{v, ""}; // post-decrement, return old value
            return Value{v, ""};
        }
        case ASTNodeType::PRINT_STMT: {
            Value v = eval(node->left, scope);
            std::cout << v.number << std::endl;
            return v;
        }
        default: return Value{0.0, ""};
    }
}

}