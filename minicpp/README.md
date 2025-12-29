# MiniCPP Compiler

A simple compiler for a subset of C++ that generates native executables.

## Features

- Parses and compiles basic C++-like programs with variables, arithmetic, assignments.
- Supports unary minus and post-decrement.
- Generates C++ code and compiles it using the system compiler (g++/clang++).

## Usage

### Interpret (run without compiling)
```bash
./minicpp program.mc
```

### Compile to executable
```bash
./minicpp -c program.mc -o output_exe
./output_exe
```

## Language Subset

- Declarations: `int x;`
- Assignments: `x = expr;`
- Expressions: arithmetic (+, -, *, /), unary minus (-), post-decrement (--)
- No functions, classes, loops, conditionals yet.

## Building

```bash
make
```

Requires: bison, flex, g++

## Installation

### Ubuntu
Run the install script:
```bash
sudo ./install_ubuntu.sh
```
This copies `minicpp` to `/usr/local/bin`.

### Windows
Download the Windows binary release, unzip, and add `minicpp.exe` to your PATH. Requires MinGW or MSVC for compilation.

## Examples

See `test.mc` for a sample program.