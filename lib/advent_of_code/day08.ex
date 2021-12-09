defmodule AdventOfCode.Day08 do

  @spec parse_input(list(String.t())) :: list({list(String.t()), list(String.t())})
  defp parse_input(input) when is_list(input) do
    input
    |> Enum.map(fn line -> String.split(line, "|", trim: true) end)
    |> Enum.map(fn parts -> parts
      |> Enum.map(fn part -> String.split(part, " ", trim: true) end)
      |> List.to_tuple()
    end)
  end

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
    |> Enum.map(fn {input, output} -> {solve_segment_wiring(input), output} end)
    |> Enum.map(fn {wiring, output} -> for digit <- output, do: translate_digit(wiring, digit) end)
    |> Enum.map(&Integer.undigits/1)
    |> Enum.sum()
  end

  @spec translate_digit(map(), String.t()) :: integer()
  defp translate_digit(wiring, digit) do
    digits = [
      "abcefg",  #0
      "cf",      #1
      "acdeg",   #2
      "acdfg",   #3
      "bcdf",    #4
      "abdfg",   #5
      "abdefg",  #6
      "acf",     #7
      "abcdefg", #8
      "abcdfg",  #9
    ]

    segments = digit
    |> String.graphemes()
    |> Enum.map(&String.to_atom/1)
    |> Enum.map(fn key -> wiring[key] end)
    |> Enum.sort()
    |> Enum.join("")

    digits
    |> Enum.find_index(&(&1 == segments))
  end

  @spec solve_segment_wiring(list(String.t())) :: Keyword.t()
  defp solve_segment_wiring(input) when is_list(input) do
    string_to_bits = fn string ->
      string
      |> String.graphemes()
      |> Enum.map(&String.to_atom/1)
      |> Enum.sort()
    end

    sets = input
    |> Enum.map(string_to_bits)
    |> Enum.uniq()

    one   = Enum.find(sets, fn s -> length(s) == 2 end)
    four  = Enum.find(sets, fn s -> length(s) == 4 end)
    seven = Enum.find(sets, fn s -> length(s) == 3 end)
    eight = Enum.find(sets, fn s -> length(s) == 7 end)
    nine  = Enum.find(sets, fn s -> length(s) == 6 and length(s -- four) == 2 end)
    six   = Enum.find(sets, fn s -> length(s) == 6 and length(s -- seven) == 4 end)
    zero  = Enum.find(sets, fn s -> length(s) == 6 and length(s -- four) != 2 and length(s -- seven) != 4 end)

    [a] = seven -- one
    [e] = eight -- nine
    [d] = eight -- zero
    [c] = eight -- six
    [f] = one -- [c]
    [b] = four -- [c, d, f]
    [g] = eight -- [a, b, c, d, e, f]

    Enum.map([a: a, b: b, c: c, d: d, e: e, f: f, g: g], fn {k, v} -> {v, k} end)
  end
end
