defmodule Mix.Tasks.Day10.P02 do
  use Mix.Task

  import AdventOfCode2021.Day10

  @shortdoc "Day 10 Part 2"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(10, 2021)

    input
    |> part2()
    |> IO.inspect(label: "Part 2 Results")
  end
end
