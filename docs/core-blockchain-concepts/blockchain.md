# <img class="dcr-icon" src="/img/dcr-icons/Blocks.svg" /> Blockchain

---

The blockchain is a chain of blocks that full nodes have reached
consensus on. To reach consensus, full nodes must verify that
nodes it connects to have the same blocks in their copy of the
chain, and that those blocks conform to the consensus rules.

Below is a high-level diagram of the Decred blockchain.

![Block Chain Overview](/img/core-blockchain-concepts/blockchain-overview.svg)

A block of one or more new transactions (Block 1) is collected into
the transaction data part of a block. These transactions are then
hashed and rehashed to create the [Merkle root](../developer-guides/merkle-root-construction.md).

The [block header](../developer-guides/block-header-specifications.md)
contains metadata about the block, including
the Merkle root and hash of the previous block header.
Including the hash of the previous block header makes it impossible to change
a transaction in a block without also modifying all subsequent blocks
in the chain.

While wallets give users the impression that DCR is moved from wallet
to wallet, transactions actually move DCR from transaction to
transaction.
Each transaction spends DCR it received from a
previous transaction, to another transaction.
The input of one transaction is the output of a previous transaction.
Below is a high-level diagram of atoms (the smallest unit of DCR)
being propagated through a series of transactions.

![Transaction Propagation](/img/core-blockchain-concepts/transaction-propagation.svg)

A transaction can create multiple outputs.
However, each output can only be used as an input once.
Any attempt to create a subsequent
output is considered a double spend, which is forbidden by the
consensus rules.

Transaction outputs that have been spent are called transaction outputs.
Transaction outputs that have not been spent are called Unspent Transaction Outputs (UTXOs).
For a payment to be valid, it must only contain UTXOs as inputs.
