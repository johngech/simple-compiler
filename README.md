# Simple Compiler Project

This repository contains a simple compiler for a subset of C++ (called MiniCPP), along with an example lexical analyzer.

## MiniCPP Compiler

MiniCPP is a basic compiler that parses and compiles a small subset of C++ into native executables. It supports variables, arithmetic expressions (including exponentiation), assignments, and basic control structures.

### Features
- **Language Subset**: Declarations (`int x;`), assignments (`x = expr;`), expressions with `+`, `-`, `*`, `/`, `^` (exponentiation), unary `-`, and post-decrement (`--`).
- **Modes**: Interpret code or compile to executable using system `g++`.
- **Cross-Platform**: Binaries available for Linux, Windows, and macOS via GitHub Releases.

### Quick Start

#### Prerequisites
- For building from source: `bison`, `flex`, `g++` (or `clang++`).
- For using the compiler: `g++` installed on your system (for the `-c` compile mode).

#### Download and Install Pre-Built Binaries
1. Go to [Releases](https://github.com/johngech/simple-compiler/releases) and download the archive for your OS:
   - **Linux**: `minicpp-linux.tar.gz`
   - **Windows**: `minicpp-windows.zip`
   - **macOS**: `minicpp-macos.tar.gz`

2. Extract the archive:
   - Linux/macOS: `tar -xzf minicpp-linux.tar.gz` (or macOS equivalent)
   - Windows: Unzip `minicpp-windows.zip`

3. Move the `minicpp` binary (or `minicpp.exe` on Windows) to a directory in your PATH, e.g., `/usr/local/bin/` on Linux/macOS, or add it to your system's PATH.

4. Test it:
   ```bash
   minicpp --help  # If supported, or try compiling a file
   ```

#### Build from Source
1. Clone the repository:
   ```bash
   git clone https://github.com/johngech/simple-compiler.git
   cd simple-compiler
   ```

2. Build the compiler:
   ```bash
   cd minicpp
   make
   ```

3. (Optional) Install locally:
   - Linux: `sudo ./install_ubuntu.sh`
   - Or manually copy `minicpp` to `/usr/local/bin/`.

#### Usage
- **Interpret a file**: `./minicpp program.mc`
- **Compile to executable**: `./minicpp -c program.mc -o output_exe`

Example program (`test.mc`):
```
int a;
int b;
a = 3 + 4 * 2;
b = a + 10;
b = a--;
b = 2*2*(3^2*9)/10;
```

Run: `./minicpp test.mc` (interprets) or `./minicpp -c test.mc -o test_exe && ./test_exe` (compiles and runs).

## Example Lexical Analyzer
The `example/` folder contains a basic lexical analyzer built with Flex and Bison for demonstration.

To build and run:
```bash
cd example
make
./lexical_analyzer test.c
```

## Contributing
- Fork the repo, make changes, and submit a PR.
- For new features, update the parser, AST, and codegen accordingly.

## License
This project is open-source. See individual files for licensing details.