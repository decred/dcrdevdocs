# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Proof Of Work

---



## Proof Of Work (PoW)

Proof-of-Work (PoW) is the mechanism used by miners to show that they 
have contributed enough computational power to create new blocks. This
is done to make it expensive for malicious actors to add new blocks
to the chain. 

PoW takes advantage of the pseudorandom nature of hash functions[]. A 
hash function is a cryptographic function that produces a fixed-size 
hash value from a variable-size input. Regardless of the size of the value
input into the hash function, the output is a fixed-size value. If
the data input to the hash function is modified in any way, and the hash
re-run, a new random number is produced. There is no way to
modify the data in a way that makes the output of the hash function 
predictable. While it is computationally easy to create a hash from an input, it is 
extremely computationally difficult to calculate an input that will 
produce a given hash. Decred’s Proof-of-Work uses the BLAKE-256 [] 
hashing function.

After a miner successfully adds a new block to the chain, miners 
begin searching for the next block. They do this by computing a hash
function which contains the block header from the last block (proving
they haven't started searching before the last block was added), plus  
a "nonce". The nonce is simply a single digit appended to the block
header. Its purpose is simply to make the hash function output random. 
Remember, if we change one digit of the input, the hash function gives
a completely new random number. The first miner to create a hash that
does not exceed a certain value wins the right to create the next block.
By finding the nonce that creates this hash, they have proved they have
contributed a certain amount of work (computational power). 

If an attacker modified a block (e.g. to double spend coins), because 
the hash includes the block header from the previous block, they must
continue to create blocks that include the modified transactions. As 
soon as an honest miner checks the blockchain and sees the illegal transaction,
it will revert the chain to the original split (just made this up, needs
review). Since
this requires, on average, as much hashing power as the entire network 
expended between the time the original modified block was created and 
the present time, PoW makes it very expensive to attack. 


### Difficulty

The difficulty refers to the the value a miner's hash must be below
to find a block. The higher this number, the lower the difficulty, which
is a measure of the average amount of computational power a miner must 
spend to find the hash. 

[NOTE: below is taken basically word for word from Bitcoin docs, and 
need updating]

To keep the network producing blocks on average every 5 minutes, every
X blocks, the network uses timestamps stored in each block header to 
calculate the number of seconds elapsed between the first and last blocks
in this 2016 block window. The ideal value is 1,209,600 seconds (two weeks).

* If it took fewer than two weeks to generate the 2,016 blocks,
  the expected difficulty value is increased proportionally (by as much
  as 300%) so that the next 2,016 blocks should take exactly two weeks
  to generate if hashes are checked at the same rate.

* If it took more than two weeks to generate the blocks, the expected
  difficulty value is decreased proportionally (by as much as 75%) for
  the same reason.

The block header provides several easy-to-modify fields, such as a
dedicated nonce field, so obtaining new hashes doesn't require waiting
for new transactions. Also, only the 80-byte block header is hashed for
proof-of-work, so including a large volume of transaction data in
a block does not slow down hashing with extra I/O, and adding additional
transaction data only requires the recalculation of the ancestor hashes in
the merkle tree.


