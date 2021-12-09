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
      [:a, :b, :c,     :e, :f, :g], # 0
      [        :c,         :f    ], # 1
      [:a,     :c, :d, :e,     :g], # 2
      [:a,     :c, :d,     :f, :g], # 3
      [    :b, :c, :d,     :f    ], # 4
      [:a, :b,     :d,     :f, :g], # 5
      [:a, :b,     :d, :e, :f, :g], # 6
      [:a,     :c,         :f    ], # 7
      [:a, :b, :c, :d, :e, :f, :g], # 8
      [:a, :b, :c, :d,     :f, :g] # 9
    ]

    string_to_bits = fn string ->
      string
      |> String.graphemes()
      |> Enum.sort()
      |> Enum.map(&String.to_atom/1)
      |> Enum.filter(&(&1 in [:a, :b, :c, :d, :e, :f, :g]))
    end

    sets = input
    |> Enum.map(string_to_bits)
    |> Enum.uniq()

  end
end
