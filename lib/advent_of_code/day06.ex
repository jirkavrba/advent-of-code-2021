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

    shift_lifetimes = fn
      {0, v} -> [{:new, v}, {@initial, v}]
      {k, v} -> [{k - 1, v}]
    end

    1..days
    |> Enum.reduce(initial, fn _, fish ->
      fish
      |> Enum.flat_map(shift_lifetimes)
      |> Map.new()
      |> then(fn map -> map
        |> put(@reset, get(map, :new, 0) + get(map, @reset, 0))
        |> delete(:new)
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
