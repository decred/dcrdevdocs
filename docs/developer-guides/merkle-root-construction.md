# ![](../img/dcr-icons/Code.svg){ .dcr-icon } Merkle Root Construction

---

This page explains what Merkle trees are, how Decred uses them, and provides step-by-step instructions for constructing compliant Merkle trees.

### Merkle Trees


A Merkle tree is a data structure that can be used to store hashes of arbitrary data. In the context of Decred, this might be transaction or ticket data. 

Merkle trees are created by repeatedly hashing pairs of nodes until there is only one hash left, the Merkle Root. They are constructed from the bottom up, from hashes of the leaf nodes (hashes of the raw input data). The diagram below shows a Merkle root constructed from eight leaf nodes. 

![Merkle Tree](/img/core-blockchain-concepts/merkle_tree.svg)

Merkle trees are particularly useful for blockchains, as they efficiently and compactly summarize larger data sets.


### Merkle Trees in Decred

Merkle roots are used to create compact summaries of all transactions in a block. These Merkle roots can then be queried to quickly and efficiently verify whether or not a transaction is included in a block. 

Each block header contains the Merkle roots of two Merkle trees, the `MerkleRoot` tree and `StakeRoot` tree. The `MerkleRoot` tree contains hashes of all regular transaction IDs. The `StakeRoot` tree contains hashes of stake-based transaction IDs (ticket purchases, votes, revocations, etc.). 

#### Hash Function

Unless otherwise specified, all hashing operations **must** be performed with the BLAKE-256 hash function with 14 rounds.

#### Merkle Root Construction

All Merkle trees **must** be constructed according to the unique Merkle tree construct originally implemented by Satoshi, which relies on construction of the tree from an ordered list as follows:

1. Calculate list of BLAKE-256 hashes of original data (e.g. transaction IDs) 
1. If the list is empty, return a 32-byte root hash of all zeroes; otherwise
1. While the list contains two or more items:
	- If the number of items remaining in the list is odd, duplicate the final hash
	- Combine each pair of adjacent entries with the BLAKE-256 hash of the two entries concatenated together. The list will have ceil(N/2) entries remaining after combining the adjacent entries
1. Return the final remaining item in the list as the Merkle root

!!! warning "Warning"
	The requirement for duplicating the final hash for internal tree levels that have an odd number of nodes must be carefully considered by applications making use of the resulting Merkle root because it means the final calculated Merkle root for a tree that internally duplicated a hash and one that actually included a duplicate hash at that position will be indistinguishable.

The below diagram illustrates these steps.

![Merkle Tree Calculation](/img/core-blockchain-concepts/merkle_root_calc.svg)




