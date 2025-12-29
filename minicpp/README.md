# MiniCPP Compiler

A simple compiler for a subset of C++ that generates native executables.

## Features

- Parses and compiles basic C++-like programs with variables, arithmetic, assignments.
- Supports unary minus, post-decrement, and exponentiation (^).
- Print statements: `print(expr);` to display results.
- Generates C++ code and compiles it using the system compiler (g++/clang++).

## Usage

### Interpret (run without compiling)

```bash
./minicpp program.mc
```

### Compile to executable

```bash
./minicpp -c program.mc
./a.out  # Run the generated executable
```

Or specify output name:

```bash
./minicpp -c program.mc -o myprogram
./myprogram
```

## Language Subset

- Declarations: `int x;`
- Assignments: `x = expr;`
- Print: `print(expr);` (displays the value)
- Expressions: arithmetic (+, -, \*, /, ^), unary minus (-), post-decrement (--)
- No functions, classes, loops, conditionals yet.

## Building

```bash
make
```

Requires: bison, flex, g++

## Installation

Download the latest release from [GitHub Releases](https://github.com/yourusername/minicpp/releases).

### Linux

1. Download `minicpp-linux.tar.gz`
2. Extract: `tar -xzf minicpp-linux.tar.gz`
3. Move `minicpp` to `/usr/local/bin/` or add to PATH.

Or use the install script:

```bash
sudo ./install_ubuntu.sh
```

### Windows

1. Download `minicpp-windows.zip`
2. Extract and add `minicpp.exe` to your PATH.
3. Requires MinGW or MSVC for compilation (when using -c).

### macOS

1. Download `minicpp-macos.tar.gz`
2. Extract: `tar -xzf minicpp-macos.tar.gz`
3. Move `minicpp` to `/usr/local/bin/` or add to PATH.

## Examples

See `test.mc` for a sample program.
