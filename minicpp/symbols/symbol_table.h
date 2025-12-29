#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <string>
#include <unordered_map>

namespace minicpp {

struct Value {
    double number = 0.0;
    std::string str = "";
};

struct Symbol {
    std::string name;
    std::string type;
    Value value;
};

class SymbolTable {
public:
    SymbolTable* parent;
    std::unordered_map<std::string, Symbol*> symbols;

    SymbolTable(SymbolTable* p = nullptr) : parent(p) {}

    void define(const std::string& name, const std::string& type, Value val) {
        symbols[name] = new Symbol{name, type, val};
    }

    Symbol* lookup(const std::string& name) {
        if (symbols.count(name)) return symbols[name];
        return parent ? parent->lookup(name) : nullptr;
    }

    bool update(const std::string& name, Value val) {
        Symbol* s = lookup(name);
        if (s) { s->value = val; return true; }
        return false;
    }
};

}
#endif