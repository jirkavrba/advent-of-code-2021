defmodule AdventOfCode.Day07 do

  defp fuel_consumed(center, positions) do
    positions
    |> Enum.map(fn x -> abs(center - x) end)
    |> Enum.sum()
  end

  def compute_fuel_consumption(input) do
    positions = input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()

    List.first(positions) .. List.last(positions)
    |> Enum.map(fn position -> fuel_consumed(position, positions) end)
    |> Enum.min()
  end

  def __task2__(input) do
    :ok
  end

end
