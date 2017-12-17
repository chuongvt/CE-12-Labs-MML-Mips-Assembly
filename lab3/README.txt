Chuong Viet Truong
Chvtruon@ucsc.edu
1490515
Lab 3
Lab Section 02B

QUESTIONS:
1) Discuss the algorithm(s) you designed. Were there any issues in implementing them?

- I used many functions in order to write my code as it helped me organize it depending on what I wanted
each section of the code to do. The functions that I wrote were takeTwosComplement, printNewline, 
converStringToInt, convertIntToBinary, and printBitShiftMask. After recieving the string through the program
argument and storing it into $s0, I incremented through the first character and checked if it was negative
by using slt and using the result of that, depending on if it is a "1" or a "0" to increment it to the next
char or not. Next, I wrote convertStringToInt and turned the string into an int by storing each individual int
into the main int by multiples of 10. I then built the function takeTwosComplement to take 2's complement if
necessary and wrapped it up by converting it to binary through the functions convertIntToBinary and printBitShiftMask.
I implemented these functions by using a bit shift mask, using bitwise AND with the int and the mask, and then
shifting the mask and relooping it until we get all the necessary binary values. It did take a while to
implement the algorithms, but overall I did not have any issues.

2) Discuss any assembly language techniques you developed or discovered.

- I was quick to realize that MIPS was not an ordinary programming language. Since it is more low level and closer
to the hardware, there's a lot more to be done for simpler programs. During the assignment, I learned how to use
the branch statements. It's equivalent to conditional statements in higher level languages, but I learned that
it is implemented in a completely different way in MIPS. It's functionality is still similar in a sense that
it will execute the function/label if the conditon statement is met. I also learned how to shift bits in MIPS, 
which can be used for many other things such as multiplying or dividing in an efficient way.

3)Several pseudo-ops were needed to complete this lab. Compare the code written with the
assembled code and look at what the assembler did. How many more lines of assembly were
written?

It seems as if the basic column contains some different pseudo-ops in comparison with the source code, with 
similar functionality and also revealing the location addresses for the jumps. There are 16 more lines
of assembly.