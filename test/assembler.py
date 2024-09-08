
regs = []
for i in range(32):
    regs.append(format(i, '05b'))

oneline = False
OUTPUT_FILE = "./memory.txt"
with open(OUTPUT_FILE, "w"):
    pass

def main():
    # addi(1, 0, 5)
    # addi(2, 0, 8)
    # add(3, 1, 2)
    # addi(4, 0, 2)
    # add(5, 3, 4)
    for i in range(32):
        addi(i, 0, i)
    for i in range(32):
        debug_a(i)


def lui(dreg, imm):
    simm = (imm << 12) & 4294967295
    fimm = format(simm, '020b')
    inst = fimm + regs[dreg] + "0110111"
    output(inst, OUTPUT_FILE, oneline)

def add(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "000" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)

def sub(rd, rs1, rs2):
    inst = "0100000" + regs[rs2] + regs[rs1] + "000" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)

def xor(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "100" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)

def addi(rd, rs1, imm):
    fimm = format(imm & 4095, '012b')
    inst = fimm + regs[rs1] + "000" + regs[rd] + "0010011"
    output(inst, OUTPUT_FILE, oneline)

def debug_a(rs1):
    inst = "000000000000" + regs[rs1] + "00000000" + "0001011"
    output(inst, OUTPUT_FILE, oneline)

def output(inst, filename, oneline=False):
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
        if oneline:
            f.write("".join(byte[::-1]) + '\n')
        else:
            for b in byte[::-1]:
                f.write(b + '\n')
    


if __name__ == "__main__":
    main()