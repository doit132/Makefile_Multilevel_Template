# === 各种路径变量 Begin
# 当前 makefile 所在的文件路径, 也是项目的根目录
TOPDIR := $(shell pwd)

BUILD_DIR_ROOT = build
BUILD_DIR :=
BIN_DIR_ROOT = bin
BIN_DIR :=

export TOPDIR BUILD_DIR_ROOT BIN_DIR_ROOT BIN_DIR BUILD_DIR
# TODO 链接脚本路径, 头文件搜索路径 Begin
LDPATH :=

# 头文件搜索路径
INCDIRS :=
# TODO 链接脚本路径, 头文件搜索路径 End
# === 各种路径变量 End

# === 面向目标平台不同硬件架构的交叉编译工具链设置 Begin
ARCH  ?= arm
CROSS_COMPILE ?= arm-linux-

ifeq ($(ARCH),x86)
	CC := gcc
else
	CC := $(CROSS_COMPILE)gcc
endif

AS  	= $(CROSS_COMPILE)as
LD  	= $(CROSS_COMPILE)ld
CPP     = $(CC) -E
AR      = $(CROSS_COMPILE)ar
NM	= $(CROSS_COMPILE)nm
STRIP	= $(CROSS_COMPILE)strip
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

export AS LD CC CPP AR NM
export STRIP OBJCOPY OBJDUMP

# 函数的作用是将 INCDIRS 变量中的每个元素（目录名）前面加上 -I, 以构建用于指定头文件搜索路径的参数
INCFLAGS := $(patsubst %, -I %, $(INCDIRS))

# == 编译选项 Begin
# 警告选项
# 	-Wall : 开启所有常见的警告提示 \
  	-Wextra : 开启额外的警告提示, 包括一些非常规的代码风格和一些潜在的问题 \
  	-Wpedantic : \
		开启更严格的警告提示, 符合 C 或 C++ 标准的要求, 它会提供更严格的警告, 帮助你编写遵循语言标准的代码 \
  	-Wmissing-prototypes : \
  		用于检查是否存在函数原型的缺失, 函数原型是函数声明的一种形式, 它指定了函数的参数和返回类型, 使用函数原型可以帮助编译器检查函数调用的正确性, 并捕捉潜在的类型不匹配错误 \
  	-Wstrict-prototypes : \
		用于检查函数声明的严格性, 它要求函数声明中必须显式指定参数类型, 不允许使用旧式的省略号参数声明方式
WARNFLAGS := -Wall -Wpedantic -Wextra
WARNFLAGS += -Wmissing-prototypes -Wstrict-prototypes

# 字符编码选项
#   -fexec-charset=gbk : 告诉编译器在生成可执行文件时使用 GBK 字符集, 用于支持中文
CHARENCODINGFLAGS := -fexec-charset=gbk

CFLAGS := -fomit-frame-pointer
CFLAGS += $(WARNFLAGS) $(CHARENCODINGFLAGS)

CPPFLAGS:=
# == 编译选项 End

# TODO 链接选项 Beign
# 链接选项
# LDFLAGS := -T$(LDPATH)
# -nostdlib 不链接标准库
LDFLAGS := -nostdlib
# TODO 链接选项 End
export CFLAGS LDFLAGS INCFLAGS CPPFLAGS
# === 面向目标平台不同硬件架构的交叉编译工具链设置 End

# 在不同操作系统上进行编译的针对性选项
include mk/OS.mk
# debug or release mode
include mk/DR.mk

# TODO 被编译的目录, 被编译的当前目录下的文件 Beign
# 编译目标文件的名称
TARGET := test

# 被编译的当前目录下的文件
obj-y +=

# 被编译的子目录
obj-y += example/test01/
obj-y += example/test02/
obj-y += example/test03/
obj-y += src/
# TODO 被编译的目录, 被编译的当前目录下的文件 End

all : $(BIN_DIR) $(BIN_DIR)/$(TARGET).bin
	@echo $(TARGET) has been built!

$(BIN_DIR):
	@mkdir -p $(@D)

# 如果使用 CC 编译链接, 则会自动链接标准库文件, 如果使用 LD 则不会自动链接标准库文件
$(BIN_DIR)/$(TARGET).bin : start_recursive_build
	@echo "Building executable: $@"
	$(LD) $(LDFLAGS) -o $(BIN_DIR)/$(TARGET).elf $(wildcard **/*.o)
	$(OBJCOPY) -O binary -S $(BIN_DIR)/$(TARGET).elf $@
	$(OBJDUMP) -D -m arm $(BIN_DIR)/$(TARGET).elf > $(BIN_DIR)/$(TARGET).dis

start_recursive_build:
	$(MAKE) -C ./ -f $(TOPDIR)/Makefile.build

include mk/PHONY.mk
