# <img class="dcr-icon" src="/img/dcr-icons/Code.svg" /> txscript

---

Decred uses a scripting system known as
[txscript](https://github.com/decred/dcrd/tree/master/txscript) for
transactions.
txscript is a simple, stack-based,
[Forth](https://en.wikipedia.org/wiki/Forth_(programming_language))-like
programming language.
The language is not Turing complete and does not implement any
type of looping, but it is still fairly powerful despite this.
Each of these properties are described in more detail below.

A script can be considered as a list of conditions attached to a transaction,
which must be met in order for the recipient of a transaction to spend the
Decred they have received.

In a simple transfer of Decred from one address to another, the script will
typically specify just two requirements:

- a public key that, when hashed, yields the receiving address specified in the
  script
- a signature to prove ownership of the private key corresponding to that public
  key

More complex scripts can be constructed requiring multiple private keys, or no
keys at all, and it is possible to make use of time locks which prevent the
spending of DCR until some point in the future.

The scripts executed by full nodes while validating transactions in a block or
before entering the mempool are actually a combination of two or three different
scripts:

- The _Public Key_ script (`scriptPubKey`) resides in the _previous output_ (the
  UTXO or in other words, the [output being
  spent](../transaction-format.md#outputs) by one of
  the transaction's input).

- The _Signature Script_ (`scriptSig`) is stored in the
  [input](../transaction-format.md#witness-inputs)
  being validated.

- The so-called _Redeem Script_ is used in P2SH addresses and is stored as
  part of the `scriptSig` and has some special rules for being detected and
  executed.

---

## Stack-based

txscript is described as a stack-based language because it uses a
[stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) data structure
in processing and executing commands.
A given script is run from left-to-right, and as it runs it makes use of the
stack to store values.

txscript uses operation codes, or opcodes, to remove items from the stack,
perform some calculation on them, and then push the result back onto the stack.

To provide a simple example, consider the following script which uses the
opcodes `OP_ADD` and `OP_EQUAL`.
In the real world, the data used in scripts are usually cryptographic values
such as public keys and signatures, but for the sake of simplicity this example
just uses some small integers.

```no-highlight
6 5 OP_ADD 12 OP_EQUAL
```

This script contains five instructions, which will be executed as follows:

1. The value 6 is pushed onto the stack
  ![Simple addition step 1](/img/txscript/addition-1.png)

1. The value 5 is pushed onto the stack
  ![Simple addition step 2](/img/txscript/addition-2.png)

1. `OP_ADD` pops the top two values from the stack, adds them together, and pushes
   the result, 11, onto the stack
  ![Simple addition step 3](/img/txscript/addition-3.png)

1. The value 12 is pushed onto the stack
  ![Simple addition step 4](/img/txscript/addition-4.png)

1. `OP_EQUAL` pops the top two values from the stack, compares them, and pushes 0
   (false) onto the stack. If the values were equal, 1 (true) would be pushed
   instead.
  ![Simple addition step 5](/img/txscript/addition-5.png)

---

## Forth-like

txscript resembles [Forth](https://en.wikipedia.org/wiki/Forth_(programming_language)),
an imperative stack-based language originally released in 1970.

Forth is typically used in embedded systems which involve interaction with
hardware, and it has been widely used in the fields of astronomy and space
travel.
This is can be attributed to its portability, efficient memory use and high
execution speed.

---

## Turing Incomplete

Unlike most modern programming languages, txscript is not [Turing
complete](https://en.wikipedia.org/wiki/Turing_completeness) as it lacks some
of the needed functionality such as loops, jumps, and complex control
structures.
This is a deliberate design decision.
While this does limit the scope of scripts which can be written in txscript,
there are several advantages which come from Turing incompleteness:

- Scripts cannot enter infite loops, which could arise from either unintentional
  programming errors or from intentional, malicious attacks. This means txscript
  is not susceptible to [the halting
  problem](https://en.wikipedia.org/wiki/Halting_problem).
- Complexity of scripts is limited, which means they can be more easily audited
  and more thoroughly tested.

---

## Examples

Further, more complex examples, as well as some real world uses of txscript can
be found in the `txscript` package in the [dcrd
repo](https://github.com/decred/dcrd/tree/master/txscript#examples) on GitHub.
