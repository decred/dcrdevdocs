# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> Detecting Forks

---

## Detecting Forks

Non-upgraded nodes may use and distribute incorrect information during
both types of forks, creating several situations which could lead to
financial loss. In particular, non-upgraded nodes may relay and accept
transactions that are considered invalid by upgraded nodes and so will
never become part of the universally-recognized best block chain.
Non-upgraded nodes may also refuse to relay blocks or transactions which
have already been added to the best block chain, or soon will be, and so
provide incomplete information.

<!-- paragraph below based on src/main.cpp CheckForkWarningConditions() -->

Bitcoin Core includes code that detects a hard fork by looking at block
chain proof of work. If a non-upgraded node receives block chain headers
demonstrating at least six blocks more proof of work than the best chain
it considers valid, the node reports a warning in the `getnetworkinfo` RPC
results and runs the `-alertnotify` command if set.  This warns the
operator that the non-upgraded node can't switch to what is likely the
best block chain.

Full nodes can also check block and transaction version numbers. If the
block or transaction version numbers seen in several recent blocks are
higher than the version numbers the node uses, it can assume it doesn't
use the current consensus rules. Bitcoin Core reports this situation
through the `getnetworkinfo` RPC and `-alertnotify` command if set.

In either case, block and transaction data should not be relied upon
if it comes from a node that apparently isn't using the current
consensus rules.

SPV clients which connect to full nodes can detect a likely hard fork by
connecting to several full nodes and ensuring that they're all on the
same chain with the same block height, plus or minus several blocks to
account for transmission delays and stale blocks.  If there's a
divergence, the client can disconnect from nodes with weaker chains.

SPV clients should also monitor for block and transaction version number
increases to ensure they process received transactions and create new
transactions using the current consensus rules.