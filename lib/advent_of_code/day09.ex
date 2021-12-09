defmodule AdventOfCode.Day09 do

  @spec find_sum_of_low_points(list(String.t())) :: integer()
  def find_sum_of_low_points(input) when is_list(input) do
    width = input |> Enum.at(0) |> String.length()
    height = input |> Enum.count()

    matrix = input
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(width)
    |> find_low_points(width, height)
  end

  defp neighbours(matrix, x, y, width, height) do
    c = [matrix |> Enum.at(y) |> Enum.at(x)]

    dx = for i <- max(x - 1, 0) .. min(x + 1, width - 1), do: matrix |> Enum.at(y) |> Enum.at(i)
    dy = for i <- max(y - 1, 0) .. min(y + 1, height - 1), do: matrix |> Enum.at(i) |> Enum.at(i)

    dx ++ dy -- c -- c
  end

  defp find_low_points(matrix, width, height) do
    neighbours(matrix, 0, 0, width, height)
  end
end
