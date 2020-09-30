# <img class="dcr-icon" src="/img/dcr-icons/Code.svg" /> Reproducible Builds

---

The process of building software from source can be described as
**reproducible** (or **deterministic**) if it can be run multiple times, under
different conditions, and always yield the same result when given the same
input.
The output of a truly deterministic build will be identical down to every
individual bit, such that equality can be measured using MD5/SHA1 hashes.

A build process may not be deterministic because a compiler may insert metadata
into the output, for example, a timestamp field indicating when the build
happened, or debugging symbols which reference the absolute path of the source
code on the build machine.
If a build process includes compressing some resources, running the compression
with a different level of parallelism may yield different output.
In these cases, two binaries built from the same source may behave identically,
but their hashes will not match when compared.

---

## The Importance of Reproducible Builds

One of the properties of open source software is that anybody is free to browse
and audit the source code.
Advanced users who compile the source for themselves can take some confidence
from the fact that it is has been reviewed by the community, and is therefore
likely to be free of malicious intent.

However, users who compile from source typically represent only a very small
subset of the target audience for a piece of software.
The vast majority of users will instead download a binary which has been
compiled and distributed by somebody else.
A malicious distributor could make modifications to the source code before they
compile it.
To provide an example in the context of cryptocurrency, somebody distributing
pre-compiled wallet software could add extra code which relays the users private
keys back to the distributor, enabling them to steal the users coins.

The existence of reproducible builds provides a method to verify that no
vulnerabilities or backdoors have been added to the code before it has been
compiled.
Multiple parties are able to compile the same source code and because the
results are identical each time, they are able to come to consensus on the
"correct" result.

---

## Reproducible Decred Releases

[decred/release](https://github.com/decred/release) is an automated tool for
cross-compiling executables and release archives (`.tar.gz` or `.zip` depending
on platform) for Decred releases.
Provided the same version of the Go compiler, it should be possible to use this
tool on any system to build the Decred binaries deterministically.

The Go compiler does not build deterministic binaries by default, however
`decred/release` encourages deterministic builds with some parameters.

- `-trimpath` is used to remove all file system paths from compiled executables
- The `buildid` added by the linker is hard-coded to empty string
- Local `GOFLAGS` are overwritten to empty string
- The `netgo` build tag is used to ensure statically linked binaries
- cgo is disabled with environment variable `CGO_ENABLED` set to `0` to ensure
  statically linked binaries

Rather than relying upon the build environment to provide archiving tools,
`decred/release` uses Go packages implementing `tar`/`zip`/`gzip` compression to
ensure archiving is deterministic.

When all of the binaries have been compiled and archived, a manifest file is
written which contains the SHA256 hashes of each archive.
This manifest can be used by consumers of pre-compiled software to
[verify the binaries](https://docs.decred.org/advanced/verifying-binaries/)
they have downloaded.
