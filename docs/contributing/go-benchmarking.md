# ![](../img/dcr-icons/Code.svg){ .dcr-icon } Benchmarking in Go
---

Since many of the Decred projects are written using Golang, this page will give a basic guide on how to benchmark functions in Go. You can find several examples of good benchmarking practices in Decred repos, but this page will serve as the community guide and standard.

!!! question "Looking for a way to contribute to The Decred Project?"

    If you've got Golang skills and are looking to contribute, you can find a ton of opportunities where the code in [Decred repos](https://github.com/decred) could benefit from having benchmarks.

    Further, learning to benchmark is a good introduction to Golang for beginners who have already spent time learning from resources like [A Tour of Go](https://go.dev/tour/list) and [Effective Go](https://go.dev/doc/effective_go). To get ideas for how to prioritize benchmarking, read the Go Profiling Guide.

    TODO: Add link to forthcoming Go Profiling guide.

## Why Benchmark?

In the world of cryptocurrencies, even the smallest bug can cost people a significant amount of money. Decred is financial software, and every effort must be taken to ensure the code is as accurate and bug-free as possible. For people to perceive that Decred has value, they also need to perceive that it is safe and reliable. Benchmarking is a good way to help achieve this goal.

The Decred developers advocate that node/wallet/dex software should be easy and accessible for the average person. Hardware and bandwidth costs should be kept as low as possible to promote the highest level of decentralization. The easier it is to run a node, the more people who will. Although it's possible to interact with Decred without running a full-node or even self-custodying, the average user is incentivized to run their own full-nodes to achieve the maximum trustlessness, security, and privacy, as well as to support the network.

With that in mind, it is incredibly important to optimize Decred software to be as performant as possible, without sacrificing accuracy and security. Creating benchmarks for functions allows you to assess the code's performance, and to quantify that performance against future function updates.

Benchmarks, essentially, are how to measure if you've made a faster function. To determine which parts of the code might be the worst offenders for performance and optimization, read the Profiling Guide.

TODO: Add link to forthcoming Go Profiling guide.

## Guide:

### Running a Bench Test Example

Example to see what's going on. Possibly use dcrd's [apbf](https://github.com/decred/dcrd/blob/master/container/apbf/bench_test.go) or dcrd's [secp256k1](https://github.com/decred/dcrd/blob/master/dcrec/secp256k1/bench_test.go) or something else?

### Writing a Bench Test File

Basic format (bench_test.go inside each module?), benchmarking with various inputs, naming, etc.

### Running a benchmark with some standard practices

Number of CPUs, number of times to execute (or length of time to execute for), using various inputs, sample size, displaying memory allocation statistics, etc.

### Comparing Benchmark Results with Benchstat

`go install golang.org/x/perf/cmd/benchstat@latest`

## Further Reading:

### Why Nodes Should Be Optimized for Budget Software:

* [To Node or Not to Node? - Jameson Lopp](https://blog.lopp.net/to-node-or-not-to-node-/)
* [2021 Altcoin Node Sync Tests - Jameson Lopp](https://blog.lopp.net/2021-altcoin-node-sync-tests/)
* [The Limits to Blockchain Scalability - Vitalik Buterin](https://vitalik.ca/general/2021/05/23/scaling.html)

### Optimizing Golang Code:

* [Benchmarking in Golang](https://blog.logrocket.com/benchmarking-golang-improve-function-performance/)
* [Golang: Simple Optimization Notes](https://medium.com/scum-gazeta/golang-simple-optimization-notes-70bc64673980)