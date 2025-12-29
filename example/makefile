# Makefile for Flex lexical analyzer
CC = gcc
CFLAGS = -Wall -Wextra -O2
FLEX = flex
TARGET = lexical_analyzer

all: $(TARGET)

$(TARGET): lex.yy.c
	$(CC) $(CFLAGS) -o $(TARGET) lex.yy.c -lfl

lex.yy.c: lexical_analyzer.l
	$(FLEX) lexical_analyzer.l

clean:
	rm -f $(TARGET) lex.yy.c *.o

run: $(TARGET)
	./$(TARGET)

test: $(TARGET)
	@echo "Testing with sample code..."
	@echo "int main() { int x = 5 + 3; if (x > 0) return x; }" | ./$(TARGET)

.PHONY: all clean run test
