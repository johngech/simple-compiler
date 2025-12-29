// symbol_table.cpp
#include "symbol_table.h"
#include <stdexcept>

namespace minicpp {

bool SymbolTable::exists(const std::string& name) {
    if (table.find(name) != table.end()) return true;
    if (parent) return parent->exists(name);
    return false;
}

Symbol* SymbolTable::get(const std::string& name) {
    auto it = table.find(name);
    if (it != table.end()) return &it->second;
    if (parent) return parent->get(name);
    return nullptr;
}

void SymbolTable::set(const std::string& name, const Symbol& sym) {
    table[name] = sym;
}

} // namespace minicpp
