#!/usr/bin/env bash  

TABLENAME=symbols


SYMBOL_DB_FILE="symbols"

# 方法列表
STRING_SYMBOL_FILE="func.list"

# 当前文件的头
HEAD_FILE="$PROJECT_DIR/$PROJECT_NAME/codeObfuscation.h"


export LC_CTYPE=C
# 创建数据库使用
createTable(){
    echo "create table $TABLENAME(src text, des text);" | sqlite3 $SYMBOL_DB_FILE
}
# 插入数据库使用
insertValue(){
   echo "insert into $TABLENAME values('$1' ,'$2');" | sqlite3  $SYMBOL_DB_FILE
}
# 查询数据库使用
query(){
   echo "select * from $TABLENAME where src='$1';" | sqlite3 $SYMBOL_DB_FILE
}

# 进行生成随机方法名
ramdomString(){
    openssl rand -base64 64 | tr -cd 'a-zA-Z' |head -c 16
}
# 移除数据路文件
rm -f $SYMBOL_DB_FILE
# 移除头文件
rm -f $HEAD_FILE

# 进行创建数据库
createTable

# 创建头文件
touch $HEAD_FILE


# 进行定义头文件
echo '#ifndef Demo_codeObfuscation_h

#define Demo_codeObfuscation_h' >> $HEAD_FILE

echo "//confuse string at `date`" >> $HEAD_FILE

# 进行查看到昂前的文件内容
cat "$STRING_SYMBOL_FILE" | while read -ra line; do

if [[ ! -z "$line" ]]; then

# 生成谁技术
ramdom=`ramdomString`

echo $line $ramdom
# 插入数据
insertValue $line $ramdom

echo "#define $line $ramdom" >> $HEAD_FILE

fi

done

echo "#endif" >> $HEAD_FILE

sqlite3 $SYMBOL_DB_FILE .dump

