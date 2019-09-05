# <img class="dcr-icon" src="/img/dcr-icons/Info.svg" /> Projects

---

All projects listed on this page are currently in active development.
All projects are open source with their source code available on GitHub.
New contributors are welcome to contribute to any of these projects.

---

## dcrd

- [decred/dcrd](https://github.com/decred/dcrd) (Go)

dcrd is a full node implementation of Decred written in Go (golang).

It acts as a fully-validating chain daemon for the Decred cryptocurrency.
dcrd maintains the entire past transactional ledger of Decred and allows relaying
of transactions to other Decred nodes around the world.
The software was originally forked from [btcd](https://github.com/btcsuite/btcd),
which is a bitcoin full node implementation that is still under active development.

---

## dcrwallet

- [decred/dcrwallet](https://github.com/decred/dcrwallet) (Go)

dcrwallet is the daemon that handles Decred wallet functionality for a single user.
It tracks balances across addresses, allows stakeholders to participate in Proof-of-Stake voting,
and manages all of your accounts, addresses, and transactions.

dcrwallet can operate in two distinct modes.
The first (and default) is to communicate with a single trusted dcrd instance using JSON-RPC.
The second is a privacy-preserving
[Simplified Payment Verification (SPV)](https://docs.decred.org/wallets/spv/).

---

## decrediton

- [decred/decrediton](https://github.com/decred/decrediton) (Node.js)

decrediton is a cross-platform GUI wallet for Decred built with Electron.
It operates by communicating with dcrd and dcrwallet over RPC.
It also integrates with Politeia to allow ticket holders to vote on Proposals.

---

## Lightning Network

- [decred/dcrlnd](https://github.com/decred/dcrlnd) (Go)
- [decred/lightning-faucet](https://github.com/decred/lightning-faucet) (Go)
- [decred/lightning-onion](https://github.com/decred/lightning-onion) (Go)

Decred’s Lightning Network implementation (dcrlnd) is based on the lnd implementation
for Bitcoin, and is under active development.
lightning-faucet provides a testnet service similar to traditional cryptocurrency faucets,
but rather than sending Decred to the user via an on-chain transaction, it will open a
payment channel with the user.
lightning-onion is a Decred implementation of the onion routing protocol used by dcrlnd.

---

## dcrdata

- [decred/dcrdata](https://github.com/decred/dcrdata) (Go)

dcrdata is a Decred block explorer, implemented from scratch by the Decred project.

---

## atomicswap

- [decred/atomicswap](https://github.com/decred/atomicswap) (Go)

The atomicswap repository contains utilities to manually perform cross-chain atomic
swaps between various supported pairs of cryptocurrencies.

---

## Politeia

- [decred/politeia](https://github.com/decred/politeia) (Go)
- [decred/politeiagui](https://github.com/decred/politeiagui) (Go)
- [decred/snew-classic-ui](https://github.com/decred/snew-classic-ui) (Go)

Politeia is Decred's solution for decentralized governance.
[decred/politeia](https://github.com/decred/politeia) implements
a time-stamped and versioned data store based on git,
and this is used as the back-end for Politeia.
The front-end is implemented in [decred/politeiagui](https://github.com/decred/politeiagui)
and [decred/snew-classic-ui](https://github.com/decred/snew-classic-ui).

---

## dcrtime

- [decred/dcrtime](https://github.com/decred/dcrtime) (Go)
- [decred/dcrtimegui](https://github.com/decred/dcrtimegui) (Node.js)

dcrtime is a blockchain based timestamping service,
inspired by the work of Peter Todd’s
[OpenTimestamps](https://petertodd.org/2016/opentimestamps-announcement).
dcrtime allows a nearly unlimited number of hashes
to be timestamped onchain with the inclusion of a
single merkle root in a transaction.

dcrtimegui implements a front-end for dcrtime,
enabling files to be timestamped through a web-browser.

---

## Mobile Wallets

- [raedahgroup/dcrios](https://github.com/raedahgroup/dcrios) (Swift)
- [decred/dcrandroid](https://github.com/decred/dcrandroid) (Java, Kotlin)

Native wallets for both iOS and Android.

---

## dcrstakepool

- [decred/dcrstakepool](https://github.com/decred/dcrstakepool) (Go)

dcrstakepool is the reference implementation for a Decred Voting Service Provider
(VSP).
It consists of two major components: a back-end voting daemon which remains online
24/7 and votes on behalf of users, and a front-end website which allows users to
register and manage their accounts.

---

## dcrpool

- [decred/dcrpool](https://github.com/decred/dcrpool) (Go)

dcrpool is a lightweight Proof-of-Work (PoW) mining pool which operates
without collecting any personal information from its users.

---

## TinyDecred

- [decred/tinydecred](https://github.com/decred/tinydecred) (Python)

A Python 3 Decred toolkit.
The modules in TinyDecred can be used to integrate Decred into Python projects.
Everything needed to create wallets to send and receive DCR.

---

## Documentation

- [decred/dcrdocs](https://github.com/decred/dcrdocs) (Markdown, mkdocs)
- [jholdstock/dcrdevdocs](https://github.com/jholdstock/dcrdevdocs) (Markdown, mkdocs)

Decred has two sources of documentation. dcrdocs is user documentation,
focused on explaining Decred at a high level and how to use the software.
dcrdevdocs is developer documentation, written to explain the internal
workings of Decred at a lower level.

---

## Privacy

- [decred/cspp](https://github.com/decred/cspp) (Go)

Privacy in Decred is implemented using CoinShuffle++.
The cspp repository contains both the client and the server implementations.

---

## Decentralized Exchange (DEx)

- [decred/dcrdex](https://github.com/decred/dcrdex) (Go)

Decred stakeholders [voted to approve](https://proposals.decred.org/proposals/417607aaedff2942ff3701cdb4eff76637eca4ed7f7ba816e5c0bd2e971602e1)
funding to develop a new kind of decentralized cryptocurrency exchange.
