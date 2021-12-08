defmodule Mix.Tasks.Day01.P02 do
  use Mix.Task

  import AdventOfCode2021.Day01

  @shortdoc "Day 01 Part 2"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(1, 2021)

    input
    |> part2()
    |> IO.inspect(label: "Part 2 Results")
  end
end
