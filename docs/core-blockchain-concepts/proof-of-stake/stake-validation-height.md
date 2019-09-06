# <img class="dcr-icon" src="/img/dcr-icons/TicketLive.svg" /> Stake Validation Height

---

Stake Validation Height (SVH) is one of the [Blockchain Parameters](../blockchain-parameters.md).

SVH is the height at which votes are required to add a new block to the top of the blockchain.
Before SVH, Proof-of-Work miners are able to add blocks to the chain without including stakeholder votes.
After SVH, all mined blocks must include at least 3 votes, otherwise they will not be considered
valid by consensus rules.

The SVH height is the first block that will be voted on, but will include in itself no votes.
This is because tickets vote to approve or disapprove the previous block,
not the block they have been included in.

The existence of SVH allows the ticket pool to grow towards its target size before voting begins.
If voting were to begin as soon as the [Stake Enabled Height](stake-enabled-height.md) were reached,
the opportunity for participants to purchase tickets would be significantly reduced.
This could create a scenario where the ticket pool is emptied and the chain is permenantly stalled
due to a lack of votes.

The value for SVH varies per environment:

|         |Stake Validation Height|
|---      |---                    |
| Mainnet | 4096                  |
| Testnet | 768                   |
| Simnet  | 144                   |
| Regnet  | 144                   |
