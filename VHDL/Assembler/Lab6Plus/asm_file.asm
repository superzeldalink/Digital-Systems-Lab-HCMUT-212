% R1 <= M[50]
mv   R1, #50
ld    R1, R1

% R2 <= SW (600 in oct)
in 01
mv R4, R7

mul R1, R4

% M[52] <= R0
mv R1, #52
st R6, R1

% R1 <= M[52]
mv   R1, #52
ld    R1, R1

% LED (200 in oct) <= R1
mv R7, R1
out 00

halt

data 50, #12