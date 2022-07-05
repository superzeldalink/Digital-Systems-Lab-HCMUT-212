% R1 <= M[50]
mvi   R1, #50
ld    R1, R1

% R2 <= SW (600 in oct)
mvi   R4, #384
ld    R4, R4

% R0 <= R1 * R4
mvi   R2,#1
mv    R5,R7
add   R0, R1
sub   R4, R2
mvnz R7, R5

% M[52] <= R0
mvi R1, #52
st R0, R1

% R1 <= M[52]
mvi   R1, #52
ld    R1, R1

% LED (200 in oct) <= R1
mvi R6, #128
st R1, R6

halt

data 50, #12