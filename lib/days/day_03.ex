defmodule AdventOfCode2021.Day03 do
  def part1(args) do
    frequencies =
      args
      |> Enum.map(&gather_frequencies/1)
      |> Enum.zip_reduce([], &gather_frequency/2)

    gamma = calculate_gamma(frequencies)
    epsilon = calculate_epsilon(frequencies)

    calculate_power_consumption(gamma, epsilon)
  end

  defp split_characters(string), do: String.graphemes(string)

  defp gather_frequencies(value) do
    value
    |> split_characters()
  end

  defp gather_frequency(value, acc) do
    frequency =
      value
      |> Enum.frequencies()

    Enum.concat(acc, [frequency])
  end

  defp calculate_gamma(frequencies) do
    frequencies
    |> Enum.reduce('', &calculate_gamma_digit/2)
  end

  defp calculate_gamma_digit(frequency, acc) do
    "#{acc}#{get_gamma_digit(frequency)}"
  end

  defp get_gamma_digit(frequency) do
    cond do
      Map.get(frequency, "0") > Map.get(frequency, "1") ->
        "0"

      true ->
        "1"
    end
  end

  defp calculate_epsilon(frequencies) do
    frequencies
    |> Enum.reduce('', &calculate_epsilon_digit/2)
  end

  defp calculate_epsilon_digit(frequency, acc) do
    "#{acc}#{get_epsilon_digit(frequency)}"
  end

  defp get_epsilon_digit(frequency) do
    cond do
      Map.get(frequency, "0") > Map.get(frequency, "1") ->
        "1"

      true ->
        "0"
    end
  end

  defp calculate_power_consumption(gamma, epsilon) when is_binary(gamma) do
    calculate_power_consumption(String.to_integer(gamma, 2), epsilon)
  end

  defp calculate_power_consumption(gamma, epsilon) when is_binary(epsilon) do
    calculate_power_consumption(gamma, String.to_integer(epsilon, 2))
  end

  defp calculate_power_consumption(gamma, epsilon) do
    gamma * epsilon
  end

  def part2(args) do
    args
    |> IO.puts()
  end
end
