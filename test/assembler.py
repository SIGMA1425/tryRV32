
regs = []
for i in range(32):
    regs.append(format(i, '05b'))

oneline = False
OUTPUT_FILE = "./memory.txt"
with open(OUTPUT_FILE, "w"):
    pass

def main():
    addi(1, 0, 5)
    addi(2, 0, 5)
    slt(3, 1, 2)
    slt(4, 2, 1)
    sll(5, 1, 2)
    beq(1, 2, 8)
    addi(6, 0, 10)
    addi(6, 0, 16)
    # addi(2, 0, 8)
    # add(3, 1, 2)
    # addi(4, 0, 2)
    # add(5, 3, 4)
    # for i in range(32):
    #     addi(i, 0, i)
    for i in range(7):
        debug_a(i)



def lui(dreg, imm):
    fimm = format(imm & 1048575, '020b')
    inst = fimm + regs[dreg] + "0110111"
    output(inst, OUTPUT_FILE, oneline)

def auipc(rd, imm):
    fimm = format(imm & 1048575, '020b')
    inst = fimm + regs[rd] + "0010111"
    output(inst, OUTPUT_FILE, oneline)

def jal(rd, imm):
    fimm = format(imm & 1048575, '020b')
    inst = fimm[0] + fimm[10:20] + fimm[9] + fimm[1:9] + regs[rd] + "1101111"
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

def sll(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "001" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)


def srl(rd, rs1, rs2):
    inst = "0100000" + regs[rs2] + regs[rs1] + "101" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)


def sra(rd, rs1, rs2):
    inst = "0100000" + regs[rs2] + regs[rs1] + "101" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)


def slli(rd, rs1, imm):
    fimm = format(imm & 31, '05b')
    inst = "0000000" + fimm + regs[rs1] + "001" + regs[rd] + "0010011"
    output(inst, OUTPUT_FILE, oneline)


def srli(rd, rs1, imm):
    fimm = format(imm & 31, '05b')
    inst = "0000000" + fimm + regs[rs1] + "101" + regs[rd] + "0010011"
    output(inst, OUTPUT_FILE, oneline)

def srai(rd, rs1, imm):
    fimm = format(imm & 31, '05b')
    inst = "0100000" + fimm + regs[rs1] + "101" + regs[rd] + "0010011"
    output(inst, OUTPUT_FILE, oneline)


def slt(rd, rs1, rs2):
    inst = "0000000" + regs[rs2] + regs[rs1] + "010" + regs[rd] + "0110011"
    output(inst, OUTPUT_FILE, oneline)


def beq(rs1, rs2, imm):
    branch(rs1, rs2, imm, "000")

def bne(rs1, rs2, imm):
    branch(rs1, rs2, imm, "001")

def blt(rs1, rs2, imm):
    branch(rs1, rs2, imm, "100")

def branch(rs1, rs2, imm, funct):
    fimm = format(imm & 8191, '013b')
    inst = fimm[0] + regs[rs2] + regs[rs1] + funct + fimm[8:12] + fimm[1] + "1100011"
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
