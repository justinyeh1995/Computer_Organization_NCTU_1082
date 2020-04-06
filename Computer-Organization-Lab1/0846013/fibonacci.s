.data
argument: .word 10 # Number to find the factorial value of
str1: .string "th number in the Fibonacci sequence is "

.text
main:
        lw       a0, argument   # Load argument from static data
        jal      ra, fibonacci  # Jump-and-link to the 'fibonacci' label

        # Print the result to console
        
        lw       a0, argument
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

fibonacci:
        # Push 
        addi     sp, sp, -16 # create space every time it is called
        sw       ra, 8(sp) # store to return later  
        sw       a0, 0(sp)  # a0 is the argument
        bne      a0, zero, ElseIf

        # If n==0, then 
        addi     x22, x22, 0 
        lw       ra, 8(sp)
        addi     sp, sp, 16   # pop stack
        ret # return to the caller

#Block1
ElseIf: 
        mv       a2, zero
        addi     a2, a2, 1
        bne      a0, a2, Else

        # If n==1, then
        addi     x22, x22, 1 
        lw       ra, 8(sp)
        addi     sp, sp, 16   # pop stack
        ret # return to the caller
        
#Block2
Else:  

        addi     a0, a0, -1 # n-1
        jal      ra  fibonacci # its result is at a0
       
        lw       a0, 0(sp)
        addi     a0, a0, -2
        jal      ra  fibonacci
        
        lw       ra, 8(sp)
        addi     sp, sp, 16
        ret      # return

printResult:
        mv       t0, x22 # result in x22
        mv       t1, a0  # argument  = 10

        mv       a1, t1
        li       a0, 1
        ecall

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        ret  # return