# Test 1 Exercise
# This program that gets a word of input from user, then capitalise all the letters
# MUHAMMAD AZRUL BIN NOOR AZMI 1811839 SECTION 1

 .data
 	buffer:		.space 100
 	welcome:	.asciiz "Welcome to capitalise your word program\n" #Prompt a welcoming message to the user 
 	enterWord:	.asciiz "Enter a word that exactly 5 small letters\n" #Prompt a message to the user to enter a word. The word must be of exactly 5 characters of small letters only
 	capitalize:	.asciiz "Capitalized: "
  .text 
  	main:
  	jal PrintString #Procedure for welcoming message
  
  #Prompt user to enter 5 small letter
  	la $a0, enterWord    # Load and print string asking for string
   	li $v0, 4
    	syscall

   	li $v0, 8       # take in input
    	la $a0, buffer  # load byte space into address
    	li $a1, 100      # allot the byte space for string
    	syscall
    	move $s0, $a0   # save string to s0

    	li $v0, 4
    	li $t0, 0

    	#Loop to capitalize
    	loop:
    	lb $t1, buffer($t0)    #Load byte from 't0'th position in buffer into $t1
   	beq $t1, 0, exit       #If ends, exit
    	blt $t1, 'a', not_lower  #If less than a, exit
    	bgt $t1, 'z', not_lower #If greater than z, exit
    	sub $t1, $t1, 32  #If lowercase, then subtract 32
    	sb $t1, buffer($t0)  #Store it back to 't0'th position in buffer

    	#if not lower, then increment $t0 and continue
    	not_lower: 
    	addi $t0, $t0, 1
    	j loop

    	exit:
    	la $a0, capitalize    # load and print "capitalized" string
    	li $v0, 4
    	syscall

    	move $a0, $s0   # primary address = s0 address (load pointer)
    	li $v0, 4       # print string
    	syscall
    	li $v0, 10      # end program
    	syscall
  	
  PrintString:
  	li $v0, 4
  	la $a0, welcome
  	syscall
  	jr $ra