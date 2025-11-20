dcrdevdocs
==========

[![Build Status](https://github.com/decred/dcrdevdocs/workflows/Build%20and%20Test/badge.svg)](https://github.com/decred/dcrdevdocs/actions)
[![ISC License](https://img.shields.io/badge/license-ISC-blue.svg)](http://copyfree.org)

`dcrdevdocs` is source code for the [Decred Developers documentation](https://devdocs.decred.org).

`dcrdevdocs` is built with [MkDocs](https://www.mkdocs.org/) - a documentation toolkit written in Python.

## Development

#### Install Python

In order to develop on `dcrdocs` you will need [Python](https://www.python.org/)
installed on your system.
Version 3.14 is recommended because this is the version used by the live site,
however MkDocs does also support versions 3.8 and later.
Python 2 is not supported.

You can verify your installation of Python by checking the output from these two
commands:

```bash
$ python --version
Python 3.9.5
$ pip --version
pip 21.1.2
```

#### Install dependencies

To install MkDocs and all of the other Python libraries required by `dcrdevdocs`:

```bash
$ pip install mkdocs && pip install --user -r requirements.txt
```

#### Getting started

This repo contains a single configuration file named `mkdocs.yml`, and a folder named `docs` that will contain the documentation source files. MkDocs comes with a built-in dev-server that lets you preview the documentation as you work on it. Make sure you are in the same directory as the `mkdocs.yml` configuration file, and then start the server by running the `mkdocs serve` command:

```bash
$ mkdocs serve
INFO     -  Building documentation...
INFO     -  Cleaning site directory
INFO     -  Documentation built in 9.09 seconds
INFO     -  [13:26:55] Serving on http://127.0.0.1:8000/
```

If you are using Windows, you may need to inform python to search sys.path for the mkdocs module:

```bash
$ python -m mkdocs serve
INFO     -  Building documentation...
INFO     -  Cleaning site directory
INFO     -  Documentation built in 9.09 seconds
INFO     -  [13:26:55] Serving on http://127.0.0.1:8000/
```

Open up <http://127.0.0.1:8000> in your browser, and you will see the documentation home page being displayed. The dev-server also supports auto-reloading, and will rebuild your documentation whenever anything in the configuration file or the documentation directory changes.

#### Formatting

In general, stick to standard Markdown formatting. However, these docs use [Material for Mkdocs](https://squidfunk.github.io/mkdocs-material/reference/), so consult their documentation if you need additional formatting tools.


## Deploying

To deploy `dcrdevdocs`, first build the documentation:

```bash
$ ./bin/build_docs.sh
```

This will build the documentation into a new directory named `site`.

The version of `dcrdevdocs` that you just built only uses static files which are all contained within the `site/` directory, so this directory can be hosted using almost any web server software.

#### Docker

`dcrdevdocs` can also be built and hosted in a [Docker](https://www.docker.com/) container. Build the container using:

```bash
$ ./bin/build.sh
```

The container can then be run with:

```bash
$ docker run -d --rm -p <local port>:80 decred/dcrdevdocs:latest
```

## Pages to review upon testnet reset

- `environments/testnet.md`

## Getting help

To get help with `dcrdevdocs` please create a [GitHub issue](https://github.com/decred/dcrdevdocs/issues) or the join the [Decred community](https://decred.org/community/) using your preferred chat platform.
