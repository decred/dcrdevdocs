# <img class="dcr-icon" src="/img/dcr-icons/Wallet.svg" /> Deterministic Wallet Formats

---

Decred supports both single chain and Hierarchical Deterministic (HD) wallets.

### Single Chain

In single chain wallets, a single seed is used to create a series of public keys. This is considered less secure than HD wallets, because if the seed is stolen all funds are compromised. In addition, single seed wallets generate a new randomly-selected private key for each new address. Therefore, if the wallet file is lost or damaged, the user will irrevocably lose all funds.

### Hierarchical Deterministic (HD) 

In HD wallets, a special parent seed based on [BIP0032](https://en.bitcoin.it/wiki/BIP_0032) is used to deterministically create child private keys for addresses. This means that a user typically only needs to back up the seed phrase. If the wallet file is lost or damaged, the user can use this seed phrase to deterministically recreate their private keys and recover their funds. 

Below is a diagram showing how child private keys are generated from the parent seed. 

![HD wallet overview](/img/hd-overview.svg)

dcrd provides an API for generating and interacting with HD extended keys via the hdkeychain package. Documentation for hdkeychain can be found [here](https://github.com/decred/dcrd/blob/3e2208f8c1d123841919221734ec463ef3ece544/hdkeychain/README.md).

