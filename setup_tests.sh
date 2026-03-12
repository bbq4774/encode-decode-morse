#!/bin/bash

# Tạo thư mục chứa dữ liệu
IN_DIR="tests/input"
EXP_DIR="tests/expected"
mkdir -p $IN_DIR $EXP_DIR

# Hàm hỗ trợ tạo file
create_tc() {
    echo "$2" > "$IN_DIR/$1.txt"
    echo "$3" > "$EXP_DIR/$1.txt"
}

echo "--- DANG TAO DU LIEU TEST ---"

# 5 Test Encode (01-05)
# TC01: SOS -> S: +++ | O: ========= | S: +++
create_tc "01" "SOS" "+++ ========= +++"

# TC02: VHT -> V: +++=== | H: ++++ | T: ===
create_tc "02" "Viettel Network Technologies Center 2018" "+++=== ++ + === === + +===++  ===+ + === +====== ========= +===+ ===+===  === + ===+===+ ++++ ===+ ========= +===++ ========= ======+ ++ + +++  ===+===+ + ===+ === + +===+  ++======= =========== +======== =======++"

# TC03: 2026 -> 2: ++======= | 0: =========== | 2: ++======= | 6: =====++++
create_tc "03" "2026" "++======= =========== ++======= =====++++"

# TC04: A B (Khoảng trắng giữa A và B)
# A: +=== | B: ===+++
create_tc "04" "A B" "+===  ===+++"

# TC05: Hello (Không phân biệt hoa thường)
# H: ++++ | E: + | L: +===++ | L: +===++ | O: =========
create_tc "05" "VHT 2026 Morse Code Testing 0123456789" "+++=== ++++ ===  ++======= =========== ++======= =====++++  ====== ========= +===+ +++ +  ===+===+ ========= ===++ +  === + +++ === ++ ===+ ======+  =========== +======== ++======= +++====== ++++===== +++++ =====++++ ======+++ =======++ ========+"

# 5 Test Decode (06-10)
# TC06: Giải mã AB -> A: +=== | B: ===+++
create_tc "06" "+=== ===+++" "AB"

# TC07: Giải mã từ HOME
# H: ++++ | O: ========= | M: ====== | E: +
create_tc "07" "++++ ========= ====== +" "HOME"

# TC08: Giải mã có khoảng trắng (A B)
create_tc "08" "+++ *===" "Invalid Morse"

# TC09: Giải mã số 09
# 0: =========== | 9: ========+
create_tc "09" "=========== ========+" "09"

# TC10: Test chuỗi không đúng chuẩn (Chứa ký tự lạ *)
# Bạn hãy đảm bảo code C in ra đúng chuỗi này khi gặp lỗi
create_tc "10" "+++========++++++======" "Invalid Morse"

echo "Done"