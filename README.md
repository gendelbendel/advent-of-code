# AdventOfCode2021

[Elixir](https://elixir-lang.org/) implementation of the [Advent of Code 2021](https://adventofcode.com/2021) challenges

## Installation

```bash
mix deps.get
```

## Secrets config

Make a new file `config/secrets.exs` and define it like so:

```elixir
use Mix.Config

config :advent_of_code_2021, AdventOfCode2021.Input,
  session_cookie: "..." # yours will be longer
```

Replace the `session_cookie` value with your cookie from the adventofcode website

## Running

```bash
mix dayXX.pYY
```

Replace `XX` with your day, `YY` with part (either `01` or `02`)

## TODOs

- Add unit tests :)
- Days 04-09
