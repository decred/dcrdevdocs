# <img class="dcr-icon" src="/img/dcr-icons/Blocks.svg" /> Orphan Blocks

---

Blocks-first nodes may download orphan blocks---blocks whose previous
block header hash field refers to a block header this node
hasn't seen yet. In other words, orphan blocks have no known parent
(unlike stale blocks, which have known parents but which aren't part of
the best block chain).

![Difference Between Orphan And Stale Blocks](/img/dev/en-orphan-stale-definition.svg?)

When a blocks-first node downloads an orphan block, it will not validate
it. Instead, it will send a `getblocks` message to the node which sent
the orphan block; the broadcasting node will respond with an `inv` message
containing inventories of any blocks the downloading node is missing (up
to 500); the downloading node will request those blocks with a `getdata`
message; and the broadcasting node will send those blocks with a `block`
message. The downloading node will validate those blocks, and once the
parent of the former orphan block has been validated, it will validate
the former orphan block.

Headers-first nodes avoid some of this complexity by always requesting
block headers with the `getheaders` message before requesting a block
with the `getdata` message. The broadcasting node will send a `headers`
message containing all the block headers (up to 2,000) it thinks the
downloading node needs to reach the tip of the best header chain; each of
those headers will point to its parent, so when the downloading node
receives the `block` message, the block shouldn't be an orphan
block---all of its parents should be known (even if they haven't been
validated yet). If, despite this, the block received in the `block`
message is an orphan block, a headers-first node will discard it immediately.

However, orphan discarding does mean that headers-first nodes will
ignore orphan blocks sent by miners in an unsolicited block push.
