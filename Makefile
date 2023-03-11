# write a function that executes a program and returns the exit code
define execute
	out/$(1)/$(2); echo $$?;
endef

# write a function to create a directory and compile the file with gcc
define compilegcc
	mkdir -p out/$(1)
	as -g -o out/$(1)/$(2).o src/$(1)/$(2).s
	gcc -o out/$(1)/$(2) out/$(1)/$(2).o
endef

# write a function to create a directory and compile the file with as
define compile
	mkdir -p out/$(1)
	as -g -o out/$(1)/$(2).o src/$(1)/$(2).s
	ld -o out/$(1)/$(2) out/$(1)/$(2).o
endef

# ================================ INTRODUCTION ================================
Introduction/FirstProgram: src/Introduction/FirstProgram.s
	$(call compilegcc,Introduction,FirstProgram)
	$(call execute,Introduction,FirstProgram)

# ================================ BASIC ARITHMETIC ================================
BasicArithmetic/Sum01: src/BasicArithmetic/Sum01.s
	$(call compilegcc,BasicArithmetic,Sum01)
	$(call execute,BasicArithmetic,Sum01)

BasicArithmetic/Sum02: src/BasicArithmetic/Sum02.s
	$(call compilegcc,BasicArithmetic,Sum02)
	$(call execute,BasicArithmetic,Sum02)

# ================================ MEMORY ================================
Memory/Load01: src/Memory/Load01.s
	$(call compilegcc,Memory,Load01)
	$(call execute,Memory,Load01)

Memory/Store01: src/Memory/Store01.s
	$(call compilegcc,Memory,Store01)
	$(call execute,Memory,Store01)

Memory/LDR: src/Memory/LDR.s
	$(call compilegcc,Memory,LDR)
	$(call execute,Memory,LDR)

Memory/LoadPseudo: src/Memory/LoadPseudo.s
	$(call compilegcc,Memory,LoadPseudo)
	$(call execute,Memory,LoadPseudo)

# ================================ BRANCHING ================================
Branching/Branch01: src/Branching/Branch01.s
	$(call compilegcc,Branching,Branch01)
	$(call execute,Branching,Branch01)

Branching/Compare01: src/Branching/Compare01.s
	$(call compile,Branching,Compare01)
	$(call execute,Branching,Compare01)

# ================================ CONTROL ================================
ControlStructure/Sum22: src/ControlStructure/Sum22.s
	$(call compile,ControlStructure,Sum22)
	$(call execute,ControlStructure,Sum22)

ControlStructure/CollatzConjecture: src/ControlStructure/CollatzConjecture.s
	$(call compile,ControlStructure,CollatzConjecture)
	$(call execute,ControlStructure,CollatzConjecture)

ControlStructure/KevinsSum22: src/ControlStructure/KevinsSum22.s
	$(call compile,ControlStructure,KevinsSum22)
	$(call execute,ControlStructure,KevinsSum22)

# ================================ ARRAY AND STRCUTS ================================
ArrayNStruct/Array01: src/ArrayNStruct/Array01.s
	$(call compile,ArrayNStruct,Array01)
	$(call execute,ArrayNStruct,Array01)

ArrayNStruct/Array02: src/ArrayNStruct/Array02.s
	$(call compile,ArrayNStruct,Array02)
	$(call execute,ArrayNStruct,Array02)

# ================================ FUNCTIONS ================================
Function/Hello01: src/Function/Hello01.s
	$(call compilegcc,Function,Hello01)
	$(call execute,Function,Hello01)

Function/Printf01: src/Function/Printf01.s
	$(call compilegcc,Function,Printf01)
	$(call execute,Function,Printf01)

# ================================ UTILITY ================================
clean:
	rm -rf out