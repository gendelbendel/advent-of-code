# AdventOfCode

[Elixir](https://elixir-lang.org/) implementation of the [Advent of Code 2021](https://adventofcode.com/2021) challenges

## Installation

```bash
mix deps.get
```

## Secrets config

Make a new file `config/secrets.exs` and define it like so:

```elixir
use Mix.Config

config :advent_of_code, AdventOfCode.Input,
  session_cookie: "..." # yours will be longer
```

Replace the `session_cookie` value with your cookie from the adventofcode website

## dev_input vs cache vs download

There are three different ways of gathering input:

1. Downloading input directly from the advent of code website
2. Using a cache from your saved download
3. Using [dev_input](dev_input) directory (aka my input)

### Load preference order

The input loading order depends on configuration and existence of files.

1. If `allow_dev_dir?` in [config/config.exs](config/config.exs) is set to `true` and the input file exists for your specified year/day/part inside `dev_input` directory, the program will prioritize this first.
2. If the input file exists for your specified year/day/part inside `.cache` directory, the program will prioritize this second.
3. If `allow_network?` in [config/config.exs](config/config.exs) is set to `true`, it will download the input directly from the Advent of Code website
   - Note: You must have your secret setup correctly. Refer to [Secrets Config](#secrets-config).

## Running

```bash
mix day_runner -d X -p Y -y Z
```

Replace `X` with your day, `Y` with part (either `1` or `2`), and `Z` with your year

e.g. to run day 01, part 01, year 2022

```bash
mix day_runner -d 1 -p 1 -y 2022
```
