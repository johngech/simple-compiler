#ifndef TOKENS_H
#define TOKENS_H

namespace minicpp {

// Removed "class" to allow implicit conversion to int
enum TokenType {
    // Start at 258 to avoid conflict with ASCII values used by Bison
    IF = 258,
    ELSE,
    WHILE,
    FOR,
    RETURN,
    SWITCH,
    CASE,
    DEFAULT,
    BREAK,
    CONTINUE,
    GOTO,
    DO,

    // Types
    INT,
    FLOAT,
    DOUBLE,
    CHAR,
    VOID,
    SHORT,
    LONG,
    SIGNED,
    UNSIGNED,
    BOOL,
    STRING,
    STRUCT,
    UNION,
    ENUM,
    CLASS,

    // C++ modifiers
    PUBLIC,
    PRIVATE,
    PROTECTED,
    VIRTUAL,
    OVERRIDE,
    CONST,
    STATIC,
    EXTERN,
    AUTO,
    REGISTER,
    VOLATILE,
    RESTRICT,

    // Constants
    TRUE,
    FALSE,
    NULLPTR,

    // Identifiers & literals
    IDENTIFIER,
    NUMBER,
    STRING_LITERAL,
    CHARACTER_LITERAL,

    // Operators
    PLUS,
    MINUS,
    MUL,
    DIV,
    MOD,
    ASSIGN,
    PLUS_ASSIGN,
    MINUS_ASSIGN,
    MUL_ASSIGN,
    DIV_ASSIGN,
    MOD_ASSIGN,
    EQ,
    NEQ,
    LT,
    GT,
    LE,
    GE,
    AND,
    OR,
    NOT,
    BITWISE_AND,
    BITWISE_OR,
    BITWISE_XOR,
    BITWISE_NOT,
    SHIFT_LEFT,
    SHIFT_RIGHT,
    INCREMENT,
    DECREMENT,

    // Symbols
    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,
    LBRACKET,
    RBRACKET,
    SEMI,
    COMMA,
    DOT,
    ARROW,
    COLON,
    TERNARY_QUESTION,

    // Preprocessor
    PREPROCESSOR,

    // End of file / error
    END_OF_FILE = 0, // Conventionally 0 is End Of File
    ERROR = -1
};

} // namespace minicpp

#endif