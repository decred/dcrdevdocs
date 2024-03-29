# ![](../../../img/dcr-icons/Code.svg){ .dcr-icon } Opcodes

The complete txscript language includes over 100 operation codes, or opcodes,
however only a small number of these are used in the vast majority of the
transactions on the Decred blockchain.

---

## Data Push

These opcodes are used to push commonly used constants onto the stack.

| Word                       | Opcode | Hex       | Description |
|----------------------------|--------|-----------|-------------|
| `OP_FALSE`/`OP_0`          | 0      | 0x00      | An empty array of bytes is pushed onto the stack. |
| `OP_DATA_1` - `OP_DATA_75` | 1-75   | 0x01-0x4b | The next 1-75 bytes is data to be pushed onto the stack. |
| `OP_PUSHDATA1`             | 76     | 0x4c      | The next byte contains the number of bytes to be pushed onto the stack. |
| `OP_PUSHDATA2`             | 77     | 0x4d      | The next two bytes contain the number of bytes to be pushed onto the stack in little endian order. |
| `OP_PUSHDATA4`             | 78     | 0x4e      | The next four bytes contain the number of bytes to be pushed onto the stack in little endian order. |
| `OP_1NEGATE`               | 79     | 0x4f      | The number -1 is pushed onto the stack. |
| `OP_TRUE`/`OP_1`           | 81     | 0x51      | The number 1 is pushed onto the stack. |
| `OP_2` - `OP-16`           | 82-96  | 0x52-0x60 | The number 2-16 is pushed onto the stack. |

## Flow Control

These opcodes enable conditional logic as well as allowing scripts to stop
execution.

| Word        | Opcode | Hex   | Description |
|-------------|--------|-------|-------------|
| `OP_IF`     | 99     | 0x63  | If the top stack value is not False, the statements are executed. The top stack value is removed. |
| `OP_NOTIF`  | 100    | 0x64  | If the top stack value is False, the statements are executed. The top stack value is removed. |
| `OP_ELSE`   | 103    | 0x67  | If the preceding OP_IF or OP_NOTIF or OP_ELSE was not executed then these statements are executed, and if the preceding OP_IF or OP_NOTIF or OP_ELSE was executed then these statements are not executed. |
| `OP_ENDIF`  | 104    | 0x68  | Ends an if/else block. All blocks must end, or script execution fails. An OP_ENDIF without OP_IF earlier is also invalid. |
| `OP_VERIFY` | 105    | 0x69  | Script execution fails if top stack value is not true. The top stack value is removed. |
| `OP_RETURN` | 106    | 0x6a  | Script execution fails if executed. |

## Stack

These opcodes allow scripts to modify the state of the stack.

| Word              | Opcode | Hex   | Description |
|-------------------|--------|-------|-------------|
| `OP_TOALTSTACK`   | 107    | 0x6b  | Puts the input onto the top of the alt stack. Removes it from the main stack. |
| `OP_FROMALTSTACK` | 108    | 0x6c  | Puts the input onto the top of the main stack. Removes it from the alt stack. |
| `OP_2DROP`        | 109    | 0x6d  | Removes the top two stack items. |
| `OP_2DUP`         | 110    | 0x6e  | Duplicates the top two stack items. |
| `OP_3DUP`         | 111    | 0x6f  | Duplicates the top three stack items. |
| `OP_2OVER`        | 112    | 0x70  | Copies the pair of items two spaces back in the stack to the front. |
| `OP_2ROT`         | 113    | 0x71  | The fifth and sixth items back are moved to the top of the stack. |
| `OP_2SWAP`        | 114    | 0x72  | Swaps the top two pairs of items. |
| `OP_IFDUP`        | 115    | 0x73  | If the top stack value is not 0, duplicate it. |
| `OP_DEPTH`        | 116    | 0x74  | Puts the number of stack items onto the stack. |
| `OP_DROP`         | 117    | 0x75  | Removes the top stack item. |
| `OP_DUP`          | 118    | 0x76  | Duplicates the top stack item. |
| `OP_NIP`          | 119    | 0x77  | Removes the second-to-top stack item. |
| `OP_OVER`         | 120    | 0x78  | Copies the second-to-top stack item to the top. |
| `OP_PICK`         | 121    | 0x79  | The item n back in the stack is copied to the top. |
| `OP_ROLL`         | 122    | 0x7a  | The item n back in the stack is moved to the top. |
| `OP_ROT`          | 123    | 0x7b  | The top three items on the stack are rotated to the left. |
| `OP_SWAP`         | 124    | 0x7c  | The top two items on the stack are swapped. |
| `OP_TUCK`         | 125    | 0x7d  | The item at the top of the stack is copied and inserted before the second-to-top item. |

