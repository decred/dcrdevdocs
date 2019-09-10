# <img class="dcr-icon" src="/img/dcr-icons/Pool.svg" /> Memory Pool

---

When a transaction is transmitted to the Decred network, it will be validated by
all of the full nodes receiving it to ensure it meets required consensus rules.
If a node deems the transaction to be valid, the node will store the transaction
in a non-persistent memory pool, or mempool for short.

Transactions sit in the mempool waiting for a Proof-of-Work (PoW miner) to
include them in a block.
Transactions in the mempool are known as "unconfirmed" transactions, as their
presence in the mempool does not guarantee they will be mined into a block.
PoW miners select transactions to include in blocks based on configurable policy.
For example, many miners will prioritise transactions which are paying larger
fees in order to maximise their profitability.

Because each node will have a different capacity for storing transactions, and
each node will be in its own unique position in the network, it is highly likely
that each node on the network will have a different set of transactions in its
mempool.
So while the mempool is often referred to as a single entity, in practice, it is
the sum of all transactions in the mempools of all full nodes connected to the
network.

As the mempool is non-persistent, it is lost when a node shuts down.
This means that never-mined unconfirmed transactions tend to slowly disappear
from the network as nodes restart or as they purge some transactions to make
room in memory for others.

The mempool is important for PoW miners as it provides a readily-available
source of validated transactions to include in the block that is currently being
solved.
It is also useful for non-mining peers that wants to keep track of unconfirmed
transactions, for instance [SPV](https://docs.decred.org/wallets/spv) clients
that do not maintain their own mempool.

Every time a newly mined block is received by a node, the node removes all of
the transactions which were included in the block from its mempool.
The node will also check for any expired, un-mined, transactions and those are
also removed from the mempool

Transactions which are mined into blocks that later become stale blocks may be
added back into the memory pool.
These re-added transactions may be re-removed from the pool almost immediately
if the replacement blocks include them.
This is the case in dcrd, which removes stale blocks from the chain one-by-one,
starting with the tip (highest block).
As each block is removed, its transactions are added back to the memory pool.
After all of the stale blocks are removed, the replacement blocks are added to
the chain one-by-one, ending with the new tip.
As each block is added, any transactions it confirms are removed from the memory
pool.
