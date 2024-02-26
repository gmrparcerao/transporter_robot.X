COMMENT @
    Sao Paulo State Technology College of Itaquera "Professor Miguel Reale"
    Sao Paulo, 2019/04/19
    Associate of Science in Industrial Automation

    Names of undergraduate students:
      Bruno Ryuiti Kitano
      Gabriel Liobino Sampaio
      Guilherme Matheus Rafael Parcerão
      Matheus Batista Rodrigues Carvalho
      
    Lecturer:
      Eder Terceiro

    Goals: 
      Software to control start and stop of a robot based on the track color

    Hardware:
      PIC16F648A
      Resistors
      Hbridge module
      DC motor
      LDR sensors
      Colorless high-brightness LED

    Reviews: 
      R000 - begin

    This code is for didatic purposes only. No warranty of any kind is provided.
@

#include "p16f648a.inc"

__CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
    radix dec
    org 0x00
    cblock 0x20
    loop1, loop2, loop3
    endc
    bsf STATUS, RP0
    movlw b'11110110'
    ; 0 = output to PIC
    ; 1 = 2 = input for module
    ; 3 = output to H-bridge
    ; 4 = reset input
    movwf TRISB
    bcf STATUS, RP0
    bcf PORTB, 0
    call delay

test
    btfsc PORTB, 1
    goto main
    btfsc PORTB, 2
    goto main
    goto condition

main
    goto test

condition
    btfsc PORTB, 0
    goto stop
    goto start
    
delay
    movlw .20
    movwf loop3

mid
    movlw .250
    movwf loop2
    
exter
    movlw .250
    movwf loop1
    
intern
    nop
    decfsz loop1, 1
    goto intern
    decfsz loop2, 1
    goto exter
    decfsz loop3, 1
    goto mid
    return
    
start
    bsf PORTB, 0
    call delay
    goto test
    
stop
    bcf PORTB, 0
    goto stop
    
end
