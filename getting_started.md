<!-- <img src="./web/public/images/logo.png" height="68" /> -->
<img src="../elixir-bench-web/public/images/logo.png" height="68" />

# ElixirBench Guide

**ElixirBench is currentl on alpha stage and just a few projects have being
selected for testing and improvements on our services.**

**To add your project, get in contact with us and we will give you the support
and instructions.**

## Prerequisites

To start using ElixirBench, make sure you have:

- A Github account.
- Owner permissions for project hosted on Github.
- Benchmarks scripts to be executed in our runners.

## How to get started

1. Go to your project `settings > webhooks`.
1. Add a webhook pointing to `elixir-bench.org/hooks/handle` and listening
to `push` and `pull-request` events.
1. Make sure the webhook successfuly responded to the `ping event`. :heavy_check_mark: 
1. Add a `bench/config.yml` file to your repository to tell ElixirBench what to
do. The following example specifies a project that should be built with Elixir 1.5.2
and erlang OTP 20.1.2.
```yaml
elixir: 1.5.2
erlang: 20.1.2
```
1. Add a `bench/benchee_helper.exs` file to your repository with all the setup
and calls to your benchmarks. More details in the next section.

## Benchmark Runners

There are a few libraries out there for writing benchmarks in Elixir.
Right now, only one benchmark runner is supported - the [`benchee`](https://github.com/PragTob/benchee) package.
This library was specially designed to make it easier to setup and compare the
results of your benchmarks. Before proceeding, take a minute to look at the documentation and features.

The runner, once the whole environment is brought up, will invoke a single command
to run the benchmarks:

```bash
mix run bench/bench_helper.exs
```

This script is responsible for setup, execution and cleanup of benchmarks.
Results of the runs, must be stored in JSON format in the directory indicated by the
`BENCHMARKS_OUTPUT_PATH` environment variable. An example benchmark can be found in the
[Ecto repository](https://github.com/elixir-ecto/ecto/blob/00284340a69f4cb5327323f12e37c98a81208279/bench/insert_bench.exs).


## Configuring your project

To leverage ElixirBench in a project, a YAML configuration file is expected in `bench/config.yml`
in the project's Githib repository. This configuration file specifies the
environment for running the benchmark. Additional services, like databases can be
provisioned through docker containers.

```yaml
elixir: 1.5.2
erlang: 20.1.2
environment:
  MYSQL_URL: root@localhost
  PG_URL: postgres:postgres@localhost
deps:
  docker:
    - container_name: postgres
      image: postgres:9.6.6-alpine
    - container_name: mysql
      image: mysql:5.7.20
      environment:
        MYSQL_ALLOW_EMPTY_PASSWORD: "true"
```

## Benchmark Samples

Here are some projects that you can grab inspired to learn and setup your
benchmarks!

- Ecto

