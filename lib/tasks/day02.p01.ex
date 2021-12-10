defmodule Mix.Tasks.Day02.P01 do
  use Mix.Task

  import AdventOfCode2021.Day02

  @shortdoc "Day 02 Part 1"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(2, 2021)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
