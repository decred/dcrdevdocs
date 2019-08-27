# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Proof Of Work

---

## Proof Of Work

The block chain is collaboratively maintained by anonymous peers on the network, so
Bitcoin requires that each block prove a significant amount of work was invested in
its creation to ensure that untrustworthy peers who want to modify past blocks have
to work harder than honest peers who only want to add new blocks to the
block chain.

Chaining blocks together makes it impossible to modify transactions included
in any block without modifying all subsequent blocks. As a
result, the cost to modify a particular block increases with every new block
added to the block chain, magnifying the effect of the proof of work.

The [proof of work](/en/glossary/proof-of-work) used in Bitcoin
takes advantage of the apparently random nature of cryptographic hashes.
A good cryptographic hash algorithm converts arbitrary data into a
seemingly random number. If the data is modified in any way and
the hash re-run, a new seemingly random number is produced, so there is
no way to modify the data to make the hash number predictable.

To prove you did some extra work to create a block, you must create a
hash of the block header which does not exceed a certain value. For
example, if the maximum possible hash value is <span
class="math">2<sup>256</sup> − 1</span>, you can prove that you
tried up to two combinations by producing a hash value less than <span
class="math">2<sup>255</sup></span>.

In the example given above, you will produce a successful hash on average every other try.
You can even estimate the probability
that a given hash attempt will generate a number below the [target](/en/glossary/nbits)
threshold.
Bitcoin assumes a linear probability that the lower it makes the target threshold, the more hash attempts (on average) will need to be tried.

New blocks will only be added to the block chain if their hash is at
least as challenging as a [difficulty](/en/glossary/difficulty) value expected by the consensus protocol.
Every 2,016 blocks, the network uses timestamps stored in each
block header to calculate the number of seconds elapsed between generation
of the first and last of those last 2,016 blocks. The ideal value is
1,209,600 seconds (two weeks).

* If it took fewer than two weeks to generate the 2,016 blocks,
  the expected difficulty value is increased proportionally (by as much
  as 300%) so that the next 2,016 blocks should take exactly two weeks
  to generate if hashes are checked at the same rate.

* If it took more than two weeks to generate the blocks, the expected
  difficulty value is decreased proportionally (by as much as 75%) for
  the same reason.

(Note: an off-by-one error in the Bitcoin Core implementation causes the
difficulty to be updated every 2,01*6* blocks using timestamps from only
2,01*5* blocks, creating a slight skew.)

Because each block header must hash to a value below the target
threshold, and because each block is linked to the block that
preceded it, it requires (on average) as much hashing power to
propagate a modified block as the entire Bitcoin network expended
between the time the original block was created and the present time.
Only if you acquired a majority of the network's hashing power
could you reliably execute such a [51 percent attack](/en/glossary/51-percent-attack) against
transaction history (although, it should be noted, that even less than 50% of the hashing power still has a good chance of performing such attacks).

The block header provides several easy-to-modify fields, such as a
dedicated nonce field, so obtaining new hashes doesn't require waiting
for new transactions. Also, only the 80-byte block header is hashed for
proof-of-work, so including a large volume of transaction data in
a block does not slow down hashing with extra I/O, and adding additional
transaction data only requires the recalculation of the ancestor hashes in
the merkle tree.
