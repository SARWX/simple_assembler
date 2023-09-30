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

    LDR R0, =0x40011010     @       Adress of GPIOC_BSRR = = 0x40011010, simbol = idicates that the command is pseudo
    LDR R2, =0x200          @       New state of GPIOC_BSRR SET led

toggle:
    STR R2, [R0]            @       Toggle led
    CMP R2, #0x200          @       Check if led is set
    ITE NE
    LDRNE R2, =0x200        @       Set if wasn't set
    LDREQ R2, =0x2000000    @       Reset if was set

    LDR R1, =0xFFFFF        @       Set counter 
    B wait                  @       Execute wait function

wait:
    CMP R1, #0x0            @       While counter R0 > 0
    BEQ toggle              @       If R0 == 0 toggle led
    SUB R1, #0x1            @       Decrement counter
    B wait                  @       Return to the wait
    
