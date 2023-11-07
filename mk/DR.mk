# === Debug Or Release 模式 Begin
# Debug (default) and release modes settings
ifeq ($(release),1)
	BUILD_DIR := $(BUILD_DIR)/release
	BIN_DIR := $(BIN_DIR)/release
	CFLAGS += -O3 -DNDEBUG
	CPPFLAGS += -O3 -DNDEBUG
else
	BUILD_DIR := $(BUILD_DIR)/debug
	BIN_DIR := $(BIN_DIR)/debug
	CFLAGS += -O0 -g
	CPPFLAGS += -O0 -g
endif
# === Debug Or Release 模式 End
