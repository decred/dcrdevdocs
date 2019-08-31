# <img class="dcr-icon" src="/img/dcr-icons/Blocks.svg" /> Block Broadcasting

---

When a miner discovers a new block, it broadcasts the new block to its
peers using one of the following methods:

* **[Unsolicited Block Push][]{:#term-unsolicited-block-push}{:.term}:**
  the miner sends a `block` message to each of its full node peers with
  the new block. The miner can reasonably bypass the standard relay
  method in this way because it knows none of its peers already have the
  just-discovered block.

* **[Standard Block Relay][]{:#term-standard-block-relay}{:.term}:**
  the miner, acting as a standard relay node, sends an `inv` message to
  each of its peers (both full node and SPV) with an inventory referring
  to the new block. The most common responses are:

   * Each blocks-first (BF) peer that wants the block replies with a
     `getdata` message requesting the full block.

   * Each headers-first (HF) peer that wants the block replies with a
     `getheaders` message containing the header hash of the
     highest-height header on its best header chain, and likely also
     some headers further back on the best header chain to allow fork
     detection. That message is immediately followed by a `getdata`
     message requesting the full block. By requesting headers first, a
     headers-first peer can refuse orphan blocks as described in the
     subsection below.

   * Each Simplified Payment Verification (SPV) client that wants the
     block replies with a `getdata` message typically requesting a
     merkle block.

   The miner replies to each request accordingly by sending the block
   in a `block` message, one or more headers in a `headers` message,
   or the merkle block and transactions relative to the SPV client's
   bloom filter in a `merkleblock` message followed by zero or more
   `tx` messages.

* **[Direct Headers Announcement][/en/glossary/block-header]{:#term-direct-headers-announcement}{:.term}:**
  a relay node may skip the round trip overhead of an `inv` message
  followed by `getheaders` by instead immediately sending a `headers`
  message containing the full header of the new block. A HF peer
  receiving this message will partially validate the block header as it
  would during headers-first IBD, then request the full block contents
  with a `getdata` message if the header is valid. The relay node then
  responds to the `getdata` request with the full or filtered block
  data in a `block` or `merkleblock` message, respectively. A HF node
  may signal that it prefers to receive `headers` instead of `inv`
  announcements by sending a special `sendheaders` message during the
  connection handshake.

  This protocol for block broadcasting was proposed in BIP 130 and has
  been implemented in Bitcoin Core since version 0.12.

By default, Bitcoin Core broadcasts blocks using direct headers
announcement to any peers that have signalled with `sendheaders` and
uses standard block relay for all peers that have not. Bitcoin Core
will accept blocks sent using any of the methods described above.

Full nodes validate the received block and then advertise it to their
peers using the standard block relay method described above.  The condensed
table below highlights the operation of the messages described above
(Relay, BF, HF, and SPV refer to the relay node, a blocks-first node, a
headers-first node, and an SPV client; *any* refers to a node using any
block retrieval method.)

| Message                              | From→To     | Payload
|--------------------------------------|-------------|--------------------------
| [`inv`][inv message]                 | Relay→*Any* | The inventory of the new block
| [`getdata`][getdata message]         | BF→Relay    | The inventory of the new block
| [`getheaders`][getheaders message]   | HF→Relay    | One or more header hashes on the HF node's best header chain (BHC)
| [`headers`][headers message]         | Relay→HF    | Up to 2,000 headers connecting HF node's BHC to relay node's BHC
| [`block`][block message]             | Relay→BF/HF | The new block in [serialized format][section serialized blocks]
| [`merkleblock`][merkleblock message] | Relay→SPV   | The new block filtered into a merkle block
| [`tx`][tx message]                   | Relay→SPV   | Serialized transactions from the new block that match the bloom filter





