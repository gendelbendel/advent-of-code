defmodule AdventOfCode.Year2022.Day03 do
  def part1(args) do
    args
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&divide_compartments/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  defp divide_compartments(rucksack) do
    {first_half, second_half} = String.split_at(rucksack, div(String.length(rucksack), 2))
    unique_list_items([String.graphemes(first_half), String.graphemes(second_half)])
  end

  defp unique_list_items(items) do
    items
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.at(0)
  end

  defp score(var) do
    code = String.to_charlist(var) |> hd

    if code > 96 do
      code - 96
    else
      code - 38
    end
  end

  def part2(args) do
    args
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.chunk_every(3)
    |> Enum.map(&divide_badges/1)
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  defp divide_badges(jobs) do
    unique_list_items(Enum.map(jobs, fn job -> String.graphemes(job) end))
  end
end
