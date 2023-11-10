
# === 伪目标
.PHONY: clean
clean:
# make -C drivers clean
# make -C freertos clean
# rm -f *.o *.elf *.bin
	echo $(OS)
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.elf")
	rm -f $(shell find -name "*.bin")
	rm -f $(shell find -name "*.dis")
# rm -f $(BIN_DIR)/$(TARGET_NAME).elf $(BIN_DIR)/$(TARGET_NAME).dis $(BIN_DIR)/$(TARGET_NAME).bin

.PHONY: distclean
distclean:
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.o.d")
	rm -f $(shell find -name "*.dis")
	rm -f $(shell find -name "*.elf")
	rm -f $(shell find -name "*.bin")
# rm -f $(BIN_DIR)/$(TARGET_NAME).elf $(BIN_DIR)/$(TARGET_NAME).dis $(BIN_DIR)/$(TARGET_NAME).bin

.PHONY: copy_target
copy_target:
	cp -f $(BIN_DIR)/$(TARGET_NAME).bin /mnt/d/Users/Desktop/

.PHONY: help
help:
	@printf "\
	Usage: make target... [options]...\n\
	\n\
	Targets:\n\
	  all             Build executable (debug mode by default) (default target)\n\
	  install         Install packaged program to desktop (debug mode by default)\n\
	  run             Build and run executable (debug mode by default)\n\
	  copyassets      Copy assets to executable directory for selected platform and configuration\n\
	  cleanassets     Clean assets from executable directories (all platforms)\n\
	  clean           Clean build and bin directories (all platforms)\n\
	  compdb          Generate JSON compilation database (compile_commands.json)\n\
	  format          Format source code using clang-format\n\
	  format-check    Check that source code is formatted using clang-format\n\
	  lint            Lint source code using clang-tidy\n\
	  lint-fix        Lint and fix source code using clang-tidy\n\
	  docs            Generate documentation with Doxygen\n\
	  help            Print this information\n\
	  printvars       Print Makefile variables for debugging\n\
	\n\
	Options:\n\
	  release=1       Run target using release configuration rather than debug\n\
	  win32=1         Build for 32-bit Windows (valid when built on Windows only)\n\
	\n\
	Note: the above options affect the all, install, run, copyassets, compdb, and printvars targets\n"

# Print Makefile variables
.PHONY: printvars
printvars:
	@printf "\
	OS:            \"$(OS)\"\n\
	BUILD_DIR:     \"$(BUILD_DIR)\"\n\
	BIN_DIR:       \"$(BIN_DIR)\"\n\
	ARCH:          \"$(ARCH)\"\n\
	CROSS_COMPILE: \"$(CROSS_COMPILE)\"\n\
	CC:            \"$(CC)\"\n\
	WARNFLAGS:     \"$(WARNFLAGS)\"\n\
	CFLAGS:        \"$(CFLAGS)\"\n\
	LDFLAGS:       \"$(LDFLAGS)\"\n\
	TARGET_NAME:        \"$(TARGET_NAME)\"\n"
.PHONY: time
time:
	echo "start test time"
	@time make

