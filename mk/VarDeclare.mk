# === 编译工具链相关的变量 Begin
ARCH ?=
CROSS_COMPILE ?=

CC      ?=
AS  	?=
LD  	?=
CPP     ?=
AR      ?=
NM	    ?=
STRIP	?=
OBJCOPY ?=
OBJDUMP ?=

INCFLAGS :=
CFLAGS :=
CPPFLAGS :=

LDFLAGS :=
# === 编译工具链相关的变量 End

# PROJECT_ROOT_DIR: 整个项目的根目录路径, 是一个相对路径
# PROJECT_ABS_ROOT_DIR: 整个项目的根目录路径, 是一个绝对路径
# BUILD_ROOT_DIR: 编译输出文件 .o,.o.d 的根目录路径, 是相对于项目根目录而言的
# BIN_ROOT_DIR: 可执行文件 .bin, .img, .elf 的根目录路径, 是相对于项目根目录而言的
PROJECT_ROOT_DIR = .
PROJECT_ABS_ROOT_DIR = $(CURDIR)
BUILD_ROOT_DIR :=
BIN_ROOT_DIR :=

# VPATH: Makefile 中的特殊变量, 用于指定额外的搜索路径, 使得 Make 在这些路径下查找文件
# ! 必须给这个变量赋值
VPATH :=

# TARGET_NAME: 目标名称
# 比如: TARGET_NAME := test
TARGET_NAME :=

# ALL_INC_PATH: 整个项目中只要有头文件的文件夹, 将其路径加入到这个变量中
# EXCLUDE_INC_PATH: 如果有头文件不想纳入搜索中, 将其所在文件夹路径加入到这个变量中
# INC_PATH: 从 ALL_INC_PATH 中过滤掉 EXCLUDE_INC_PATH 中的文件夹
# 比如: \
	ALL_INC_PATH     = ./include ./include/xxx \
	EXCLUDE_INC_PATH = ./include \
	INC_PATH         = ./include/xxx
ALL_INC_PATH     :=
EXCLUDE_INC_PATH :=
INC_PATH         :=

# *ALL_CFILE_PATH:     整个项目中所有 .C 文件所在的文件夹路径
# *EXCLUDE_CFILE_PATH: 如果有整个文件夹的 .c 文件都不想纳入编译中, 将其所在文件夹路径加入到这个变量中
# !注意: 不光会排除这个文件夹路径, 还会将这个文件夹的子文件夹也排除
# *ONLY_INCLUDE_CFILE_PATH: 如果有整个文件夹的 .c 文件想纳入编译中, 将其所在文件夹路径加入到这个变量中
# !注意: 只会将这个文件夹路径纳入 C 文件的搜索, 并不会将这个文件夹的子文件夹也纳入后续 C 文件的搜索
# *CFILE_PATH: 从 ALL_CFILE_PATH 中过滤掉 EXCLUDE_CFILE_PATH 后剩下的文件夹路径
# 比如: \
	ALL_CFILE_PATH          = ./src ./src/bsp/uart  \
	EXCLUDE_CFILE_PATH      = ./src \
	ONLY_INCLUDE_CFILE_PATH = ./src/bsp/uart \
	CFILE_PATH              = ./src/bsp/uart
ALL_CFILE_PATH          :=
EXCLUDE_CFILE_PATH      :=
ONLY_INCLUDE_CFILE_PATH :=
CFILE_PATH              :=

# *ALL_SFILE_PATH: 整个项目中所有 .S 文件所在的文件夹路径
# *EXCLUDE_SFILE_PATH: 如果有整个文件夹的 .S 文件都不想纳入编译中, 将其所在文件夹路径加入到这个变量中
# !注意: 不光会排除这个文件夹路径, 还会将这个文件夹的子文件夹也排除
# *ONLY_INCLUDE_SFILE_PATH: 如果有整个文件夹的 .c 文件想纳入编译中, 将其所在文件夹路径加入到这个变量中
# !注意: 只会将这个文件夹路径纳入 .S 文件的搜索, 并不会将这个文件夹的子文件夹也纳入后续 .S 文件的搜索
# *SFILE_PATH: 从 ALL_SFILE_PATH 中过滤掉 EXCLUDE_SFILE_PATH 后剩下的文件夹路径
# 比如: \
	ALL_SFILE_PATH = ./src ./src/bsp/uart \
	EXCLUDE_SFILE_PATH = ./src \
	ONLY_INCLUDE_SFILE_PATH = ./src/bsp/uart \
	SFILE_PATH = ./src/bsp/uart
