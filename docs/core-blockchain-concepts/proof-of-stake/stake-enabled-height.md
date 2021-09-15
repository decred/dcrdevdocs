# ![](../../img/dcr-icons/TicketLive.svg){ .dcr-icon } Stake Enabled Height

---

Stake Enabled Height (SEH) is one of the [Blockchain Parameters](../../developer-guides/blockchain-parameters.md).

SEH is the height at which the first Proof-of-Stake (PoS) ticket could possibly mature.
On mainnet, the SEH is 512.
This means it is not possible for any tickets to mature before block 512.
The SEH is the sum of the CoinbaseMaturity + TicketMaturity.
The first coins created on mainnet, for example, were the
[premine](https://docs.decred.org/advanced/premine/) coins created in the genesis block.
These coins could not be spent for 256 blocks (the CoinbaseMaturity).
If these coins were used to purchase a ticket on block 257 (the first block they were spendable),
that ticket would take another 256 blocks to mature (the TicketMaturity).

**Note:** Even though it is possible for a ticket to **mature** on the Stake Enabled Height,
tickets cannot **vote** until the [Stake Validation Height](stake-validation-height.md).

The value for SEH varies per environment:

|         |Coinbase Maturity|Ticket Maturity|Stake Enabled Height|Block Time |Estimated Duration|
|---      |---              |---            |---                 |---        |---               |
| Mainnet | 256             | 256           | 512                | 5 minutes | 43 hours         |
| Testnet | 16              | 16            | 32                 | 2 minutes | 64 minutes       |
| Simnet  | 16              | 16            | 32                 | 1 second  | 32 seconds       |
| Regnet  | 16              | 16            | 32                 | 1 second  | 32 seconds       |
