%code requires {
    // This goes into parser.hpp - MUST be first
    #include "../ast/ast.h"
}

%{
#include <cstdio>
#include <cstdlib>
#include <string>

// Tell Bison that yylex and yyerror exist
extern int yylex();
void yyerror(const char* s);
%}

%union {
    double number;
    char* string;
    minicpp::ASTNode* node; // This now works because of %code requires
}

/* ALL KEYWORDS RESTORED */
%token <string> T_IDENTIFIER
%token <number> T_NUMBER
%token T_IF T_ELSE T_WHILE T_FOR T_RETURN T_SWITCH T_CASE T_DEFAULT T_BREAK T_CONTINUE T_GOTO T_DO
%token T_INT T_FLOAT T_DOUBLE T_CHAR T_VOID T_SHORT T_LONG T_SIGNED T_UNSIGNED T_BOOL T_STRING T_STRUCT T_UNION T_ENUM T_CLASS
%token T_PUBLIC T_PRIVATE T_PROTECTED T_VIRTUAL T_OVERRIDE T_CONST T_STATIC T_EXTERN T_AUTO T_REGISTER T_VOLATILE T_RESTRICT
%token T_TRUE T_FALSE T_NULLPTR T_STRING_LITERAL T_CHARACTER_LITERAL
%token T_PLUS T_MINUS T_MUL T_DIV T_MOD T_ASSIGN
%token T_PLUS_ASSIGN T_MINUS_ASSIGN T_MUL_ASSIGN T_DIV_ASSIGN T_MOD_ASSIGN
%token T_EQ T_NEQ T_LT T_GT T_LE T_GE T_AND T_OR T_NOT
%token T_BITWISE_AND T_BITWISE_OR T_BITWISE_XOR T_BITWISE_NOT T_SHIFT_LEFT T_SHIFT_RIGHT
%token T_INCREMENT T_DECREMENT T_ARROW
%token T_LPAREN T_RPAREN T_LBRACE T_RBRACE T_LBRACKET T_RBRACKET T_SEMI T_COMMA T_DOT T_COLON T_TERNARY_QUESTION
%token T_PREPROCESSOR T_ERROR

%type <node> program stmt stmt_list expr declaration assignment class_def struct_def access_specifier return_stmt

%left T_PLUS T_MINUS
%left T_MUL T_DIV
%left T_BITWISE_XOR  /* exponentiation */
%right UMINUS  /* unary minus */

%%

program:
    stmt_list { minicpp::root = $1; }
    ;

stmt_list:
    stmt { $$ = minicpp::ast_program(); $$->children.push_back($1); }
    | stmt_list stmt { $1->children.push_back($2); $$ = $1; }
    ;

stmt:
    declaration | assignment | class_def | struct_def | return_stmt | access_specifier
    ;

declaration:
    T_INT T_IDENTIFIER T_SEMI { $$ = minicpp::ast_declaration($2); free($2); }
    ;

assignment:
    T_IDENTIFIER T_ASSIGN expr T_SEMI { $$ = minicpp::ast_assignment($1, $3); free($1); }
    ;

expr:
    expr T_PLUS expr        { $$ = minicpp::ast_binary($1, $3, '+'); }
  | expr T_MINUS expr       { $$ = minicpp::ast_binary($1, $3, '-'); }
  | expr T_MUL expr         { $$ = minicpp::ast_binary($1, $3, '*'); }
  | expr T_DIV expr         { $$ = minicpp::ast_binary($1, $3, '/'); }
  | expr T_BITWISE_XOR expr { $$ = minicpp::ast_binary($1, $3, '^'); }
  | T_LPAREN expr T_RPAREN  { $$ = $2; }
  | T_NUMBER                { $$ = minicpp::ast_number($1); }
  | T_IDENTIFIER            { $$ = minicpp::ast_identifier($1); free($1); }
  | T_MINUS expr %prec UMINUS { $$ = minicpp::ast_unary($2, '-'); }
  | expr T_DECREMENT          { $$ = minicpp::ast_unary($1, 'd'); }
  ;

class_def:
    T_CLASS T_IDENTIFIER T_LBRACE stmt_list T_RBRACE T_SEMI
    { $$ = minicpp::ast_class($2); $$->children = $4->children; free($2); }
    ;

struct_def:
    T_STRUCT T_IDENTIFIER T_LBRACE stmt_list T_RBRACE T_SEMI
    { $$ = minicpp::ast_struct($2); $$->children = $4->children; free($2); }
    ;

access_specifier:
    T_PUBLIC T_COLON    { $$ = minicpp::ast_access_specifier("public"); }
  | T_PRIVATE T_COLON   { $$ = minicpp::ast_access_specifier("private"); }
  | T_PROTECTED T_COLON { $$ = minicpp::ast_access_specifier("protected"); }
  ;

return_stmt:
    T_RETURN expr T_SEMI { $$ = minicpp::ast_return($2); }
    ;

%%
void yyerror(const char* s) { std::fprintf(stderr, "Parse Error: %s\n", s); }