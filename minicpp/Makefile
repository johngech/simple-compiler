CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -I/usr/include -I/usr/local/include

# All files to build
SRCS = parser/parser.cpp lexer/lexer.cpp ast/ast.cpp evaluators/evaluator.cpp codegen/codegen.cpp main.cpp
OBJS = $(SRCS:.cpp=.o)

all: minicpp

parser/parser.cpp parser/parser.hpp: parser/parser.y
	bison -d -o parser/parser.cpp parser/parser.y

lexer/lexer.cpp: lexer/lexer.l parser/parser.hpp
	flex -+ -o lexer/lexer.cpp lexer/lexer.l   # <-- Use -+ for C++ scanner

minicpp: $(OBJS)
	$(CXX) $(CXXFLAGS) -o minicpp $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f minicpp lexer/lexer.cpp parser/parser.cpp parser/parser.hpp $(OBJS)

.PHONY: all clean lexer parser
