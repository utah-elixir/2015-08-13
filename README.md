# Utah Elixir 2015-08-13

Distribute all the things

Prerequisites
-------------

## Elixir

http://elixir-lang.org/install.html

Usage
-----

```sh
$ git clone https://github.com/utah-elixir/2015-08-13
$ cd 2015-08-13
$ mix deps.get
$ ./bin/start
Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.0.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(c@127.0.0.1)1> DistributedFun.start()
```

## Examples

### Prerequisites

#### Mac OS X (brew)

```sh
$ brew install sox
```

#### Apt-get

```sh
$ sudo apt-get install sox
```

### Add

```sh
iex(c@127.0.0.1)1> DistributedFun.Example.Add.register()
iex(c@127.0.0.1)2> DistributedFun.Example.Add.call(1, 2)
```

### Say

```sh
iex(c@127.0.0.1)1> DistributedFun.Example.Say.register()
iex(c@127.0.0.1)2> DistributedFun.Example.Say.call("Hello, there!")
```

### Tune

```sh
iex(c@127.0.0.1)1> DistributedFun.Example.Tune.register()
iex(c@127.0.0.1)1> DistributedFun.Example.Tune.call(c: 1)
```
