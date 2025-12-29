%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* Function prototypes */
void print_token(const char* type, const char* value, int line);
void print_error(const char* value, int line);

/* Global line counter */
int line_num = 1;

/* Color codes for terminal output (optional) */
#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define YELLOW  "\x1b[33m"
#define BLUE    "\x1b[34m"
#define MAGENTA "\x1b[35m"
#define CYAN    "\x1b[36m"
#define RESET   "\x1b[0m"

%}

/* Definitions */
DIGIT       [0-9]
LETTER      [a-zA-Z]
ID          {LETTER}({LETTER}|{DIGIT}|_)*
NUMBER      {DIGIT}+(\.{DIGIT}+)?([eE][+-]?{DIGIT}+)?
WHITESPACE  [ \t]
NEWLINE     \n

%%

 /* Keywords */
"if"|"else"|"while"|"for"|"do"|"switch"|"case"|"default"|"break"|"continue"|"return"|"goto"|"class"|"override"|"private"|"protected"|"public" {
    print_token("KEYWORD", yytext, line_num);
}

"int"|"float"|"double"|"char"|"string"|"void"|"short"|"long"|"signed"|"unsigned"|"struct"|"union"|"enum"|"typedef" {
    print_token("DATA_TYPE", yytext, line_num);
}

"const"|"static"|"extern"|"auto"|"register"|"volatile"|"restrict" {
    print_token("STORAGE_CLASS", yytext, line_num);
}

"true"|"false"|"NULL" {
    print_token("CONSTANT", yytext, line_num);
}

"sizeof" {
    print_token("OPERATOR", yytext, line_num);
}

 /* Logical Operators */
"&&"|"||" {
    print_token("LOGICAL_OPERATOR", yytext, line_num);
}

"!" {
    print_token("LOGICAL_NOT", yytext, line_num);
}

"=="|"!=" {
    print_token("RELATIONAL_OPERATOR", yytext, line_num);
}

"<"|">"|"<="|">=" {
    print_token("RELATIONAL_OPERATOR", yytext, line_num);
}

 /* Mathematical Operators */
"+"|"-"|"*"|"/"|"%" {
    print_token("ARITHMETIC_OPERATOR", yytext, line_num);
}

"++"|"--" {
    print_token("INCREMENT_DECREMENT", yytext, line_num);
}

"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"<<="|">>=" {
    print_token("ASSIGNMENT_OPERATOR", yytext, line_num);
}

"&"|"|"|"^"|"~"|"<<"|">>" {
    print_token("BITWISE_OPERATOR", yytext, line_num);
}

"=" {
    print_token("ASSIGNMENT", yytext, line_num);
}

 /* Symbols */
"{"|"}"|"("|")"|"["|"]" {
    print_token("BRACKET", yytext, line_num);
}

";" {
    print_token("SEMICOLON", yytext, line_num);
}

"," {
    print_token("COMMA", yytext, line_num);
}

"." {
    print_token("DOT", yytext, line_num);
}

"->" {
    print_token("ARROW", yytext, line_num);
}

":" {
    print_token("COLON", yytext, line_num);
}

"?" {
    print_token("TERNARY_QUESTION", yytext, line_num);
}

 /* Numbers */
{NUMBER} {
    print_token("NUMBER", yytext, line_num);
}

 /* Identifiers */
{ID} {
    print_token("IDENTIFIER", yytext, line_num);
}

 /* Strings */
\"([^"\\]|\\.)*\" {
    print_token("STRING_LITERAL", yytext, line_num);
}

\'([^'\\]|\\.)*\' {
    print_token("CHARACTER_LITERAL", yytext, line_num);
}

 /* Comments */
"//".* {
    print_token("COMMENT", yytext, line_num);
}

"/*"([^*]|(\*+[^*/]))*\*+\/ {
    print_token("MULTILINE_COMMENT", yytext, line_num);
}

 /* Preprocessor Directives */
^#.* {
    print_token("PREPROCESSOR", yytext, line_num);
}

 /* Whitespace */
{WHITESPACE}+ {
    /* Ignore whitespace */
}

 /* Newline */
{NEWLINE} {
    line_num++;
}

 /* Any other character */
. {
    print_error(yytext, line_num);
}

%%

void print_token(const char* type, const char* value, int line) {
    /* Map token types to colors */
    const char* color = RESET;
    
    if (strcmp(type, "KEYWORD") == 0 || strcmp(type, "DATA_TYPE") == 0) {
        color = GREEN;
    } else if (strstr(type, "OPERATOR")) {
        color = YELLOW;
    } else if (strcmp(type, "IDENTIFIER") == 0) {
        color = CYAN;
    } else if (strcmp(type, "NUMBER") == 0) {
        color = MAGENTA;
    } else if (strstr(type, "BRACKET") || strcmp(type, "SEMICOLON") == 0 || strcmp(type, "COMMA") == 0) {
        color = BLUE;
    } else if (strstr(type, "LITERAL")) {
        color = RED;
    } else if (strstr(type, "COMMENT")) {
        color = "\x1b[90m";  /* Gray */
    }
    
    printf("[Line %3d] %-25s: %s%s%s\n", 
           line, type, color, value, RESET);
}

void print_error(const char* value, int line) {
    printf(RED "[Line %3d] ERROR: Invalid character '%s'\n" RESET, line, value);
}

int main(int argc, char** argv) {
    printf("===============================================\n");
    printf("      LEXICAL ANALYZER WITH FLEX\n");
    printf("===============================================\n\n");
    
    printf("%-25s %-15s %s\n", "TOKEN TYPE", "LINE", "VALUE");
    printf("%-25s %-15s %s\n", "----------", "----", "-----");
    
    if (argc > 1) {
        /* Read from file */
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
            return 1;
        }
    } else {
        printf("\nEnter your code (Ctrl+D to end):\n");
        printf("---------------------------------\n");
    }
    
    yylex();
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    printf("\n===============================================\n");
    printf("            ANALYSIS COMPLETE\n");
    printf("===============================================\n");
    
    return 0;
}

int yywrap() {
    return 1;
}
