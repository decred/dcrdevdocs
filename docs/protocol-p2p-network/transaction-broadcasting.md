# ![](../img/dcr-icons/Transactions.svg){ .dcr-icon } Transaction Broadcasting

---

Once a transaction has been created, it needs to be broadcast to the mining
nodes on the network so that it may be included in a block.
A node can broadcast a transaction by sending an `inv` message containing the
transaction to all of its peers.
Peers receiving the `inv` message will request the full transaction details with
a `getdata` message.
If the receiving node considers the transaction to be valid, it will add the
transaction to its local [mempool](memory-pool.md), and it will broadcast the
transaction to all of its own peers with another `inv` message.
The transaction continues to propogate around the peer-to-peer network in this
fashion.

If a peer is not involved in a transaction, it will only rebroadcast the
transaction once, the first time it becomes aware of it.
The sender and receiver of the transaction however, will continue to rebroadcast
the transaction until it is mined into a block, or expires.
