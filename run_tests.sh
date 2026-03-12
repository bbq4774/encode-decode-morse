#!/bin/bash

EXE="./my_morse.o"
IN_DIR="tests/input"
EXP_DIR="tests/expected"
RES_FILE="result.txt"
FINAL_LOG="final_report.txt"

# Xóa file report cũ nếu có và ghi tiêu đề
echo "===== KẾT QUẢ KIỂM THỬ TỰ ĐỘNG =====" > $FINAL_LOG
echo "------------------------------------" >> $FINAL_LOG

echo "Dang chay test... Vui long doi..."

for i in {01..10}
do
    num=$(echo $i | sed 's/^0//')
    
    # Chạy chương trình tùy theo loại test
    if [ $num -le 5 ]; then
        MODE="ENCODE"
        $EXE -e "$IN_DIR/$i.txt" > /dev/null 2>&1
    else
        MODE="DECODE"
        $EXE -d "$IN_DIR/$i.txt" > /dev/null 2>&1
    fi

    # Ghi log chi tiết vào file chung
    echo -n "Test Case $i [$MODE]: " >> $FINAL_LOG
    
    # So sánh không phân biệt khoảng trắng và xuống dòng
    if diff -w -B "$RES_FILE" "$EXP_DIR/$i.txt" > /dev/null; then
        echo "PASS" >> $FINAL_LOG
    else
        echo "FAIL" >> $FINAL_LOG
        echo "   -> Noi dung mong doi: $(cat $EXP_DIR/$i.txt)" >> $FINAL_LOG
        echo "   -> Noi dung thuc te : $(cat $RES_FILE)" >> $FINAL_LOG
    fi
done

echo "------------------------------------" >> $FINAL_LOG
echo "HOAN THANH! Xem chi tiet tai file: $FINAL_LOG"
echo "------------------------------------"
cat $FINAL_LOG # In luon ra man hinh cho tien