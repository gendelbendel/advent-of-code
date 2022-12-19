defmodule AdventOfCode.Year2021.Day02 do
  # `forward X` increases the horizontal position by X units.
  # `down X` increases the depth by X units.
  # `up X` decreases the depth by X units.
  #
  # What do you get if you multiply your final horizontal position by your final depth?
  def part1(args) do
    args
    |> Enum.reduce(%{horizontal: 0, depth: 0}, &gather_values/2)
    |> multiply_location()
  end

  defp gather_values(value, acc) when value == "" do
    acc
  end

  defp gather_values(value, acc) do
    [command, num] = String.split(value)

    num = String.to_integer(num)

    case command do
      "forward" ->
        Map.replace(acc, :horizontal, acc.horizontal + num)

      "up" ->
        Map.replace(acc, :depth, acc.depth - num)

      "down" ->
        Map.replace(acc, :depth, acc.depth + num)

      _ ->
        acc
    end
  end

  defp multiply_location(map) do
    map.horizontal * map.depth
  end

  # `down X` increases your aim by X units.
  # `up X` decreases your aim by X units.
  # `forward X` does two things:
  #   It increases your `horizontal` position by X units.
  #   It increases your `depth` by your aim multiplied by X.
  #
  # What do you get if you multiply your final horizontal position by your final depth?
  def part2(args) do
    args
    |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, &gather_values_p2/2)
    |> multiply_location()
  end

  defp gather_values_p2(value, acc) when value == "" do
    acc
  end

  defp gather_values_p2(value, acc) do
    [command, num] = String.split(value)

    num = String.to_integer(num)

    case command do
      "forward" ->
        Map.replace(acc, :horizontal, acc.horizontal + num)
        |> Map.replace(:depth, acc.depth + acc.aim * num)

      "up" ->
        Map.replace(acc, :aim, acc.aim - num)

      "down" ->
        Map.replace(acc, :aim, acc.aim + num)

      _ ->
        acc
    end
  end
end
