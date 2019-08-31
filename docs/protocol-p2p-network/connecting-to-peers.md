# <img class="dcr-icon" src="/img/dcr-icons/AtoB.svg" /> Connecting to Peers

---

<!-- TODO jholdstock: No idea if this applies to Decred -->
Connecting to a peer is done by sending a `version` message, which
contains your version number, block, and current time to the remote
node. The remote node responds with its own `version` message. Then both
nodes send a `verack` message to the other node to indicate the
connection has been established.

Once connected, the client can send to the remote node `getaddr` and `addr` messages to gather additional peers.

In order to maintain a connection with a peer, nodes by default will send a message to peers before 30 minutes of inactivity. If 90 minutes pass without a message being received by a peer, the client will assume that connection has closed.
