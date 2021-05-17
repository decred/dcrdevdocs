# ![](../img/dcr-icons/AtoB.svg){ .dcr-icon } Peer Discovery

---

When started for the first time, dcrd doesn’t know the IP addresses of any
active full nodes.
Because randomly querying all IP addresses on the internet looking for full
nodes is prohibitively expensive, dcrd bootstraps this process by querying a
hardcoded list of DNS seeds maintained by the community.
The seeds should respond with one or more DNS A records with the IP addresses of
full nodes that may accept incoming connections.

The Unix command [dig](https://en.wikipedia.org/wiki/Dig_(command)) can be used
to demonstrate this process.
The following example shows the DNS records returned from a testnet Decred seed.

```no-highlight
$ dig +noall +answer testnet-seed.decred.org
testnet-seed.decred.org.  30  IN  A  192.3.103.135
testnet-seed.decred.org.  30  IN  A  206.81.16.204
testnet-seed.decred.org.  30  IN  A  195.49.75.206
testnet-seed.decred.org.  30  IN  A  52.36.222.36
testnet-seed.decred.org.  30  IN  A  188.166.43.247
[...]
```

The DNS seeds are maintained by Decred community members running
[dcrseeder](#dcrseeder).

<!-- paragraph below based on Greg Maxwell's email in
     http://comments.gmane.org/gmane.comp.bitcoin.devel/5378 -->

DNS seed results are not authenticated and a malicious seed operator or
network man-in-the-middle attacker can return only IP addresses of
nodes controlled by the attacker, isolating dcrd on the attacker's
own network and allowing the attacker to feed it bogus transactions and
blocks.
For this reason, dcrd does not rely on DNS seeds exclusively.

Once dcrd has connected to the network, its peers can begin to send
it `addr`
(address) messages with the IP addresses and port numbers of
other active peers on the network, providing a fully decentralized method of
peer discovery without relying upon DNS.
An active peer is considered one that has transmitted a message
within the last 3 hours.
Nodes which have not transmitted in that time frame should be forgotten.

dcrd keeps a record of known reliable peers in a
persistent on-disk json file which usually allows it to connect directly
to those peers on subsequent startups without having to query DNS seeds.

## Disable DNS seeding

It is possible to disable DNS seeding in dcrd by using the `--nodnsseed` flag.
If DNS seeding is disabled, dcrd will either need to load peers from its local
json file, or a peer IP address needs to be provided with `--addpeer`.

```no-highlight
dcrd --addpeer=192.168.1.12
```

The `--connect` flag will disable DNS seeding and force dcrd to **only** connect to
specified peers.
dcrd will not listen for any incoming connections when `--connect` is set.

```no-highlight
dcrd --connect=192.168.1.12,192.168.1.13
```

## dcrseeder

dcrseeder is a crawler for the Decred network, which exposes a list of reliable
nodes via a built-in DNS server.

When dcrseeder is started for the first time, it will connect to a known trusted
dcrd instance, perform a `getaddr` request and then disconnect. The `addr`
response contains the IPs of all peers known by the node. dcrseeder will then
connect to each of these IPs, perform a `getaddr` request, and continue
traversing the network in this fashion. dcrseeder maintains a list of all known
peers and periodically checks that they are online and available.

When dcrseeder is queried for node information, it responds with details of a
random selection of the reliable nodes it knows about.

The code for dcrseeder can be found on [GitHub](https://github.com/decred/dcrseeder).
