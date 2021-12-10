defmodule Mix.Tasks.Day02.P02 do
  use Mix.Task

  import AdventOfCode2021.Day02

  @shortdoc "Day 02 Part 2"
  def run(_args) do
    input = AdventOfCode2021.Input.get!(2, 2021)

    input
    |> part2()
    |> IO.inspect(label: "Part 2 Results")
  end
end
