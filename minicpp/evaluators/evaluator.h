#ifndef EVALUATOR_H
#define EVALUATOR_H

#include "../ast/ast.h"
#include "../symbols/symbol_table.h"

namespace minicpp {

class Evaluator {
public:
    SymbolTable* globals;
    Evaluator() { globals = new SymbolTable(); }

    Value eval(ASTNode* node, SymbolTable* scope = nullptr);
};

} // namespace minicpp

#endif