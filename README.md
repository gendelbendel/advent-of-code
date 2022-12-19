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

## Running

```bash
mix day_runner -d X -p Y -y Z
```

Replace `X` with your day, `Y` with part (either `1` or `2`), and `Z` with your year

e.g. to run day 01, part 01, year 2022

```bash
mix day_runner -d 1 -p 1 -y 2022
```
