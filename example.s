.globl main
.text
.thumb
.syntax unified
main:
    LDR R0, =0x40021018     @       Adress of RCC_APB2ENR = 0x40021018, simbol = idicates that the command is pseudo
    LDR R1, [R0]            @       R1 = RCC_APB2ENR
    MOV R2, #0x10
    ORR R1, R1, R2          @       R1 |= 0x10
    STR R1, [R0]            @       RCC_APB2ENR = R1

    LDR R0, =0x40011004     @       Adress of GPIOC_CRH = = 0x40011004, simbol = idicates that the command is pseudo
    LDR R2, =0x44444424     @       New state of GPIOC_CRH
    STR R2, [R0]            @       Write new state to the GPIOC_CRH    *PC9 = output push-pull max speed 2 MHz

    LDR R0, =0x42220264     @       Adress of 25th bit GPIOC_BSRR = 0x42220264 BIT RESET, simbol = idicates that the command is pseudo
    LDR R1, =0x42220224     @       Adress of 9th bit GPIOC_BSRR = 0x42220264 BIT SET, simbol = idicates that the command is pseudo
    MOV R2, #0x1            
    STR R2, [R1]            @       Initial set state

toggle:

    STR R2, [R0]            @       Toggle reset state
    EOR R2, R2, #0x1        @       Change led state
    STR R2, [R1]            @       Toggle set state

    LDR R3, =0xFFFFF        @       Set counter 
    B wait                  @       Execute wait function

wait:
    CMP R3, #0x0            @       While counter R0 > 0
    BEQ toggle              @       If R0 == 0 toggle led
    SUB R3, #0x1            @       Decrement counter
    B wait                  @       Return to the wait
    
