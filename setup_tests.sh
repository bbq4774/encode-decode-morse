#!/bin/bash

# Make directory
IN_DIR="tests/input"
EXP_DIR="tests/expected"
mkdir -p $IN_DIR $EXP_DIR

# Creat test case
create_tc() {
    echo "$2" > "$IN_DIR/$1.txt"
    echo "$3" > "$EXP_DIR/$1.txt"
}

echo "--- Creating test case ---"

# 5 Test Encode (01-05)
# TC01: SOS -> S: +++ | O: ========= | S: +++
create_tc "01" "SOS" "+++ ========= +++"

# TC02: String
create_tc "02" "Viettel Network Technologies Center 2018" "+++=== ++ + === === + +===++  ===+ + === +====== ========= +===+ ===+===  === + ===+===+ ++++ ===+ ========= +===++ ========= ======+ ++ + +++  ===+===+ + ===+ === + +===+  ++======= =========== +======== =======++"

# TC03: 2026 -> 2: ++======= | 0: =========== | 2: ++======= | 6: =====++++
create_tc "03" "2026" "++======= =========== ++======= =====++++"

# TC04: A B (Space between A and B)
# A: +=== | B: ===+++
create_tc "04" "A B" "+===  ===+++"

# TC05: String
create_tc "05" "VHT 2026 Morse Code Testing 0123456789" "+++=== ++++ ===  ++======= =========== ++======= =====++++  ====== ========= +===+ +++ +  ===+===+ ========= ===++ +  === + +++ === ++ ===+ ======+  =========== +======== ++======= +++====== ++++===== +++++ =====++++ ======+++ =======++ ========+"

# 5 Test Decode (06-10)
# TC06: AB -> A: +=== | B: ===+++
create_tc "06" "+=== ===+++" "AB"

# TC07: HOME
# H: ++++ | O: ========= | M: ====== | E: +
create_tc "07" "++++ ========= ====== +" "HOME"

# TC08: String have invalid character
create_tc "08" "+++ *===" "Invalid Morse"

# TC09: 09
# 0: =========== | 9: ========+
create_tc "09" "=========== ========+" "09"

# TC10: String invalid
create_tc "10" "+++========++++++======" "Invalid Morse"

echo "Done"