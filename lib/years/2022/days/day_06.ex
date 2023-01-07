defmodule AdventOfCode.Year2022.Day06 do
  def part1(args) do
    marker_length = 4

    args
    |> find_marker(marker_length)
  end

  defp find_marker(args, marker_length) do
    args
    |> format_input
    |> get_signal_chunks(marker_length)
    |> Enum.reduce_while(0, &check_for_marker(&1, marker_length, &2))
  end

  defp format_input(args) do
    args
    |> Enum.filter(fn x -> x != "" end)
    |> List.first()
  end

  defp get_signal_chunks(signal, length) do
    signal
    |> String.graphemes()
    |> Enum.chunk_every(length, 1)
    |> Enum.with_index(length)
  end

  defp check_for_marker(chunk, length, _acc) do
    {chunk_string, chunk_index} = chunk
    unique = chunk_string |> Enum.uniq()

    if length(unique) == length do
      {:halt, chunk_index}
    else
      {:cont, 0}
    end
  end

  def part2(args) do
    marker_length = 14

    args
    |> find_marker(marker_length)
  end
end