## Splice

These opcodes allow a script to perform a limited set of string manipulations.

| Word         | Opcode | Hex   | Description |
|--------------|--------|-------|-------------|
| `OP_CAT`     | 126    | 0x7e  | Concatenates two strings. |
| `OP_SUBSTR`  | 127    | 0x7f  | Returns a section of a string. |
| `OP_LEFT`    | 128    | 0x80  | Keeps only characters left of the specified point in a string. |
| `OP_RIGHT`   | 129    | 0x81  | Keeps only characters right of the specified point in a string. |
| `OP_SIZE`    | 130    | 0x82  | Pushes the string length of the top element of the stack (without popping it). |

## Bitwise Logic

These opcodes allow scripts to manipulate data by performing bit-level logic
operations.

Inputs are limited to signed 32-bit integers.

| Word        | Opcode | Hex   | Description |
|-------------|--------|-------|-------------|
| `OP_INVERT` | 131    | 0x83  | Flips all of the bits in the input. |
| `OP_AND`    | 132    | 0x84  | Boolean and between each bit in the inputs. |
| `OP_OR`     | 133    | 0x85  | Boolean or between each bit in the inputs. |
| `OP_XOR`    | 134    | 0x86  | Boolean exclusive or between each bit in the inputs. |

## Bytewise Comparison

These opcodes compare the top two items on the stack as raw bytes.

| Word             | Opcode | Hex   | Description |
|------------------|--------|-------|-------------|
| `OP_EQUAL`       | 135    | 0x87  | Returns 1 if the inputs are exactly equal, 0 otherwise. |
| `OP_EQUALVERIFY` | 136    | 0x88  | Same as OP_EQUAL, but runs OP_VERIFY afterward. |

## Bitwise Rotation

These opcodes enable circular shifting of bits.
They treat the top two items on the stack as 32-bit integers, the first
respresents the number of bits to rotate to the left or right, and the second is
the value to be rotated.

| Word       | Opcode | Hex   | Description |
|------------|--------|-------|-------------|
| `OP_ROTR`  | 137    | 0x89  | Shift bits right, sign is not preserved. |
| `OP_ROTL`  | 138    | 0x8a  | Shift bits left, sign is not preserved. |

## Arithmetic

These opcodes implement common arithmetic operations to be used on integer
values.

Arithmetic inputs are limited to signed 32-bit integers, but may overflow their
output.
For example, it is possible for `OP_ADD` to have 2^31 - 1 for its two operands
resulting 2^32 - 2, which overflows, but is still pushed to the stack as the
result of the addition.

