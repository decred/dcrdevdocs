# <img class="dcr-icon" src="/img/dcr-icons/Dcrtl.svg" /> Regnet

---

Regnet, a.k.a. regression test network, is a local testing environment. Regnet
is very similar to [simnet](simnet.md) but differs in subtle ways.

Simnet is intended for full integration testing with other applications, such as
mining software or wallets, whereas regnet is intended for unit tests, RPC
server tests and consensus rule tests. Regnet is not intended to be used outside
of these contexts.

As regnet is a temporary network for private use, there are no public
block explorers or faucets available.

Regnet can be enabled simply by starting `dcrd` with the `--regnet` flag.

Regnet is almost the same as simnet but there are differences to consider.

- The regnet block database is deleted every time dcrd is started in regnet
  mode. This forces regnet to begin from the genesis block every time. Simnet
  mode preserves the block database, so on subsequent start ups it will continue
  where it left off.

- The regnet blockchain will begin with various consensus rule changes already
  deployed, whereas the simnet chain starts with none.
