defmodule AdventOfCode2021.Day10 do
  def part1(args) do
    args
    |> Enum.reduce([], &discover_errors/2)
    |> Enum.sum()
  end

  defp discover_errors(value, acc) do
    maybe_errors =
      value
      |> String.graphemes()
      |> Enum.reduce(%{stack: []}, &test_for_error/2)

    cond do
      is_number(maybe_errors) ->
        [maybe_errors | acc]

      true ->
        [0 | acc]
    end
  end

  defp test_for_error(_value, acc) when is_number(acc) do
    acc
  end

  defp test_for_error(value, acc) do
    cond do
      String.contains?(get_available_opening_braces(), value) ->
        Map.replace!(acc, :stack, [value | acc.stack])

      String.contains?(get_available_closing_braces(), value) ->
        resolve_potential_error(value, acc)
    end
  end

  def resolve_potential_error(value, acc) do
    cond do
      List.first(acc.stack) == get_opening_pair(value) ->
        [_head | tail] = Map.get(acc, :stack)
        Map.replace!(acc, :stack, tail)

      List.first(acc.stack) != get_opening_pair(value) ->
        get_error_value(value)
    end
  end

  defp get_opening_pair(close) do
    case close do
      ")" -> "("
      "]" -> "["
      "}" -> "{"
      ">" -> "<"
      _ -> 0
    end
  end

  defp get_error_value(error) do
    case error do
      ")" -> 3
      "]" -> 57
      "}" -> 1197
      ">" -> 25137
      _ -> 0
    end
  end

  defp get_available_opening_braces(), do: "([{<"

  defp get_available_closing_braces(), do: ")]}>"

  def part2(args) do
    args
    |> Enum.reduce([], &discover_goods/2)
    |> find_middle_score()
  end

  defp discover_goods(value, acc) do
    maybe_goods =
      value
      |> String.graphemes()
      |> Enum.reduce(%{stack: []}, &test_for_goods/2)

    cond do
      is_map(maybe_goods) ->
        [Enum.reduce(maybe_goods.stack, 0, &calculate_goods_value/2) | acc]

      true ->
        acc
    end
  end

  defp find_middle_score(scores) do
    scores
    |> Enum.sort()
    |> Enum.at(div(length(scores), 2))
  end

  defp calculate_goods_value(value, acc) do
    acc * 5 + get_goods_value(value)
  end

  defp test_for_goods(_value, acc) when is_number(acc) do
    acc
  end

  defp test_for_goods(value, acc) do
    cond do
      String.contains?(get_available_opening_braces(), value) ->
        Map.replace!(acc, :stack, [value | acc.stack])

      String.contains?(get_available_closing_braces(), value) ->
        resolve_potential_goods(value, acc)
    end
  end

  def resolve_potential_goods(value, acc) do
    cond do
      List.first(acc.stack) == get_opening_pair(value) ->
        [_head | tail] = Map.get(acc, :stack)
        Map.replace!(acc, :stack, tail)

      List.first(acc.stack) != get_opening_pair(value) ->
        0
    end
  end

  defp get_goods_value(goods) do
    case goods do
      "(" -> 1
      "[" -> 2
      "{" -> 3
      "<" -> 4
      _ -> 0
    end
  end
end
