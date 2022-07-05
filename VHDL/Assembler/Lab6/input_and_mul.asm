mv R6, R7
mvi R1, #256
ld r1, r1
# LOADED BTN State, active low => pressed = 0

add R1, R1
mvnz R7, R6

mvi R1, #384
ld r1, r1
# LOADED SW State to R1 = A

mvi R6, #256
st R1, R6
# Print A on HEX/LED

mv R6, R7
mvi R4, #256
ld r4, r4
# LOADED BTN State, active low => pressed = 0

add R4, R4
mvnz R7, R6

mvi R4, #384
ld r4, r4
# LOADED SW State to R4 = B

mvi R6, #256
st R4, R6
# Print B on HEX/LED

mvi   R2,#1
mv    R5,R7
add   R0, R1
sub   R4,R2
mvnz R7,R5

mvi R1, #256
st R0, R1
# Print on HEX/LED

halt