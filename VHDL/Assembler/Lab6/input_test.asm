mv R6, R7
mvi R0, #256
ld r0, r0
# LOADED BTN State, active low => pressed = 0

add R0, R0
mvnz R7, R6

mvi R0, #384
ld r0, r0
# LOADED SW State
halt