| Word                    | Opcode | Hex   | Description |
|-------------------------|--------|-------|-------------|
| `OP_1ADD`               | 139    | 0x8b  | 1 is added to the input. |
| `OP_1SUB`               | 140    | 0x8c  | 1 is subtracted from the input. |
| `OP_2MUL`               | 141    | 0x8d  | The input is multiplied by 2. |
| `OP_2DIV`               | 142    | 0x8e  | The input is divided by 2. |
| `OP_NEGATE`             | 143    | 0x8f  | The sign of the input is flipped. |
| `OP_ABS`                | 144    | 0x90  | The input is made positive. |
| `OP_NOT`                | 145    | 0x91  | If the input is 0 or 1, it is flipped. Otherwise the output will be 0. |
| `OP_0NOTEQUAL`          | 146    | 0x92  | Returns 0 if the input is 0. 1 otherwise. |
| `OP_ADD`                | 147    | 0x93  | Performs addition on the inputs. |
| `OP_SUB`                | 148    | 0x94  | Performs subtraction on the inputs. |
| `OP_MUL`                | 149    | 0x95  | Performs multiplication on the inputs. |
| `OP_DIV`                | 150    | 0x96  | Performs division on the inputs. |
| `OP_MOD`                | 151    | 0x97  | Performs modulo on the inputs. |
| `OP_LSHIFT`             | 152    | 0x98  | Shifts bits left. Zeros are shifted in on the right. Does not preserve sign. |
| `OP_RSHIFT`             | 153    | 0x99  | Shifts bits right. Uses sign extension to preserve sign. |
| `OP_BOOLAND`            | 154    | 0x9a  | If both inputs are not 0, the output is 1. Otherwise 0. |
| `OP_BOOLOR`             | 155    | 0x9b  | If either input is not 0, the output is 1. Otherwise 0. |
| `OP_NUMEQUAL`           | 156    | 0x9c  | Returns 1 if the input numbers are equal, 0 otherwise. |
| `OP_NUMEQUALVERIFY`     | 157    | 0x9d  | Same as OP_NUMEQUAL, but runs OP_VERIFY afterward. |
| `OP_NUMNOTEQUAL`        | 158    | 0x9e  | Returns 1 if the input numbers are not equal, 0 otherwise. |
| `OP_LESSTHAN`           | 159    | 0x9f  | Returns 1 if first input is less than second input, 0 otherwise. |
| `OP_GREATERTHAN`        | 160    | 0xa0  | Returns 1 if first input is greater than second input, 0 otherwise. |
| `OP_LESSTHANOREQUAL`    | 161    | 0xa1  | Returns 1 if first input is less than or equal to second input, 0 otherwise. |
| `OP_GREATERTHANOREQUAL` | 162    | 0xa2  | Returns 1 if first input is greater than or equal to second input, 0 otherwise. |
| `OP_MIN`                | 163    | 0xa3  | Returns the smaller of two inputs. |
| `OP_MAX`                | 164    | 0xa4  | Returns the larger of two inputs. |
| `OP_WITHIN`             | 165    | 0xa5  | Returns 1 if x is within the specified range (left-inclusive), 0 otherwise. |

## Cryptography

These opcodes implement cryptographic primitives commonly used in transaction
scripts.

