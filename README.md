# What is Hahing?
Hashing is the process of scrambling raw information to the extent that it cannot reproduce it back to its original form. It takes a piece of information and passes it through a function that performs mathematical operations on the plaintext. This function is called the hash function, and the output is called the hash value/digest. 

# Difference between Hashing and Encryption?
Encryption is a reversible process that transforms data into an unreadable format (ciphertext) that can be decrypted back into the original text (plaintext) with a key. Hashing, on the other hand, is a one-way function that converts data into a fixed-length string (hash value) that cannot be reversed. It's primarily used for data integrity verification and password storage.  

# What is SHA 256 Algorithm?
SHA 256 is a part of the SHA 2 family of algorithms, where SHA stands for Secure Hash Algorithm. Published in 2001, it was a joint effort between the NSA and NIST to introduce a successor to the SHA 1 family, which was slowly losing strength against brute force attacks.
The significance of the 256 in the name stands for the final hash digest value, i.e. irrespective of the size of plaintext/cleartext, the hash value will always be 256 bits.
The other algorithms in the SHA family are more or less similar to SHA 256. Now, look into knowing a little more about their guidelines.

Embark on a transformative journey through our Cyber security Bootcamp, where you'll delve deep into the intricacies of cutting-edge technologies like the SHA-256 algorithm. Uncover the cryptographic principles that make this algorithm the cornerstone of blockchain security, all while honing your skills in defending against cyber threats. 


# Project 
## Structure

* SHA-256 Overview: Implements the 64-round iterative compression function as defined in FIPS PUB 180-4.
Core Components:
   - Message Scheduler: Expands the 512-bit input message into 64 words.
   - Compression Logic: Processes message blocks with the SHA-256 round functions.
  - State Registers: Maintains the working state of hash values
