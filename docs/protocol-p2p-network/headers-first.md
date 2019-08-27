# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Overview

---

### Headers-First


Bitcoin Core 0.10.0 uses an initial block download (IBD) method called
*headers-first*. The goal is to download the headers for the best [header
chain][/en/glossary/header-chain]{:#term-header-chain}{:.term}, partially validate them as best
as possible, and then download the corresponding blocks in parallel.  This
solves several problems with the older blocks-first IBD method.

![Overview Of Headers-First Method](/img/dev/en-headers-first-flowchart.svg?)

The first time a node is started, it only has a single block in its
local best block chain---the hardcoded genesis block (block 0).  The
node chooses a remote peer, which we'll call the sync node, and sends it the
`getheaders` message illustrated below.

![First getheaders message](/img/dev/en-ibd-getheaders.svg?)

In the header hashes field of the `getheaders` message, the new node
sends the header hash of the only block it has, the genesis block
(6fe2...0000 in internal byte order).  It also sets the stop hash field
to all zeroes to request a maximum-size response.

Upon receipt of the `getheaders` message, the sync node takes the first
(and only) header hash and searches its local best block chain for a
block with that header hash. It finds that block 0 matches, so it
replies with 2,000 header (the maximum response) starting from
block 1. It sends these header hashes in the `headers` message
illustrated below.

![First headers message](/img/dev/en-ibd-headers.svg?)

The IBD node can partially validate these block headers by ensuring that
all fields follow consensus rules and that the hash of the header is
below the target threshold according to the nBits field.  (Full
validation still requires all transactions from the corresponding
block.)

After the IBD node has partially validated the block headers, it can do
two things in parallel:

1. **Download More Headers:** the IBD node can send another `getheaders`
   message to the sync node to request the next 2,000 headers on the
   best header chain. Those headers can be immediately validated and
   another batch requested repeatedly until a `headers` message is
   received from the sync node with fewer than 2,000 headers, indicating
   that it has no more headers to offer. As of this writing, headers
   sync can be completed in fewer than 200 round trips, or about 32 MB
   of downloaded data.

    Once the IBD node receives a `headers` message with fewer than 2,000
    headers from the sync node, it sends a `getheaders` message to each
    of its outbound peers to get their view of best header chain. By
    comparing the responses, it can easily determine if the headers it
    has downloaded belong to the best header chain reported by any of
    its outbound peers. This means a dishonest sync node will quickly be
    discovered even if checkpoints aren't used (as long as the IBD node
    connects to at least one honest peer; Bitcoin Core will continue to
    provide checkpoints in case honest peers can't be found).

2. **Download Blocks:** While the IBD node continues downloading
   headers, and after the headers finish downloading, the IBD node will
   request and download each block. The IBD node can use the block
   header hashes it computed from the header chain to create `getdata`
   messages that request the blocks it needs by their inventory. It
   doesn't need to request these from the sync node---it can request
   them from any of its full node peers. (Although not all full nodes
   may store all blocks.) This allows it to fetch blocks in parallel and
   avoid having its download speed constrained to the upload speed of a
   single sync node.

    To spread the load between multiple peers, Bitcoin Core will only
    request up to 16 blocks at a time from a single peer. Combined with
    its maximum of 8 outbound connections, this means headers-first
    Bitcoin Core will request a maximum of 128 blocks simultaneously
    during IBD (the same maximum number that blocks-first Bitcoin Core
    requested from its sync node).

![Simulated Headers-First Download Window](/img/dev/en-headers-first-moving-window.svg?)

Bitcoin Core's headers-first mode uses a 1,024-block moving download
window to maximize download speed. The lowest-height block in the window
is the next block to be validated; if the block hasn't arrived by the
time Bitcoin Core is ready to validate it, Bitcoin Core will wait a
minimum of two more seconds for the stalling node to send the block. If
the block still hasn't arrived, Bitcoin Core will disconnect from the
stalling node and attempt to connect to another node. For example, in
the illustration above, Node A will be disconnected if it doesn't send
block 3 within at least two seconds.

Once the IBD node is synced to the tip of the block chain, it will
accept blocks sent through the regular block broadcasting described in a
later subsection.

**Resources:** The table below summarizes the messages mentioned
throughout this subsection. The links in the message field will take you
to the reference page for that message.

| Message                            | From→To    | Payload
|------------------------------------|------------|--------------------------
| [`getheaders`][getheaders message] | IBD→Sync   | One or more header hashes
| [`headers`][headers message]       | Sync→IBD   | Up to 2,000 block headers
| [`getdata`][getdata message]       | IBD→*Many* | One or more block inventories derived from header hashes
| [`block`][block message]           | *Many*→IBD | One serialized block


</div>