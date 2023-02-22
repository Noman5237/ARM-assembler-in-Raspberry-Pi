# write a function that executes a program and returns the exit code
define execute
	$(1)
	echo $$?
endef

Introduction/FirstProgram: Introduction/FirstProgram.o
	gcc -o out/Introduction/FirstProgram out/Introduction/FirstProgram.o
	$(call execute, out/Introduction/FirstProgram)


Introduction/FirstProgram.o: src/Introduction/FirstProgram.s
	mkdir -p out/Introduction
	as -g -o out/Introduction/FirstProgram.o src/Introduction/FirstProgram.s

clean:
	rm -rf out