# Chuong Viet Truong
# CE 12
# Lab 5
# November 25th, 2017

.data
newLine:         .asciiz "\n"
keyInMsg:        .asciiz "The given key is: "
textInMsg:       .asciiz "The given text is: "
encryptMsg:      .asciiz "The encrypted text is: "
decryptMsg:      .asciiz "The decrypted text is: "
ascii:           .word   128
cipherText:      .space  101
decipherText:    .space  101

.text
main:
	# Counters/strlen for function to find key & text length
	li  		 $t8, 0           			# Key strlen
	li    		 $t9, 0       	 		    # Text strlen

	# Load key to $s0
	lw	         $s0, ($a1)
	
	# Load clear text to $s1
	lw           $s1, 4($a1)
	
	# Get the length for key and text
	jal 		 keyAndTextLength

	# Print key input message
	la	         $a0, keyInMsg 
	li	         $v0, 4 
	syscall 
	
	# Print key
	la	         $a0, ($s0) 
	li	         $v0, 4 
	syscall 
	
	jal          printNewLine
	
	# Print text input message
	la           $a0, textInMsg
	li           $v0, 4
	syscall	
	
	# Print clear text
	la	         $a0, ($s1) 
	li	         $v0, 4 
	syscall 
	
	jal          printNewLine
	
	# Print encrypt output message
	la           $a0, encryptMsg
	li           $v0, 4
	syscall	
	
	# Encode
	li           $t0, 0           			# Encode counter
	jal 		 encode
	
	jal 		 printEncryption
	
	jal          printNewLine

	# Print decrypt output message
	la           $a0, decryptMsg
	li           $v0, 4
	syscall	
	
	# Zero out the registers $t0 & $t2-$t6
	li           $t0, 0           			# Decode counter
	li           $t2, 0
	li           $t3, 0
	li           $t4, 0
	li           $t5, 0
	li           $t6, 0
	# Decode
	jal 		 decode
	
	jal 		 printDecryption
	
	j 			 endProg

# Function to encode text
encode:
	blt          $t0, $t9, cipherTheText    # Reloop if counter DNE strlen(text)
	sb           $0, cipherText($t0)
	
	jr 			 $ra
	
cipherTheText:
	lb           $t2, ($s1)  				# Load char from text to cipher
	rem          $t3, $t0, $t8				# Get counter % strlen(key)
	
	addi 		 $sp, $sp, -4				
	sw 			 $s0, 0($sp)	        	# Store key in stack
	 
	j            getKeyForE
	continueCiphering:
	
	add          $t4, $t2, $t6              # Add text char & key char together
	rem          $t4, $t4, 128              # After added, % with ASCII (128)
	
	sb           $t4, cipherText($t0)       # Store the result byte in cipherText 
	
	lw 			 $s0, 0($sp)            	# Load key from stack
	addi 		 $sp, $sp, 4
	
	addi 		 $s1, $s1, 1                # Increment text to next char
	addi         $t0, $t0, 1                # Increment counter
	j            encode

# Function to get the needed key char
getKeyForE:
	 add         $s0, $s0, $t3
	 lb          $t6, ($s0)
	 
	 j           continueCiphering
	
# Function to print encrypted text
printEncryption:
	la           $t5, cipherText
	move         $a0, $t5
	li           $v0, 4
	syscall
	
	jr           $ra

# Function to decode text
decode:
	blt          $t0, $t9, decipherTheText  # Reloop if counter DNE strlen(text)
	
	jr           $ra
	
decipherTheText:
	lb           $t2, cipherText($t0)       # Load char from cipherText
	rem          $t3, $t0, $t8              # Get counter % strlen(key)
	
	addi 		 $sp, $sp, -4
	sw 			 $s0, 0($sp)	        	# Store key in stack
	 
	j            getKeyForD
	continueDeciphering:
	
	sub          $t4, $t2, $t6              # Add cipherText char & key char together
	remu         $t4, $t4, 128				# Get counter % strlen(key)
	
	sb           $t4, decipherText($t0)
	
	lw 			 $s0, 0($sp)            	# Load key from stack
	addi 		 $sp, $sp, 4
	
	addi         $t0, $t0, 1                # Increment counter
	j            decode
	
getKeyForD:
	 add         $s0, $s0, $t3
	 lb          $t6, ($s0)
	 
	 j           continueDeciphering
	 
# Function to print decrypted text
printDecryption:
	la           $t5, decipherText
	move         $a0, $t5
	li           $v0, 4
	syscall
	
	jr           $ra
	
# Function to get strlen of key and text
keyAndTextLength:
	addi 		 $sp, $sp, -12      
	sw 			 $s0, 0($sp)	  		    # Store key in stack       
	sw 			 $s1, 4($sp)      			# Store text in stack
	sw 			 $ra, 8($sp)
	
	j kLoop
	
kLoop:
	lb 			 $t7, 0($s0)     			# Load next character of key onto $t7
	beqz 		 $t7, tLoop       			# Move onto text length if end of key
	addi 		 $s0, $s0, 1     			# Increment the key string pointer
	addi 		 $t8, $t8, 1
	j 			 kLoop
	
tLoop:
	lb 			 $t6, 0($s1)
	beqz 		 $t6, exitTAndKLoop
	addi 		 $s1, $s1, 1
	addi 		 $t9, $t9, 1
	j 			 tLoop
	
exitTAndKLoop:
	lw 			 $s0, 0($sp)     			# Load key from stack
	lw 			 $s1, 4($sp)      			# Load text from stack
	lw 			 $ra, 8($sp)
	addi 		 $sp, $sp, 12

	jr 			 $ra
	
# Function to print a new line
printNewLine:
	la           $a0, newLine
	li           $v0, 4
	syscall	

	jr           $ra

# Function to exit program
endProg:
	li	         $v0, 10
	syscall 
