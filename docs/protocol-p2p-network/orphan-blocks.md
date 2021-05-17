# ![](../img/dcr-icons/Blocks.svg){ .dcr-icon } Orphan Blocks

---

dcrd may download orphan blocks---blocks whose previous
[block header](../developer-guides/block-header-specifications.md) hash field refers to a block header this node
hasn't seen yet. In other words, orphan blocks have no known parent
(unlike stale blocks, which have known parents but which aren't part of
the best block chain).

![Difference Between Orphan And Stale Blocks](/img/protocol-p2p-network/en-orphan-stale-definition.svg)

When dcrd downloads an orphan block, it will not validate
it. Instead, it will send a `getblocks` message to the node which sent
the orphan block, the broadcasting node will respond with an `inv` message
containing inventories of any blocks the downloading node is missing (up
to 500), the downloading node will request those blocks with a `getdata`
message, and the broadcasting node will send those blocks with a `block`
message. The downloading node will validate those blocks, and once the
parent of the former orphan block has been validated, it will validate
the former orphan block.
