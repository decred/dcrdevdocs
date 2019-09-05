# <img class="dcr-icon" src="/img/dcr-icons/Dcrtl.svg" /> Testnet

---

Testnet is a full Decred network which is completely independent from mainnet.
Decred on testnet carry no economic value, making testnet the perfect place to
test new applications and experiment without risk before moving onto mainnet.

Decred is currently on its 3rd testnet, also known as testnet3. Testnets are
periodically reset to help keep a manageable blockchain file size.

## How to Run a Testnet Node

Running a testnet3 node is incredibly easy. Your application of choice will need
to download the testnet3 blockchain, and you will need to create a new wallet
file for testnet3 use. Your mainnet blockchain and wallet files will remain
untouched.

### Decrediton

You can switch Decrediton between mainnet and testnet in the Settings tab by
using the dropdown box labelled "Network".

### Command-Line Suite

To launch `dcrd` and `dcrwallet` on testnet, simply add the `--testnet` flag to
your launch command.
Alternatively, you could put `testnet=1` in all of your
config files.

On the first launch of `dcrd --testnet`, `dcrd` will begin downloading the
testnet3 blockchain to the `data/testnet3` folder of `dcrd`'s home directory.

Before you're able to launch `dcrwallet` with the `--testnet` flag, you must
create a separate testnet wallet using the `dcrwallet --testnet --create`
command. The steps are the same as those found in the [dcrwallet Setup
Guide](https://docs.decred.org/wallets/cli/dcrwallet-setup).

To issue commands to both `dcrwallet` and `dcrd`, you must also add the
`--testnet` flag to any of the `dcrctl` commands that you use. E.g. you would
issue the `dcrctl --testnet --wallet getbalance` command to check your testnet
balance.

---

## Acquiring Testnet Coins

You can acquire coins through the [Decred Testnet
Faucet](https://faucet.decred.org). Please return any coins to the address
listed at the bottom of that page when you're done playing with the testnet.

---

## Testnet Block Explorer

A testnet instance of [dcrdata](https://github.com/decred/dcrdata) is available for public
use at <https://testnet.dcrdata.org/>.

---

## Testnet Voting Service Providers (VSP)

To experiment with staking and voting with a Voting Service Provider (VSP),
you'll need to sign up for a testnet VSP.

- [https://testnet.decredvoting.com](https://testnet.decredvoting.com)
- [https://test-dcrpool.dittrex.com](https://test-dcrpool.dittrex.com)
- [https://teststakepool.decred.org](https://teststakepool.decred.org)
- [https://test.stakey.net](https://test.stakey.net)
