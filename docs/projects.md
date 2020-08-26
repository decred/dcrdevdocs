# <img class="dcr-icon" src="/img/dcr-icons/Info.svg" /> Projects

All projects listed on this page are currently in active development.
All projects are open source with their source code available on GitHub.
New contributors are welcome to contribute to any of these projects.
Further details for each project can be found in the README files of each GitHub
repository.

---

## dcrd

- [decred/dcrd](https://github.com/decred/dcrd) (Go)

dcrd is a full node implementation of Decred written in Go (golang).

It acts as a fully-validating chain daemon for the Decred cryptocurrency.
dcrd maintains the entire past transactional ledger of Decred and allows relaying
of transactions to other Decred nodes around the world.

---

## dcrwallet

- [decred/dcrwallet](https://github.com/decred/dcrwallet) (Go)

dcrwallet is the daemon that handles Decred wallet functionality for a single user.
It tracks balances across addresses, allows stakeholders to participate in Proof-of-Stake voting,
and manages all of your accounts, addresses, and transactions.

---

## dcrctl

- [decred/dcrctl](https://github.com/decred/dcrctl) (Go)

dcrctl is a command-line client for interacting with the JSON-RPC servers of
dcrd and dcrwallet.

dcrctl is not a daemon like dcrd or dcrwallet, it is an interactive tool which
calls the requested RPC method, prints the response and then terminates. It is
the primary method for CLI users to interact with their personal node and wallet.

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
The backend and middleware are written in Go.
On the front end, Webpack enables the use of modern javascript features, as well
as SCSS for styling.

---

## atomicswap

- [decred/atomicswap](https://github.com/decred/atomicswap) (Go)

The atomicswap repository contains utilities to manually perform cross-chain
atomic swaps between various supported pairs of cryptocurrencies.
Pull requests implementing support for additional cryptocurrencies and wallets
are encouraged.

---

## Politeia

- [decred/politeia](https://github.com/decred/politeia) (Go)
- [decred/politeiagui](https://github.com/decred/politeiagui) (Go)
- [decred/pi-ui](https://github.com/decred/pi-ui) (React)

Politeia is Decred's solution for decentralized governance.
[decred/politeia](https://github.com/decred/politeia) implements
a time-stamped and versioned data store based on git,
and this is used as the back-end for Politeia.
The front-end is implemented in [decred/politeiagui](https://github.com/decred/politeiagui)
and [decred/pi-ui](https://github.com/decred/pi-ui).

---

## dcrtime

- [decred/dcrtime](https://github.com/decred/dcrtime) (Go)
- [decred/dcrtimegui](https://github.com/decred/dcrtimegui) (Node.js)

dcrtime is a blockchain based timestamping service,
inspired by the work of Peter Todd’s
[OpenTimestamps](https://petertodd.org/2016/opentimestamps-announcement).
dcrtime allows a nearly unlimited number of hashes
to be timestamped onchain with the inclusion of a
single Merkle root in a transaction.

dcrtimegui implements a front-end for dcrtime,
enabling files to be timestamped through a web-browser.

---

## Mobile Wallets

- [planetdecred/dcrios](https://github.com/planetdecred/dcrios) (Swift)
- [planetdecred/dcrandroid](https://github.com/planetdecred/dcrandroid) (Java, Kotlin)

Native wallets for both iOS and Android.
These wallets make use of [dcrwallet](#dcrwallet) in SPV mode to ensure they
have a light footprint on mobile devices.

---

## vspd

- [decred/vspd](https://github.com/decred/vspd) (Go)

vspd is the reference implementation for a Decred Voting Service Provider (VSP).
A VSP maintains a pool of always-online voting wallets and allows Decred
stakeholders to delegate the voting of their tickets to these wallets.

[Announced](https://blog.decred.org/2020/06/02/A-More-Private-Way-to-Stake/) in
June 2020, vspd is a direct replacement for the previous VSP implementation
[dcrstakepool](https://github.com/decred/dcrstakepool).

---

## dcrpool

- [decred/dcrpool](https://github.com/decred/dcrpool) (Go)

dcrpool is a lightweight Proof-of-Work (PoW) mining pool which operates
without collecting any personal information from its users.
dcrpool currently supports a variety of the most popular blake-256 ASICs.

---

## TinyDecred

- [decred/tinydecred](https://github.com/decred/tinydecred) (Python)

A Python 3 Decred toolkit.
The modules in TinyDecred can be used to integrate Decred into Python projects.
Everything needed to create wallets to send and receive DCR.

---

## Documentation

- [decred/dcrdocs](https://github.com/decred/dcrdocs) (Markdown, mkdocs)
- [decred/dcrdevdocs](https://github.com/decred/dcrdevdocs) (Markdown, mkdocs)

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

In 2019 the Decred stakeholders
[voted to approve](https://proposals.decred.org/proposals/417607aaedff2942ff3701cdb4eff76637eca4ed7f7ba816e5c0bd2e971602e1)
funding to develop a new kind of decentralized cryptocurrency exchange.
dcrdex makes use of [atomic swaps](#atomicswap) to enable cryptocurrency trading
in a completely trustless, peer-to-peer fashion.
dcrdex does not collect any trading fees, and does not attempt to replace
traditional centralized exchanges with a new blockchain or token.

---

## dcrros

- [decred/dcrros](https://github.com/decred/dcrros) (Go)

dcrros (Decred/Rosetta) is a middleware service that provides access to the
Decred network via a [Rosetta-compatible API](https://www.rosetta-api.org/).
dcrros works as an API conversion layer and cache for the data required by
Rosetta implementations.
