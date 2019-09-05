# <img class="dcr-icon" src="/img/dcr-icons/AtoB.svg" /> Connecting to Peers

---

Connecting to a peer is done by sending a `version` message, which
contains your version number, block, and current time to the remote node.
The remote node responds with its own `version` message.
Then both nodes send a `verack` message to the other node to indicate
the connection has been established.

Once connected, the client can send to the remote node `getaddr` and `addr`
messages to gather additional peers.

<!-- TODO jholdstock: Checking this on Matrix:

            following is from bitcoin docs:

            > In order to maintain a connection with a peer, nodes by default will send a
            > message to peers before 30 minutes of inactivity.
            > If 90 minutes pass without a message being received by a peer,
            > the client will assume that connection has closed.

            I am reading `peers.go` to see how this works for Decred, I would like to check my understanding:

            Nodes send each connected peer a ping message every 2 minutes. If a peer does not respond or send its own ping message in a 5 minute window, the node will disconnect from it

 -->
In order to maintain a connection with a peer, nodes by default will send a
message to peers before 30 minutes of inactivity.
If 90 minutes pass without a message being received by a peer,
the client will assume that connection has closed.
