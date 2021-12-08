defmodule AdventOfCode.Day08 do

  def solve_first_task(input) when is_list(input) do
    input
    |> Enum.map(fn line -> String.split(line, "|", trim: true) end)
    |> Enum.flat_map(fn [_, output] -> String.split(output, " ", trim: true) end)
    |> Enum.map(&String.length/1)
    |> Enum.count(&(&1 in [2, 3, 4, 7]))
  end

  def __task2__(input) do
    :ok
  end

end
