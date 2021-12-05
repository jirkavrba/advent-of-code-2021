defmodule AdventOfCode.Day05 do
  defmodule Location do
    @type t :: %__MODULE__{
      x: integer(),
      y: integer()
    }

    defstruct x: 0, y: 0

    defguard is_straight(x1, x2, y1, y2) when x1 == x2 or y1 == y2

    @spec new(list(integer())) :: t()
    def new([x, y]), do: %Location{x: x, y: y}

    @spec points_between(list(t())) :: list(t())
    def points_between([%Location{x: x1, y: y1}, %Location{x: x2, y: y2}]) when is_straight(x1, x2, y1, y2)  do
      for x <- min(x1, x2) .. max(x1, x2),
          y <- min(y1, y2) .. max(y1, y2),
      do: %Location{x: x, y: y}
    end

    def points_between([%Location{x: x1, y: y1}, %Location{x: x2, y: y2}]) do
      x1..x2
      |> Enum.zip(y1..y2)
      |> Enum.map(fn {x, y} -> %Location{x: x, y: y} end)
    end

    @spec is_straight_line(list(list(integer()))) :: boolean()
    def is_straight_line([%Location{x: x1, y: y1}, %Location{x: x2, y: y2}]) when is_straight(x1, x2, y1, y2), do: true
    def is_straight_line(_), do: false
  end

  @spec venture_to_locations(String.t()) :: list(list(Location.t()))
  defp venture_to_locations(line) do
    # The format is x1,y1 -> x2,y2
    ~r"(\d+),(\d+)\s+->\s+(\d+),(\d+)"
    |> Regex.run(line)
    |> Enum.drop(1) # The first element is the whole regex match
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&Location.new/1)
  end

  @spec compute_venture_overlaps(list(String.t()), boolean()) :: integer()
  def compute_venture_overlaps(input, include_diagonals \\ false) when is_list(input) do
    filter = fn line -> include_diagonals or Location.is_straight_line(line) end

    input
    |> Enum.map(&venture_to_locations/1)
    |> Enum.filter(filter)
    |> Enum.flat_map(&Location.points_between/1)
    |> Enum.frequencies()
    |> Enum.count(fn {_, count} -> count > 1 end)
  end
end
