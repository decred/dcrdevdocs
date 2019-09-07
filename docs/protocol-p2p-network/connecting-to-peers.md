# <img class="dcr-icon" src="/img/dcr-icons/AtoB.svg" /> Connecting to Peers

---

Connecting to a peer is done by sending a `version` message, which
contains your version number, the height of your last seen block,
and current time to the remote node.
The remote node responds with its own `version` message.
Then both nodes send a `verack` message to the other node to indicate
the connection has been established.

Once connected, the client can send to the remote node `getaddr` and `addr`
messages to gather additional peers.

In order to maintain a connection with a peer, dcrd nodes will send a
ping message to peers every two minutes.
If 5 minutes pass without the peer responding, or sending its own ping
message, the client will assume that connection has closed.
