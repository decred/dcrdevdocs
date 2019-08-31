# <img class="dcr-icon" src="/img/dcr-icons/Blocks.svg" /> Blocks-First

---

Bitcoin Core (up until version [0.9.3][bitcoin core 0.9.3]) uses a
simple initial block download (IBD) method we'll call *blocks-first*.
The goal is to download the blocks from the best block chain in sequence.

![Overview Of Blocks-First Method](/img/dev/en-blocks-first-flowchart.svg?)

The first time a node is started, it only has a single block in its
local best block chain---the hardcoded genesis block (block 0).  This
node chooses a remote peer, called the sync node, and sends it the
`getblocks` message illustrated below.

![First GetBlocks Message Sent During IBD](/img/dev/en-ibd-getblocks.svg?)

In the header hashes field of the `getblocks` message, this new node
sends the header hash of the only block it has, the genesis block
(6fe2...0000 in internal byte order).  It also sets the stop hash field
to all zeroes to request a maximum-size response.

Upon receipt of the `getblocks` message, the sync node takes the first
(and only) header hash and searches its local best block chain for a
block with that header hash. It finds that block 0 matches, so it
replies with 500 block inventories (the maximum response to a
`getblocks` message) starting from block 1. It sends these inventories
in the `inv` message illustrated below.

![First Inv Message Sent During IBD](/img/dev/en-ibd-inv.svg?)

Inventories are unique identifiers for information on the network. Each
inventory contains a type field and the unique identifier for an
instance of the object. For blocks, the unique identifier is a hash of
the block's header.

The block inventories appear in the `inv` message in the same order they
appear in the block chain, so this first `inv` message contains
inventories for blocks 1 through 501. (For example, the hash of block 1
is 4860...0000 as seen in the illustration above.)

The IBD node uses the received inventories to request 128 blocks from
the sync node in the `getdata` message illustrated below.

![First GetData Message Sent During IBD](/img/dev/en-ibd-getdata.svg?)

It's important to blocks-first nodes that the blocks be requested and
sent in order because each block header references the header hash of
the preceding block. That means the IBD node can't fully validate a
block until its parent block has been received. Blocks that can't be
validated because their parents haven't been received are called orphan
blocks; a subsection below describes them in more detail.

Upon receipt of the `getdata` message, the sync node replies with each
of the blocks requested. Each block is put into serialized block format
and sent in a separate `block` message. The first `block` message sent
(for block 1) is illustrated below.

![First Block Message Sent During IBD](/img/dev/en-ibd-block.svg?)

The IBD node downloads each block, validates it, and then requests the
next block it hasn't requested yet, maintaining a queue of up to 128
blocks to download. When it has requested every block for which it has
an inventory, it sends another `getblocks` message to the sync node
requesting the inventories of up to 500 more blocks.  This second
`getblocks` message contains multiple header hashes as illustrated
below:

![Second GetBlocks Message Sent During IBD](/img/dev/en-ibd-getblocks2.svg?)

Upon receipt of the second `getblocks` message, the sync node searches
its local best block chain for a block that matches one of the header
hashes in the message, trying each hash in the order they were received.
If it finds a matching hash, it replies with 500 block inventories
starting with the next block from that point. But if there is no
matching hash (besides the stopping hash), it assumes the only block the
two nodes have in common is block 0 and so it sends an `inv` starting with
block 1 (the same `inv` message seen several illustrations above).

This repeated search allows the sync node to send useful inventories even if
the IBD node's local block chain forked from the sync node's local block
chain. This fork detection becomes increasingly useful the closer the
IBD node gets to the tip of the block chain.

When the IBD node receives the second `inv` message, it will request
those blocks using `getdata` messages.  The sync node will respond with
`block` messages.  Then the IBD node will request more inventories with
another `getblocks` message---and the cycle will repeat until the IBD
node is synced to the tip of the block chain.  At that point, the node
will accept blocks sent through the regular block broadcasting described
in a later subsection.



#### Blocks-First Advantages & Disadvantages


The primary advantage of blocks-first IBD is its simplicity. The primary
disadvantage is that the IBD node relies on a single sync node for all
of its downloading. This has several implications:

* **Speed Limits:** All requests are made to the sync node, so if the
  sync node has limited upload bandwidth, the IBD node will have slow
  download speeds.  Note: if the sync node goes offline, Bitcoin Core
  will continue downloading from another node---but it will still only
  download from a single sync node at a time.

* **Download Restarts:** The sync node can send a non-best (but
  otherwise valid) block chain to the IBD node. The IBD node won't be
  able to identify it as non-best until the initial block download nears
  completion, forcing the IBD node to restart its block chain download
  over again from a different node. Bitcoin Core ships with several
  block chain checkpoints at various block heights selected by
  developers to help an IBD node detect that it is being fed an
  alternative block chain history---allowing the IBD node to restart
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

All of these problems are addressed in part or in full by the
headers-first IBD method used in Bitcoin Core 0.10.0.

**Resources:** The table below summarizes the messages mentioned
throughout this subsection. The links in the message field will take you
to the reference page for that message.

| Message                          | From→To  | Payload
|----------------------------------|----------|--------------------------
| [`getblocks`][getblocks message] | IBD→Sync | One or more header hashes
| [`inv`][inv message]             | Sync→IBD | Up to 500 block inventories (unique identifiers)
| [`getdata`][getdata message]     | IBD→Sync | One or more block inventories
| [`block`][block message]         | Sync→IBD | One serialized block

