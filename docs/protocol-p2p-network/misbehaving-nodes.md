# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Misbehaving Nodes

---

<!-- TODO jholdstock: I dont think decred has -banscore or -bantime -->
Take note that for both types of broadcasting,
mechanisms are in place to punish misbehaving peers who take up
bandwidth and computing resources by sending false information.
If a peer gets a banscore above the `-banscore=<n>` threshold,
he will be banned for the number of seconds defined by `-bantime=<n>`,
which is 86,400 by default (24 hours).
