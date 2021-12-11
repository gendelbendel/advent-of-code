defmodule Mix.Tasks.Day10.P01 do
  use Mix.Task

  import AdventOfCode2021.Day10

  @shortdoc "Day 10 Part 1"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(10, 2021)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
