%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int line_num;
extern char* yytext;
void yyerror(const char *s);
%}

/* Token Declarations */
%token IF ELSE WHILE FOR RETURN CLASS PUBLIC PRIVATE
%token DATA_TYPE IDENTIFIER NUMBER_LITERAL STRING_LITERAL
%token PLUS MINUS MULTIPLY DIVIDE ASSIGN
%token AND OR EQ NE LT GT LE GE
%token SEMICOLON COMMA LPAREN RPAREN LBRACE RBRACE

/* Operator Precedence */
%left OR
%left AND
%left EQ NE LT GT LE GE
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

program:
    program statement
    | statement
    ;

statement:
    variable_declaration
    | assignment_statement
    | if_statement
    | while_statement
    | return_statement
    | block
    ;

variable_declaration:
    DATA_TYPE IDENTIFIER SEMICOLON { printf("[Line %d] Valid: Variable Declaration\n", line_num); }
    | DATA_TYPE IDENTIFIER ASSIGN expression SEMICOLON { printf("[Line %d] Valid: Declaration with Assignment\n", line_num); }
    ;

assignment_statement:
    IDENTIFIER ASSIGN expression SEMICOLON { printf("[Line %d] Valid: Assignment\n", line_num); }
    ;

if_statement:
    IF LPAREN expression RPAREN statement { printf("[Line %d] Valid: If Statement\n", line_num); }
    | IF LPAREN expression RPAREN statement ELSE statement { printf("[Line %d] Valid: If-Else Statement\n", line_num); }
    ;

while_statement:
    WHILE LPAREN expression RPAREN statement { printf("[Line %d] Valid: While Loop\n", line_num); }
    ;

return_statement:
    RETURN expression SEMICOLON { printf("[Line %d] Valid: Return Statement\n", line_num); }
    ;

block:
    LBRACE program RBRACE
    ;

expression:
    expression PLUS expression
    | expression MINUS expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    | expression EQ expression
    | expression LT expression
    | IDENTIFIER
    | NUMBER_LITERAL
    | STRING_LITERAL
    | LPAREN expression RPAREN
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "\033[31mSyntax Error at line %d: %s near '%s'\033[0m\n", line_num, s, yytext);
}

int main() {
    printf("--- Starting Syntax Analysis ---\n");
    if (yyparse() == 0) {
        printf("\nResult: Parsing Completed Successfully!\n");
    } else {
        printf("\nResult: Parsing Failed due to syntax errors.\n");
    }
    return 0;
}