# <img class="dcr-icon" src="/img/dcr-icons/Wallet.svg" /> Wallets

---

The term wallet can refer to either a wallet file or a wallet application. Wallet files are files used to store private keys. Wallet applications are clients that manage private/public key pairs, sign transactions, and interact with the peer-to-peer network to get information from the blockchain and to [broadcast new transactions](../../protocol-p2p-network/transaction-broadcasting.md) .


Decred supports both single chain and Hierarchical Deterministic (HD) [wallet formats](deterministic-wallet-formats.md).

### dcrwallet

dcrwallet is a node daemon that handles Decred wallet functionality for a single user. It tracks balances across addresses, allows stakeholders to participate in Proof-of-Stake (PoS) voting, and manages all of the user's accounts, addresses, and transactions.

dcrwallet can operate in two distinct modes. The first (and default) mode is to communicate with a single trusted dcrd instance using a JSON-RPC server inspired by the Bitcoin Core RPC server. The second is the privacy-preserving
[Simplified Payment Verification (SPV)](https://docs.decred.org/wallets/spv/) mode.

Documentation for dcrwallet can be found in the [decred/dcrwallet](https://github.com/decred/dcrwallet) repo. Documentation on the RPC server, including the RPC API and client usage can be found in [dcrwallet/rpc/documentation/](https://github.com/decred/dcrwallet/tree/8b5855ece5fc371c5f03483d907a6b458c2c6115/rpc/documentation).



