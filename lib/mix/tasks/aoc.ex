defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "A simple mix task to scaffold AoC files structure for a day specified in the params."

  @moduledoc ~S"""
  For example, using `mix aoc 5` will generate the following files:
  - `/lib/advent_of_code/day05.ex`
  - `/test/advent_of_code/day05_test.ex`
  - `/priv/inputs/day05.txt`
  """

  @impl Mix.Task
  def run([]) do
    Mix.shell().error("Missing day number as an argument!\nFor example, use 'mix aoc 5'")
  end

  @impl Mix.Task
  def run([day | _]) do
    day = String.pad_leading(day, 2, "0")

    file_name = Macro.underscore("day#{day}")
    module_name = Macro.camelize("day#{day}")

    assigns = [
      file_name: file_name,
      module: module_name,
      test_module:  module_name <> "Test",
    ]

    Mix.Generator.copy_template("priv/mix/day.eex", "lib/advent_of_code/#{file_name}.ex", assigns)
    Mix.Generator.copy_template("priv/mix/day_test.eex", "test/advent_of_code/#{file_name}_test.exs", assigns)
  end
end
