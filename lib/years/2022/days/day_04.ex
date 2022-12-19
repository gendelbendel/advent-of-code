defmodule AdventOfCode.Year2022.Day04 do
  def part1(args) do
    args
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&gather_ranges/1)
    |> Enum.map(&detect_overlaps/1)
    |> Enum.sum()
  end

  defp gather_ranges(range_pair) do
    range_pair
    |> String.split(",")
    |> Enum.map(&define_begin_finish/1)
  end

  defp define_begin_finish(range) do
    [begin, finish] =
      range
      |> String.split("-")

    %{begin: String.to_integer(begin), finish: String.to_integer(finish)}
  end

  defp detect_overlaps(range_pair_map) do
    [first, second] = range_pair_map

    cond do
      (first.begin <= second.begin and first.finish >= second.finish) or
          (second.begin <= first.begin and second.finish >= first.finish) ->
        1

      true ->
        0
    end
  end

  @spec part2(any) :: number
  def part2(args) do
    args
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&gather_ranges/1)
    |> Enum.map(&detect_contains/1)
    |> Enum.sum()
  end

  defp detect_contains(range_pair_map) do
    [first, second] = range_pair_map

    cond do
      first.begin in second.begin..second.finish or
        first.finish in second.begin..second.finish or
        second.begin in first.begin..first.finish or
          second.finish in first.begin..first.finish ->
        1

      true ->
        0
    end
  end
end
