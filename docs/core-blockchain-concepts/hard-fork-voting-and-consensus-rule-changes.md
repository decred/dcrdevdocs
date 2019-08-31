# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Hard Fork Voting and Consensus Rule Changes

---

Typically, all full nodes are validating blocks using the same consensus 
rules. However, there may be situations where some nodes are using different
consensus rules. For instance, when there is an update to the consensus 
rules, nodes that have not upgraded will still be using the old rules. 
This can break consensus in two possible ways.

1. A block following the new consensus rules is accepted by the upgraded
nodes, but rejected by the non-upgraded nodes. This could happen, for instance,
if a block includes a transaction using a new feature enabled by 
the updated consensus rules (e.g. a new opCode). Upgraded nodes will 
accept the transaction, but non-upgraded nodes will reject it for 
violating the old consensus rules. 
2. A block not following the new consensus rules is rejected by the 
upgraded nodes, but accepted by non-upgraded nodes. This could happen,
for instance, if a block includes a transaction that is valid under the 
old rules, but invalid in the new rules (e.g. the transaction was using a 
feature that was being abused so it was removed).

In the first case (block rejected by non-upgraded nodes), miners that 
get blockchain data from non-upgraded nodes will not see blocks 
that use the new consensus rule changes. This
causes a hard fork, with one chain following
the old rules and one chain following the new rules.  

Below is a high-level diagram of a hard fork. 

![Hard Fork](../img/hard-fork.svg)

In the second case (block rejected by upgraded nodes), it is possible
to keep the blockchain from permanently splitting if upgraded nodes
control a majority of the hash rate. This is because, while upgraded 
nodes will reject blocks not following the new consensus rules, non-upgraded
nodes will accept all of the blocks accepted by upgraded nodes. This 
means that, over time, the upgraded nodes can build a stronger chain, 
which the non-upgraded nodes must accept as the valid chain. This is 
called a soft fork. 

Below is a high-level diagram of a soft fork. 

![Soft Fork](../img/soft-fork.svg)

<!-- TODO s_ben: Rewrote btc content for PoW, but it needs review. Also,
	wondering how we're going to ties this together with the PoS voting,
	hard fork resistance, etc.... -->

**--------------- BTC docs version below for reference ----------------**










To maintain consensus, all full nodes validate blocks using the same
consensus rules. However, sometimes the consensus rules are changed to
introduce new features or prevent network abuse. When the new rules are
implemented, there will likely be a period of time when non-upgraded
nodes follow the old rules and upgraded nodes follow the new rules,
creating two possible ways consensus can break:

1. A block following the new consensus rules is accepted by upgraded
   nodes but rejected by non-upgraded nodes. For example, a new
   transaction feature is used within a block: upgraded nodes understand
   the feature and accept it, but non-upgraded nodes reject it because
   it violates the old rules.

2. A block violating the new consensus rules is rejected by upgraded
   nodes but accepted by non-upgraded nodes. For example, an abusive
   transaction feature is used within a block: upgraded nodes reject it
   because it violates the new rules, but non-upgraded nodes accept it
   because it follows the old rules.

In the first case, rejection by non-upgraded nodes, mining software
which gets block chain data from those non-upgraded nodes refuses to
build on the same chain as mining software getting data from upgraded
nodes. This creates permanently divergent chains---one for non-upgraded
nodes and one for upgraded nodes---called a [hard
fork][/en/glossary/hard-fork].

![Hard Fork](../img/hard-fork.svg)

In the second case, rejection by upgraded nodes, it's possible to keep
the block chain from permanently diverging if upgraded nodes control a
majority of the hash rate. That's because, in this case, non-upgraded
nodes will accept as valid all the same blocks as upgraded nodes, so the
upgraded nodes can build a stronger chain that the non-upgraded nodes
will accept as the best valid block chain. This is called a [soft
fork][/en/glossary/soft-fork].

![Soft Fork](../img/soft-fork.svg)

Although a fork is an actual divergence in block chains, changes to the
consensus rules are often described by their potential to create either
a hard or soft fork. For example, "increasing the block size above 1 MB
requires a hard fork." In this example, an actual block chain fork is
not required---but it is a possible outcome.

Consensus rule changes may be activated in various ways. During Bitcoin's
first two years, Satoshi Nakamoto performed several soft forks by just
releasing the backwards-compatible change in a client that began immediately
enforcing the new rule. Multiple soft forks such as BIP30 have
been activated via a flag day where the new rule began to be enforced at a
preset time or block height. Such forks activated via a flag day are known as
[User Activated Soft Forks][/en/glossary/uasf] (UASF) as
they are dependent on having sufficient users (nodes) to enforce the new rules
after the flag day.

Later soft forks waited for a majority of hash rate (typically 75% or 95%)
to signal their readiness for enforcing the new consensus rules. Once the signalling
threshold has been passed, all nodes will begin enforcing the new rules. Such
forks are known as [Miner Activated Soft Forks][/en/glossary/masf] (MASF)
as they are dependent on miners for activation.

**Resources:** [BIP16][], [BIP30][], and [BIP34][] were implemented as
changes which might have lead to soft forks. [BIP50][] describes both an
accidental hard fork, resolved by temporary downgrading the capabilities
of upgraded nodes, and an intentional hard fork when the temporary
downgrade was removed. A document from Gavin Andresen outlines [how
future rule changes may be
implemented](https://gist.github.com/gavinandresen/2355445).