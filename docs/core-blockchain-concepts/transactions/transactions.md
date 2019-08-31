# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Transactions

---

Decred transactions are transfers of DCR that exist within blocks. Transactions are comprised primarily of inputs and outputs, though they have a few other fields of data as well. 


## Transaction Types

To enable Decred's consensus rules, transactions are split into two separate trees within a block: the regular transaction tree and the stake transaction tree. The stake transaction tree contains transactions related to ticket buying and ticket voting rewards. The regular transaction tree contains all other transactions. 

In addition to regular transactions (sending DCR from one address to another), there are a few special transaction types to be aware of:

* **Coinbase transaction:** Every block which is mined contains a single coinbase transaction. A coinbase transaction will typically have three outputs: one output that contains the encoded block height (used to ensure that coinbase hash collisions are impossible), one output that creates the coins added to the project treasury (10% of the block reward), and one output that creates the coins paid to the PoW miner for creating the block (60% of the block reward). Coinbase transactions are part of the regular transaction tree, which means that they will be rejected if Proof-of-Stake (PoS) voters vote to disapprove the block which contains them. Decred created in coinbase transactions cannot be spent until the coinbase maturity period has passed.
* **Stakebase transaction:** Every block starting at the stake validation height which is mined will contain a stakebase transaction for each ticket which voted on that block. The stakebase transaction will identify the ticket that voted, as well as produce the Decred which was spent to purchase the ticket, and the newly created Decred constituting the voting reward. Stakebase transactions belong to the stake transaction tree, which means that these transactions cannot be rejected by PoS voters, even if they vote to disapprove the block which contains them.
* **Multisignature:** Multisignature refers to transactions which can be authorized by more than one private key. Multisignature transactions can support multiple keys (N) and a subset of those (M) are required to transact (commonly known as “MofN”). For example, a 2 of 3 multisignature transaction would have three valid keys, however only two of them would be required to authorize. Multisignature transactions are in the regular transaction tree.


## Related pages

- [Transaction format](transaction-format.md)
- [Transactions](opcodes.md)