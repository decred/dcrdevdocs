# <img class="dcr-icon" src="/img/dcr-icons/Constitution.svg" /> Contracts

---

Contracts are transactions which use the decentralized Decred system to enforce
financial agreements.
Decred contracts can often be crafted to minimize dependency on outside agents,
such as the court system, which significantly decreases the risk of dealing with
unknown entities in financial transactions.

The following section describes a possible example of a Decred contract - escrow
and arbitration.
Because contracts deal with real people, not just transactions, the scenario
is framed below in story format.

## Escrow And Arbitration

Charlie-the-customer wants to buy a product from Bob-the-businessman,
but neither of them trusts the other person, so they use a contract to
help ensure Charlie gets his merchandise and Bob gets his payment.

A simple contract could say that Charlie will spend DCR to an
output which can only be spent if Charlie and Bob both sign the input
spending it. That means Bob won't get paid unless Charlie gets his
merchandise, but Charlie can't get the merchandise and keep his payment.

This simple contract isn't much help if there's a dispute, so Bob and
Charlie enlist the help of Alice-the-arbitrator to create an escrow
contract. Charlie spends his DCR
to an output which can only be spent if two of the three people sign the
input. Now Charlie can pay Bob if everything is ok, Bob can refund
Charlie's money if there's a problem, or Alice can arbitrate and decide
who should get the DCR if there's a dispute.

To create a multiple-signature
output, Bob and Charlie each give the other a public key. Then Bob creates a
P2SH multisig redeem script.

This is a 2-of-3 multisig
pubkey script, more generically called a m-of-n pubkey script (where *m* is the
*minimum* matching signatures required and *n* in the *number* of public
keys provided).

Bob gives the redeem script to Charlie, who checks to make sure his
public key and Alice's public key are included. Then he hashes the
redeem script to create a P2SH redeem script and pays the DCR to it. Bob
sees the payment get added to the block chain and ships the merchandise.

Unfortunately, the merchandise gets slightly damaged in transit. Charlie
wants a full refund, but Bob thinks a 10% refund is sufficient. They
turn to Alice to resolve the issue. Alice asks for photo evidence from
Charlie along with a copy of the redeem script Bob created and
Charlie checked.

After looking at the evidence, Alice thinks a 40% refund is sufficient,
so she creates and signs a transaction with two outputs, one that spends 60%
of the DCR to Bob's public key and one that spends the remaining
40% to Charlie's public key.

In the signature script Alice puts her signature
and a copy of the unhashed serialized redeem script
that Bob created.  She gives a copy of the incomplete transaction to
both Bob and Charlie.  Either one of them can complete it by adding
their signature.

When the transaction is broadcast to the network, each peer checks the
signature script against the P2SH output Charlie previously paid,
ensuring that the redeem script matches the redeem script hash previously
provided. Then the redeem script is evaluated, with the two signatures
being used as input data. Assuming the redeem script
validates, the two transaction outputs show up in Bob's and Charlie's
wallets as spendable balances.

However, if Alice created and signed a transaction neither of them would
agree to, such as spending all the DCR to herself, Bob and Charlie
can find a new arbitrator and sign a transaction spending the DCR
to another 2-of-3 multisig redeem script hash, this one including a public
key from that second arbitrator. This means that Bob and Charlie never
need to worry about their arbitrator stealing their money.
