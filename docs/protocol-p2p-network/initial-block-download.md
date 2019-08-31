# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Initial Block Download

---

Before a full node can validate unconfirmed transactions and
recently-mined blocks, it must download and validate all blocks from
block 1 (the block after the hardcoded genesis block) to the current tip
of the best block chain. This is the Initial Block Download (IBD) or
initial sync.

Although the word "initial" implies this method is only used once, it
can also be used any time a large number of blocks need to be
downloaded, such as when a previously-caught-up node has been offline
for a long time. In this case, a node can use the IBD method to download
all the blocks which were produced since the last time it was online.

dcrd uses the IBD method any time the last block on its local
best block chain has a block header time more than 24 hours in the past.
dcrd will also perform IBD if its local best block chain is
more than 288 blocks lower than its local best header chain (that is,
the local block chain is more than about 24 hours in the past).
