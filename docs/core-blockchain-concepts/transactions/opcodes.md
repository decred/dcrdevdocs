# <img class="dcr-icon" src="/img/dcr-icons/Transactions.svg" /> opCodes

---


**NOTE: below is from BTC docs for reference. Opcodes for Decred appear to be
documented in this file,**
https://github.com/decred/dcrd/blob/8be96a87293a19f64dcbb933791531b151b01bd5/txscript/opcode.go


The opcodes used in the pubkey scripts of standard transactions are:

* Various data pushing opcodes from 0x00 to 0x4e (1--78). These aren't
  typically shown in examples, but they must be used to push
  signatures and public keys onto the stack. See the link below this list
  for a description.

* `OP_TRUE`/`OP_1` (0x51) and `OP_2` through `OP_16` (0x52--0x60), which
  push the values 1 through 16 to the stack.

* [`OP_CHECKSIG`][op_checksig] consumes a signature and a full public key, and pushes
  true onto the stack if the transaction data specified by the SIGHASH flag was
  converted into the signature using the same ECDSA private key that
  generated the public key.  Otherwise, it pushes false onto the stack.

* [`OP_DUP`][op_dup] pushes a copy of the topmost stack item on to the stack.

* [`OP_HASH160`][op_hash160] consumes the topmost item on the stack,
  computes the RIPEMD160(SHA256()) hash of that item, and pushes that hash onto the stack.

* [`OP_EQUAL`][op_equal] consumes the top two items on the stack, compares them, and
  pushes true onto the stack if they are the same, false if not.

* [`OP_VERIFY`][op_verify]consumes the topmost item on the stack.
  If that item is zero (false) it terminates the script in failure.

* [`OP_EQUALVERIFY`][op_equalverify] runs `OP_EQUAL` and then `OP_VERIFY` in sequence.

* [`OP_CHECKMULTISIG`][op_checkmultisig] consumes the value (n) at the top of the stack,
  consumes that many of the next stack levels (public keys), consumes
  the value (m) now at the top of the stack, and consumes that many of
  the next values (signatures) plus one extra value.

    The "one extra value" it consumes is the result of an off-by-one
    error in the Bitcoin Core implementation. This value is not used, so
    signature scripts prefix the list of secp256k1 signatures with a
    single OP_0 (0x00).

    `OP_CHECKMULTISIG` compares the first signature against each public
    key until it finds an ECDSA match. Starting with the subsequent
    public key, it compares the second signature against each remaining
    public key until it finds an ECDSA match. The process is repeated
    until all signatures have been checked or not enough public keys
    remain to produce a successful result.

    Because public keys are not checked again if they fail any signature
    comparison, signatures must be placed in the signature script using
    the same order as their corresponding public keys were placed in
    the pubkey script or redeem script. See the `OP_CHECKMULTISIG` warning
    below for more details.

* [`OP_RETURN`][op_return] terminates the script in failure when executed.

A complete list of opcodes can be found on the Bitcoin Wiki [Script
Page][wiki script], with an authoritative list in the `opcodetype` enum
of the Bitcoin Core [script header file][core script.h]

![Warning icon](/img/icons/icon_warning.svg?)
**<span id="signature_script_modification_warning">Signature script modification warning</span>:**
Signature scripts are not signed, so anyone can modify them. This
means signature scripts should only contain data and data-pushing opcodes
which can't be modified without causing the pubkey script to fail.
Placing non-data-pushing opcodes in the signature script currently
makes a transaction non-standard, and future consensus rules may forbid
such transactions altogether. (Non-data-pushing opcodes are already
forbidden in signature scripts when spending a P2SH pubkey script.)

![Warning icon](/img/icons/icon_warning.svg?)
**`OP_CHECKMULTISIG` warning:** The multisig verification process
described above requires that signatures in the signature script be
provided in the same order as their corresponding public keys in
the pubkey script or redeem script. For example, the following
combined signature and pubkey script will produce the stack and
comparisons shown:


OP_0 <A sig> <B sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
B sig           C pubkey
A sig           B pubkey
OP_0            A pubkey

1. B sig compared to C pubkey (no match)
2. B sig compared to B pubkey (match #1)
3. A sig compared to A pubkey (match #2)

Success: two matches found


But reversing the order of the signatures with everything else the same
will fail, as shown below:


OP_0 <B sig> <A sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
A sig           C pubkey
B sig           B pubkey
OP_0            A pubkey

1. A sig compared to C pubkey (no match)
2. A sig compared to B pubkey (no match)

Failure, aborted: two signature matches required but none found so far, and there's only one pubkey remaining