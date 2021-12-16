defmodule Mix.Tasks.Day05.P01 do
  use Mix.Task

  import AdventOfCode2021.Day03

  @shortdoc "Day 05 Part 1"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(5, 2021)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
