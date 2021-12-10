defmodule AdventOfCode2021.Day01 do
  def part1(args) do
    args
    |> Enum.reduce(%{count: 0, prev: -1}, &gather_all/2)
    |> Map.get(:count)
  end

  defp gather_all(value, %{count: 0, prev: -1}) do
    %{count: 1, prev: value}
  end

  defp gather_all(value, acc) do
    value |> IO.inspect(label: "Current value")
    acc.prev |> IO.inspect(label: "Previous value")

    cond do
      value > acc.prev ->
        %{count: acc.count + 1, prev: value}

      true ->
        %{count: acc.count, prev: value}
    end
  end

  def part2(args) do
    args
    |> Enum.reduce(%{"count" => 0}, &gather_all_sliding/2)
    |> Access.get("count")
  end

  defp gather_all_sliding(value, acc) when is_binary(value) do
    num = String.to_integer(value)
    gather_all_sliding(num, acc)
  end

  defp gather_all_sliding(value, %{"aCount" => 1} = acc) do
    IO.puts('here')

    %{
      "count" => 0,
      "a" => Access.get(acc, "a") + value,
      "aCount" => 2,
      "b" => value,
      "bCount" => 1
    }
  end

  defp gather_all_sliding(value, %{"bCount" => 1} = acc) do
    %{
      "count" => 0,
      "a" => Access.get(acc, "a") + value,
      "aCount" => 3,
      "b" => Access.get(acc, "b") + value,
      "bCount" => 2,
      "c" => value,
      "cCount" => 1
    }
  end

  defp gather_all_sliding(value, %{"cCount" => 1} = acc) do
    newAcc = %{
      "count" => Access.get(acc, "count"),
      "a" => Access.get(acc, "a"),
      "aCount" => 3,
      "b" => Access.get(acc, "b") + value,
      "bCount" => 3,
      "c" => Access.get(acc, "c") + value,
      "cCount" => 2
    }

    cond do
      Access.get(newAcc, "b") > Access.get(newAcc, "a") ->
        %{
          "count" => Access.get(newAcc, "count") + 1,
          "a" => Access.get(newAcc, "b"),
          "aCount" => 3,
          "b" => Access.get(newAcc, "c"),
          "bCount" => 3,
          "c" => value,
          "cCount" => 1
        }

      true ->
        %{
          "count" => Access.get(newAcc, "count"),
          "a" => Access.get(newAcc, "b"),
          "aCount" => 3,
          "b" => Access.get(newAcc, "c"),
          "bCount" => 3,
          "c" => value,
          "cCount" => 1
        }
    end
  end

  defp gather_all_sliding(value, %{"count" => 0}) do
    %{"count" => 0, "a" => value, "aCount" => 1}
  end
end
