#!/bin/bash

# 定义要格式化的文件类型，可以根据需要进行修改
file_types=("*.c" "*.h")
for file_type in ${file_types[@]}; do
        find . -type f -name $file_type -exec clang-format -i {} \;
done

# 格式化最新的commit，并直接在原文件上修改
git diff -U0 HEAD^ | clang-format-diff -i -p1
