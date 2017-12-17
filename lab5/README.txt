Chuong Viet Truong
Chvtruon@ucsc.edu
1490515
Lab 5
Lab Section 02B

QUESTIONS:
1) Discuss the encode/decode algorithms. What similarities are there between them?

- For encode, we began the algorithm by creating a loop going from 0 to strlen(cleartext). For each iteration, we got the current index char of the cleartext and added that with (current index%strlen(key)) char of the key. We then add those two elements. Using the result of that, we % with ASCII (128) and then receive the character of that current index for our cipher text.

- Decode is quite similar. We began the algorithm by creating a loop going from 0 to strlen(cleartext). For each iteration, we got the current index char of the ciphered text and added that with (current index%strlen(key)) char of the key. We then subtract those two elements. Using the result of that, we % with ASCII (128) and then receive the character of that current index for our cipher text.

- They are both practically similar. The only difference is that since encode is looking to encrypt the text, it takes the element of cleartext and adds it with the element of the key. On the other hand, decode takes the element of ciphertext and subtracts it with the element of the key.

2) Discuss the functions you made and what you were required to save.

- I made functions to help out with decode and encode. I also made functions to count the character length of key and text. I was required to save the registers that stored the key and text because I had to increment through each bit individually in order to count the amount of character in both strings.