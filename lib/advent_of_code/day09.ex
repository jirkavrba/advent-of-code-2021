defmodule AdventOfCode.Day09 do
  alias AdventOfCode.Support.Matrix

  @spec find_sum_of_low_points(list(String.t())) :: integer()
  def find_sum_of_low_points(input) when is_list(input) do
    width = input |> Enum.at(0) |> String.length()
    height = input |> Enum.count()

    matrix = input
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(width)
    |> Matrix.from_list()
    |> find_low_points(width, height)
  end

  defp neighbours({x, y}, width, height) do
    [
      (if x > 0,          do: {x - 1, y}),
      (if x < width - 1,  do: {x + 1, y}),
      (if y > 0,          do: {x, y - 1}),
      (if y < height - 1, do: {x, y + 1}),
    ]
    |> Enum.reject(&(&1 == nil))
  end

  defp find_low_points(matrix, width, height) do
    positions = for x <- 0..(width - 1), y <- 0..(height - 1), do: {
      matrix[y][x],
      neighbours({x, y}, width, height)
      |> Enum.map(fn {x, y} -> matrix[y][x] end)
    }

    positions
    |> Enum.filter(fn {position, neighbours} -> Enum.all?(neighbours, fn neighbour -> neighbour > position end) end)
    |> Enum.map(fn {position, _} -> position + 1 end)
    |> Enum.sum()
  end
end
