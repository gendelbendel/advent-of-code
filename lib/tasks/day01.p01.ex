defmodule Mix.Tasks.Day01.P01 do
  use Mix.Task

  import AdventOfCode2021.Day01

  @shortdoc "Day 01 Part 1"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(1, 2021)

    input
    |> part1()
    |> IO.inspect(label: "Part 1 Results")
  end
end
