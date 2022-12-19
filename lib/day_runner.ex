defmodule Mix.Tasks.DayRunner do
  use Mix.Task

  @shortdoc "Run supplied day and part"
  def run(args) do
    with {:ok, day_part_year} <- parse_options(args),
         {:ok, %{day: day, part: part, mod: mod, year: year}} <- get_module(day_part_year) do
      input = AdventOfCode.Input.get!(day, year)

      apply(mod, part, [input])
      |> IO.inspect(label: "Year #{year} Day #{day} #{Atom.to_string(part)} results: ")
    else
      {:error, error} -> handle_error(error)
    end
  end

  defp handle_error(error) do
    raise error
  end

  defp parse_options(args) do
    {valid, _args, _invalid} =
      args
      |> OptionParser.parse(
        strict: [day: :integer, part: :integer, year: :integer],
        aliases: [d: :day, p: :part, y: :year]
      )

    valid
    |> Map.new()
    |> validate_options()
  end

  defp validate_options(%{day: _day, part: _part, year: _year} = options) do
    {:ok, options}
  end

  defp validate_options(%{day: _day}) do
    {:error, "Missing part. Supply with `-p X` or `--part X`"}
  end

  defp validate_options(%{part: _part}) do
    {:error, "Missing day. Supply with `-d X` or `--day X`"}
  end

  defp validate_options(_opts) do
    {:error, "Something really wrong happened"}
  end

  defp get_module(%{day: day, part: part, year: year}) do
    with modules <- get_all_day_modules(year),
         day_mod_pair <-
           Enum.reduce(modules, %{day: day, part: part, year: year}, &find_matching_day/2),
         {:ok, valid_day} <- validate_day(day_mod_pair),
         {:ok, _valid_part} = valid_pair <- validate_part(valid_day) do
      valid_pair
    else
      {:error, error} -> {:error, error}
    end
  end

  defp find_matching_day(mod, acc) do
    cond do
      Map.get(acc, :day) == Map.get(mod, :day) ->
        Map.put(acc, :mod, Map.get(mod, :mod))

      true ->
        acc
    end
  end

  defp validate_part(%{part: 1} = full) do
    {:ok, Map.replace(full, :part, :part1)}
  end

  defp validate_part(%{part: 2} = full) do
    {:ok, Map.replace(full, :part, :part2)}
  end

  defp validate_part(%{part: part}) do
    {:error, "Invalid part; only 1 or 2 is allowed. Given: #{part}"}
  end

  defp validate_day(%{mod: _mod} = full) do
    {:ok, full}
  end

  defp validate_day(%{day: day, part: _part}) do
    {:error, "Could not find available module for day: #{day}"}
  end

  defp get_all_day_modules(year) do
    with {:ok, list} <- :application.get_key(:advent_of_code, :modules) do
      list
      |> Enum.filter(&filter_year_modules(&1, year))
      |> Enum.filter(&filter_day_modules_suffix/1)
      |> Enum.map(&get_module_map_value/1)
    end
  end

  defp filter_year_modules(mod, year) do
    String.contains?(Atom.to_string(mod), ~w|Year|) &&
      String.contains?(Atom.to_string(mod), Integer.to_string(year))
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
