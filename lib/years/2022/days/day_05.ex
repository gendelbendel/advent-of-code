defmodule AdventOfCode.Year2022.Day05 do
  def part1(args) do
    stacks =
      args
      |> Enum.filter(fn x -> x != "" end)
      |> prepare_stacks()

    moves =
      args
      |> Enum.filter(fn x -> String.contains?(x, "move") end)
      |> prepare_moves()

    moves
    |> execute_moves_9000(stacks)
    |> top_boxes()
  end

  defp prepare_stacks(input) do
    input
    |> Enum.filter(fn line -> String.contains?(line, "[") end)
    |> Enum.map(&prepare_row/1)
    |> Enum.zip()
    |> Enum.map(fn row -> Tuple.to_list(row) end)
    |> Enum.map(fn row -> Enum.filter(row, fn ele -> ele != " " end) end)
    |> Enum.map(fn row -> Enum.reverse(row) end)
  end

  defp prepare_row(row) do
    row
    |> String.codepoints()
    |> Enum.chunk_every(4)
    |> Enum.map(fn box -> Enum.at(box, 1) end)
  end

  defp prepare_moves(moves) do
    moves
    |> Enum.map(&prepare_move/1)
  end

  defp prepare_move(move) do
    [qty, from, to] = Regex.scan(~r{\d+}, move)

    %{
      qty: String.to_integer(List.first(qty)),
      from: String.to_integer(List.first(from)),
      to: String.to_integer(List.first(to))
    }
  end

  defp execute_moves_9000(moves, stacks) do
    moves
    |> Enum.reduce(stacks, &execute_move_9000/2)
  end

  defp execute_move_9000(move, stacks) do
    for i <- 0..move.qty, i > 0, reduce: stacks do
      acc ->
        {value, new_stack} =
          Enum.at(acc, move.from - 1)
          |> List.pop_at(-1)

        stacks_half_done = List.replace_at(acc, move.from - 1, new_stack)

        List.replace_at(
          stacks_half_done,
          move.to - 1,
          Enum.at(stacks_half_done, move.to - 1) ++ [value]
        )
    end
  end

  defp top_boxes(stacks) do
    stacks
    |> Enum.reduce("", fn stack, acc -> "#{acc}#{List.last(stack)}" end)
  end

  def part2(args) do
    stacks =
      args
      |> Enum.filter(fn x -> x != "" end)
      |> prepare_stacks()

    moves =
      args
      |> Enum.filter(fn x -> String.contains?(x, "move") end)
      |> prepare_moves()

    moves
    |> execute_moves_9001(stacks)
    |> top_boxes()
  end

  defp execute_moves_9001(moves, stacks) do
    moves
    |> Enum.reduce(stacks, &execute_move_9001/2)
  end

  defp execute_move_9001(move, stacks) do
    values =
      Enum.at(stacks, move.from - 1)
      |> Enum.take(-move.qty)

    new_stack =
      Enum.at(stacks, move.from - 1)
      |> Enum.drop(-move.qty)

    stacks_half_done = List.replace_at(stacks, move.from - 1, new_stack)

    List.replace_at(
      stacks_half_done,
      move.to - 1,
      Enum.at(stacks_half_done, move.to - 1) ++ values
    )
  end
end
