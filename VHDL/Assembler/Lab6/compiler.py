OP = {
    'mv': 0, 'mvi': 1, 'add': 2, 'sub': 3, 'ld': 4, 'st': 5, 'mvnz': 6, 'halt': 7, 'data': "",
}

# 000 Rx Ry            mv Rx, Ry             Rx <- Ry
# 001 Rx xxx           mvi Rx, nextDIN       Rx <- nextDIN
# 010 Rx Ry            add Rx, Ry            Rx <- Rx + Ry
# 011 Rx Ry            sub Rx, Ry            Rx <- Rx - Ry
# 100 Rx Ry            ld Rx, Ry             Rx <- rom[Ry]
# 101 Rx Ry            st Rx, Ry             rom[Ry] <- Rx
# 110 Rx Ry            mvnz Rx, Ry           Rx <- Ry if G /= 0

asm = open('mul.asm', 'r')
code = asm.read()
asm.close()

result = """
-- MADE BY ME :))
-- THANKS FOR USING!

WIDTH=9;
DEPTH=128;

ADDRESS_RADIX=UNS;
DATA_RADIX=OCT;

CONTENT BEGIN
\t[0..127]\t:\t000;
"""

if __name__ == '__main__':
    i = 0
    for instrc in code.splitlines():
        if not instrc or instrc[0] == '%':
            continue

        opcode = instrc.split(" ")[0]
        par = instrc.replace(" ", "")[len(opcode):].split(",")

        instrcOct = ""

        if opcode == 'data':
            instrcOct = instrcOct + "\t" + str(int(par[0])) + "\t:\t"
        else:
            instrcOct = instrcOct + "\t" + str(i) + "\t:\t"

        if opcode != 'data':
            instrcOct = instrcOct + "{0:o}".format(OP[opcode])
            if opcode != 'halt':
                instrcOct = instrcOct + par[0][1]

        i = i + 1

        if opcode == 'halt':
            instrcOct = instrcOct + "00;\t-- halt"
        elif opcode == "data":
            instrcOct = instrcOct + "{0:03o}".format(int(par[1][1:])) + ";"
        elif opcode != 'mvi':
            instrcOct = instrcOct + par[1][1] + ";\t-- " + instrc
        else:
            instrcOct = instrcOct + "0;\t-- " + instrc + ";\n\t" + \
                str(i) + "\t:\t" + "{0:03o}".format(int(par[1][1:])) + ";"
            i = i + 1

        result = result + instrcOct + "\n"

result = result + "END;"

file = open('rom_file.mif', 'w')
file.write(result)
file.close()
