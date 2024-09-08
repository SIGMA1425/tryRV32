
regs = []
for i in range(32):
    regs.append(format(i, '05b'))

OUTPUT_FILE = "text.txt"
with open(OUTPUT_FILE, "w"):
    pass

def main():
    addi(1, 0, 5)
    addi(2, 0, 8)
    add(3, 1, 2)
    addi(4, 0, 2)
    sub(5, 3, 4)


def lui(dreg, imm):
    simm = (imm << 12) & 4294967295
    fimm = format(simm, '020b')
    inst = fimm + regs[dreg] + "0110111"
    output(inst, OUTPUT_FILE)

def add(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "000" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE)

def sub(rd, rs1, rs2):
    inst = "0100000" + regs[rs2] + regs[rs1] + "000" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE)

def xor(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "100" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE)

def addi(rd, rs1, imm):
    fimm = format(imm & 4095, '012b')
    inst = fimm + regs[rs1] + "000" + regs[rd] + "0010011"
    output(inst, OUTPUT_FILE)

def output(inst, filename):
    inst_int = int(inst, 2)
    inst_hex = format(inst_int, '08x')
    print(inst)
    print(inst_hex)
    byte = []
    byte.append(inst_hex[0:2])
    byte.append(inst_hex[2:4])
    byte.append(inst_hex[4:6])
    byte.append(inst_hex[6:8])
    print(byte)

    with open(filename, "a") as f:
        for b in byte[::-1]:
            f.write(b + '\n')
    


if __name__ == "__main__":
    main()