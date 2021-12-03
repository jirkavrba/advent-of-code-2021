defmodule AdventOfCode.Day03Test do
  use ExUnit.Case
  alias AdventOfCode.Input
  alias AdventOfCode.Day03.Task1

  test "task 1 example" do
    input = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]

    assert Task1.compute_gamma_epsilon_produce(input) == 198
  end

  test "task 1 input" do
    input = Input.read_lines_from_file("priv/inputs/day03.txt")
    assert Task1.compute_gamma_epsilon_produce(input) == 3148794
  end
end