The `OP_SHA256` opcode is activated by
[DCP-0002](https://github.com/decred/dcps/blob/master/dcp-0002/dcp-0002.mediawiki).
On mainnet, this agenda was activated on block 189,568 (November 2017).
Prior to this agenda activation, `OP_SHA256` is treated as `OP_UNKNOWN192`.

Note that `OP_CODESEPARATOR` is disabled.
Any script including `OP_CODESEPARATOR` will abort and fail, even if it is
within an unexecuted `OP_IF` branch.

| Word                     | Opcode | Hex   | Description |
|--------------------------|--------|-------|-------------|
| `OP_RIPEMD160`           | 166    | 0xa6  | The input is hashed using RIPEMD-160. |
| `OP_SHA1`                | 167    | 0xa7  | The input is hashed using SHA-1. |
| `OP_BLAKE256`            | 168    | 0xa8  | The input is hashed using BLAKE-256. |
| `OP_HASH160`             | 169    | 0xa9  | The input is hashed twice: first with BLAKE-256 and then with RIPEMD-160. |
| `OP_HASH256`             | 170    | 0xaa  | The input is hashed two times with BLAKE-256. |
| `OP_CODESEPARATOR`       | 171    | 0xab  | All of the signature checking words will only match signatures to the data after the most recently-executed OP_CODESEPARATOR. Disabled. |
| `OP_CHECKSIG`            | 172    | 0xac  | Consumes a signature and a full public key, and pushes 1 onto the stack if the transaction data specified by the SIGHASH flag was converted into the signature using the same private key that generated the public key for the given signature type.  Otherwise, it pushes 0 onto the stack. |
| `OP_CHECKSIGVERIFY`      | 173    | 0xad  | Same as OP_CHECKSIG, but OP_VERIFY is executed afterward. |
| `OP_CHECKMULTISIG`       | 174    | 0xae  | Compares the first signature against each public key until it finds an ECDSA match. Starting with the subsequent public key, it compares the second signature against each remaining public key until it finds an ECDSA match. The process is repeated until all signatures have been checked or not enough public keys remain to produce a successful result. All signatures need to match a public key. If all signatures are valid, 1 is returned, 0 otherwise. |
| `OP_CHECKMULTISIGVERIFY` | 175    | 0xaf  | Same as OP_CHECKMULTISIG, but OP_VERIFY is executed afterward. |
| `OP_CHECKSIGALT`         | 190    | 0xbe  | Consumes a signature type, signature and a full public key, and pushes 1 onto the stack if the transaction data specified by the SIGHASH flag was converted into the signature using the same ECDSA private key that generated the public key.  Otherwise, it pushes 0 onto the stack.  |
| `OP_CHECKSIGALTVERIFY`   | 191    | 0xbf  | Same as OP_CHECKSIGALT, but OP_VERIFY is executed afterward. |
| `OP_SHA256`              | 192    | 0xc0  | The input is hashed using SHA-256. Previously `OP_UNKNOWN192`. |

## Lock time

These opcodes are activated by
[DCP-0003](https://github.com/decred/dcps/blob/master/dcp-0003/dcp-0003.mediawiki).
On mainnet, this agenda was activated on block 189,568 (November 2017). Prior to this
agenda activation, these opcodes are treated as `OP_NOP2` and `OP_NOP3`
respectively.

| Word                     | Opcode | Hex  | Description |
|--------------------------|--------|------|-------------|
| `OP_CHECKLOCKTIMEVERIFY` | 177    | 0xb1 | Script execution fails if the top stack item is greater than the transaction's nLockTime field, otherwise script evaluation continues as though an OP_NOP was executed. Previously `OP_NOP2`. |
| `OP_CHECKSEQUENCEVERIFY` | 178    | 0xb2 | Script execution fails if the relative lock time of the input is not equal to or longer than the value of the top stack item. Previously `OP_NOP3`. |

## Proof-of-Stake

These opcodes are used to create Proof-of-Stake transactions.

They are all considered NOPs within the scripting system. Their semantics are
enforced outside of the scripting system by the staking consensus rules.

| Word             | Opcode | Hex   | Description |
|------------------|--------|-------|-------------|
| `OP_SSTX`        | 186    | 0xba  | Tags an output as a ticket purchase. |
| `OP_SSGEN`       | 187    | 0xbb  | Tags an output as a ticket vote. |
| `OP_SSRTX`       | 188    | 0xbc  | Tags an output as a ticket revocation. |
| `OP_SSTXCHANGE`  | 189    | 0xbd  | Tags an output as ticket purchase change. |

## No op

As the name implies, these opcodes do nothing, they are reserved for future use.
The txscript engine can be passed a flag which will cause usage of these opcodes
to return an error.

Following the activation of
[DCP-0002](https://github.com/decred/dcps/blob/master/dcp-0002/dcp-0002.mediawiki),
`OP_UNKNOWN192` is redefined as `OP_SHA256`.

Following the activation of
[DCP-0003](https://github.com/decred/dcps/blob/master/dcp-0003/dcp-0003.mediawiki),
`OP_NOP2` and `OP_NOP3` are redefined as `OP_CHECKLOCKTIMEVERIFY` and
`OP_CHECKSEQUENCEVERIFY` respectively.

| Word                              | Opcode    | Hex         | Description |
|-----------------------------------|-----------|-------------|-------------|
| `OP_NOP`                          | 97        | 0x61        | Does nothing. Does not cause script execution to fail. |
| `OP_NOP1`                         | 176       | 0xb0        | Does nothing. Does not cause script execution to fail. |
| `OP_NOP4` - `OP_NOP10`            | 179 - 185 | 0xb3 - 0xb9 | Does nothing. Does not cause script execution to fail. |
| `OP_UNKNOWN193` - `OP_UNKNOWN248` | 193 - 248 | 0xc1 - 0xf8 | Does nothing. Does not cause script execution to fail. |

## Reserved

| Word          | Opcode | Hex   | Description |
|---------------|--------|-------|-------------|
| `OP_RESERVED` | 80     | 0x50  | Script execution fails unless occuring in an unexecuted OP_IF branch. |
| `OP_VER`      | 98     | 0x62  | Script execution fails unless occuring in an unexecuted OP_IF branch. |
| `OP_VERIF`    | 101    | 0x65  | Script execution fails even when occuring in an unexecuted OP_IF branch. |
| `OP_VERNOTIF` | 102    | 0x66  | Script execution fails even when occuring in an unexecuted OP_IF branch. |
