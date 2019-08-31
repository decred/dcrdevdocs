# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Peer Discovery

---


When started for the first time, programs don't know the IP
addresses of any active full nodes. In order to discover some IP
addresses, they query one or more DNS names (called [DNS seeds][/en/glossary/dns-seed]{:#term-dns-seed}{:.term})
hardcoded into Bitcoin Core and
BitcoinJ. The response to the lookup should include one or more [DNS
A records][] with the IP addresses of full nodes that may accept new
incoming connections. For example, using the [Unix `dig`
command][dig command]:

    ;; QUESTION SECTION:
    ;seed.bitcoin.sipa.be.	    IN  A

    ;; ANSWER SECTION:
    seed.bitcoin.sipa.be.	60  IN  A  192.0.2.113
    seed.bitcoin.sipa.be.	60  IN  A  198.51.100.231
    seed.bitcoin.sipa.be.	60  IN  A  203.0.113.183
    [...]

The DNS seeds are maintained by Bitcoin community members: some of them
provide dynamic DNS seed servers which automatically get IP addresses
of active nodes by scanning the network; others provide static DNS
seeds that are updated manually and are more likely to provide IP
addresses for inactive nodes. In either case, nodes are added to the
DNS seed if they run on the default Bitcoin ports of 8333 for mainnet
or 18333 for testnet.

<!-- paragraph below based on Greg Maxwell's email in
     http://comments.gmane.org/gmane.comp.bitcoin.devel/5378 -->

DNS seed results are not authenticated and a malicious seed operator or
network man-in-the-middle attacker can return only IP addresses of
nodes controlled by the attacker, isolating a program on the attacker's
own network and allowing the attacker to feed it bogus transactions and
blocks.  For this reason, programs should not rely on DNS seeds
exclusively.

Once a program has connected to the network, its peers can begin to send
it `addr`
(address<!--noref-->) messages with the IP addresses and port numbers of
other peers on the network, providing a fully decentralized method of
peer discovery. Bitcoin Core keeps a record of known peers in a
persistent on-disk database which usually allows it to connect directly
to those peers on subsequent startups without having to use DNS seeds.

However, peers often leave the network or change IP addresses, so
programs may need to make several different connection attempts at
startup before a successful connection is made. This can add a
significant delay to the amount of time it takes to connect to the
network, forcing a user to wait before sending a transaction or checking
the status of payment.

<!-- reference for "Bitcoin Core...11 seconds" below:
     https://github.com/bitcoin/bitcoin/pull/4559 -->

To avoid this possible delay, BitcoinJ always uses dynamic DNS seeds to
get IP addresses for nodes believed to be currently active.
Bitcoin Core also tries to strike a balance between minimizing delays
and avoiding unnecessary DNS seed use: if Bitcoin Core has entries in
its peer database, it spends up to 11 seconds attempting to connect to
at least one of them before falling back to seeds; if a connection is
made within that time, it does not query any seeds.

<!-- reference for Bitcoin Core behavior described below: search for
"FixedSeeds" in src/net.cpp; BitcoinJ has IPv4 seeds in its chainparams
and a function to use them, but I don't see that function being used in
any of the examples/wallet templates (but I'm not Java fluent, so
maybe PEBKAC). -@harding -->

Both Bitcoin Core and BitcoinJ also include a hardcoded list of IP
addresses and port numbers to several dozen nodes which were active
around the time that particular version of the software was first
released. Bitcoin Core will start attempting to connect to these nodes
if none of the DNS seed servers have responded to a query within 60
seconds, providing an automatic fallback option.

As a manual fallback option, Bitcoin Core also provides several
command-line connection options, including the ability to get a list of
peers from a specific node by IP address, or to make a persistent
connection to a specific node by IP address.  See the `-help` text for
details.  BitcoinJ can be programmed to do the same thing.

**Resources:** [Bitcoin Seeder][], the program run by several of the
seeds used by Bitcoin Core and BitcoinJ. The Bitcoin Core [DNS Seed
Policy][].  The hardcoded list of IP addresses used by Bitcoin Core and
BitcoinJ is generated using the [makeseeds script][].
