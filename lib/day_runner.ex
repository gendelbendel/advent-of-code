defmodule Mix.Tasks.DayRunner do
  use Mix.Task

  # import AdventOfCode2021.Day01

  @shortdoc "Run supplied day and part"
  def run(args) do
    parse_options(args)
    |> run_with_options()
  end

  defp parse_options(args) do
    {valid, _args, _invalid} =
      args
      |> OptionParser.parse(
        strict: [day: :integer, part: :integer],
        aliases: [d: :day, p: :part]
      )

    valid
    |> List.to_tuple()
    |> validate_options()
  end

  defp validate_options(options) do
    case options do
      {{:day, _day}, {:part, _part}} -> options
      {{:day, _day}} -> {:error, "Missing part. Supply with `-p X` or `--part X`"}
      {{:part, _part}} -> {:error, "Missing day. Supply with `-d X` or `--day X`"}
      _ -> {:error, "Something really wrong happened"}
    end
  end

  defp run_with_options({:error, error}) do
    IO.inspect(error)
  end

  defp run_with_options({{:day, day}, {:part, part}}) do
    day_modules = get_all_day_modules()

    day_modules
    |> Enum.reduce(%{day: day, part: part}, &find_matching_day/2)
    |> validate_day_and_part()
    |> run_day_and_part()
  end

  defp find_matching_day(mod, acc) do
    cond do
      Map.get(acc, :day) == Map.get(mod, :day) ->
        Map.put(acc, :mod, Map.get(mod, :mod))

      true ->
        acc
    end
  end

  defp run_day_and_part(%{day: day, part: part, mod: mod} = full) when is_map(full) do
    input = AdventOfCode2021.Input.get!(day, 2021)

    apply(mod, part, input)
    |> IO.inspect(label: "Day #{day} #{Atom.to_string(part)} results: ")
  end

  defp run_day_and_part(_) do
  end

  defp validate_day_and_part(%{day: _day, part: part, mod: _mod} = full) do
    case part do
      1 ->
        Map.replace(full, :part, :part1)

      2 ->
        Map.replace(full, :part, :part2)

      _ ->
        IO.puts("Invalid part; only 1 or 2 is allowed. Given: #{part}")
    end
  end

  defp validate_day_and_part(%{day: day, part: part}) do
    IO.puts("Could not find available module: -d #{day} -p #{part}")
  end

  defp get_all_day_modules() do
    with {:ok, list} <- :application.get_key(:advent_of_code_2021, :modules) do
      list
      |> Enum.filter(&filter_day_modules_suffix/1)
      |> Enum.map(&get_module_map_value/1)
    end
  end

  defp filter_day_modules_suffix(mod) do
    module_name =
      mod
      |> get_module_last_name()

    String.contains?(module_name, ~w|Day|) &&
      !String.contains?(module_name, ~w|Runner|) &&
      !String.contains?(module_name, ~w|Day00|)
  end

  defp get_module_map_value(mod) do
    %{
      day: get_day_from_module(mod),
      mod: mod
    }
  end

  defp get_day_from_module(mod) do
    mod
    |> get_module_last_name()
    |> String.split("Day")
    |> List.last()
    |> String.to_integer()
  end

  defp get_module_last_name(mod) do
    mod
    |> Module.split()
    |> List.last()
  end
end
