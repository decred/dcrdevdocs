# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Overview

---

### Memory Pool

Full peers may keep track of unconfirmed transactions which are eligible to
be included in the next block. This is essential for miners who will
actually mine some or all of those transactions, but it's also useful
for any peer who wants to keep track of unconfirmed transactions, such
as peers serving unconfirmed transaction information to SPV clients.

Because unconfirmed transactions have no permanent status in Bitcoin,
Bitcoin Core stores them in non-persistent memory, calling them a memory
pool or mempool. When a peer shuts down, its memory pool is lost except
for any transactions stored by its wallet. This means that never-mined
unconfirmed transactions tend to slowly disappear from the network as
peers restart or as they purge some transactions to make room in memory
for others.

Transactions which are mined into blocks that later become stale blocks may be
added back into the memory pool. These re-added transactions may be
re-removed from the pool almost immediately if the replacement blocks
include them. This is the case in Bitcoin Core, which removes stale
blocks from the chain one by one, starting with the tip (highest block).
As each block is removed, its transactions are added back to the memory
pool. After all of the stale blocks are removed, the replacement
blocks are added to the chain one by one, ending with the new tip. As
each block is added, any transactions it confirms are removed from the
memory pool.

SPV clients don't have a memory pool for the same reason they don't
relay transactions. They can't independently verify that a transaction
hasn't yet been included in a block and that it only spends UTXOs, so
they can't know which transactions are eligible to be included in the
next block.