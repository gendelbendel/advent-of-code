defmodule AdventOfCode.Year2022.Day01 do
  def part1(args) do
    args
    |> Enum.reduce(%{leader: 0, current: 0}, &gather_elf_calories/2)
    |> Map.get(:leader)
  end

  def update_current_calories(calories, acc) do
    {parsed_calories, _} = Integer.parse(calories)
    %{acc | current: acc.current + parsed_calories}
  end

  def gather_elf_calories(calories, acc) when calories != "" do
    update_current_calories(calories, acc)
  end

  def gather_elf_calories(_calories, acc) do
    cond do
      acc.leader >= acc.current -> %{leader: acc.leader, current: 0}
      true -> %{leader: acc.current, current: 0}
    end
  end

  def part2(args) do
    args
    |> Enum.reduce(%{current: 0, top_three: [0, 0, 0]}, &gather_top_three_elf_calories/2)
    |> Map.get(:top_three)
    |> Enum.sum()
  end

  def gather_top_three_elf_calories(calories, acc) when calories != "" do
    update_current_calories(calories, acc)
  end

  def gather_top_three_elf_calories(_calories, acc) do
    %{current: 0, top_three: [acc.current | acc.top_three] |> Enum.sort(:desc) |> Enum.take(3)}
  end
end
