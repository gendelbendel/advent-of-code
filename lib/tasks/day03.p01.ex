defmodule Mix.Tasks.Day03.P01 do
  use Mix.Task

  import AdventOfCode2021.Day03

  @shortdoc "Day 03 Part 1"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(3, 2021)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
