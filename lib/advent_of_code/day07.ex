defmodule AdventOfCode.Day07 do

  @spec fuel_consumed(integer(), list(integer()), :constant | :linear)  :: integer()

  # 1 -> 1 -> 1 -> 1 -> 1
  defp fuel_consumed(center, positions, :constant) do
    positions
    |> Enum.map(fn x -> abs(center - x) end)
    |> Enum.sum()
  end

  # 1 -> 2 -> 3 -> 4 -> 5
  defp fuel_consumed(center, positions, :linear) do
    positions
    |> Enum.map(fn x -> abs(center - x) end)
    |> Enum.map(fn x -> (x/2) * (x + 1) end)
    |> Enum.map(&trunc/1)
    |> Enum.sum()
  end

  @spec compute_fuel_consumption(String.t(), :constant | :linear) :: integer()
  def compute_fuel_consumption(input, consumption_acceleration) do
    positions = input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()

    List.first(positions) .. List.last(positions)
    |> Enum.map(fn position -> fuel_consumed(position, positions, consumption_acceleration) end)
    |> Enum.min()
  end
end
