# Chuong Viet Truong
# Lab 3
# October 29th, 2017
# Decimal to Binary Converter

.data
newLine:         .asciiz "\n"
welcomeMsg:      .asciiz "Welcome to Decimal to Binary Conversion."
inPrefix:        .asciiz "Input Number: "
outPrefix:       .asciiz "Output Number: "
bitArray:        .space  128

.text
main:
	# Store program argument into register $s0
	move	     $s0, $a1
	lw	         $s0, ($s0)
	
	# Load welcome message to register $a0 and run it using syscall 4
	la	         $a0, welcomeMsg 
	li	         $v0, 4 
	syscall 
	
	jal          printNewLine
	
	# Print input prefix
	la           $a0, inPrefix
	li           $v0, 4
	syscall	
	
	# Print out string of the number
	move         $a0, $s0
	li           $v0, 4
	syscall
	
	jal          printNewLine
	
	# Load first character
	lb           $t1, ($s0)
	
	# Check if first char is negative & set flag to register $t0
	addi         $t2, $t2, 47
	slt          $t0, $t1, $t2
	
	# Increment to next char if negative
	add          $s0, $s0, $t0
	
	jal          convertStringToInt
	
	bne          $t0, $0, takeTwosComplement
	
	continueCode1:
	# Print output prefix
	la           $a0, outPrefix
	li           $v0, 4
	syscall
	
	# Load bitmask to register $t3 and position mask                  
	addi         $t3, $0, 1                   
	sll          $t3, $t3, 31 
	
	# Set register $t4 to 0 and loop counter
	add          $t4, $0, $0
	addi         $t5, $0, 0
	
	jal convertIntToBinary
	
	continueCode2:
	
	# Exit the program by loading syscall 10 to register $v0 & doing it
	li	         $v0, 10
	syscall 
	
takeTwosComplement:
	not          $t7, $t7
	addi         $t7, $t7, 1
	# Return back to code after taking 2s C
	j            continueCode1    

# Function to print a new line
printNewLine:
	la           $a0, newLine
	li           $v0, 4
	syscall
	
	jr           $ra
	
# Function to convert String to an Integer
convertStringToInt:
	lb           $t1, ($s0)                      # Loads next char
	add          $t1, $t1, -48                   # Converts char to int
	mul          $t7, $t7, 10                    # Multiply number by 10
	add          $t7, $t7, $t1                   # Add the next number into int
	add          $s0, $s0, 1                     # Increment to next char
	lb           $t1, ($s0)                      # Loads next char
	bne          $t1, $0, convertStringToInt     # Re loop if char still exists
	
	jr           $ra
	
# Function to convert Integer to Binary
convertIntToBinary:
	and          $t4, $t7, $t3                   # Bitwise AND int & mask, then store into register $t4
	beq          $t4, $0, printBitShiftMask      # If result from $t4 is 0, print the bit 0
	add          $t4, $0, $0                     # Clear register $t4
	addi         $t4, $0, 1                      # Add 1 to $t4

	j            printBitShiftMask               # Jumps to printBit and prints 1
	
printBitShiftMask:
	li           $v0, 1            
	move         $a0, $t4
	syscall
	
	srl          $t3, $t3, 1                     # Shift the mask to the right by 1
	add          $t5, $t5, 1                     # Increment the loop index by 1
	bne          $t5, 32, convertIntToBinary     # If index is not 32, reloop
	# Return back to code after converting to binary
	j            continueCode2
