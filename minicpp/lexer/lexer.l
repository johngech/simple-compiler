%{
#include <iostream>
#include <string>
#include <cstdlib>
#include "../parser/parser.hpp"
#include "../ast/ast.h"

extern YYSTYPE yylval;   
extern int line_num;


class MyLexer : public yyFlexLexer {
public:
    MyLexer(std::istream* in) : yyFlexLexer(in) {}
    int yylex() { return yyFlexLexer::yylex(); }
};

MyLexer* scanner = nullptr;

void set_lexer_input(std::istream& is) {
    if (scanner) delete scanner;
    scanner = new MyLexer(&is);
}

int yylex() {
    if (!scanner) return 0;
    return scanner->yylex();
}

%}

%option noyywrap
%option c++

ID      [a-zA-Z][a-zA-Z0-9_]*
DIGIT   [0-9]+(\.[0-9]+)?

%%

"if"                { return T_IF; }
"else"              { return T_ELSE; }
"while"             { return T_WHILE; }
"for"               { return T_FOR; }
"return"            { return T_RETURN; }
"switch"            { return T_SWITCH; }
"case"              { return T_CASE; }
"default"           { return T_DEFAULT; }
"break"             { return T_BREAK; }
"continue"          { return T_CONTINUE; }
"goto"              { return T_GOTO; }
"do"                { return T_DO; }

"int"               { return T_INT; }
"float"             { return T_FLOAT; }
"double"            { return T_DOUBLE; }
"char"              { return T_CHAR; }
"void"              { return T_VOID; }
"short"             { return T_SHORT; }
"long"              { return T_LONG; }
"signed"            { return T_SIGNED; }
"unsigned"          { return T_UNSIGNED; }
"bool"              { return T_BOOL; }
"string"            { return T_STRING; }
"struct"            { return T_STRUCT; }
"union"             { return T_UNION; }
"enum"              { return T_ENUM; }
"class"             { return T_CLASS; }

"public"            { return T_PUBLIC; }
"private"           { return T_PRIVATE; }
"protected"         { return T_PROTECTED; }
"virtual"           { return T_VIRTUAL; }
"override"          { return T_OVERRIDE; }
"const"             { return T_CONST; }
"static"            { return T_STATIC; }
"extern"            { return T_EXTERN; }
"auto"              { return T_AUTO; }
"register"          { return T_REGISTER; }
"volatile"          { return T_VOLATILE; }
"restrict"          { return T_RESTRICT; }

"true"              { return T_TRUE; }
"false"             { return T_FALSE; }
"nullptr"           { return T_NULLPTR; }
"print"             { return T_PRINT; }


{ID}    { yylval.string = strdup(yytext); return T_IDENTIFIER; }
{DIGIT} { yylval.number = std::atof(yytext); return T_NUMBER; }


\"([^\"\\\\]|\\.)*\" { return T_STRING_LITERAL; }
\'([^\'\\\\]|\\.)*\' { return T_CHARACTER_LITERAL; }


"+="  { return T_PLUS_ASSIGN; }
"-="  { return T_MINUS_ASSIGN; }
"*="  { return T_MUL_ASSIGN; }
"/="  { return T_DIV_ASSIGN; }
"%="  { return T_MOD_ASSIGN; }
"=="  { return T_EQ; }
"!="  { return T_NEQ; }
"<="  { return T_LE; }
">="  { return T_GE; }
"&&"  { return T_AND; }
"||"  { return T_OR; }
"<<"  { return T_SHIFT_LEFT; }
">>"  { return T_SHIFT_RIGHT; }
"++"  { return T_INCREMENT; }
"--"  { return T_DECREMENT; }
"->"  { return T_ARROW; }


"+"  { return T_PLUS; }
"-"  { return T_MINUS; }
"*"  { return T_MUL; }
"/"  { return T_DIV; }
"%"  { return T_MOD; }
"="  { return T_ASSIGN; }
"<"  { return T_LT; }
">"  { return T_GT; }
"!"  { return T_NOT; }
"&"  { return T_BITWISE_AND; }
"|"  { return T_BITWISE_OR; }
"^"  { return T_BITWISE_XOR; }
"~"  { return T_BITWISE_NOT; }


"(" { return T_LPAREN; }
")" { return T_RPAREN; }
"{" { return T_LBRACE; }
"}" { return T_RBRACE; }
"[" { return T_LBRACKET; }
"]" { return T_RBRACKET; }
";" { return T_SEMI; }
"," { return T_COMMA; }
"\." { return T_DOT; }        
":" { return T_COLON; }
"?" { return T_TERNARY_QUESTION; }


^#.* { return T_PREPROCESSOR; }


[ \t]+ ; 
\n     { line_num++; }


. { return T_ERROR; }

%%


int line_num = 1;
