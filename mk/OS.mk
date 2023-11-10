# === 在不同操作系统上进行编译的针对性选项
# 检测当前编译平台使用的操作系统
ifeq ($(OS),Windows_NT) # OS is a preexisting environment variable on Windows
	OS = windows
else
	UNAME := $(shell uname -s)
	ifeq ($(UNAME),Darwin)
		OS = macos
	else ifeq ($(UNAME),Linux)
		OS = linux
	else
    	$(error OS not supported by this Makefile)
	endif
endif

# OS-specific settings
ifeq ($(OS),windows)
	# Link libgcc and libstdc++ statically on Windows
	LDFLAGS += -static-libgcc -static-libstdc++

	# Windows 32- and 64-bit common settings
	INCFLAGS +=
	LDFLAGS +=

	ifeq ($(win32),1)
		# Windows 32-bit settings
		INCFLAGS +=
		LDFLAGS +=
	else
		# Windows 64-bit settings
		INCFLAGS +=
		LDFLAGS +=
	endif
else ifeq ($(OS),macos)
	# macOS-specific settings
	INCFLAGS +=
	LDFLAGS +=
else ifeq ($(OS),linux)
	# Linux-specific settings
	INCFLAGS +=
	LDFLAGS +=
endif

# Windows-specific default settings
ifeq ($(OS),windows)
	ifeq ($(win32),1)
		# Compile for 32-bit
		CPPFLAGS += -m32
	else
		# Compile for 64-bit
		CPPFLAGS += -m64
	endif
endif

# OS-specific build, bin, and assets directories
BUILD_DIR := $(BUILD_ROOT_DIR)/$(OS)
BIN_DIR := $(BIN_ROOT_DIR)/$(OS)
ifeq ($(OS),windows)
	# Windows 32-bit
	ifeq ($(win32),1)
		BUILD_DIR := $(BUILD_DIR)32
		BIN_DIR := $(BIN_DIR)32
	# Windows 64-bit
	else
		BUILD_DIR := $(BUILD_DIR)64
		BIN_DIR := $(BIN_DIR)64
	endif
endif

