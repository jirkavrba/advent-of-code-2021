defmodule AdventOfCode.Day05 do
  defmodule Line do
    @type t() :: %__MODULE__{
            x1: integer(), x2: integer(),
            y1: integer(), y2: integer()
          }

    @enforce_keys [:x1, :x2, :y1, :y2]
    defstruct [:x1, :x2, :y1, :y2]
    @spec new(list(integer())) :: t()
    def new([x1, y1, x2, y2]), do: %Line{x1: x1, x2: x2, y1: y1, y2: y2}

    @spec is_straight(t()) :: boolean()
    def is_straight(%Line{x1: x1, x2: x2, y1: y1, y2: y2}) do
      x1 == x2 or y1 == y2
    end

    @spec points(t()) :: {integer(), integer()}
    def points(%Line{x1: x1, x2: x2, y1: y1, y2: y2} = line) do
      cond do
        is_straight(line) -> for x <- x1..x2, y <- y1..y2, do: {x, y}
        true              -> for {x, y} <- Enum.zip(x1..x2, y1..y2), do: {x, y}
      end
    end
  end

  @spec venture_to_line(String.t()) :: Line.t()
  defp venture_to_line(line) do
    # The first element is the whole regex match
    ~r"(\d+),(\d+)\s+->\s+(\d+),(\d+)"
    |> Regex.run(line)
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> Line.new()
  end

  @spec compute_venture_overlaps(list(String.t()), boolean()) :: integer()
  def compute_venture_overlaps(input, include_diagonals \\ false) when is_list(input) do
    filter = fn line -> include_diagonals or Line.is_straight(line) end

    input
    |> Enum.map(&venture_to_line/1)
    |> Enum.filter(filter)
    |> Enum.flat_map(&Line.points/1)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.count(fn count -> count > 1 end)
  end
end
