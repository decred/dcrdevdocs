# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Transaction Broadcasting

---

<!-- TODO jholdstock: Need to validate this paragraph. Also would be good to define `txt -->
In order to send a transaction to a peer, an `inv` message is sent.
If a `getdata` response message is received, the transaction is sent using `tx`.
The peer receiving this transaction also forwards the transaction in the same manner,
given that it is a valid transaction.
