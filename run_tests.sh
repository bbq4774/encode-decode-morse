#!/bin/bash

EXE="./my_morse.o"
IN_DIR="tests/input"
EXP_DIR="tests/expected"
ACT_DIR="tests/actual_results"
RES_FILE="result.txt"
FINAL_LOG="final_report.txt"

# Create actual results directory if it doesn't exist
mkdir -p $ACT_DIR

# Log title
echo "===== Automation test =====" > $FINAL_LOG
echo "------------------------------------" >> $FINAL_LOG

echo "Running..."

for i in {01..10}
do
    num=$(echo $i | sed 's/^0//')
    
    # Run all test case (Encode + Decode)
    if [ $num -le 5 ]; then
        MODE="ENCODE"
        $EXE -e "$IN_DIR/$i.txt" > /dev/null 2>&1
    else
        MODE="DECODE"
        $EXE -d "$IN_DIR/$i.txt" > /dev/null 2>&1
    fi

    # Save current result to a separate file for each test case
    if [ -f "$RES_FILE" ]; then
        cp "$RES_FILE" "$ACT_DIR/${i}_actual.txt"
    fi

    # Write log to final_report file
    echo -n "Test Case $i [$MODE]: " >> $FINAL_LOG
    
    # Compare 2 file
    if diff -w -B "$RES_FILE" "$EXP_DIR/$i.txt" > /dev/null; then
        echo "PASS" >> $FINAL_LOG
    else
        echo "FAIL" >> $FINAL_LOG
        echo "   -> Expected: $(cat $EXP_DIR/$i.txt)" >> $FINAL_LOG
        echo "   -> Actualy : $(cat $RES_FILE)" >> $FINAL_LOG
    fi
done

echo "------------------------------------" >> $FINAL_LOG
echo "DONE! Log save in file: $FINAL_LOG"
echo "Check individual results in: $ACT_DIR/" # Notified storage path
echo "------------------------------------"
cat $FINAL_LOG