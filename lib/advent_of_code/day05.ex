defmodule AdventOfCode.Day05 do
  defmodule Point do
    @type t :: %__MODULE__{
            x: integer(),
            y: integer()
          }

    defstruct x: 0, y: 0

    defguard is_straight(x1, x2, y1, y2) when x1 == x2 or y1 == y2

    @spec new(list(integer())) :: t()
    def new([x, y]), do: %Point{x: x, y: y}

    @spec points_between({t(), t()}) :: list(t())
    def points_between({%Point{x: x1, y: y1}, %Point{x: x2, y: y2}}) when is_straight(x1, x2, y1, y2) do
      for x <- x1..x2, y <- y1..y2, do: %Point{x: x, y: y}
    end

    # Diagonals
    def points_between({%Point{x: x1, y: y1}, %Point{x: x2, y: y2}}) do
      for {x, y} <- Enum.zip(x1..x2, y1..y2), do: %Point{x: x, y: y}
    end

    def is_straight_line({%Point{x: x1, y: y1}, %Point{x: x2, y: y2}}) when is_straight(x1, x2, y1, y2), do: true
    def is_straight_line(_), do: false
  end

  @spec venture_to_locations(String.t()) :: {Point.t(), Point.t()}
  defp venture_to_locations(line) do
    # The format is x1,y1 -> x2,y2
    ~r"(\d+),(\d+)\s+->\s+(\d+),(\d+)"
    |> Regex.run(line)
    # The first element is the whole regex match
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&Point.new/1)
    |> List.to_tuple()
  end

  @spec compute_venture_overlaps(list(String.t()), boolean()) :: integer()
  def compute_venture_overlaps(input, include_diagonals \\ false) when is_list(input) do
    filter = fn line -> include_diagonals or Point.is_straight_line(line) end

    input
    |> Enum.map(&venture_to_locations/1)
    |> Enum.filter(filter)
    |> Enum.flat_map(&Point.points_between/1)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.count(fn count -> count > 1 end)
  end
end
