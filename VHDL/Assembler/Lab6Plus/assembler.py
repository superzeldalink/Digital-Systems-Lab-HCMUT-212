import sys
opcodeList = {
    'mv' : '0000',
    'add' : '0001',
    'sub' : '0010',
    'mul' : '0011',
    'ld' : '0100',
    'st' : '0101',
    'cmp' : '0110',
    'br' : '0111',
    'not' : '10000',
    'tcpl' : '10001',
    'and' : '1001',
    'shl' : '10100',
    'shr' : '10101',
    'inc' : '11000',
    'dec' : '11001',
    'incc' : '11010',
    'decc' : '11011',
    'in' : '111100',
    'out' : '111101',
    'lda' : '11111110',
    'halt' : '11111111',
    'data' : '',
}

groups = [
    ['mv', 'add', 'sub', 'mul', 'cmp', 'and'],
    ['ld', 'st', 'br'],
    ['not', 'tcpl', 'shl', 'shr', 'inc', 'incc',' dec', 'decc'],
    ['in', 'out'],
    ['lda', 'halt']
]

result = """
-- MADE BY ME :))
-- THANKS FOR USING!

WIDTH=8;
DEPTH=65536;

ADDRESS_RADIX=UNS;
DATA_RADIX=BIN;

CONTENT BEGIN
\t[0..65535]\t:\t00000000;
"""

asm = open('asm_file.asm', 'r')
code = asm.read()
asm.close()


if __name__ == '__main__':
    i = 0
    for instrc in code.splitlines():
        try:
            instrc = instrc.lower()
            if not instrc or instrc[0] == '%':
                continue

            flags = 0

            opcode = instrc.split(" ")[0]
            opcodeBin = opcodeList[opcode]
            par = instrc.replace(" ", "")[len(opcode):].split(",")

            dest = 0
            src = 0
            
            if opcode == 'data':
                result += "\t" + str(par[0]) + "\t:\t"   
            else:
                result += "\t" + str(i) + "\t:\t"   

            if opcode == 'br':
                try:
                    if 'l' in par[0] : dest += 4
                    if 'e' in par[0] : dest += 2
                    if 'g' in par[0] : dest += 1
                except:
                    pass

            elif opcode == "data":
                result = result + "{0:08b}".format(int(par[1][1:])) + ";\n"

            elif opcode in groups[0] or opcode in groups[1] or opcode in groups[2]:
                dest = int(par[0][1])
                if dest > 7:
                    print("ERROR!")
                    sys.exit()

            elif opcode in groups[3]:
                dest = int(par[0])
                if dest > 4:
                    print("ERROR!")
                    sys.exit()
                

            if opcode in groups[0]:
                if par[1][0] == "r":
                    mode = 0
                    src = int(par[1][1])
                else:
                    mode = 1
                    if par[1][0] == "#":
                        src = int(par[1][1:])
                        if src > 255:
                            print("ERROR!")
                            sys.exit()
                result += "{0}{1}{2:03b}".format(opcodeBin, mode, dest) + ";\t--" + instrc + "\n"
                if par[1] != 'hl':
                    i += 1
                    result += "\t" + str(i) + "\t:\t" + "{0:08b}".format(src) + ";\n"

            elif opcode in groups[1]:
                if par[1] == 'hl':
                    mode = 1
                    src = 0
                else:
                    mode = 0
                    if par[1][0] == "r":
                        src = int(par[1][1])
                    else:
                        print("ERROR!")
                        sys.exit()

                result += "{0}{1}{2:03b}".format(opcodeBin, mode, dest) + ";\t--" + instrc + "\n"
                if par[1] != 'hl':
                    i += 1
                    result += "\t" + str(i) + "\t:\t"  + "{0:08b}".format(src) + ";\n"

            elif opcode in groups[2]:
                result += "{0}{1:03b}".format(opcodeBin, dest) + ";\t--" + instrc + "\n"

            elif opcode in groups[3]:
                result += "{0}{1:02b}".format(opcodeBin, dest) + ";\t--" + instrc + "\n"

            elif opcode in groups[4]:
                result += opcodeBin + ";\t--" + instrc + "\n"

            i += 1
        except Exception as e:
            print("ERROR! " + e)
            sys.exit()

result = result + "END;"

file = open('rom_file.mif', 'w')
file.write(result)
file.close()
