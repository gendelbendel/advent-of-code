use Mix.Config

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true,
  project_root: File.cwd!(),
  cache_dir: ".cache/advent_of_code_inputs",
  dev_dir: "dev_input/advent_of_code_inputs",
  allow_dev_dir?: true

try do
  import_config "secrets.exs"
rescue
  _ -> :ok
end
