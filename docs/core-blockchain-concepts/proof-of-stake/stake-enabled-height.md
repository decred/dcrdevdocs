# <img class="dcr-icon" src="/img/dcr-icons/TicketLive.svg" /> Stake Enabled Height

---

Stake Enabled Height (SEH) is one of the [Blockchain Parameters](../blockchain-parameters.md).

SEH describes the height at which the first Proof-of-Stake (PoS) ticket could possibly mature.
The first coins created on the Decred blockchain were the
[premine](https://docs.decred.org/advanced/premine/) coins.
According to coinbase maturity rules, these coins could not be spent until after block 256,
so tickets could not be purchased before this time.
Assuming a ticket is purchased on block 257, the ticket will take another 256 blocks to mature.
Thus we can calculate the SEH as `CoinbaseMaturity + TicketMaturity`.
The target block time for mainnet is 5 minutes, giving a SEH of approximately 43 hours.

**Note:** Even though it is possible for a ticket to **mature** on the Stake Enabled Height,
tickets cannot **vote** until the [Stake Validation Height](stake-validation-height.md).

The value for SEH varies per environment:

|         |Coinbase Maturity|Ticket Maturity|Stake Enabled Height|Block Time |Estimated Duration|
|---      |---              |---            |---                 |---        |---               |
| Mainnet | 256             | 256           | 512                | 5 minutes | 43 hours         |
| Testnet | 16              | 16            | 32                 | 2 minutes | 64 minutes       |
| Simnet  | 16              | 16            | 32                 | 1 second  | 32 seconds       |
| Regnet  | 16              | 16            | 32                 | 1 second  | 32 seconds       |
