defmodule Mix.Tasks.Day03.P02 do
  use Mix.Task

  import AdventOfCode2021.Day03

  @shortdoc "Day 03 Part 2"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(3, 2021)

    input
    |> part2()
    |> IO.inspect(label: "Part 2 Results")
  end
end
