# ![](../img/dcr-icons/Blocks.svg){ .dcr-icon } Initial Block Download

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
best block chain has a [block header](../developer-guides/block-header-specifications.md) time more than 24 hours in the past.
dcrd will also perform IBD if its local best block chain is
more than 288 blocks lower than its local best header chain (that is,
the local block chain is more than about 24 hours in the past).

## Blocks-First

dcrd uses a simple IBD method called *blocks-first*.
The goal is to download the blocks from the best block chain in sequence.
Below is a high-level diagram of the blocks-first method.

![Overview Of Blocks-First Method](/img/protocol-p2p-network/en-blocks-first-flowchart.svg)

The first time a node is started, it only has a single block in its
local best block chain, the hardcoded genesis block (block 0).
We will refer to this as the "IBD node".
This node chooses a remote peer, called the "sync node", and sends it the
`getblocks` message illustrated below.

![First GetBlocks Message Sent During IBD](/img/protocol-p2p-network/en-ibd-getblocks.svg)

In the header hashes field in the payload of the `getblocks` message, this new node
sends the header hash of the only block it has, the genesis block
(6fe2...0000 in internal byte order).  It also sets the stop hash field
to all zeroes to request a maximum-size response.

Upon receipt of the `getblocks` message, the sync node takes the first
(and only) header hash and searches its local best block chain for a
block with that header hash. It finds that block 0 matches, so it
replies with 500 block inventories (the maximum response to a
`getblocks` message) starting from block 1. It sends these inventories
in the inventory (`inv`) message illustrated below.

![First Inv Message Sent During IBD](/img/protocol-p2p-network/en-ibd-inv.svg)

Inventories are unique identifiers for information on the network. Each
inventory contains a type field and the unique identifier for an
instance of the object. For blocks, the unique identifier is a hash of
the block's header.

The block inventories appear in the `inv` message in the same order they
appear in the block chain.
In our example, as illustrated above, the first `inv` message contains
inventories for blocks 1 through 501.
We can also see that the unique identifier for the first message is the
hash of block 1 (4860…0000).

The IBD node uses the received inventories to request 128 blocks from
the sync node in the `getdata` message illustrated below.

![First GetData Message Sent During IBD](/img/protocol-p2p-network/en-ibd-getdata.svg)

It's important to blocks-first nodes that the blocks be requested and
sent in order because each block header references the header hash of
the preceding block. That means the IBD node can't fully validate a
block until its parent block has been received. Blocks that can't be
validated because their parents haven't been received are called [orphan
blocks](orphan-blocks.md).

Upon receipt of the `getdata` message, the sync node replies with each
of the blocks requested. Each block is put into serialized block format
and sent in a separate `block` message. The first `block` message sent
(for block 1) is illustrated below.

![First Block Message Sent During IBD](/img/protocol-p2p-network/en-ibd-block.svg)

The IBD node downloads each block, validates it, and then requests the
next block it hasn't requested yet, maintaining a queue of up to 128
blocks to download. When it has requested every block for which it has
an inventory, it sends another `getblocks` message to the sync node
requesting the inventories of up to 500 more blocks.  This second
`getblocks` message contains multiple header hashes as illustrated
below:

![Second GetBlocks Message Sent During IBD](/img/protocol-p2p-network/en-ibd-getblocks2.svg)

Upon receipt of the second `getblocks` message, the sync node searches
its local best block chain for a block that matches one of the header
hashes in the message, trying each hash in the order they were received.
If it finds a matching hash, it replies with 500 block inventories
starting with the next block from that point. But if there is no
matching hash (besides the stop hash), it assumes the only block the
two nodes have in common is block 0 and so it sends an `inv` starting with
block 1 (the same `inv` message seen several illustrations above).

This repeated search allows the sync node to send useful inventories even if
the IBD node's local block chain forked from the sync node's local block
chain. This fork detection becomes increasingly useful the closer the
IBD node gets to the tip of the block chain.

When the IBD node receives the second `inv` message, it will request
those blocks using `getdata` messages.  The sync node will respond with
`block` messages.  Then the IBD node will request more inventories with
another `getblocks` message, and the cycle will repeat until the IBD
node is synced to the tip of the block chain.  At that point, the node
will accept blocks sent through the regular
block broadcasting mechanism.

### Blocks-First Advantages & Disadvantages

The primary advantage of blocks-first IBD is its simplicity. The primary
disadvantage is that the IBD node relies on a single sync node for all
of its downloading. This has several implications:

* **Speed Limits:** All requests are made to the sync node, so if the
  sync node has limited upload bandwidth, the IBD node will have slow
  download speeds.  Note that if the sync node goes offline, dcrd
  will continue downloading from another node, but it will still only
  download from a single sync node at a time.

* **Download Restarts:** The sync node can send a non-best (but
  otherwise valid) block chain to the IBD node. The IBD node won't be
  able to identify it as non-best until the initial block download nears
  completion, forcing the IBD node to restart its block chain download
  over again from a different node. dcrd ships with several
  block chain checkpoints at various block heights selected by
  developers to help an IBD node detect that it is being fed an
  alternative block chain history, allowing the IBD node to restart
  its download earlier in the process.

* **Disk Fill Attacks:** Closely related to the download restarts, if
  the sync node sends a non-best (but otherwise valid) block chain, the
  chain will be stored on disk, wasting space and possibly filling up
  the disk drive with useless data.

* **High Memory Use:** Whether maliciously or by accident, the sync node
  can send blocks out of order, creating orphan blocks which can't be
  validated until their parents have been received and validated.
  Orphan blocks are stored in memory while they await validation,
  which may lead to high memory use.
