# <img class="dcr-icon" src="/img/dcr-icons/QuestionTicket.svg" /> Lottery Selection Semantics

---

In Decred's lottery system, 5 tickets are called pseudorandomly to vote on the
validity of each block created by PoW miners. This page describes the algorithm
used to select tickets. For a high level overview of the ticket voting process,
see the [Proof-of-Stake (PoS)
Overview](https://docs.decred.org/proof-of-stake/overview/) in the regular docs.

## Pseudorandom number generation

Tickets are selected from the ticket pool using a deterministic [Pseudorandom
Number Generator
(PRNG)](https://en.wikipedia.org/wiki/Pseudorandom_number_generator). It is
deterministic because the seed input to the PRNG is derived from the hash of the
previous block (the block being voted on). Specifically, the seed is a
serialization of the
[header](https://docs.decred.org/advanced/block-header-specifications) of the
previous block suffixed with a constant derived from the hex representation of
the mathematical constant Pi (𝜋), which acts as a publicly verifiable
Nothing-Up-My-Sleeve
([NUMS](https://en.wikipedia.org/wiki/Nothing-up-my-sleeve_number)) constant.
All eligible tickets in the ticket pool (also referred to as live tickets) are
hashed using the
[BLAKE-256](https://docs.decred.org/research/blake-256-hash-function) hash
function and sorted
[lexicographically](https://en.wikipedia.org/wiki/Lexicographical_order) by
their hash to generate a [total
order](https://en.wikipedia.org/wiki/Total_order). Finally, uniformly random
values constrained by the number of total eligible tickets as an upper bound are
produced and used as indices into the total order.

## Example

Below we examine a real ticket selection example on the Decred mainnet.

Notes from davecgh:

If we're discussing the ticket selection process, just the piece about selecting the tickets.
So, pick a block header, calculate the indexes based on seeding the PRNG with that
Then, show how those indexes, within a larger live ticket pool map to the actual winning tickets.
Links to dcrdata explorer would be good there I think.
That way there is something concrete to follow.

| Index        | Sorted lived tickets         |
| ------------- |:-------------:|
| 0    | (some made up ticket hash here)|
| 1     | (some made up ticket hash here)     |
| ...| omitted     |  
| 7    | real winning ticket hash here|
| ...     | omitted    |
| 17754 | real winning ticket hash here     |  
| ...     | omitted    |
