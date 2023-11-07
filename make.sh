#!/bin/bash
# === 将编译信息输出到日志文件
LOG_DIR="log"
WARN_LOG_FILE="$LOG_DIR/warn.log"
INFO_LOG_FILE="$LOG_DIR/info.log"

LOG_FILES=("$WARN_LOG_FILE" "$INFO_LOG_FILE")

# 检查目录是否存在，不存在则创建
if [ ! -d "$LOG_DIR" ]; then
        mkdir -p "$LOG_DIR"
fi

# 检查文件是否存在，不存在则创建
for file in "${LOG_FILES[@]}"; do
        if [ ! -f "$file" ]; then
                touch "$file"
        fi
done

# 通过最后生成的 imx 后缀文件来判断编译是否成功
if ls ./bin/linux/*/*.dis 1>/dev/null 2>&1; then
        make distclean
fi

# 这里不能使用 make -jN 进行编译, 否则必定报错
make -j 1>log/info.log 2>log/warn.log
# === End

# 检测 log/warn.log 文件是否为空, 如果为空说明没有错误信息, 后续不需要对其内容进行正则替换
file_path="log/warn.log"
file_contents=$(cat "$file_path" | tr -d '[:space:]')

if grep -qiE "warn|error" "$file_path"; then
        code -r "$file_path"
fi

# 需要替换的字符串数组
search_string=(
        "/usr/local/arm/bin/arm-buildroot-linux-gnueabihf_sdk-buildroot/bin/../lib/gcc/arm-buildroot-linux-gnueabihf/7.5.0/../../../../arm-buildroot-linux-gnueabihf/bin/"
        "/usr/local/arm/bin/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/7.5.0/../../../../arm-linux-gnueabi/bin/"
        "(^.*?:$)"
)

# 替换成的字符串数组
replace_string=(
        "\n"
        "\n"
        "\n\1"
)

# 使用循环和 sed 命令对文件内容进行正则替换
for ((i = 0; i < ${#search_string[@]}; i++)); do
        sed -i -E "s#${search_string[$i]}#${replace_string[$i]}#g" "$file_path"
done

if ls ./bin/linux/*/*.dis 1>/dev/null 2>&1; then
        echo "编译成功!!!"
        make copy_target
        exit 0
fi
