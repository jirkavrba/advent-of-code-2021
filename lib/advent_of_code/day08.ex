defmodule AdventOfCode.Day08 do

  @spec solve_first_task(list(String.t())) :: non_neg_integer()
  def solve_first_task(input) when is_list(input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn {_, output} -> output end)
    |> Enum.map(&String.length/1)
    |> Enum.count(&(&1 in [2, 3, 4, 7]))
  end

  @spec solve_second_task(list(String.t())) :: non_neg_integer()
  def solve_second_task(input) do
    input
    |> parse_input()
    |> Enum.map(fn {input, output} -> {translate_segments(input), output} end)
    |> Enum.map(fn {translations, output} -> for i <- output, do: translations[i] end)
  end

  @spec parse_input(list(String.t())) :: list({list(String.t()), list(String.t())})
  defp parse_input(input) when is_list(input) do
    input
    |> Enum.map(fn line -> String.split(line, "|", trim: true) end)
    |> Enum.map(fn parts -> parts
      |> Enum.map(fn part -> String.split(part, " ", trim: true) end)
      |> List.to_tuple()
    end)
  end

  @spec translate_segments(list(String.t())) :: %{char() => char()}
  defp translate_segments(input) when is_list(input) do
    segments = [
      #a  b  c  d  e  f  g
      [1, 1, 1, 0, 1, 1, 1], # 0
      [0, 0, 1, 0, 0, 1, 0], # 1
      [1, 0, 1, 1, 1, 0, 1], # 2
      [1, 0, 1, 1, 0, 1, 1], # 3
      [0, 1, 1, 1, 0, 1, 0], # 4
      [1, 1, 0, 1, 0, 1, 1], # 5
      [1, 1, 0, 1, 1, 1, 1], # 6
      [1, 0, 1, 0, 0, 1, 0], # 7
      [1, 1, 1, 1, 1, 1, 1], # 8
      [1, 1, 1, 1, 0, 1, 1], # 9
    ]

    string_to_bits = fn string -> ?a..?b |> Enum.map(&(String.contains?(string, &1))) end

    input
    |> Enum.map(string_to_bits)
    |> IO.inspect()
  end
end