ALL_SFILE_PATH :=
EXCLUDE_SFILE_PATH :=
ONLY_INCLUDE_SFILE_PATH :=
SFILE_PATH :=

# ALL_CFILE:     整个项目中所有 .c 源文件, 将其文件路径加入到这个变量中
# EXCLUDE_CFILE: 如果有源文件不想被编译, 将其文件路径加入到这个变量中
# BUILD_CFILE:   从 ALL_CFILE 中过滤掉 EXCLUDE_CFILE 后的文件路径
# DIR_COBJ:      将 BUILD_CFILE 的 .c 后缀换成 .o 后缀, 表示就地编译
# 比如:  \
  	ALL_CFILE     := ./src/main.c ./src/uart/uart.c \
	EXCLUDE_CFILE := ./src/main.c \
	BUILD_CFILE   := ./src/uart/uart.c \
	DIR_COBJ      := ./src/uart/uart.o
ALL_CFILE     :=
EXCLUDE_CFILE :=
BUILD_CFILE   :=
DIR_COBJ      :=

# ALL_SFILE:     整个项目中所有 .S 源文件, 将其文件路径加入到这个变量中
# EXCLUDE_SFILE: 如果有源文件不想被编译, 将其文件路径加入到这个变量中
# BUILD_SFILE:   从 ALL_SFILE 中过滤掉 EXCLUDE_SFILE 后的文件路径
# DIR_SOBJ:      将 BUILD_SFILE 的 .S 后缀换成 .o 后缀, 表示就地编译
# 比如:  \
  	ALL_SFILE     := ./src/main.S ./src/uart/uart.S \
	EXCLUDE_SFILE := ./src/main.S \
	BUILD_SFILE   := ./src/uart/uart.S \
	DIR_SOBJ      := ./src/uart/uart.o
ALL_SFILE	  :=
EXCLUDE_SFILE :=
BUILD_SFILE	  :=
DIR_SOBJ      :=

# COBJFILE: 取出 BUILD_CFILE 中的值, 剔除路径, 剔除文件名后缀, 增加 .o 文件名后缀
# SOBJFILE: 取出 BUILD_SFILE 中的值, 剔除路径, 剔除文件名后缀, 增加 .o 文件名后缀
# OBJFILE: 取出 COBJFILE 和 SOBJFILE 中的值放入这个变量
# 比如: \
	BUILD_CFILE := ./src/uart/uart.c ./src/main.c \
	BUILD_SFILE := ./src/start.S \
	COBJFILE	:= uart.o main.o \
	SOBJFILE    := start.o \
	OBJFILE     := uart.o main.o start.o
COBJFILE		:=
SOBJFILE		:=
OBJFILE         :=

# BUILD_DIR_COBJ: 给 COBJFILE 加上构建路径
# BUILD_DIR_SOBJ: 给 SOBJFILE 加上构建路径
# BUILD_DIR_OBJ: 取出 BUILD_DIR_COBJ 和 BUILD_DIR_SOBJ 中的值放入这个变量
# 比如: \
	COBJFILE := uart.o main.o \
	SOBJFILE := start.o \
	BUILD_DIR_COBJ	  := obj/uart.o obj/main.o \
	BUILD_DIR_SOBJ    := obj/start.o \
	BUILD_DIR_OBJ     := obj/uart.o obj/main.o obj/start.o
BUILD_DIR_COBJ		:=
BUILD_DIR_SOBJ		:=
BUILD_DIR_OBJ       :=

# 导出所有声明的变量
export $(shell sed -n 's/^\([^#]*\) *=.*/\1/p' mk/VarDeclare.mk)

