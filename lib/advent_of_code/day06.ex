defmodule AdventOfCode.Day06 do
  @spec compute_number_of_lanternfish_after(String.t(), non_neg_integer()) :: non_neg_integer()
  def compute_number_of_lanternfish_after(initial, days \\ 80) when is_integer(days) do
    initial =
      initial
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    reducer = fn _day, fish ->
      fish
      |> Enum.flat_map(fn {0, v} -> [{:new, v}, {8, v}]; {k, v} -> [{k - 1 , v}] end)
      |> Map.new()
      |> then(fn map ->
        map
        |> Map.put(6, Map.get(map, :new, 0) + Map.get(map, 6, 0))
        |> Map.delete(:new)
      end)
    end

    1..days
    |> Enum.reduce(initial, reducer)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end
end
