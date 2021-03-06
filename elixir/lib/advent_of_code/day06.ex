defmodule AdventOfCode.Day06 do

  @reset 6
  @initial 8

  @spec compute_number_of_lanternfish_after(String.t(), non_neg_integer()) :: non_neg_integer()
  def compute_number_of_lanternfish_after(input, days \\ 80) when is_integer(days) do
    initial =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    import Map, only: [put: 3, get: 3, delete: 2]

    1..days
    |> Enum.reduce(initial, fn _, fish ->
      fish
      |> put(@reset + 1, get(fish, 0, 0) + get(fish, @reset + 1, 0))
      |> put(@initial + 1, get(fish, 0, 0))
      |> delete(0)
      |> Enum.map(fn {k, v} -> {k - 1, v} end)
      |> Map.new()
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
