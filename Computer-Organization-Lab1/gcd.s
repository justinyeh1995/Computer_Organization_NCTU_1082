.data #Data Section is used for declaring initialized data or constants
N1: .word 512
N2: .word 480
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text #Text Section is used for keeping the actual code.
main:
    lw       a0, N1
    lw       a1, N2
    mv       x21, a0  
    mv       x22, a1   
    # GCD
    jal      ra, gcd
    
    # Print the result to console
    lw       a2, N1
    lw       a3, N2    
    jal      ra, printResult

    # Exit program
    li       a0, 10
    ecall

gcd:         # a0 stores the result 
    # Push
    addi     sp,sp, -16  # adjust stack for 2 items(the content of ra, a0, a1)
    sw       ra, 8(sp)  # save the return address to stack so it can go back to main
    #sw       x21, 8(sp)  # save the argument N1 to stack
    #sw       x22, 0(sp)  # save the argument N2 to stack
    
    bne      x22, zero, L1 # if n != 0 then go to sub_gcd, and it also means that a0 stores the return value now 
    mv       a0, x21
    mv       a1, x22

    jalr     x0, x1, 0  # return

L1:
    mv       t1, x22     # t1 = n
    rem      x22, x21, x22 # a1 = r = m % n
    mv       x21, t1     # a0 = n
    jal      gcd
    
    # Pop
    # lw       x22, 0(sp)
	# lw       x21, 8(sp)
    lw       ra, 8(sp)
    addi     sp, sp, 16 # pop stack, don't bother restoring values
    jalr     x0, x1, 0  # return 
    
printResult:
	mv  t0, a0
    mv  t1, a1 

    la       a1, str1
    li       a0, 4
    ecall

    mv       a1, a2
    li       a0, 1
    ecall

    la       a1, str2
    li       a0, 4
    ecall

    mv       a1, a3
    li       a0, 1
    ecall

	la       a1, str3
    li       a0, 4
    ecall
    
    mv       a1, t0
    li       a0, 1
    ecall

    jalr     x0, x1, 0  # return 