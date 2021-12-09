defmodule AdventOfCode.Day09 do

  alias AdventOfCode.Support.Matrix

  @type position :: {integer(), integer()}

  @spec parse_input(list(String.t())) :: {integer(), integer(), map()}
  defp parse_input(input) when is_list(input) do
    width = input |> Enum.at(0) |> String.length()
    height = input |> Enum.count()
    matrix = input
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(width)
    |> Matrix.from_list()

    {width, height, matrix}
  end

  @spec find_sum_of_low_points(list(String.t())) :: integer()
  def find_sum_of_low_points(input) when is_list(input) do
    {width, height, matrix} = parse_input(input)

    matrix
    |> find_low_points(width, height)
    |> Enum.map(fn {x, y} -> matrix[y][x] + 1 end)
    |> Enum.sum()
  end

  @spec find_low_points(map(), integer(), integer()) :: list(position())
  defp find_low_points(matrix, width, height) do
    positions = for x <- 0..(width - 1), y <- 0..(height - 1), do: {
      {x, y},
      matrix[y][x],
      neighbours({x, y}, width, height) |> Enum.map(fn {x, y} -> matrix[y][x] end)
    }

    positions
    |> Enum.filter(fn {_, value, neighbours} -> Enum.all?(neighbours, fn neighbour -> neighbour > value end) end)
    |> Enum.map(fn {position, _, _} -> position end)
  end

  @spec neighbours(position(), integer(), integer()) :: list(position())
  defp neighbours({x, y}, width, height) do
    [
      (if x > 0,          do: {x - 1, y}),
      (if x < width - 1,  do: {x + 1, y}),
      (if y > 0,          do: {x, y - 1}),
      (if y < height - 1, do: {x, y + 1}),
    ]
    |> Enum.reject(&(&1 == nil))
  end

  @spec find_product_of_largest_basins(list(String.t())) :: integer()
  def find_product_of_largest_basins(input) when is_list(input) do
    {width, height, matrix} = parse_input(input)
    matrix
    |> find_low_points(width, height)
    |> Enum.map(fn center -> find_basin(center, matrix, width, height) end)
    |> Enum.map(&length/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @edge_depth 9

  @spec find_basin(position(), list(position()), map(), integer(), integer()) :: list(position())
  def find_basin(center, basin \\ [], matrix, width, height) do
    neighbours = neighbours(center, width, height)
    |> Enum.reject(fn position -> position in basin end)
    |> Enum.reject(fn {x, y} -> matrix[y][x] >= @edge_depth end)

    initial = basin ++ neighbours ++ [center]
    reducer = fn element, basin -> find_basin(element, basin, matrix, width, height) -- [element] end

    Enum.reduce(neighbours, initial, reducer)
  end
end
