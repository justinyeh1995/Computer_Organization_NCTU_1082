.data
argument: .word 10
newline: .string "\n"
space: .string " "
str1: .string "Array: "
str2: .string "Sorted: "
data: .word   5 3 6 7 31 23 43 12 45 1  # integer is 4 bytes                     
        
.text
main:       
            la   a3, data               # load base address of data
            lw   a2, argument           # load argument into a2
            # print str1
            jal  ra, printResult1
            # print array
            jal  ra, printArray
            # bubblesort
            jal  ra, bubblesort
            # print str2
            jal  ra, printResult2
            # print array
            jal  ra, printArray
            # Exit program
            li       a0, 10
            ecall

bubblesort:
            addi  sp,sp, -40
            sw ra, 32(sp)
            sw s6, 24(sp) # n
            sw s5, 16(sp) # v
            sw s4, 8(sp)  # j
            sw s3, 0(sp)  # i
            # Procedure body
            mv s5, a3    # copy base address into x21
            mv s6, a2    # copy argument into x22
            
            # Outer loop
            li s3, 0     # i = 0, initial condition
for1ist:    bge s3, a2, exit1  # go to exit1 if i >= n
            
            # Inner loop
            addi s4,  s3, -1  # j = i-1, initial condition
for2tst:    blt s4, zero, exit2 # if x20 < zero exit2
            slli t0, s4, 2      # reg x5 = j*4
            add t0, s5, t0      # reg x5 = v + (j*4)
            lw t1, 0(t0)         # load v[j]: reg x6 = v[j]
            lw t2, 4(t0)         # load v[j+1]: reg x7 = v[j+1]
            ble t1, t2, exit2    # go to exit2 if x6 <= x7
            # Pass parameters and call 
            mv a0, s5           # first parameter is v
            mv a1, s4           # second parameter is j
            jal ra, swap         # call swap
            addi s4, s4, -1    # j--
            j for2tst            # go to the next iteration

exit2:      addi s3, s3, 1     # i++
            j for1ist            # jump to the next iteration of the outer loop

exit1:      lw s3, 0(sp)        # Restore x19 from stack
            lw s4, 8(sp)
            lw s5, 16(sp)
            lw s6, 24(sp)
            lw ra, 32(sp)
            addi sp, sp, 40
            jalr     x0, x1, 0   # Return to calling routine

swap:
            slli    t1, a1, 2    # reg x6 = k*4
            add     t1, a0, t1   # reg x6 = v + (k*4)
            lw      t0, 0(t1)    # reg x5 = v[k]
            lw      t2, 4(t1)    # reg x7 = v[k+1]
            sw      t2, 0(t1)    # v[k] = reg x7
            sw      t0, 4(t1)    # v[k+1] = reg x5
            jalr    x0, x1, 0   # Return to calling routine
            

printResult1: # print str1
            la       a1, str1
            li       a0, 4
            ecall    
            # print new line
            la       a1, newline
            li       a0, 4
            ecall                    
            
            jalr    x0, x1, 0   # Return to calling routine
            
printResult2: # print str2          
            la       a1, str2
            li       a0, 4
            ecall        
            # print new line
            la       a1, newline
            li       a0, 4
            ecall           

            jalr    x0, x1, 0   # Return to calling routine


printResult3: # printf("\n")
            la      a1,	newline
            li      a0,	4
            ecall
            jalr     x0, x1, 0   # Return to calling routine
           
printArray:
     
        li      t0, 0 # i = 0 (register x5 = 0)
loop:   
        slli    t1, t0, 2 # x6 = i * 4
        add     t2, a3, t1 # x7 = address of array[i]
        lw      t3, 0(t2)
        # Print data[i] value
        mv 	a1, t3
        li 	a0, 1
        ecall
	# Print space
        la      a1,  space
        li      a0,	4
        ecall
        # Increment
        addi 	t0, t0, 1 # i++
        blt 	t0, a2, loop
        # Pinrt newline
        la      a1,  newline
        li      a0,	4
        ecall
        # Return
        jalr	x0 x1 0