# write a function that executes a program and returns the exit code
define execute
	out/$(1)/$(2); echo $$?;
endef

# write a function to create a directory and compile the file
define compile
	mkdir -p out/$(1)
	as -g -o out/$(1)/$(2).o src/$(1)/$(2).s
	gcc -o out/$(1)/$(2) out/$(1)/$(2).o
endef

Introduction/FirstProgram: src/Introduction/FirstProgram.s
	$(call compile,Introduction,FirstProgram)
	$(call execute,Introduction,FirstProgram)

BasicArithmetic/Sum01: src/BasicArithmetic/Sum01.s
	$(call compile,BasicArithmetic,Sum01)
	$(call execute,BasicArithmetic,Sum01)

BasicArithmetic/Sum02: src/BasicArithmetic/Sum02.s
	$(call compile,BasicArithmetic,Sum02)
	$(call execute,BasicArithmetic,Sum02)

Memory/Load01: src/Memory/Load01.s
	$(call compile,Memory,Load01)
	$(call execute,Memory,Load01)

Memory/Store01: src/Memory/Store01.s
	$(call compile,Memory,Store01)
	$(call execute,Memory,Store01)

clean:
	rm -rf out