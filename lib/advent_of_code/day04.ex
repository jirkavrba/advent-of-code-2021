defmodule AdventOfCode.Day04 do
  defmodule BingoBoard do
    @moduledoc """
    Bingo board struct, all columns and diagonals are counted as rows for simplicity
    """
    @type t :: %__MODULE__{
            rows: list(list(integer())),
            numbers: list(integer())
          }
    @enforce_keys [:rows, :numbers]
    defstruct [:rows, :numbers]

    @size 5

    @spec size() :: integer()
    def size(), do: @size

    # Only supports 5x5 grid
    @spec create(list(integer)) :: t()
    def create(numbers) when is_list(numbers) and length(numbers) == 25 do
      # TODO: Use NX and tensors for this...
      rows = Enum.chunk_every(numbers, @size)
      columns = for i <- 0..(@size - 1), do: Enum.map(rows, fn row -> Enum.at(row, i) end)

      %__MODULE__{
        numbers: numbers,
        rows: rows ++ columns
      }
    end

    @spec mark(t(), number) :: t()
    def mark(%BingoBoard{rows: rows, numbers: numbers} = board, number) do
      rows = Enum.map(rows, fn row -> row -- [number] end)
      numbers = numbers -- [number]

      %BingoBoard{board | rows: rows, numbers: numbers}
    end

    @spec won?(t()) :: boolean()
    def won?(%BingoBoard{rows: rows}) do
      Enum.any?(rows, &Enum.empty?/1)
    end

    @spec score(t()) :: integer()
    def score(%BingoBoard{numbers: numbers}), do: Enum.sum(numbers)
  end

  defmodule Input do
    @spec parse_boards(list(String.t())) :: list(BingoBoard.t())
    defp parse_boards(source) do
      source
      |> Enum.map(&String.trim/1)
      |> Enum.join(" ")
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(BingoBoard.size() * BingoBoard.size())
      |> Enum.map(&BingoBoard.create/1)
    end

    @spec parse(list(String.t())) :: {list(integer()), list(BingoBoard.t())}
    def parse(lines) when is_list(lines) do
      [draws | boards] = lines

      draws =
        draws
        |> String.trim()
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      boards = parse_boards(boards)

      {draws, boards}
    end
  end

  defmodule Task1 do
    @type accumulator :: {list(BingoBoard.t()), BingoBoard.t() | nil, integer() | nil}
    @spec draw_next_number(integer(), accumulator()) :: accumulator()
    defp draw_next_number(number, {boards, nil, _}) do
      boards = Enum.map(boards, fn board -> BingoBoard.mark(board, number) end)
      winner = Enum.find(boards, &BingoBoard.won?/1)

      case winner do
        nil -> {boards, nil, nil}
        board -> {boards, board, number}
      end
    end

    defp draw_next_number(_number, acc), do: acc

    def find_score_of_winner_board(lines) when is_list(lines) do
      {draws, boards} = Input.parse(lines)

      draws
      |> Enum.reduce({boards, nil, nil}, &draw_next_number/2)
      |> then(fn {_, board, draw} -> BingoBoard.score(board) * draw end)
    end
  end

  defmodule Task2 do
    @type accumulator :: {list(BingoBoard.t()), list(BingoBoard.t()), integer()}
    @spec draw_next_number(integer(), accumulator()) :: accumulator()
    defp draw_next_number(_, {[], _, _} = acc), do: acc

    defp draw_next_number(number, {[last], _, _} = acc) do
      last = BingoBoard.mark(last, number)

      cond do
        BingoBoard.won?(last) -> {[], last, number}
        true -> acc
      end
    end

    defp draw_next_number(number, {boards, _, _}) do
      remaining =
        boards
        |> Enum.map(fn board -> BingoBoard.mark(board, number) end)
        |> Enum.reject(&BingoBoard.won?/1)

      {remaining, nil, nil}
    end

    def find_score_of_last_board(lines) when is_list(lines) do
      {draws, boards} = Input.parse(lines)

      draws
      |> Enum.reduce({boards, nil, nil}, &draw_next_number/2)
      |> then(fn {_, board, draw} -> BingoBoard.score(board) * draw end)
    end
  end
end
