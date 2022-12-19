defmodule AdventOfCode.Year2022.Day02 do
  def part1(args) do
    args
    |> Enum.map(&parse_player_input/1)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.map(&get_player_score/1)
    |> Enum.sum()
  end

  defp parse_player_input(game) when game == "" do
  end

  defp parse_player_input(game) do
    [enemy, _space, player] = game |> String.graphemes()
    %{enemy: enemy, player: player}
  end

  defp get_player_score(game) do
    get_player_choice_value(game) + get_player_game_result_value(game)
  end

  defp get_player_choice_value(%{enemy: _enemy, player: player}) do
    case player do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
      _ -> 0
    end
  end

  defp get_player_game_result_value(%{enemy: enemy, player: player}) do
    cond do
      player == "X" ->
        cond do
          enemy == "A" -> 3
          enemy == "B" -> 0
          enemy == "C" -> 6
        end

      player == "Y" ->
        cond do
          enemy == "A" -> 6
          enemy == "B" -> 3
          enemy == "C" -> 0
        end

      player == "Z" ->
        cond do
          enemy == "A" -> 0
          enemy == "B" -> 6
          enemy == "C" -> 3
        end

      true ->
        0
    end
  end

  def part2(args) do
    args
    |> Enum.map(&parse_player_input/1)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.map(&get_player_score_p2/1)
    |> Enum.sum()
  end

  defp get_player_score_p2(game) do
    get_player_choice_value_p2(game) + get_player_game_result_value_p2(game)
  end

  defp get_player_choice_value_p2(%{enemy: _enemy, player: player}) do
    case player do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
      _ -> 0
    end
  end

  defp get_player_game_result_value_p2(%{enemy: enemy, player: player}) do
    cond do
      player == "X" ->
        cond do
          enemy == "A" -> 3
          enemy == "B" -> 1
          enemy == "C" -> 2
        end

      player == "Y" ->
        cond do
          enemy == "A" -> 1
          enemy == "B" -> 2
          enemy == "C" -> 3
        end

      player == "Z" ->
        cond do
          enemy == "A" -> 2
          enemy == "B" -> 3
          enemy == "C" -> 1
        end

      true ->
        0
    end
  end
end
